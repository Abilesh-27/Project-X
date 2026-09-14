import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:stitch_worker/l10n/generated/app_localizations.dart';
import '../../app/router.dart';
import '../../app/theme/app_colors.dart';
import '../../core/models/job_model.dart';
import '../../core/widgets/app_header.dart';
import '../../core/widgets/shared_widgets.dart';

/// INVOICE SCREEN (PLAN.md §40)
///
/// Matches invoice_inv_4821/code.html from UI_REFERENCE:
/// - Official Tax Invoice header: INV-4821
/// - Status badge: PAID & Verified Cooperative Digital Receipt
/// - Customer Card (Priya Sharma, Flat 402, Shivani Apts, Sector 22, Dwarka)
/// - Fulfilled by Worker (WKR-2847, Ramesh Kumar, Licensed Plumbing Tech)
/// - Job Specification (#C-4821, Sanitary P-Trap Replacement)
/// - Billing Breakdown (Labour: ₹350, Material: ₹300, Other: ₹0, Subtotal: ₹650, Platform Fee 10%: ₹65, Total: ₹715)
/// - Transaction Record (UPI / PhonePe Axis Escrow, TXN-98421098234, Bank UTR: 429810842109)
/// - Bottom bar: "COMPLETE & RATE JOB" -> Rating / Completion Screen
class InvoiceScreen extends StatelessWidget {
  final Job job;
  const InvoiceScreen({super.key, required this.job});

