import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:stitch_worker/l10n/generated/app_localizations.dart';
import '../../app/router.dart';
import '../../app/theme/app_colors.dart';
import '../../core/models/job_model.dart';
import '../../core/widgets/app_header.dart';
import '../../core/widgets/shared_widgets.dart';

/// QUOTATION SENT SCREEN (PLAN.md §35)
///
/// Displayed after the worker submits the quotation:
/// - State: Waiting for customer approval
/// - NO fake customer accept/reject buttons on worker UI
/// - Shows quotation summary (total, line items overview)
/// - Next steps guidance (what happens when approved/rejected)
/// - Actions: Call customer, back to home
/// - For testing/demo workflow transitions: A clean worker simulation sheet or button to trigger customer decision event
class QuotationSentScreen extends StatefulWidget {
  final Job job;
  const QuotationSentScreen({super.key, required this.job});

  @override
  State<QuotationSentScreen> createState() => _QuotationSentScreenState();
}

class _QuotationSentScreenState extends State<QuotationSentScreen> {
  late Job _job;

  @override
  void initState() {
    super.initState();
    _job = widget.job.status == JobStatus.quotationSent
        ? widget.job
        : widget.job.copyWithStatus(JobStatus.quotationSent);
  }

  String _fmt(double v) => '₹${v.toStringAsFixed(2)}';

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final labour = _job.labourCharge;
    final materials = _job.materialCost;
    final other = _job.otherCharges;
    final subtotal = labour + materials + other;
    final platformFee = subtotal * (_job.platformFeePercent / 100);
    final total = subtotal + platformFee;

    return Scaffold(
      backgroundColor: AppColors.surfaceAlt,
      body: Column(
        children: [
          // ─── HEADER ───
          AppHeader(
            title: l10n.quotationSent,
            subtitle: '${l10n.customerJobId(_job.jobId)} • ${_job.customerName}',
            onBack: () => context.go(Routes.home),
            actions: [
              IconButton(
                icon: const Icon(Icons.phone_rounded, color: AppColors.cardWhite, size: 20),
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Calling ${_job.customerName} (${_job.customerPhone})')),
                  );
                },
                tooltip: l10n.callCustomer,
              ),
            ],
            bottom: Row(
              children: [
                StatusChip(
                  label: l10n.waitingForApproval,
                  backgroundColor: AppColors.amber.withValues(alpha: 0.2),
                  textColor: AppColors.amber,
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
                // SUCCESS SENT CARD
                Container(
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    color: AppColors.cardWhite,
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: AppColors.emerald.withValues(alpha: 0.3)),
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
                          color: AppColors.emerald.withValues(alpha: 0.1),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.check_circle_rounded, color: AppColors.emerald, size: 36),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        l10n.quotationSentSuccess,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w800,
                          color: AppColors.textPrimary,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 6),
                      Text(
                        l10n.quotationSentWaiting,
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

                // SUMMARY BREAKDOWN CARD
                AppCard(
                  padding: const EdgeInsets.all(14),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            l10n.serviceQuotation,
                            style: const TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w700,
                              color: AppColors.textPrimary,
                            ),
                          ),
                          Text(
                            '#${_job.jobId}',
                            style: const TextStyle(
                              fontSize: 11,
                              fontFamily: 'monospace',
                              color: AppColors.textMuted,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      const Divider(height: 18, color: AppColors.borderLight),
                      _buildSummaryRow(l10n.labourServiceCharge, _fmt(labour)),
                      const SizedBox(height: 6),
                      _buildSummaryRow(l10n.materialCostItemized, _fmt(materials)),
                      if (other > 0) ...[
                        const SizedBox(height: 6),
                        _buildSummaryRow(l10n.otherServiceCharges, _fmt(other)),
                      ],
                      const SizedBox(height: 6),
                      _buildSummaryRow(
                        l10n.platformFeePercent(_job.platformFeePercent.toStringAsFixed(0)),
                        '+ ${_fmt(platformFee)}',
                        isMuted: true,
                      ),
                      const Divider(height: 18, color: AppColors.borderLight),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            l10n.customerServiceTotal,
                            style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w800, color: AppColors.textPrimary),
                          ),
                          Text(
                            _fmt(total),
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w900,
                              fontFamily: 'monospace',
                              color: AppColors.navy,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 14),

                // WORKFLOW GUIDELINES
                AppCard(
                  padding: const EdgeInsets.all(14),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.info_outline_rounded, size: 16, color: AppColors.cobalt),
                          const SizedBox(width: 8),
                          Text(
                            l10n.quotationStatus,
                            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: AppColors.textPrimary),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: AppColors.emerald.withValues(alpha: 0.08),
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: AppColors.emerald.withValues(alpha: 0.2)),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Icon(Icons.check_circle_rounded, size: 16, color: AppColors.emerald),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    l10n.ifApproved,
                                    style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: AppColors.emerald),
                                  ),
                                  const SizedBox(height: 2),
                                  Text(
                                    l10n.approvedAction,
                                    style: const TextStyle(fontSize: 11, color: AppColors.textSecondary),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 8),
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: AppColors.surfaceAlt,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: AppColors.borderLight),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Icon(Icons.cancel_rounded, size: 16, color: AppColors.textMuted),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    l10n.ifRejected,
                                    style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: AppColors.textMuted),
                                  ),
                                  const SizedBox(height: 2),
                                  Text(
                                    l10n.rejectedAction,
                                    style: const TextStyle(fontSize: 11, color: AppColors.textMuted),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 80),
              ],
            ),
          ),
        ],
      ),

      // ─── BOTTOM ACTIONS ───
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
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        side: const BorderSide(color: AppColors.border),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                      onPressed: () => context.go(Routes.home),
                      child: Text(
                        l10n.backToHome,
                        style: const TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 13,
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.cobalt,
                        foregroundColor: AppColors.cardWhite,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                      onPressed: () {
                        context.push(
                          Routes.jobCustomerDecision,
                          extra: {'job': _job, 'isAccepted': true},
                        );
                      },
                      child: Text(
                        l10n.customerAccepted,
                        style: const TextStyle(
                          fontWeight: FontWeight.w800,
                          fontSize: 12,
                          letterSpacing: 0.3,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSummaryRow(String title, String amount, {bool isMuted = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 12,
            color: isMuted ? AppColors.textMuted : AppColors.textSecondary,
          ),
        ),
        Text(
          amount,
          style: TextStyle(
            fontSize: 12,
            fontFamily: 'monospace',
            fontWeight: FontWeight.w600,
            color: isMuted ? AppColors.textMuted : AppColors.textPrimary,
          ),
        ),
      ],
    );
  }
}
