import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:stitch_worker/l10n/generated/app_localizations.dart';
import '../../app/theme/app_colors.dart';
import '../../app/router.dart';
import '../../core/models/job_model.dart';

/// Worker Schedule & Calendar Screen.
class ScheduleScreen extends StatefulWidget {
  const ScheduleScreen({super.key});

  @override
  State<ScheduleScreen> createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen> {
  int _selectedDayIndex = 0;

  final List<Map<String, String>> _days = [
    {'day': 'Today', 'date': '24 Oct'},
    {'day': 'Fri', 'date': '25 Oct'},
    {'day': 'Sat', 'date': '26 Oct'},
    {'day': 'Sun', 'date': '27 Oct'},
    {'day': 'Mon', 'date': '28 Oct'},
  ];

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Scaffold(
      backgroundColor: AppColors.surface,
      appBar: AppBar(
        backgroundColor: AppColors.navy,
        foregroundColor: Colors.white,
        title: Text(
          l10n.scheduleTitle,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Calendar day strip
            Container(
              color: AppColors.cardWhite,
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
              child: Row(
                children: List.generate(_days.length, (index) {
                  final d = _days[index];
                  final isSelected = _selectedDayIndex == index;
                  return Expanded(
                    child: GestureDetector(
                      onTap: () => setState(() => _selectedDayIndex = index),
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 3),
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        decoration: BoxDecoration(
                          color: isSelected ? AppColors.cobalt : AppColors.surfaceAlt,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: isSelected ? AppColors.cobalt : AppColors.border,
                          ),
                        ),
                        child: Column(
                          children: [
                            Text(
                              d['day']!,
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                                color: isSelected ? Colors.white : AppColors.textSecondary,
                              ),
                            ),
                            const SizedBox(height: 3),
                            Text(
                              d['date']!,
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: isSelected ? Colors.white : AppColors.textPrimary,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ),
            const Divider(height: 1, color: AppColors.divider),

            // Working hours info banner
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.access_time, size: 14, color: AppColors.textMuted),
                      const SizedBox(width: 6),
                      Text(
                        '${l10n.workHours}: 08:00 AM – 06:00 PM',
                        style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: AppColors.textSecondary),
                      ),
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    decoration: BoxDecoration(
                      color: AppColors.emerald.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: const Text(
                      'No Conflicts',
                      style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: AppColors.emeraldDark),
                    ),
                  ),
                ],
              ),
            ),

            // Timeline items
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  if (_selectedDayIndex == 0) ...[
                    _buildTimelineCard(
                      time: '08:00 AM – 12:00 PM',
                      title: 'Morning Duty Availability',
                      type: 'Available Slot',
                      statusColor: AppColors.emerald,
                      icon: Icons.check_circle_outline,
                      isFree: true,
                    ),
                    const SizedBox(height: 12),
                    _buildTimelineCard(
                      time: '02:00 PM – 03:30 PM',
                      title: 'Plumbing Repair • Job #C-4821',
                      subtitle: 'Priya Sharma • Flat 402, Shivani Apartments, Dwarka',
                      type: 'Confirmed Customer Job',
                      statusColor: AppColors.cobalt,
                      icon: Icons.plumbing,
                      onTap: () => context.push(Routes.jobConfirmed, extra: DemoData.customerJob),
                    ),
                    const SizedBox(height: 12),
                    _buildTimelineCard(
                      time: '04:30 PM – 06:00 PM',
                      title: 'Buffer & Transit Time',
                      type: 'Blocked Slot',
                      statusColor: AppColors.amber,
                      icon: Icons.hourglass_bottom,
                      isFree: true,
                    ),
                  ] else if (_selectedDayIndex == 1) ...[
                    _buildTimelineCard(
                      time: '08:00 AM – 04:00 PM',
                      title: 'AIIMS New Delhi • Sanitation & Ward 4B',
                      subtitle: 'Duty JB-8841-DL • 4 Peers on shift • Guaranteed ₹650',
                      type: 'Institutional Assignment',
                      statusColor: AppColors.indigo,
                      icon: Icons.business,
                      onTap: () => context.push(Routes.institution),
                    ),
                  ] else ...[
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.all(32),
                        child: Text(
                          l10n.noUpcomingJobs,
                          style: const TextStyle(color: AppColors.textMuted, fontSize: 13),
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTimelineCard({
    required String time,
    required String title,
    String? subtitle,
    required String type,
    required Color statusColor,
    required IconData icon,
    bool isFree = false,
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: isFree ? AppColors.surfaceAlt : AppColors.cardWhite,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isFree ? AppColors.border : statusColor.withValues(alpha: 0.3),
            width: isFree ? 1 : 1.5,
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 38,
              height: 38,
              decoration: BoxDecoration(
                color: statusColor.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, color: statusColor, size: 20),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        time,
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                          color: statusColor,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 1.5),
                        decoration: BoxDecoration(
                          color: statusColor.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          type,
                          style: TextStyle(fontSize: 9, fontWeight: FontWeight.bold, color: statusColor),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  if (subtitle != null) ...[
                    const SizedBox(height: 3),
                    Text(
                      subtitle,
                      style: const TextStyle(fontSize: 11, color: AppColors.textMuted),
                    ),
                  ],
                ],
              ),
            ),
            if (onTap != null)
              const Padding(
                padding: EdgeInsets.only(top: 8),
                child: Icon(Icons.chevron_right, color: AppColors.textSlate, size: 18),
              ),
          ],
        ),
      ),
    );
  }
}
