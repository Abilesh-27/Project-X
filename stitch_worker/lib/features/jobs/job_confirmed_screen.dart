import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:stitch_worker/l10n/generated/app_localizations.dart';
import '../../app/router.dart';
import '../../app/theme/app_colors.dart';
import '../../core/models/job_model.dart';
import '../../core/widgets/app_header.dart';
import '../../core/widgets/shared_widgets.dart';

/// CONFIRMED JOB SCREEN (PLAN.md §21).
/// Start Journey pushes into Live Journey Tracking (GPS → Arrival → OTP).
/// Reschedule / Cancel / Contact Customer remain stubbed with a clear
/// "coming next" notice — they are a later implementation phase.
class JobConfirmedScreen extends StatelessWidget {
  final Job job;
  const JobConfirmedScreen({super.key, required this.job});

  void _notComingYet(BuildContext context, String label) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('$label — arriving in the next implementation phase.')),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    // Pre-inspection, only the locked onsite visit fee + its platform fee
    // apply — the service quotation (labour/material) is a later phase.
    final platformFee = job.onsiteFee * (job.platformFeePercent / 100);

    return Scaffold(
      backgroundColor: AppColors.surfaceAlt,
      body: Column(
        children: [
          AppHeader(
            title: l10n.confirmedJobDetails,
            subtitle: l10n.customerJobId(job.jobId),
            onBack: () => context.pop(),
            bottom: Align(
              alignment: Alignment.centerLeft,
              child: StatusChip.success(l10n.jobConfirmed),
            ),
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 32),
              children: [
                AppCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 22,
                            backgroundColor: AppColors.cobalt,
                            child: Text(job.customerInitials, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700)),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(job.customerName, style: Theme.of(context).textTheme.titleSmall),
                                Text(job.serviceName, style: Theme.of(context).textTheme.bodySmall),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const Divider(height: 24),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Icon(Icons.location_on_rounded, size: 16, color: AppColors.cobalt),
                          const SizedBox(width: 8),
                          Expanded(child: Text(job.address, style: Theme.of(context).textTheme.bodySmall)),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          const Icon(Icons.schedule_rounded, size: 16, color: AppColors.cobalt),
                          const SizedBox(width: 8),
                          Text(_fmtRange(job.scheduledStart, job.scheduledEnd), style: Theme.of(context).textTheme.bodySmall),
                          if (job.distance != null) ...[
                            const SizedBox(width: 14),
                            const Icon(Icons.near_me_rounded, size: 16, color: AppColors.cobalt),
                            const SizedBox(width: 6),
                            Text('${job.distance!.toStringAsFixed(1)} ${l10n.km}', style: Theme.of(context).textTheme.bodySmall),
                          ],
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
                AppCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        l10n.billingBreakdown.toUpperCase(),
                        style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: AppColors.textMuted, letterSpacing: 0.4),
                      ),
                      const SizedBox(height: 10),
                      _Row(label: l10n.onsiteFee, value: job.onsiteFee, currency: l10n.rupeeSymbol),
                      _Row(label: l10n.platformFee, value: platformFee, currency: l10n.rupeeSymbol),
                      const Divider(height: 20),
                      _Row(label: l10n.total, value: job.onsiteFee + platformFee, currency: l10n.rupeeSymbol, bold: true),
                    ],
                  ),
                ),
                if (job.reportedProblem != null) ...[
                  const SizedBox(height: 12),
                  AppCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          l10n.notes.toUpperCase(),
                          style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: AppColors.textMuted, letterSpacing: 0.4),
                        ),
                        const SizedBox(height: 8),
                        Text(job.reportedProblem!, style: Theme.of(context).textTheme.bodyMedium),
                      ],
                    ),
                  ),
                ],
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: () => _notComingYet(context, l10n.reschedule),
                        icon: const Icon(Icons.event_repeat_rounded, size: 16),
                        label: Text(l10n.reschedule),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: () => _notComingYet(context, l10n.contactCustomer),
                        icon: const Icon(Icons.call_rounded, size: 16),
                        label: Text(l10n.contactCustomer),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                OutlinedButton.icon(
                  onPressed: () => _notComingYet(context, l10n.cancelAction),
                  style: OutlinedButton.styleFrom(foregroundColor: AppColors.rose, side: const BorderSide(color: AppColors.rose)),
                  icon: const Icon(Icons.close_rounded, size: 16),
                  label: Text(l10n.cancelJob),
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
            onPressed: () => context.push(Routes.jobJourney, extra: job),
            child: Text(l10n.startJourney),
          ),
        ),
      ),
    );
  }

  String _fmtRange(DateTime start, DateTime end) {
    String t(DateTime d) => '${d.hour.toString().padLeft(2, '0')}:${d.minute.toString().padLeft(2, '0')}';
    return '${t(start)} – ${t(end)}';
  }
}

class _Row extends StatelessWidget {
  final String label;
  final double value;
  final String currency;
  final bool bold;
  const _Row({required this.label, required this.value, required this.currency, this.bold = false});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        children: [
          Expanded(
            child: Text(label, style: TextStyle(fontSize: 13, color: AppColors.textSecondary, fontWeight: bold ? FontWeight.w700 : FontWeight.w500)),
          ),
          Text(
            '$currency${value.toStringAsFixed(2)}',
            style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: bold ? AppColors.cobalt : AppColors.textPrimary),
          ),
        ],
      ),
    );
  }
}
