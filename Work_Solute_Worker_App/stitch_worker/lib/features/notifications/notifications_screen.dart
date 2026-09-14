import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:stitch_worker/l10n/generated/app_localizations.dart';
import '../../app/theme/app_colors.dart';
import '../../app/router.dart';
import '../../core/models/job_model.dart';

class NotificationData {
  final String id;
  final String category; // 'customer', 'institution', 'system'
  final String title;
  final String body;
  final String time;
  final String badgeText;
  final Color badgeColor;
  final IconData icon;
  bool isRead;
  final String? route;

  NotificationData({
    required this.id,
    required this.category,
    required this.title,
    required this.body,
    required this.time,
    required this.badgeText,
    required this.badgeColor,
    required this.icon,
    this.isRead = false,
    this.route,
  });
}

/// Notifications Screen matching Stitch UI reference in `notifications_screen/code.html`.
class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  String _selectedFilter = 'all';

  final List<NotificationData> _notifications = [
    NotificationData(
      id: 'N-1',
      category: 'customer',
      title: 'Service Starts in 58m',
      body: 'Job #C-4821 for Priya Sharma. Prepare plumbing tools and safety kit.',
      time: '10m ago',
      badgeText: 'SERVICE REMINDER',
      badgeColor: AppColors.amber,
      icon: Icons.alarm,
      isRead: false,
      route: Routes.jobConfirmed,
    ),
    NotificationData(
      id: 'N-2',
      category: 'system',
      title: 'Quotation Approved by Client',
      body: 'Priya Sharma accepted Quotation Q-4821 (₹715.00). Proceed to execute service.',
      time: '45m ago',
      badgeText: 'QUOTATION ACCEPTED',
      badgeColor: AppColors.emerald,
      icon: Icons.check_circle_outline,
      isRead: false,
    ),
    NotificationData(
      id: 'N-3',
      category: 'system',
      title: 'Payout of ₹16,800 Credited',
      body: 'Weekly settlement STL-2024-1017 transferred to SBI A/C •••• 4821.',
      time: '2h ago',
      badgeText: 'SETTLEMENT CREDITED',
      badgeColor: AppColors.cobalt,
      icon: Icons.account_balance_wallet,
      isRead: false,
      route: Routes.earnings,
    ),
    NotificationData(
      id: 'N-4',
      category: 'institution',
      title: 'Shift Confirmed: AIIMS Ward 4B',
      body: 'Institutional duty JB-8841-DL scheduled for Tomorrow, 08:00 AM. 4 peer workers on roster.',
      time: '4h ago',
      badgeText: 'INSTITUTION DISPATCH',
      badgeColor: AppColors.indigo,
      icon: Icons.business,
      isRead: true,
      route: Routes.institution,
    ),
    NotificationData(
      id: 'N-5',
      category: 'system',
      title: 'Welfare Scheme Verification Complete',
      body: 'Your enrollment in Worker Health Protection Scheme (WHP-2024) is approved.',
      time: '1d ago',
      badgeText: 'WELFARE APPROVED',
      badgeColor: AppColors.cyan,
      icon: Icons.shield_outlined,
      isRead: true,
      route: Routes.schemes,
    ),
    NotificationData(
      id: 'N-6',
      category: 'system',
      title: 'New Skill Course Available',
      body: 'High Voltage & Safety Compliance certificate is now available in your Courses tab.',
      time: '2d ago',
      badgeText: 'TRAINING',
      badgeColor: Colors.purple,
      icon: Icons.school_outlined,
      isRead: true,
      route: Routes.courses,
    ),
  ];

  int get _unreadCount => _notifications.where((n) => !n.isRead).length;

  List<NotificationData> get _filteredNotifications {
    if (_selectedFilter == 'all') return _notifications;
    return _notifications.where((n) => n.category == _selectedFilter).toList();
  }

  void _markAllAsRead() {
    setState(() {
      for (final n in _notifications) {
        n.isRead = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final filtered = _filteredNotifications;

    return Scaffold(
      backgroundColor: AppColors.surface,
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: AppColors.textPrimary,
        elevation: 0.5,
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Flexible(
              child: Text(
                l10n.notificationsTitle,
                style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(width: 8),
            if (_unreadCount > 0)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: AppColors.cobalt,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  '$_unreadCount ${l10n.unread}',
                  style: const TextStyle(fontSize: 10, color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
          ],
        ),
        actions: [
          TextButton.icon(
            onPressed: _markAllAsRead,
            icon: const Icon(Icons.done_all, size: 16, color: AppColors.cobalt),
            label: Text(
              l10n.markAllRead,
              style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: AppColors.cobalt),
            ),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: Column(
        children: [
          // Filter pill tabs
          Container(
            color: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  _buildFilterChip('all', '${l10n.filterAll} (${_notifications.length})'),
                  const SizedBox(width: 8),
                  _buildFilterChip(
                    'customer',
                    '${l10n.filterCustomer} (${_notifications.where((n) => n.category == 'customer').length})',
                  ),
                  const SizedBox(width: 8),
                  _buildFilterChip(
                    'institution',
                    '${l10n.filterInstitution} (${_notifications.where((n) => n.category == 'institution').length})',
                  ),
                  const SizedBox(width: 8),
                  _buildFilterChip(
                    'system',
                    '${l10n.filterSystem} (${_notifications.where((n) => n.category == 'system').length})',
                  ),
                ],
              ),
            ),
          ),
          const Divider(height: 1, color: AppColors.divider),

          // Notification cards list
          Expanded(
            child: filtered.isEmpty
                ? Center(
                    child: Text(
                      l10n.noNotifications,
                      style: const TextStyle(color: AppColors.textMuted, fontSize: 13),
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: filtered.length,
                    itemBuilder: (context, index) {
                      final item = filtered[index];
                      return _buildNotificationCard(item);
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChip(String key, String label) {
    final isSelected = _selectedFilter == key;
    return GestureDetector(
      onTap: () => setState(() => _selectedFilter = key),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.cobalt : AppColors.surfaceAlt,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? AppColors.cobalt : AppColors.border,
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 11,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
            color: isSelected ? Colors.white : AppColors.textSecondary,
          ),
        ),
      ),
    );
  }

  Widget _buildNotificationCard(NotificationData item) {
    return GestureDetector(
      onTap: () {
        setState(() => item.isRead = true);
        if (item.route != null) {
          if (item.route == Routes.jobConfirmed) {
            context.push(Routes.jobConfirmed, extra: DemoData.customerJob);
          } else {
            context.push(item.route!);
          }
        }
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: item.isRead ? AppColors.cardWhite : const Color(0xFFEFF6FF),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: item.isRead ? AppColors.border : const Color(0xFFBFDBFE),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.02),
              blurRadius: 6,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 38,
              height: 38,
              decoration: BoxDecoration(
                color: item.badgeColor.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: item.badgeColor.withValues(alpha: 0.2)),
              ),
              child: Icon(item.icon, size: 20, color: item.badgeColor),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          color: item.badgeColor.withValues(alpha: 0.12),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          item.badgeText,
                          style: TextStyle(
                            fontSize: 9,
                            fontWeight: FontWeight.w800,
                            color: item.badgeColor,
                            letterSpacing: 0.4,
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          Text(
                            item.time,
                            style: const TextStyle(fontSize: 10, color: AppColors.textMuted),
                          ),
                          if (!item.isRead) ...[
                            const SizedBox(width: 6),
                            Container(
                              width: 6,
                              height: 6,
                              decoration: const BoxDecoration(
                                color: AppColors.cobalt,
                                shape: BoxShape.circle,
                              ),
                            ),
                          ],
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Text(
                    item.title,
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: item.isRead ? FontWeight.w600 : FontWeight.w800,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    item.body,
                    style: const TextStyle(fontSize: 11, color: AppColors.textSecondary, height: 1.3),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
