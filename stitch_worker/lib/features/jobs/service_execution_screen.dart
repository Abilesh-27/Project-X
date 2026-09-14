import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:stitch_worker/l10n/generated/app_localizations.dart';
import '../../app/router.dart';
import '../../app/theme/app_colors.dart';
import '../../core/models/job_model.dart';
import '../../core/widgets/app_header.dart';
import '../../core/widgets/shared_widgets.dart';

/// SERVICE EXECUTION SCREEN (PLAN.md §37, §38)
///
/// Matches service_completion_payment_with_material_proof/code.html:
/// - Flow breadcrumbs (1. Quotation ✓ -> 2. Service Done ✓ -> 3. Billing & Payment)
/// - Work finished summary (problem addressed, work performed, completion notes)
/// - Proof of work gallery (Before vs After photos + add additional photo)
/// - Material & bill proof (itemized materials, bill photo/receipt, vendor, invoice number)
/// - Final service cost transparency card (₹715.00)
/// - Primary Action: "COMPLETE SERVICE & PROCEED TO BILLING" -> pushes to payment/invoice
class ServiceExecutionScreen extends StatefulWidget {
  final Job job;
  const ServiceExecutionScreen({super.key, required this.job});

  @override
  State<ServiceExecutionScreen> createState() => _ServiceExecutionScreenState();
}

class _ServiceExecutionScreenState extends State<ServiceExecutionScreen> {
  late Job _job;
  final List<String> _afterProofPhotos = ['Installed P-Trap', 'Flow Test (0 Leak)'];
  bool _cleanWorkArea = true;
  bool _instructionsFollowed = true;

