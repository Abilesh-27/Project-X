import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:stitch_worker/l10n/generated/app_localizations.dart';
import '../../app/router.dart';
import '../../app/theme/app_colors.dart';
import '../../core/models/job_model.dart';
import '../../core/widgets/app_header.dart';
import '../../core/widgets/shared_widgets.dart';

/// QUOTATION PREVIEW SCREEN (PLAN.md §34)
///
/// Matches customer_quotation_screen/code.html from UI_REFERENCE:
/// - Customer & Service summary card
/// - Inspection summary card (diagnosis & solution)
/// - Service Quotation pricing breakdown (1-Labour, 2-Materials, 3-Other, Subtotal, 4-Platform Fee, 5-Total)
/// - Customer Approval status card (Waiting for approval, If Approved / If Rejected guidelines)
/// - Bottom bar: Call button + "CONFIRM & SEND QUOTATION — ₹715"
class QuotationPreviewScreen extends StatelessWidget {
  final Job job;
  const QuotationPreviewScreen({super.key, required this.job});

  String _fmt(double v) => '₹${v.toStringAsFixed(2)}';
  String _fmtTime(DateTime d) => '${d.hour.toString().padLeft(2, '0')}:${d.minute.toString().padLeft(2, '0')}';

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final labour = job.labourCharge;
    final materials = job.materialCost;
    final other = job.otherCharges;
    final subtotal = labour + materials + other;
    final platformFee = subtotal * (job.platformFeePercent / 100);
    final total = subtotal + platformFee;