  String _fmt(double v) => '₹${v.toStringAsFixed(2)}';

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
            title: l10n.invoiceDetails,
            subtitle: 'INV-4821 • ${job.customerName}',
            onBack: () => context.pop(),
            actions: [
              IconButton(
                icon: const Icon(Icons.share_outlined, color: AppColors.cardWhite, size: 20),
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Sharing Tax Invoice INV-4821 PDF')),
                  );
                },
                tooltip: l10n.shareOrPrint,
              ),
            ],
            bottom: Row(
              children: [
                StatusChip(
                  label: l10n.settledInFull,
                  backgroundColor: AppColors.emerald.withValues(alpha: 0.2),
                  textColor: AppColors.emerald,
                  showDot: true,
                ),
                const SizedBox(width: 8),
                StatusChip(
                  label: l10n.taxInvoice,
                  backgroundColor: AppColors.onDarkOverlay10,
                  textColor: AppColors.onDarkSecondary,
                  icon: Icons.receipt_long_rounded,
                ),
              ],
            ),
          ),

          // ─── SCROLLABLE INVOICE BODY ───
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              children: [
                // 1. INVOICE TOP BADGE
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: AppColors.cardWhite,
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: AppColors.emerald.withValues(alpha: 0.3)),
                    boxShadow: [
                      BoxShadow(color: AppColors.textPrimary.withValues(alpha: 0.05), blurRadius: 10, offset: const Offset(0, 2)),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                l10n.taxInvoice,
                                style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w700, color: AppColors.textMuted, letterSpacing: 0.5),
                              ),
                              const SizedBox(height: 2),
                              const Text(
                                'INV-4821',
                                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900, color: AppColors.textPrimary, letterSpacing: -0.5),
                              ),
                            ],
                          ),
                          StatusChip.success(l10n.settledInFull),
                        ],
                      ),
                      const Divider(height: 18, color: AppColors.borderLight),
                      Row(
                        children: [
                          const Icon(Icons.verified_rounded, size: 16, color: AppColors.emerald),
                          const SizedBox(width: 6),
                          const Expanded(
                            child: Text(
                              'Verified Cooperative Digital Receipt • GSTIN ACTIVE',
                              style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: AppColors.textSecondary),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 14),

                // 2. BILLED TO & FULFILLED BY
                AppCard(
                  padding: const EdgeInsets.all(14),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.person_outline_rounded, size: 16, color: AppColors.cobalt),
                          const SizedBox(width: 8),
                          Text('Billed To (Customer)', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: AppColors.textMuted)),
                        ],
                      ),
                      const SizedBox(height: 6),
                      Text(job.customerName, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w800, color: AppColors.textPrimary)),
                      const SizedBox(height: 2),
                      Text(job.address, style: const TextStyle(fontSize: 11, color: AppColors.textSecondary)),
                      const Divider(height: 20, color: AppColors.borderLight),
                      Row(
                        children: [
                          const Icon(Icons.handyman_outlined, size: 16, color: AppColors.cobalt),
                          const SizedBox(width: 8),
                          Text('Fulfilled By (Worker)', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: AppColors.textMuted)),
                        ],
                      ),
                      const SizedBox(height: 6),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('Ramesh Kumar • WKR-2847', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w800, color: AppColors.textPrimary)),
                              const Text('Cooperative Node #04 (Dwarka)', style: TextStyle(fontSize: 11, color: AppColors.textSecondary)),
                            ],
                          ),
                          StatusChip.success('★ 4.9'),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 14),

                // 3. BILLING BREAKDOWN (STRICT COMPLIANT)
                AppCard(
                  padding: const EdgeInsets.all(14),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        l10n.billingBreakdown,
                        style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w800, color: AppColors.textPrimary, letterSpacing: 0.3),
                      ),
                      const Divider(height: 18, color: AppColors.borderLight),
                      _buildLineItem(l10n.labourServiceCharge, 'Sanitary P-Trap Dismantling & Replacement', _fmt(labour)),
                      const SizedBox(height: 10),
                      _buildLineItem(l10n.materialCostItemized, 'Heavy-duty 32mm PVC P-Trap + Sealant Tape', _fmt(materials)),
                      const SizedBox(height: 10),
                      _buildLineItem(l10n.otherServiceCharges, 'Standard disposal & preparation', _fmt(other)),
                      const SizedBox(height: 10),
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: AppColors.cobaltLight.withValues(alpha: 0.5),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text('Service Subtotal:', style: TextStyle(fontSize: 11, color: AppColors.textSecondary)),
                                Text(_fmt(subtotal), style: const TextStyle(fontSize: 11, fontFamily: 'monospace', fontWeight: FontWeight.bold)),
                              ],
                            ),
                            const SizedBox(height: 4),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(l10n.platformFeePercent(job.platformFeePercent.toStringAsFixed(0)), style: const TextStyle(fontSize: 11, color: AppColors.textSecondary)),
                                Text('+ ${_fmt(platformFee)}', style: const TextStyle(fontSize: 11, fontFamily: 'monospace', fontWeight: FontWeight.bold)),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 12),
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: AppColors.navy,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              l10n.totalPaid,
                              style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: AppColors.cardWhite),
                            ),
                            Text(
                              _fmt(total),
                              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w900, fontFamily: 'monospace', color: AppColors.cardWhite),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 14),

                // 4. TRANSACTION RECORD
                AppCard(
                  padding: const EdgeInsets.all(14),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Transaction Record',
                        style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w800, color: AppColors.textPrimary),
                      ),
                      const Divider(height: 18, color: AppColors.borderLight),
                      _buildRow('Payment Method', 'UPI / PhonePe • Axis Escrow'),
                      const SizedBox(height: 6),
                      _buildRow('Transaction ID', 'TXN-98421098234', isMono: true),
                      const SizedBox(height: 6),
                      _buildRow('Bank UTR Reference', '429810842109', isMono: true),
                      const SizedBox(height: 6),
                      _buildRow('Timestamp', '24 Oct 2024, 11:58:14 AM'),
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
            BoxShadow(color: AppColors.textPrimary.withValues(alpha: 0.08), blurRadius: 16, offset: const Offset(0, -4)),
          ],
        ),
        child: SafeArea(
          top: false,
          child: SizedBox(
            width: double.infinity,
            height: 48,
            child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.cobalt,
                foregroundColor: AppColors.cardWhite,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                elevation: 2,
              ),
              icon: const Icon(Icons.star_rate_rounded, size: 20),
              label: Text(
                l10n.rateCustomer,
                style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 13, letterSpacing: 0.3),
              ),
              onPressed: () {
                final completedJob = job.copyWithStatus(JobStatus.completed);
                context.push(Routes.jobRating, extra: completedJob);
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLineItem(String title, String desc, String amount) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: AppColors.textPrimary)),
              Text(desc, style: const TextStyle(fontSize: 10, color: AppColors.textMuted)),
            ],
          ),
        ),
        Text(amount, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w800, fontFamily: 'monospace')),
      ],
    );
  }

  Widget _buildRow(String label, String value, {bool isMono = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: const TextStyle(fontSize: 11, color: AppColors.textMuted)),
        Text(
          value,
          style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, fontFamily: isMono ? 'monospace' : null, color: AppColors.textPrimary),
        ),
      ],
    );
  }
}