  @override
  void initState() {
    super.initState();
    _job = widget.job.status == JobStatus.serviceInProgress
        ? widget.job
        : widget.job.copyWithStatus(JobStatus.serviceInProgress);
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
            title: l10n.serviceExecution,
            subtitle: '${l10n.customerJobId(_job.jobId)} • ${_job.customerName}',
            onBack: () => context.pop(),
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
            bottom: Column(
              children: [
                Row(
                  children: [
                    StatusChip(
                      label: l10n.workInProgress,
                      backgroundColor: AppColors.emerald.withValues(alpha: 0.2),
                      textColor: AppColors.emerald,
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
                const SizedBox(height: 8),
                // Stepper breadcrumb bar
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(
                    color: AppColors.navyDark.withValues(alpha: 0.8),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: AppColors.onDarkOverlay10),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('1. Quotation ✓', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: AppColors.emerald)),
                      Text('2. Service ●', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: AppColors.cobaltLight)),
                      Text('3. Payment', style: TextStyle(fontSize: 10, color: AppColors.textSlate)),
                      Text('4. Invoice', style: TextStyle(fontSize: 10, color: AppColors.textSlate)),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // ─── SCROLLABLE CONTENT ───
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              children: [
                // 1. CUSTOMER & SERVICE HEADER CARD
                _buildCustomerHeaderCard(context, l10n),
                const SizedBox(height: 14),

                // 2. SERVICE SUMMARY & LOG
                _buildServiceSummaryCard(context, l10n),
                const SizedBox(height: 14),

                // 3. PROOF OF WORK (Before vs After)
                _buildProofOfWorkCard(context, l10n),
                const SizedBox(height: 14),

                // 4. MATERIAL & BILL PROOF
                _buildMaterialBillProofCard(context, l10n),
                const SizedBox(height: 14),

                // 5. SERVICE COST & PRICING
                _buildPricingCard(context, l10n, labour, materials, other, subtotal, platformFee, total),
                const SizedBox(height: 14),

                // 6. COMPLETION CHECKLIST
                _buildChecklistCard(context, l10n),
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
            child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.cobalt,
                foregroundColor: AppColors.cardWhite,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                elevation: 2,
              ),
              icon: const Icon(Icons.password_rounded, size: 20),
              label: Text(
                '${l10n.verifyEndOtpAndComplete} — ${_fmt(total)}',
                style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 13, letterSpacing: 0.3),
              ),
              onPressed: () {
                final completionJob = _job.copyWith(
                  labourCharge: labour,
                  materialCost: materials,
                  otherCharges: other,
                );
                context.push(Routes.serviceCompletionOtp, extra: completionJob);
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCustomerHeaderCard(BuildContext context, AppLocalizations l10n) {
    return AppCard(
      padding: const EdgeInsets.all(14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 20,
                backgroundColor: AppColors.cobalt,
                child: Text(
                  _job.customerInitials,
                  style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13),
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
                          _job.customerName,
                          style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 14, color: AppColors.textPrimary),
                        ),
                        const SizedBox(width: 6),
                        StatusChip.success(l10n.verified),
                      ],
                    ),
                    Text(
                      '${_job.serviceName} • Under-Sink Drainage',
                      style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: AppColors.cobalt),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: AppColors.cobaltLight,
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(color: AppColors.cobalt.withValues(alpha: 0.2)),
                ),
                child: Text(
                  '#${_job.jobId}',
                  style: const TextStyle(fontSize: 10, fontFamily: 'monospace', fontWeight: FontWeight.w700, color: AppColors.cobalt),
                ),
              ),
            ],
          ),
          const Divider(height: 18, color: AppColors.borderLight),
          Row(
            children: [
              const Icon(Icons.location_on_outlined, size: 15, color: AppColors.cobalt),
              const SizedBox(width: 6),
              Expanded(
                child: Text(_job.address, style: const TextStyle(fontSize: 12, color: AppColors.textSecondary)),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildServiceSummaryCard(BuildContext context, AppLocalizations l10n) {
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
                      color: AppColors.cobaltLight,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: const Icon(Icons.fact_check_rounded, size: 16, color: AppColors.cobalt),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    l10n.serviceSummary,
                    style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w800, color: AppColors.textPrimary, letterSpacing: 0.3),
                  ),
                ],
              ),
              StatusChip.success(l10n.workCompleted),
            ],
          ),
          const SizedBox(height: 12),
          Container(
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
                  l10n.problemAddressed,
                  style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w700, color: AppColors.textMuted),
                ),
                const SizedBox(height: 2),
                Text(
                  _job.workerDiagnosis ?? 'Fractured 32mm PVC P-Trap collar junction and degraded rubber gasket.',
                  style: const TextStyle(fontSize: 12, color: AppColors.textSecondary),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Container(
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
                  l10n.workPerformed,
                  style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w700, color: AppColors.cobalt),
                ),
                const SizedBox(height: 2),
                Text(
                  'Replaced fractured P-Trap with commercial heavy-duty assembly, sealed with anti-fungal high-grade silicone, tested under 15-minute continuous water pressure test (Zero leaks verified).',
                  style: const TextStyle(fontSize: 12, color: AppColors.textPrimary),
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  l10n.completionNotes,
                  style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w700, color: AppColors.textMuted),
                ),
                const SizedBox(height: 2),
                const Text(
                  'Replaced worn assembly handed to customer. 6-Month Cooperative Workmanship Warranty activated upon invoice generation.',
                  style: TextStyle(fontSize: 11, color: AppColors.textSecondary),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProofOfWorkCard(BuildContext context, AppLocalizations l10n) {
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
                      color: AppColors.indigo.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: const Icon(Icons.camera_alt_rounded, size: 15, color: AppColors.indigo),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    l10n.proofOfWork,
                    style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w800, color: AppColors.textPrimary, letterSpacing: 0.3),
                  ),
                ],
              ),
              StatusChip.success(l10n.verifiedByTech),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              // Photo 1: Before
              Expanded(
                child: Container(
                  height: 90,
                  decoration: BoxDecoration(
                    color: AppColors.amber.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: AppColors.amber.withValues(alpha: 0.3)),
                  ),
                  padding: const EdgeInsets.all(6),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 1),
                        decoration: BoxDecoration(color: AppColors.amber, borderRadius: BorderRadius.circular(3)),
                        child: const Text('BEFORE', style: TextStyle(fontSize: 8, fontWeight: FontWeight.bold, color: Colors.white)),
                      ),
                      const Center(
                        child: Icon(Icons.water_drop_outlined, size: 24, color: AppColors.amber),
                      ),
                      const Text('PVC Leak', style: TextStyle(fontSize: 9, fontWeight: FontWeight.bold, color: AppColors.textPrimary)),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 8),
              // Photo 2: After 1
              Expanded(
                child: Container(
                  height: 90,
                  decoration: BoxDecoration(
                    color: AppColors.surfaceAlt,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: AppColors.borderLight),
                  ),
                  padding: const EdgeInsets.all(6),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 1),
                        decoration: BoxDecoration(color: AppColors.emerald, borderRadius: BorderRadius.circular(3)),
                        child: const Text('AFTER 1', style: TextStyle(fontSize: 8, fontWeight: FontWeight.bold, color: Colors.white)),
                      ),
                      const Center(
                        child: Icon(Icons.build_rounded, size: 22, color: AppColors.cobalt),
                      ),
                      const Text('Installed P-Trap', style: TextStyle(fontSize: 9, fontWeight: FontWeight.bold, color: AppColors.textPrimary)),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 8),
              // Photo 3: After 2
              Expanded(
                child: Container(
                  height: 90,
                  decoration: BoxDecoration(
                    color: AppColors.surfaceAlt,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: AppColors.borderLight),
                  ),
                  padding: const EdgeInsets.all(6),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 1),
                        decoration: BoxDecoration(color: AppColors.emerald, borderRadius: BorderRadius.circular(3)),
                        child: const Text('AFTER 2', style: TextStyle(fontSize: 8, fontWeight: FontWeight.bold, color: Colors.white)),
                      ),
                      const Center(
                        child: Icon(Icons.check_circle_outline_rounded, size: 22, color: AppColors.emerald),
                      ),
                      const Text('Pressure Test', style: TextStyle(fontSize: 9, fontWeight: FontWeight.bold, color: AppColors.textPrimary)),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton.icon(
              style: OutlinedButton.styleFrom(
                side: BorderSide(color: AppColors.cobalt.withValues(alpha: 0.3)),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
              icon: const Icon(Icons.add_a_photo_outlined, size: 15, color: AppColors.cobalt),
              label: Text(l10n.addProofPhoto, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: AppColors.cobalt)),
              onPressed: () {
                setState(() => _afterProofPhotos.add('Extra inspection photo'));
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Proof photo added successfully.')),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMaterialBillProofCard(BuildContext context, AppLocalizations l10n) {
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
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: const Icon(Icons.receipt_long_rounded, size: 16, color: AppColors.emerald),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    l10n.materialAndBillProof,
                    style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w800, color: AppColors.textPrimary, letterSpacing: 0.3),
                  ),
                ],
              ),
              StatusChip.success(l10n.verifiedMaterialCost),
            ],
          ),
          const SizedBox(height: 10),
          // Material 1
          _buildMaterialBillItem(
            name: 'Heavy-duty 32mm PVC P-Trap',
            billTag: 'KH-4821-receipt.jpg',
            vendor: 'Kailash Hardware Mart',
            amount: '₹220.00',
            l10n: l10n,
          ),
          const SizedBox(height: 8),
          // Material 2
          _buildMaterialBillItem(
            name: 'Silicone Sealant & Waterproof Tape',
            billTag: 'SW-109-memo.jpg',
            vendor: 'Sanitary World',
            amount: '₹80.00',
            l10n: l10n,
          ),
          const SizedBox(height: 10),
          // Note
          Text(
            l10n.materialProofNote,
            style: const TextStyle(fontSize: 10, color: AppColors.textMuted, height: 1.3),
          ),
        ],
      ),
    );
  }

  Widget _buildMaterialBillItem({
    required String name,
    required String billTag,
    required String vendor,
    required String amount,
    required AppLocalizations l10n,
  }) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: AppColors.surfaceAlt,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.borderLight),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(name, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: AppColors.textPrimary)),
              ),
              Text(amount, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w800, fontFamily: 'monospace')),
            ],
          ),
          const SizedBox(height: 4),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(vendor, style: const TextStyle(fontSize: 10, color: AppColors.textMuted)),
              Row(
                children: [
                  const Icon(Icons.attach_file_rounded, size: 12, color: AppColors.emerald),
                  const SizedBox(width: 2),
                  Text(billTag, style: const TextStyle(fontSize: 10, fontFamily: 'monospace', color: AppColors.emerald, fontWeight: FontWeight.bold)),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPricingCard(
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
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [AppColors.navy, Color(0xFF10243E), Color(0xFF123E9B)],
        ),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(color: AppColors.textPrimary.withValues(alpha: 0.1), blurRadius: 10, offset: const Offset(0, 3)),
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                l10n.finalServiceCost,
                style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w800, color: Color(0xFFBFDBFE), letterSpacing: 0.5),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(color: AppColors.emerald.withValues(alpha: 0.2), borderRadius: BorderRadius.circular(4)),
                child: Text(
                  'Quotation Matched',
                  style: TextStyle(fontSize: 9, fontWeight: FontWeight.bold, color: AppColors.emerald),
                ),
              ),
            ],
          ),
          const Divider(height: 16, color: AppColors.onDarkOverlay10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Labour + Material:', style: TextStyle(fontSize: 11, color: AppColors.onDarkMuted)),
              Text('${_fmt(labour)} + ${_fmt(materials)}', style: const TextStyle(fontSize: 11, fontFamily: 'monospace', color: AppColors.cardWhite)),
            ],
          ),
          const SizedBox(height: 4),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Platform Fee (10%):', style: TextStyle(fontSize: 11, color: AppColors.onDarkMuted)),
              Text('+ ${_fmt(platformFee)}', style: const TextStyle(fontSize: 11, fontFamily: 'monospace', color: AppColors.cardWhite)),
            ],
          ),
          const Divider(height: 16, color: AppColors.onDarkOverlay10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(l10n.customerServiceTotal, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: AppColors.cardWhite)),
              Text(_fmt(total), style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w900, color: AppColors.cardWhite, fontFamily: 'monospace')),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildChecklistCard(BuildContext context, AppLocalizations l10n) {
    return AppCard(
      padding: const EdgeInsets.all(12),
      child: Column(
        children: [
          CheckboxListTile(
            value: _cleanWorkArea,
            onChanged: (v) => setState(() => _cleanWorkArea = v ?? false),
            title: Text(l10n.cleanWorkArea, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600)),
            dense: true,
            controlAffinity: ListTileControlAffinity.leading,
            activeColor: AppColors.cobalt,
            contentPadding: EdgeInsets.zero,
          ),
          CheckboxListTile(
            value: _instructionsFollowed,
            onChanged: (v) => setState(() => _instructionsFollowed = v ?? false),
            title: Text(l10n.customerInstructionFollowed, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600)),
            dense: true,
            controlAffinity: ListTileControlAffinity.leading,
            activeColor: AppColors.cobalt,
            contentPadding: EdgeInsets.zero,
          ),
        ],
      ),
    );
  }
}