    return Scaffold(
      backgroundColor: AppColors.surfaceAlt,
      body: Column(
        children: [
          // ─── HEADER ───
          AppHeader(
            title: l10n.quotationPreview,
            subtitle: '${l10n.customerJobId(job.jobId)} • ${job.customerName}',
            onBack: () => context.pop(),
            actions: [
              IconButton(
                icon: const Icon(Icons.phone_rounded, color: AppColors.cardWhite, size: 20),
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Calling ${job.customerName} (${job.customerPhone})')),
                  );
                },
                tooltip: l10n.callCustomer,
              ),
            ],
            bottom: Row(
              children: [
                StatusChip(
                  label: l10n.inspectionCompleted,
                  backgroundColor: AppColors.emerald.withValues(alpha: 0.2),
                  textColor: AppColors.emerald,
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

          // ─── SCROLLABLE CONTENT ───
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              children: [
                // 1. CUSTOMER & SERVICE SUMMARY
                _buildCustomerCard(context, l10n),
                const SizedBox(height: 14),

                // 2. INSPECTION SUMMARY
                _buildInspectionCard(context, l10n),
                const SizedBox(height: 14),

                // 3. SERVICE QUOTATION PRICING
                _buildPricingSection(context, l10n, labour, materials, other, subtotal, platformFee, total),
                const SizedBox(height: 14),

                // 4. CUSTOMER APPROVAL WORKFLOW CARD
                _buildApprovalWorkflowCard(context, l10n, total),
                const SizedBox(height: 14),

                // 5. NOTES & POLICY
                _buildPolicyNotesCard(context, l10n),
                const SizedBox(height: 90), // Space for fixed bottom bar
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
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    l10n.quotationAmount,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: AppColors.textMuted,
                    ),
                  ),
                  Text(
                    _fmt(total),
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w800,
                      color: AppColors.navy,
                      fontFamily: 'monospace',
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  // Call button
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: AppColors.surfaceAlt,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: AppColors.borderLight),
                    ),
                    child: IconButton(
                      icon: const Icon(Icons.phone_rounded, color: AppColors.textSecondary, size: 20),
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Calling ${job.customerName} (${job.customerPhone})')),
                        );
                      },
                    ),
                  ),
                  const SizedBox(width: 10),
                  // Send Quotation button
                  Expanded(
                    child: SizedBox(
                      height: 48,
                      child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.cobalt,
                          foregroundColor: AppColors.cardWhite,
                          elevation: 2,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        ),
                        icon: const Icon(Icons.send_rounded, size: 18),
                        label: Text(
                          '${l10n.sendQuotation} — ${_fmt(total)}',
                          style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 13, letterSpacing: 0.3),
                        ),
                        onPressed: () {
                          final updated = job.copyWith(
                            status: JobStatus.quotationSent,
                            labourCharge: labour,
                            materialCost: materials,
                            otherCharges: other,
                          );
                          context.push(Routes.jobQuotationSent, extra: updated);
                        },
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 6),
              Text(
                l10n.digitalPushNote,
                style: const TextStyle(fontSize: 10, color: AppColors.textMuted),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCustomerCard(BuildContext context, AppLocalizations l10n) {
    return AppCard(
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
                    fontSize: 14,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          job.customerName,
                          style: const TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 14,
                            color: AppColors.textPrimary,
                          ),
                        ),
                        const SizedBox(width: 6),
                        StatusChip.success(l10n.verified),
                      ],
                    ),
                    const SizedBox(height: 2),
                    Text(
                      '${job.serviceName} • Under-Sink Drainage',
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: AppColors.cobalt,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: AppColors.surfaceAlt,
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(color: AppColors.borderLight),
                ),
                child: Text(
                  '#${job.jobId}',
                  style: const TextStyle(
                    fontSize: 11,
                    fontFamily: 'monospace',
                    fontWeight: FontWeight.w600,
                    color: AppColors.textMuted,
                  ),
                ),
              ),
            ],
          ),
          const Divider(height: 20, color: AppColors.borderLight),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(Icons.location_on_outlined, size: 15, color: AppColors.textMuted),
              const SizedBox(width: 6),
              Expanded(
                child: Text(
                  job.address,
                  style: const TextStyle(fontSize: 12, color: AppColors.textSecondary),
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Row(
            children: [
              const Icon(Icons.access_time_rounded, size: 15, color: AppColors.textMuted),
              const SizedBox(width: 6),
              Text(
                '${_fmtTime(job.scheduledStart)} – ${_fmtTime(job.scheduledEnd)} • OTP Verified',
                style: const TextStyle(fontSize: 11, color: AppColors.textMuted),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInspectionCard(BuildContext context, AppLocalizations l10n) {
    return AppCard(
      padding: const EdgeInsets.all(14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    width: 24,
                    height: 24,
                    decoration: BoxDecoration(
                      color: AppColors.emerald.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(4),
                      border: Border.all(color: AppColors.emerald.withValues(alpha: 0.3)),
                    ),
                    child: const Icon(Icons.check_circle_outline_rounded, size: 16, color: AppColors.emerald),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    l10n.inspectionDiagnosis,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.5,
                      color: AppColors.textPrimary,
                    ),
                  ),
                ],
              ),
              StatusChip(
                label: l10n.onSiteService,
                backgroundColor: AppColors.emerald.withValues(alpha: 0.1),
                textColor: AppColors.emerald,
              ),
            ],
          ),
          const SizedBox(height: 10),
          // Customer reported problem
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: AppColors.surfaceAlt,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: AppColors.borderLight),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  l10n.customerReportedIssue,
                  style: const TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textMuted,
                    letterSpacing: 0.3,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  '“${job.reportedProblem}”',
                  style: const TextStyle(
                    fontSize: 12,
                    fontStyle: FontStyle.italic,
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          // Worker Diagnosis
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: AppColors.cobaltLight.withValues(alpha: 0.5),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: AppColors.cobalt.withValues(alpha: 0.2)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  l10n.workerDiagnosis,
                  style: const TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                    color: AppColors.cobalt,
                    letterSpacing: 0.3,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  job.workerDiagnosis ?? 'Hairline fracture across 32mm PVC P-Trap collar junction; degraded rubber washer seal.',
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: AppColors.textPrimary,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          // Recommended Solution
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: AppColors.emerald.withValues(alpha: 0.08),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: AppColors.emerald.withValues(alpha: 0.2)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  l10n.recommendedSolution,
                  style: const TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                    color: AppColors.emerald,
                    letterSpacing: 0.3,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  job.recommendedSolution ?? 'Replace fractured 32mm PVC P-Trap with heavy-duty commercial unit and install new gasket.',
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: AppColors.textPrimary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPricingSection(
    BuildContext context,
    AppLocalizations l10n,
    double labour,
    double materials,
    double other,
    double subtotal,
    double platformFee,
    double total,
  ) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.cardWhite,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.cobalt.withValues(alpha: 0.3), width: 1.5),
        boxShadow: [
          BoxShadow(
            color: AppColors.textPrimary.withValues(alpha: 0.06),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Banner
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF1E40AF), AppColors.cobalt],
              ),
              borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      width: 28,
                      height: 28,
                      decoration: BoxDecoration(
                        color: AppColors.cardWhite.withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: const Icon(Icons.receipt_long_rounded, color: AppColors.cardWhite, size: 18),
                    ),
                    const SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          l10n.serviceQuotation,
                          style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w800,
                            color: AppColors.cardWhite,
                            letterSpacing: 0.5,
                          ),
                        ),
                        Text(
                          l10n.createdAfterDiagnosis,
                          style: const TextStyle(
                            fontSize: 10,
                            color: Color(0xFFDBEAFE),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                  decoration: BoxDecoration(
                    color: AppColors.cardWhite.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(4),
                    border: Border.all(color: AppColors.cardWhite.withValues(alpha: 0.3)),
                  ),
                  child: Text(
                    l10n.inr,
                    style: const TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      color: AppColors.cardWhite,
                    ),
                  ),
                ),
              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 1. Labour / Service Charge
                _buildNumberedItem(
                  num: '1',
                  title: l10n.labourServiceCharge,
                  badge: l10n.workerEditable,
                  content: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              job.recommendedSolution ?? 'Sanitary P-Trap Dismantling & Replacement',
                              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: AppColors.textPrimary),
                            ),
                            const SizedBox(height: 2),
                            const Text(
                              'Estimated duration: 45–60 mins',
                              style: TextStyle(fontSize: 10, color: AppColors.textMuted),
                            ),
                          ],
                        ),
                      ),
                      Text(
                        _fmt(labour),
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w800,
                          fontFamily: 'monospace',
                          color: AppColors.textPrimary,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 12),

                // 2. Material Cost (Itemized)
                _buildNumberedItem(
                  num: '2',
                  title: l10n.materialCostItemized,
                  badge: null,
                  content: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Heavy-duty 32mm PVC P-Trap', style: TextStyle(fontSize: 12, color: AppColors.textSecondary)),
                          Text('₹220.00', style: const TextStyle(fontSize: 12, fontFamily: 'monospace', fontWeight: FontWeight.w600)),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Silicone Sealant & Tape', style: TextStyle(fontSize: 12, color: AppColors.textSecondary)),
                          Text('₹80.00', style: const TextStyle(fontSize: 12, fontFamily: 'monospace', fontWeight: FontWeight.w600)),
                        ],
                      ),
                      const Divider(height: 12, color: AppColors.borderLight),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            l10n.materialSubtotal('2 items'),
                            style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: AppColors.textSecondary),
                          ),
                          Text(
                            _fmt(materials),
                            style: const TextStyle(fontSize: 13, fontFamily: 'monospace', fontWeight: FontWeight.w700, color: AppColors.textPrimary),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 12),

                // 3. Other Service Charges
                _buildNumberedItem(
                  num: '3',
                  title: l10n.otherServiceCharges,
                  badge: null,
                  content: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Disposal & Specialized Tools', style: TextStyle(fontSize: 12, color: AppColors.textMuted)),
                      Text(_fmt(other), style: const TextStyle(fontSize: 13, fontFamily: 'monospace', color: AppColors.textMuted)),
                    ],
                  ),
                ),
                const SizedBox(height: 12),

                // SERVICE SUBTOTAL
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: AppColors.cobaltLight.withValues(alpha: 0.7),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: AppColors.cobalt.withValues(alpha: 0.3)),
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Breakdown:', style: TextStyle(fontSize: 11, color: AppColors.textSecondary)),
                          Text(
                            '${_fmt(labour)} + ${_fmt(materials)} + ${_fmt(other)}',
                            style: const TextStyle(fontSize: 11, fontFamily: 'monospace', color: AppColors.textMuted),
                          ),
                        ],
                      ),
                      const SizedBox(height: 6),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            l10n.serviceSubtotal,
                            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w800, color: AppColors.textPrimary, letterSpacing: 0.5),
                          ),
                          Text(
                            _fmt(subtotal),
                            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w900, fontFamily: 'monospace', color: AppColors.cobalt),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 12),

                // 4. PLATFORM FEE (10%)
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: AppColors.amber.withValues(alpha: 0.08),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: AppColors.amber.withValues(alpha: 0.3)),
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Container(
                                width: 18,
                                height: 18,
                                decoration: BoxDecoration(
                                  color: AppColors.amber.withValues(alpha: 0.2),
                                  shape: BoxShape.circle,
                                ),
                                alignment: Alignment.center,
                                child: Text('4', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: AppColors.amber)),
                              ),
                              const SizedBox(width: 6),
                              Text(
                                l10n.platformFeePercent(job.platformFeePercent.toStringAsFixed(0)),
                                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: AppColors.amber),
                              ),
                            ],
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                            decoration: BoxDecoration(
                              color: AppColors.amber.withValues(alpha: 0.15),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: const Text('Auto-Calculated', style: TextStyle(fontSize: 9, fontWeight: FontWeight.w600, color: AppColors.amber)),
                          ),
                        ],
                      ),
                      const SizedBox(height: 6),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            l10n.platformFeeNote(job.platformFeePercent.toStringAsFixed(0), _fmt(subtotal)),
                            style: TextStyle(fontSize: 10, color: AppColors.amber.withValues(alpha: 0.8)),
                          ),
                          Text(
                            '+ ${_fmt(platformFee)}',
                            style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w700, fontFamily: 'monospace', color: AppColors.textPrimary),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 14),

                // 5. FINAL TOTAL CARD (NAVY GRADIENT)
                Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [AppColors.navy, Color(0xFF10243E), Color(0xFF123E9B)],
                    ),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: AppColors.cobaltLight.withValues(alpha: 0.2)),
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            l10n.totalServiceQuotation,
                            style: const TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w800,
                              color: Color(0xFFBFDBFE),
                              letterSpacing: 0.5,
                            ),
                          ),
                          Text(
                            '${_fmt(subtotal)} + ${_fmt(platformFee)}',
                            style: const TextStyle(fontSize: 10, fontFamily: 'monospace', color: AppColors.emerald),
                          ),
                        ],
                      ),
                      const Divider(height: 16, color: AppColors.onDarkOverlay10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                l10n.customerServiceTotal,
                                style: const TextStyle(fontSize: 11, color: AppColors.onDarkMuted),
                              ),
                              const SizedBox(height: 3),
                              Row(
                                children: [
                                  const Icon(Icons.check_circle_rounded, size: 12, color: AppColors.emerald),
                                  const SizedBox(width: 4),
                                  Text(
                                    l10n.readyForApproval,
                                    style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: AppColors.emerald),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Text(
                            _fmt(total),
                            style: const TextStyle(
                              fontSize: 26,
                              fontWeight: FontWeight.w900,
                              color: AppColors.cardWhite,
                              fontFamily: 'monospace',
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Text(
                        l10n.platformFeePolicy,
                        style: TextStyle(fontSize: 9.5, color: AppColors.cardWhite.withValues(alpha: 0.7), height: 1.3),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNumberedItem({
    required String num,
    required String title,
    required String? badge,
    required Widget content,
  }) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: AppColors.surfaceAlt,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.borderLight),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    width: 18,
                    height: 18,
                    decoration: BoxDecoration(
                      color: AppColors.cobaltLight,
                      shape: BoxShape.circle,
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      num,
                      style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: AppColors.cobalt),
                    ),
                  ),
                  const SizedBox(width: 6),
                  Text(
                    title,
                    style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: AppColors.textPrimary),
                  ),
                ],
              ),
              if (badge != null)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    color: AppColors.cobaltLight,
                    borderRadius: BorderRadius.circular(4),
                    border: Border.all(color: AppColors.cobalt.withValues(alpha: 0.3)),
                  ),
                  child: Text(
                    badge,
                    style: const TextStyle(fontSize: 9, fontWeight: FontWeight.w600, color: AppColors.cobalt),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppColors.cardWhite,
              borderRadius: BorderRadius.circular(6),
              border: Border.all(color: AppColors.borderLight),
            ),
            child: content,
          ),
        ],
      ),
    );
  }

  Widget _buildApprovalWorkflowCard(BuildContext context, AppLocalizations l10n, double total) {
    return AppCard(
      padding: const EdgeInsets.all(14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    width: 8,
                    height: 8,
                    decoration: const BoxDecoration(
                      color: AppColors.amber,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 6),
                  Text(
                    l10n.quotationStatus,
                    style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: AppColors.textPrimary),
                  ),
                ],
              ),
              StatusChip(
                label: l10n.waitingForApproval,
                backgroundColor: AppColors.amber.withValues(alpha: 0.1),
                textColor: AppColors.amber,
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            l10n.quotationWaitingMsg(job.customerName, _fmt(total)),
            style: const TextStyle(fontSize: 12, color: AppColors.textSecondary, height: 1.4),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: AppColors.emerald.withValues(alpha: 0.08),
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(color: AppColors.emerald.withValues(alpha: 0.2)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        l10n.ifApproved,
                        style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: AppColors.emerald),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        l10n.approvedAction,
                        style: const TextStyle(fontSize: 10, color: AppColors.textSecondary),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: AppColors.surfaceAlt,
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(color: AppColors.borderLight),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        l10n.ifRejected,
                        style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: AppColors.textMuted),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        l10n.rejectedAction,
                        style: const TextStyle(fontSize: 10, color: AppColors.textMuted),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPolicyNotesCard(BuildContext context, AppLocalizations l10n) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.cobaltLight.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.cobalt.withValues(alpha: 0.2)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.info_outline_rounded, size: 16, color: AppColors.cobalt),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              l10n.paymentAfterApproval,
              style: const TextStyle(fontSize: 11, color: AppColors.textSecondary, height: 1.3),
            ),
          ),
        ],
      ),
    );
  }
}
