import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:stitch_worker/l10n/generated/app_localizations.dart';
import '../../app/router.dart';
import '../../app/theme/app_colors.dart';
import '../../core/models/job_model.dart';
import '../../core/widgets/app_header.dart';
import '../../core/widgets/shared_widgets.dart';

/// PAYMENT & SETTLEMENT SCREEN (PLAN.md §39)
///
/// Implements live payment states:
/// - PAYMENT_PENDING: Customer prompted via App / Cash or UPI to Cooperative Escrow (₹715.00)
/// - PAYMENT_PROCESSING: Simulating gateway verification
/// - PAYMENT_SUCCESSFUL: Transaction ID: TXN-98421098234, Bank UTR: 429810842109
/// - Direct CTA to Invoice: "VIEW TAX INVOICE"
class PaymentScreen extends StatefulWidget {
  final Job job;
  const PaymentScreen({super.key, required this.job});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  late Job _job;
  JobStatus _paymentState = JobStatus.paymentPending;

  @override
  void initState() {
    super.initState();
    _job = widget.job.status == JobStatus.paymentPending
        ? widget.job
        : widget.job.copyWithStatus(JobStatus.paymentPending);
  }

  String _fmt(double v) => '₹${v.toStringAsFixed(2)}';

  void _simulatePaymentSuccess() {
    setState(() => _paymentState = JobStatus.paymentProcessing);
    Future.delayed(const Duration(milliseconds: 1200), () {
      if (mounted) {
        setState(() {
          _paymentState = JobStatus.paymentCompleted;
          _job = _job.copyWithStatus(JobStatus.paymentCompleted);
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final total = _job.customerTotal;
    final isPaid = _paymentState == JobStatus.paymentCompleted;
    final isProcessing = _paymentState == JobStatus.paymentProcessing;

    return Scaffold(
      backgroundColor: AppColors.surfaceAlt,
      body: Column(
        children: [
          // ─── HEADER ───
          AppHeader(
            title: l10n.paymentStatus,
            subtitle: '${l10n.customerJobId(_job.jobId)} • ${_job.customerName}',
            onBack: () => context.pop(),
            bottom: Row(
              children: [
                StatusChip(
                  label: isPaid
                      ? l10n.paymentSuccess
                      : (isProcessing ? l10n.paymentProcessing : l10n.awaitingPayment),
                  backgroundColor: isPaid
                      ? AppColors.emerald.withValues(alpha: 0.2)
                      : AppColors.amber.withValues(alpha: 0.2),
                  textColor: isPaid ? AppColors.emerald : AppColors.amber,
                  showDot: true,
                ),
                const SizedBox(width: 8),
                StatusChip(
                  label: l10n.onSiteService,
                  backgroundColor: AppColors.onDarkOverlay10,
                  textColor: AppColors.onDarkSecondary,
                  icon: Icons.shield_outlined,
                ),
              ],
            ),
          ),

          // ─── CONTENT ───
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              children: [
                // 1. PAYMENT STATE CARD
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: AppColors.cardWhite,
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(
                      color: isPaid ? AppColors.emerald.withValues(alpha: 0.3) : AppColors.amber.withValues(alpha: 0.3),
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
                          color: (isPaid ? AppColors.emerald : AppColors.amber).withValues(alpha: 0.1),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          isPaid ? Icons.check_circle_rounded : Icons.hourglass_top_rounded,
                          color: isPaid ? AppColors.emerald : AppColors.amber,
                          size: 32,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        isPaid ? l10n.paymentSuccess : l10n.awaitingPayment,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w800,
                          color: isPaid ? AppColors.emerald : AppColors.amber,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        isPaid
                            ? 'Payment settled in full to Cooperative Escrow'
                            : 'Waiting for customer ${_job.customerName} to confirm on app',
                        style: const TextStyle(fontSize: 12, color: AppColors.textSecondary),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 14),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                        decoration: BoxDecoration(
                          color: AppColors.cobaltLight.withValues(alpha: 0.6),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              l10n.totalPaid,
                              style: const TextStyle(fontSize: 11, color: AppColors.cobalt, fontWeight: FontWeight.w600),
                            ),
                            const SizedBox(width: 8),
                            Text(
                              _fmt(total),
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w900,
                                color: AppColors.cobalt,
                                fontFamily: 'monospace',
                              ),
                            ),
                          ],
                        ),
                      ),
                      if (!isPaid) ...[
                        const SizedBox(height: 12),
                        OutlinedButton.icon(
                          style: OutlinedButton.styleFrom(
                            side: const BorderSide(color: AppColors.cobalt),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                          ),
                          icon: const Icon(Icons.refresh_rounded, size: 16, color: AppColors.cobalt),
                          label: const Text('Simulate Customer Payment Received', style: TextStyle(fontSize: 11, color: AppColors.cobalt, fontWeight: FontWeight.bold)),
                          onPressed: isProcessing ? null : _simulatePaymentSuccess,
                        ),
                      ],
                    ],
                  ),
                ),
                const SizedBox(height: 14),

                // 2. TRANSACTION RECORD
                AppCard(
                  padding: const EdgeInsets.all(14),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            l10n.paymentDetails,
                            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w800, color: AppColors.textPrimary),
                          ),
                          if (isPaid)
                            StatusChip.success(l10n.settledInFull),
                        ],
                      ),
                      const Divider(height: 18, color: AppColors.borderLight),
                      _buildDetailRow(l10n.paymentMethod, 'UPI / PhonePe • Axis Escrow'),
                      const SizedBox(height: 8),
                      _buildDetailRow(
                        l10n.transactionId,
                        isPaid ? 'TXN-98421098234' : 'Pending Generation',
                        isMono: true,
                      ),
                      const SizedBox(height: 8),
                      _buildDetailRow(
                        l10n.bankUtr,
                        isPaid ? '429810842109' : 'Pending Escrow Sync',
                        isMono: true,
                      ),
                      const SizedBox(height: 8),
                      _buildDetailRow(
                        l10n.timestamp,
                        isPaid ? 'Today at 11:52 AM' : 'Awaiting confirmation',
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 14),

