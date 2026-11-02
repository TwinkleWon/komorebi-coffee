import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/l10n/l10n.dart';
import '../../../core/router/app_router.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/utils/formatters.dart';
import '../../../core/widgets/async_value_view.dart';
import '../../../core/widgets/common.dart';
import '../application/news_providers.dart';
import '../domain/news_item.dart';

String newsCategoryLabel(AppLocalizations l10n, NewsCategory category) =>
    switch (category) {
      NewsCategory.campaign => l10n.newsCampaign,
      NewsCategory.newProduct => l10n.newsNewProduct,
      NewsCategory.info => l10n.newsInfo,
    };

Color _categoryColor(NewsCategory category) => switch (category) {
      NewsCategory.campaign => AppColors.caramel,
      NewsCategory.newProduct => AppColors.matcha,
      NewsCategory.info => AppColors.inkMuted,
    };

class NewsTile extends ConsumerWidget {
  const NewsTile({super.key, required this.item});

  final NewsItem item;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final unread = !ref.watch(readNewsProvider).contains(item.id);
    return InkWell(
      onTap: () => context.push(AppRoutes.newsDetail(item.id)),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        newsCategoryLabel(l10n, item.category),
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                          color: _categoryColor(item.category),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        formatDate(item.publishedAt, l10n.localeName),
                        style: const TextStyle(
                          fontSize: 11,
                          color: AppColors.inkMuted,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Text(
                    item.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 14,
                      height: 1.5,
                      fontWeight: unread ? FontWeight.w700 : FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12),
            AnimatedOpacity(
              duration: const Duration(milliseconds: 200),
              opacity: unread ? 1 : 0,
              child: Container(
                width: 8,
                height: 8,
                decoration: const BoxDecoration(
                  color: AppColors.caramel,
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class NewsListScreen extends ConsumerWidget {
  const NewsListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final news = ref.watch(newsProvider);
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 72,
        title: PageTitle(eyebrow: 'News', title: l10n.newsTitle),
        actions: [
          TextButton(
            onPressed: () => ref
                .read(readNewsProvider.notifier)
                .markRead(news.valueOrNull?.data.map((n) => n.id) ?? []),
            child: Text(l10n.markAllRead),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: AsyncValueView(
        value: news,
        onRetry: () => ref.invalidate(newsProvider),
        data: (snapshot) => RefreshIndicator(
          onRefresh: () => safeRefresh(() => ref.refresh(newsProvider.future)),
          child: snapshot.data.isEmpty
              ? ListView(
                  children: [
                    EmptyState(
                      icon: Icons.mail_outline_rounded,
                      message: l10n.newsEmpty,
                    ),
                  ],
                )
              : ListView(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  children: [
                    StaleDataNotice(snapshot: snapshot),
                    ...ListTile.divideTiles(
                      context: context,
                      tiles: snapshot.data.map((n) => NewsTile(item: n)),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}

class NewsDetailScreen extends ConsumerStatefulWidget {
  const NewsDetailScreen({super.key, required this.newsId});

  final String newsId;

  @override
  ConsumerState<NewsDetailScreen> createState() => _NewsDetailScreenState();
}

class _NewsDetailScreenState extends ConsumerState<NewsDetailScreen> {
  @override
  void initState() {
    super.initState();
    // Marking as read is a side effect, so it happens once, after the first
    // frame, rather than during build.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(readNewsProvider.notifier).markRead([widget.newsId]);
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final news = ref.watch(newsProvider);
    return Scaffold(
      appBar: AppBar(),
      body: AsyncValueView(
        value: news,
        onRetry: () => ref.invalidate(newsProvider),
        data: (snapshot) {
          final item =
              snapshot.data.firstWhereOrNull((n) => n.id == widget.newsId);
          if (item == null) {
            return EmptyState(
              icon: Icons.search_off_rounded,
              message: l10n.errorNotFound,
            );
          }
          return ListView(
            padding: const EdgeInsets.fromLTRB(24, 8, 24, 40),
            children: [
              Row(
                children: [
                  Pill(label: newsCategoryLabel(l10n, item.category)),
                  const SizedBox(width: 10),
                  Text(
                    formatDate(item.publishedAt, l10n.localeName),
                    style: const TextStyle(
                        color: AppColors.inkMuted, fontSize: 12),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Text(
                item.title,
                style: Theme.of(context)
                    .textTheme
                    .titleLarge
                    ?.copyWith(height: 1.5),
              ),
              const SizedBox(height: 20),
              const Divider(),
              const SizedBox(height: 20),
              Text(item.body,
                  style: const TextStyle(fontSize: 15, height: 1.9)),
            ],
          );
        },
      ),
    );
  }
}
