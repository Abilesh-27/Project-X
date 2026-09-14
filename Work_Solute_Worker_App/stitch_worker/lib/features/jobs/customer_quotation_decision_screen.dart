import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:stitch_worker/l10n/generated/app_localizations.dart';
import '../../app/router.dart';
import '../../app/theme/app_colors.dart';
import '../../core/models/job_model.dart';
import '../../core/widgets/app_header.dart';
import '../../core/widgets/shared_widgets.dart';

/// CUSTOMER QUOTATION DECISION SCREEN (PLAN.md §36)
///
/// Models the customer's response to the sent quotation:
/// - State: QUOTATION_ACCEPTED or QUOTATION_REJECTED
/// - When Accepted: Shows approval confirmation, customer note, and enables worker "START SERVICE"
/// - When Rejected: Shows decline notice, applicable onsite visit fee handling, and job closure
class CustomerQuotationDecisionScreen extends StatelessWidget {
  final Job job;
  final bool isAccepted;

  const CustomerQuotationDecisionScreen({
    super.key,
    required this.job,
    this.isAccepted = true,
  });

  String _fmt(double v) => '₹${v.toStringAsFixed(2)}';

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final total = job.customerTotal;

    return Scaffold(
      backgroundColor: AppColors.surfaceAlt,
      body: Column(
        children: [
          // ─── HEADER ───
          AppHeader(
            title: isAccepted ? l10n.customerAccepted : l10n.customerRejected,
            subtitle: '${l10n.customerJobId(job.jobId)} • ${job.customerName}',
            onBack: () => context.pop(),
            bottom: Row(
              children: [
                StatusChip(
                  label: isAccepted ? l10n.customerAccepted : l10n.customerRejected,
                  backgroundColor: (isAccepted ? AppColors.emerald : AppColors.rose).withValues(alpha: 0.2),
                  textColor: isAccepted ? AppColors.emerald : AppColors.rose,
                  showDot: true,
                ),
                const SizedBox(width: 8),
                StatusChip(
                  label: l10n.onSiteService,
                  backgroundColor: AppColors.onDarkOverlay10,
                  textColor: AppColors.onDarkSecondary,
                  icon: Icons.location_on_rounded,
                ),
              ],
            ),
          ),

          // ─── CONTENT ───
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              children: [
                // DECISION BANNER CARD
                Container(
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    color: AppColors.cardWhite,
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(
                      color: (isAccepted ? AppColors.emerald : AppColors.rose).withValues(alpha: 0.3),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.textPrimary.withValues(alpha: 0.05),
                        blurRadius: 10,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Container(
                        width: 56,
                        height: 56,
                        decoration: BoxDecoration(
                          color: (isAccepted ? AppColors.emerald : AppColors.rose).withValues(alpha: 0.1),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          isAccepted ? Icons.check_circle_rounded : Icons.cancel_rounded,
                          color: isAccepted ? AppColors.emerald : AppColors.rose,
                          size: 36,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        isAccepted ? l10n.customerAccepted : l10n.customerRejected,
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w800,
                          color: isAccepted ? AppColors.emerald : AppColors.rose,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        isAccepted ? l10n.quotationAcceptedMsg : l10n.quotationRejectedMsg,
                        style: const TextStyle(fontSize: 12, color: AppColors.textSecondary),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 14),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                        decoration: BoxDecoration(
                          color: AppColors.cobaltLight.withValues(alpha: 0.6),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              l10n.quotationAmount,
                              style: const TextStyle(fontSize: 12, color: AppColors.cobalt, fontWeight: FontWeight.w500),
                            ),
                            const SizedBox(width: 6),
                            Text(
                              _fmt(total),
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w800,
                                color: AppColors.cobalt,
                                fontFamily: 'monospace',
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 14),

                // JOB & CUSTOMER DETAILS
                AppCard(
                  padding: const EdgeInsets.all(14),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 20,
                            backgroundColor: AppColors.cobaltLight,
                            child: Text(
                              job.customerInitials,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: AppColors.cobalt,
                                fontSize: 13,
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  job.customerName,
                                  style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 14, color: AppColors.textPrimary),
                                ),
                                Text(
                                  job.serviceName,
                                  style: const TextStyle(fontSize: 12, color: AppColors.cobalt, fontWeight: FontWeight.w600),
                                ),
                              ],
                            ),
                          ),
                          StatusChip.success(l10n.verified),
                        ],
                      ),
                      const Divider(height: 20, color: AppColors.borderLight),
                      Row(
                        children: [
                          const Icon(Icons.location_on_outlined, size: 15, color: AppColors.textMuted),
                          const SizedBox(width: 6),
                          Expanded(
                            child: Text(job.address, style: const TextStyle(fontSize: 12, color: AppColors.textSecondary)),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 14),

                // NEXT ACTION GUIDELINES
                if (isAccepted)
                  AppCard(
                    padding: const EdgeInsets.all(14),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Icon(Icons.play_circle_outline_rounded, size: 16, color: AppColors.emerald),
                            const SizedBox(width: 8),
                            Text(
                              l10n.ifApproved,
                              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: AppColors.textPrimary),
                            ),
                          ],
                        ),
                        const SizedBox(height: 6),
                        Text(
                          l10n.approvedAction,
                          style: const TextStyle(fontSize: 12, color: AppColors.textSecondary),
                        ),
                        const SizedBox(height: 10),
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: AppColors.cobaltLight.withValues(alpha: 0.5),
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: AppColors.cobalt.withValues(alpha: 0.2)),
                          ),
                          child: Row(
                            children: [
                              const Icon(Icons.info_outline_rounded, size: 15, color: AppColors.cobalt),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  l10n.paymentAfterApproval,
                                  style: const TextStyle(fontSize: 11, color: AppColors.textSecondary),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                else
                  AppCard(
                    padding: const EdgeInsets.all(14),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Icon(Icons.info_outline_rounded, size: 16, color: AppColors.rose),
                            const SizedBox(width: 8),
                            Text(
                              l10n.ifRejected,
                              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: AppColors.textPrimary),
                            ),
                          ],
                        ),
                        const SizedBox(height: 6),
                        Text(
                          l10n.rejectedAction,
                          style: const TextStyle(fontSize: 12, color: AppColors.textSecondary),
                        ),
                        const SizedBox(height: 10),
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: AppColors.surfaceAlt,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: AppColors.border),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                l10n.onsiteFee,
                                style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: AppColors.textPrimary),
                              ),
                              Text(
                                _fmt(job.onsiteFee),
                                style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w800, fontFamily: 'monospace', color: AppColors.navy),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                const SizedBox(height: 90),
              ],
            ),
          ),
        ],
      ),

      // ─── BOTTOM ACTION BAR ───
      bottomSheet: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: AppColors.cardWhite,
          border: const Border(top: BorderSide(color: AppColors.borderLight)),
          boxShadow: [
            BoxShadow(
              color: AppColors.textPrimary.withValues(alpha: 0.08),
              blurRadius: 16,
              offset: const Offset(0, -4),
            ),
          ],
        ),
        child: SafeArea(
          top: false,
          child: SizedBox(
            width: double.infinity,
            height: 48,
            child: isAccepted
                ? ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.emerald,
                      foregroundColor: AppColors.cardWhite,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      elevation: 2,
                    ),
                    icon: const Icon(Icons.play_arrow_rounded, size: 20),
                    label: Text(
                      l10n.startService,
                      style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 14, letterSpacing: 0.5),
                    ),
                    onPressed: () {
                      final serviceJob = job.copyWith(status: JobStatus.serviceInProgress);
                      context.push(Routes.jobServiceExecution, extra: serviceJob);
                    },
                  )
                : OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: AppColors.border),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    onPressed: () => context.go(Routes.home),
                    child: Text(
                      l10n.backToHome,
                      style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 13, color: AppColors.textSecondary),
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}