                // 3. INVOICE GENERATION STATUS CARD
                AppCard(
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
                                  color: AppColors.cobaltLight,
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: const Icon(Icons.receipt_long_rounded, size: 15, color: AppColors.cobalt),
                              ),
                              const SizedBox(width: 8),
                              Text(
                                l10n.invoiceDetails,
                                style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w800, color: AppColors.textPrimary),
                              ),
                            ],
                          ),
                          StatusChip(
                            label: isPaid ? 'INV-4821 READY' : 'LOCKED',
                            backgroundColor: isPaid ? AppColors.emerald.withValues(alpha: 0.1) : AppColors.surfaceAlt,
                            textColor: isPaid ? AppColors.emerald : AppColors.textMuted,
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Text(
                        isPaid
                            ? 'Official cooperative tax invoice INV-4821 has been generated and issued to customer.'
                            : 'Invoice will be automatically generated after successful payment confirmation.',
                        style: const TextStyle(fontSize: 11, color: AppColors.textSecondary, height: 1.3),
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
            child: isPaid
                ? ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.cobalt,
                      foregroundColor: AppColors.cardWhite,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      elevation: 2,
                    ),
                    icon: const Icon(Icons.receipt_long_rounded, size: 18),
                    label: Text(
                      l10n.viewInvoice,
                      style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 13, letterSpacing: 0.3),
                    ),
                    onPressed: () {
                      final invoiceJob = _job.copyWithStatus(JobStatus.invoiceGenerated);
                      context.push(Routes.jobInvoice, extra: invoiceJob);
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

  Widget _buildDetailRow(String label, String value, {bool isMono = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: const TextStyle(fontSize: 11, color: AppColors.textMuted)),
        Text(
          value,
          style: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w600,
            fontFamily: isMono ? 'monospace' : null,
            color: AppColors.textPrimary,
          ),
        ),
      ],
    );
  }
}
