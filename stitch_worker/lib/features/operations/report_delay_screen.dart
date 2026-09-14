import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:stitch_worker/l10n/generated/app_localizations.dart';
import '../../app/theme/app_colors.dart';
import '../../core/models/job_model.dart';
import '../../core/widgets/shared_widgets.dart';

/// Report Dispatch Delay Screen / Bottom Sheet.
/// Matches Stitch UI reference from `main_worker_dashboard` delay modal.
class ReportDelayScreen extends StatefulWidget {
  final Job job;
  const ReportDelayScreen({super.key, required this.job});

  @override
  State<ReportDelayScreen> createState() => _ReportDelayScreenState();
}

class _ReportDelayScreenState extends State<ReportDelayScreen> {
  String _selectedMinutes = '15';
  int _selectedReasonIndex = 0;
  bool _isSubmitted = false;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    final delayReasons = [
      {'icon': '🚗', 'text': l10n.trafficCongestion},
      {'icon': '⏱️', 'text': l10n.prevJobLate},
      {'icon': '🛵', 'text': l10n.vehicleIssue},
      {'icon': '🔧', 'text': l10n.partsPickup},
      {'icon': '🌧️', 'text': l10n.weatherDelay},
      {'icon': '🚨', 'text': l10n.emergencyDelay},
    ];

    return Scaffold(
      backgroundColor: AppColors.surface,
      appBar: AppBar(
        backgroundColor: AppColors.navy,
        foregroundColor: Colors.white,
        title: Text(
          l10n.reportDelayTitle,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
      ),
      body: SafeArea(
        child: _isSubmitted
            ? _buildSuccessFeedback(l10n)
            : ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  // Target job info
                  AppCard(
                    padding: const EdgeInsets.all(14),
                    child: Row(
                      children: [
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: AppColors.amber.withValues(alpha: 0.15),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Icon(Icons.access_time_filled, color: AppColors.amberDark, size: 22),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Job #${widget.job.jobId} • ${widget.job.customerName}',
                                style: const TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.textPrimary,
                                ),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                widget.job.serviceName,
                                style: const TextStyle(fontSize: 11, color: AppColors.textMuted),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 18),

                  // Expected Delay Time Selector
                  Text(
                    l10n.delayExpectedTime.toUpperCase(),
                    style: const TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.8,
                      color: AppColors.textSecondary,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      _buildTimeOption('15', l10n.min15),
                      const SizedBox(width: 8),
                      _buildTimeOption('30', l10n.min30),
                      const SizedBox(width: 8),
                      _buildTimeOption('45', l10n.min45),
                    ],
                  ),
                  const SizedBox(height: 20),

                  // Reason selector
                  Text(
                    l10n.selectDelayReason.toUpperCase(),
                    style: const TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.8,
                      color: AppColors.textSecondary,
                    ),
                  ),
                  const SizedBox(height: 8),
                  ...List.generate(delayReasons.length, (index) {
                    final item = delayReasons[index];
                    final isSelected = _selectedReasonIndex == index;
                    return GestureDetector(
                      onTap: () => setState(() => _selectedReasonIndex = index),
                      child: Container(
                        margin: const EdgeInsets.only(bottom: 8),
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: isSelected ? AppColors.amberLight : AppColors.cardWhite,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: isSelected ? AppColors.amber : AppColors.border,
                            width: isSelected ? 1.5 : 1,
                          ),
                        ),
                        child: Row(
                          children: [
                            Text(item['icon']!, style: const TextStyle(fontSize: 18)),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Text(
                                item['text']!,
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                                  color: isSelected ? AppColors.amberDark : AppColors.textPrimary,
                                ),
                              ),
                            ),
                            Icon(
                              isSelected ? Icons.radio_button_checked : Icons.radio_button_unchecked,
                              color: isSelected ? AppColors.amberDark : AppColors.textSlate,
                              size: 18,
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
                  const SizedBox(height: 24),

                  // Action Button
                  AppButton(
                    label: l10n.notifyDelay,
                    icon: Icons.send_rounded,
                    backgroundColor: AppColors.amber,
                    textColor: Colors.white,
                    onPressed: () {
                      setState(() => _isSubmitted = true);
                    },
                  ),
                  const SizedBox(height: 10),
                  Center(
                    child: TextButton(
                      onPressed: () => context.pop(),
                      child: Text(
                        l10n.dismiss,
                        style: const TextStyle(color: AppColors.textMuted, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }

  Widget _buildTimeOption(String value, String label) {
    final isSelected = _selectedMinutes == value;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => _selectedMinutes = value),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: isSelected ? AppColors.amberLight : AppColors.cardWhite,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isSelected ? AppColors.amber : AppColors.border,
              width: isSelected ? 1.5 : 1,
            ),
          ),
          child: Center(
            child: Text(
              label,
              style: TextStyle(
                fontSize: 12,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.w600,
                color: isSelected ? AppColors.amberDark : AppColors.textSecondary,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSuccessFeedback(AppLocalizations l10n) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 64,
              height: 64,
              decoration: BoxDecoration(
                color: AppColors.amber.withValues(alpha: 0.15),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.check_circle, size: 36, color: AppColors.amberDark),
            ),
            const SizedBox(height: 16),
            Text(
              l10n.delayReportedSuccess,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Job #${widget.job.jobId} updated: +$_selectedMinutes mins',
              style: const TextStyle(fontSize: 12, color: AppColors.textMuted),
            ),
            const SizedBox(height: 24),
            AppButton(
              label: l10n.close,
              onPressed: () => context.pop(),
            ),
          ],
        ),
      ),
    );
  }
}
