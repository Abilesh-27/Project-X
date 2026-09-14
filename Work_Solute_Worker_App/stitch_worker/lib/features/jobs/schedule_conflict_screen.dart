import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:stitch_worker/l10n/generated/app_localizations.dart';
import '../../app/theme/app_colors.dart';
import '../../core/models/job_model.dart';
import '../../core/widgets/app_header.dart';
import '../../core/widgets/shared_widgets.dart';

/// CANNOT ACCEPT THIS REQUEST — shown when schedule validation
/// (PLAN.md §19) finds an overlap with an existing commitment.
class ScheduleConflictScreen extends StatelessWidget {
  final Job job;
  const ScheduleConflictScreen({super.key, required this.job});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final conflict = DemoData.institutionJob;

    return Scaffold(
      backgroundColor: AppColors.surfaceAlt,
      body: Column(
        children: [
          AppHeader(
            title: l10n.cannotAccept,
            subtitle: l10n.customerJobId(job.jobId),
            onBack: () => context.pop(),
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: AppColors.roseLight,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: AppColors.rose.withValues(alpha: 0.25)),
                  ),
                  child: Column(
                    children: [
                      Container(
                        width: 56,
                        height: 56,
                        decoration: const BoxDecoration(color: AppColors.rose, shape: BoxShape.circle),
                        child: const Icon(Icons.event_busy_rounded, color: Colors.white, size: 28),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        l10n.cannotAccept,
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(color: AppColors.roseDark),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 6),
                      Text(
                        l10n.conflictExplanation,
                        style: Theme.of(context).textTheme.bodyMedium,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                AppCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        l10n.scheduleCompatibility.toUpperCase(),
                        style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: AppColors.textMuted, letterSpacing: 0.4),
                      ),
                      const SizedBox(height: 10),
                      _ConflictRow(
                        label: l10n.newServiceRequest,
                        value: '${job.serviceName} • ${_fmt(job.scheduledStart)}–${_fmt(job.scheduledEnd)}',
                      ),
                      const Divider(height: 20),
                      _ConflictRow(
                        label: l10n.currentAppointment,
                        value: '${conflict.serviceName} • ${_fmt(conflict.scheduledStart)}–${_fmt(conflict.scheduledEnd)}',
                        valueColor: AppColors.roseDark,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 20),
        decoration: BoxDecoration(
          color: AppColors.cardWhite,
          border: const Border(top: BorderSide(color: AppColors.border)),
        ),
        child: SafeArea(
          top: false,
          child: ElevatedButton(
            onPressed: () => context.pop(),
            child: Text(l10n.goBack),
          ),
        ),
      ),
    );
  }

  String _fmt(DateTime t) => '${t.hour.toString().padLeft(2, '0')}:${t.minute.toString().padLeft(2, '0')}';
}

class _ConflictRow extends StatelessWidget {
  final String label;
  final String value;
  final Color? valueColor;
  const _ConflictRow({required this.label, required this.value, this.valueColor});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: Theme.of(context).textTheme.labelMedium),
        const SizedBox(height: 2),
        Text(
          value,
          style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: valueColor ?? AppColors.textPrimary),
        ),
      ],
    );
  }
}
