import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:stitch_worker/l10n/generated/app_localizations.dart';
import '../../app/router.dart';
import '../../app/theme/app_colors.dart';
import '../../core/models/job_model.dart';
import '../../core/widgets/app_header.dart';
import '../../core/widgets/shared_widgets.dart';

/// Material line item for quotation.
class _MaterialItem {
  String name;
  int qty;
  String unit;
  double unitPrice;
  _MaterialItem({required this.name, this.qty = 1, this.unit = 'unit', this.unitPrice = 0});
  double get total => qty * unitPrice;
}

/// QUOTATION BUILDER SCREEN (PLAN.md §33)
///
/// Worker builds an itemized quotation after inspection:
/// - Labour/service charge (worker editable)
/// - Material items (worker editable, add/remove)
/// - Other charges (optional, worker editable)
/// - Platform fee (system controlled, auto-calculated)
/// - Customer total
///
/// On "Preview Quotation" → navigates to /job/quotation/preview
class QuotationBuilderScreen extends StatefulWidget {
  final Job job;
  const QuotationBuilderScreen({super.key, required this.job});

  @override
  State<QuotationBuilderScreen> createState() => _QuotationBuilderScreenState();
}

class _QuotationBuilderScreenState extends State<QuotationBuilderScreen> {
  late Job _job;
  late final TextEditingController _labourDescController;
  late final TextEditingController _labourAmountController;
  late final TextEditingController _otherChargesController;
  late final TextEditingController _notesController;

  final List<_MaterialItem> _materials = [];

  @override
  void initState() {
    super.initState();
    _job = widget.job.status == JobStatus.quotationDraft
        ? widget.job
        : widget.job.copyWithStatus(JobStatus.quotationDraft);

    // Seed with demo data from job
    _labourDescController = TextEditingController(
      text: _job.recommendedSolution ?? '',
    );
    _labourAmountController = TextEditingController(
      text: _job.labourCharge > 0 ? _job.labourCharge.toStringAsFixed(0) : '350',
    );
    _otherChargesController = TextEditingController(
      text: _job.otherCharges > 0 ? _job.otherCharges.toStringAsFixed(0) : '0',
    );
    _notesController = TextEditingController();

    // Seed demo materials
    _materials.addAll([
      _MaterialItem(name: 'Heavy-duty 32mm PVC P-Trap', qty: 1, unit: 'unit', unitPrice: 220),
      _MaterialItem(name: 'High-Grade Silicone Sealant & Tape', qty: 1, unit: 'roll', unitPrice: 80),
    ]);
  }

  @override
  void dispose() {
    _labourDescController.dispose();
    _labourAmountController.dispose();
    _otherChargesController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  double get _labourAmount => double.tryParse(_labourAmountController.text) ?? 0;
  double get _materialTotal => _materials.fold(0.0, (s, m) => s + m.total);
  double get _otherAmount => double.tryParse(_otherChargesController.text) ?? 0;
  double get _serviceSubtotal => _labourAmount + _materialTotal + _otherAmount;
  double get _platformFee => _serviceSubtotal * (_job.platformFeePercent / 100);
  double get _customerTotal => _serviceSubtotal + _platformFee;

  void _addMaterial() {
    setState(() {
      _materials.add(_MaterialItem(name: '', qty: 1, unit: 'unit', unitPrice: 0));
    });
  }

  void _removeMaterial(int index) {
    setState(() => _materials.removeAt(index));
  }

  Job get _updatedJob => _job.copyWith(
    labourCharge: _labourAmount,
    materialCost: _materialTotal,
    otherCharges: _otherAmount,
  );

  void _previewQuotation() {
    context.push(Routes.jobQuotationPreview, extra: _updatedJob);
  }

  String _fmt(double v) => '₹${v.toStringAsFixed(2)}';

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final job = _job;

    return Scaffold(
      backgroundColor: AppColors.surfaceAlt,
      body: Column(
        children: [
          // ─── HEADER ───
          AppHeader(
            title: l10n.quotationBuilder,
            subtitle: '${l10n.customerJobId(job.jobId)} • ${job.customerName}',
            onBack: () => context.pop(),
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

          // ─── BODY ───
          Expanded(
            child: ListView(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 140),
              children: [
                // ─── QUOTATION BANNER ───
                _QuotationBanner(l10n: l10n, inrLabel: l10n.inr),
                const SizedBox(height: 14),

                // ─── 1. LABOUR / SERVICE CHARGE ───
                _buildLabourSection(l10n),
                const SizedBox(height: 14),

                // ─── 2. MATERIAL COST ───
                _buildMaterialSection(l10n),
                const SizedBox(height: 14),

                // ─── 3. OTHER CHARGES ───
                _buildOtherChargesSection(l10n),
                const SizedBox(height: 14),

                // ─── SERVICE SUBTOTAL BAR ───
                _buildSubtotalBar(l10n),
                const SizedBox(height: 14),

                // ─── 4. PLATFORM FEE ───
                _buildPlatformFeeSection(l10n),
                const SizedBox(height: 14),

                // ─── 5. TOTAL ───
                _buildTotalSection(l10n),
                const SizedBox(height: 14),

                // ─── NOTES ───
                _buildNotesSection(l10n),
              ],
            ),
          ),
        ],
      ),

      // ─── BOTTOM ACTION BAR ───
      bottomSheet: _BottomActionBar(
        amountLabel: l10n.quotationAmount,
        amount: _fmt(_customerTotal),
        buttonLabel: l10n.previewQuotation,
        onPressed: _previewQuotation,
        icon: Icons.visibility_rounded,
        subNote: l10n.digitalPushNote,
      ),
    );
  }

  // ─── LABOUR SECTION ───
  Widget _buildLabourSection(AppLocalizations l10n) {
    return AppCard(
      padding: const EdgeInsets.all(14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _SectionHeader(
            number: '1',
            title: l10n.labourServiceCharge,
            trailing: StatusChip.info(l10n.workerEditable),
          ),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: AppColors.border),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: _labourDescController,
                  style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: AppColors.textPrimary),
                  decoration: InputDecoration(
                    isDense: true,
                    contentPadding: EdgeInsets.zero,
                    border: InputBorder.none,
                    hintText: l10n.labourDescription,
                    hintStyle: TextStyle(fontSize: 12, color: AppColors.textMuted),
                  ),
                  maxLines: 2,
                ),
                const SizedBox(height: 4),
                Text(l10n.labourEstimate, style: const TextStyle(fontSize: 10, color: AppColors.textMuted)),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Text('₹', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: AppColors.textPrimary)),
                    const SizedBox(width: 4),
                    SizedBox(
                      width: 100,
                      child: TextField(
                        controller: _labourAmountController,
                        keyboardType: TextInputType.number,
                        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700, fontFamily: 'monospace', color: AppColors.textPrimary),
                        decoration: InputDecoration(
                          isDense: true,
                          contentPadding: const EdgeInsets.symmetric(vertical: 4),
                          border: const UnderlineInputBorder(),
                          hintText: l10n.labourChargeAmount,
                          hintStyle: TextStyle(fontSize: 12, color: AppColors.textSlate),
                        ),
                        onChanged: (_) => setState(() {}),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ─── MATERIAL SECTION ───
  Widget _buildMaterialSection(AppLocalizations l10n) {
    return AppCard(
      padding: const EdgeInsets.all(14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _SectionHeader(
            number: '2',
            title: l10n.materialCostItemized,
            trailing: GestureDetector(
              onTap: _addMaterial,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.add_rounded, size: 14, color: AppColors.cobalt),
                  const SizedBox(width: 2),
                  Text(l10n.addMaterial, style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w600, color: AppColors.cobalt)),
                ],
              ),
            ),
          ),
          const SizedBox(height: 10),
          ...List.generate(_materials.length, (i) => _buildMaterialRow(l10n, i)),
          if (_materials.isNotEmpty) ...[
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  l10n.materialSubtotal(_materials.length.toString()),
                  style: const TextStyle(fontSize: 11, color: AppColors.textSecondary),
                ),
                Text(
                  _fmt(_materialTotal),
                  style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w700, fontFamily: 'monospace', color: AppColors.textPrimary),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildMaterialRow(AppLocalizations l10n, int index) {
    final item = _materials[index];
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  initialValue: item.name,
                  style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: AppColors.textPrimary),
                  decoration: InputDecoration(
                    isDense: true,
                    contentPadding: EdgeInsets.zero,
                    border: InputBorder.none,
                    hintText: l10n.materialName,
                    hintStyle: TextStyle(fontSize: 12, color: AppColors.textMuted),
                  ),
                  onChanged: (v) => item.name = v,
                ),
              ),
              GestureDetector(
                onTap: () => _removeMaterial(index),
                child: Tooltip(
                  message: l10n.removeMaterial,
                  child: Container(
                    width: 22, height: 22,
                    decoration: const BoxDecoration(color: AppColors.roseLight, shape: BoxShape.circle),
                    child: const Icon(Icons.close_rounded, size: 12, color: AppColors.rose),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Row(
            children: [
              _MiniField(
                label: l10n.materialQty,
                width: 50,
                value: item.qty.toString(),
                onChanged: (v) => setState(() => item.qty = int.tryParse(v) ?? 1),
              ),
              const SizedBox(width: 8),
              _MiniField(
                label: l10n.materialUnit,
                width: 50,
                value: item.unit,
                isNumeric: false,
                onChanged: (v) => setState(() => item.unit = v),
              ),
              const SizedBox(width: 8),
              _MiniField(
                label: l10n.materialUnitPrice,
                width: 70,
                value: item.unitPrice.toStringAsFixed(0),
                prefix: '₹',
                onChanged: (v) => setState(() => item.unitPrice = double.tryParse(v) ?? 0),
              ),
              const Spacer(),
              Text(_fmt(item.total), style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w700, fontFamily: 'monospace', color: AppColors.textPrimary)),
            ],
          ),
        ],
      ),
    );
  }

  // ─── OTHER CHARGES ───
  Widget _buildOtherChargesSection(AppLocalizations l10n) {
    return AppCard(
      padding: const EdgeInsets.all(14),
      child: Row(
        children: [
          _NumberBadge(number: '3'),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(l10n.otherServiceCharges, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w700, letterSpacing: 0.3, color: AppColors.textPrimary)),
                Text(l10n.otherChargesHint, style: const TextStyle(fontSize: 9, color: AppColors.textSlate)),
              ],
            ),
          ),
          const Text('₹', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: AppColors.textSecondary)),
          SizedBox(
            width: 60,
            child: TextField(
              controller: _otherChargesController,
              keyboardType: TextInputType.number,
              textAlign: TextAlign.end,
              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w700, fontFamily: 'monospace', color: AppColors.textPrimary),
              decoration: const InputDecoration(isDense: true, contentPadding: EdgeInsets.symmetric(vertical: 4), border: UnderlineInputBorder()),
              onChanged: (_) => setState(() {}),
            ),
          ),
        ],
      ),
    );
  }

  // ─── SUBTOTAL BAR ───
  Widget _buildSubtotalBar(AppLocalizations l10n) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.cobaltLight.withValues(alpha: 0.7),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.cobalt.withValues(alpha: 0.2)),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(l10n.serviceSubtotalBreakdown, style: const TextStyle(fontSize: 11, color: AppColors.textSecondary)),
              Text(
                '${_fmt(_labourAmount)} + ${_fmt(_materialTotal)} + ${_fmt(_otherAmount)}',
                style: const TextStyle(fontSize: 10, fontFamily: 'monospace', color: AppColors.textMuted),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Container(height: 1, color: AppColors.cobalt.withValues(alpha: 0.15)),
          const SizedBox(height: 6),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(l10n.serviceSubtotal, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w800, letterSpacing: 0.5, color: AppColors.textPrimary)),
              Text(_fmt(_serviceSubtotal), style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w800, fontFamily: 'monospace', color: AppColors.cobalt)),
            ],
          ),
        ],
      ),
    );
  }

  // ─── PLATFORM FEE ───
  Widget _buildPlatformFeeSection(AppLocalizations l10n) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.amberLight.withValues(alpha: 0.6),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.amber.withValues(alpha: 0.3)),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  _NumberBadge(number: '4', bgColor: AppColors.amber.withValues(alpha: 0.2), textColor: AppColors.amberDark),
                  const SizedBox(width: 8),
                  Text(
                    l10n.platformFeePercent(_job.platformFeePercent.toStringAsFixed(0)),
                    style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w800, letterSpacing: 0.3, color: AppColors.textPrimary),
                  ),
                ],
              ),
              StatusChip.warning(l10n.autoCalculated),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  l10n.platformFeeNote(
                    _job.platformFeePercent.toStringAsFixed(0),
                    _serviceSubtotal.toStringAsFixed(0),
                  ),
                  style: const TextStyle(fontSize: 10, color: AppColors.amberDark),
                ),
              ),
              const SizedBox(width: 8),
              Text('+ ${_fmt(_platformFee)}', style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w700, fontFamily: 'monospace', color: AppColors.textPrimary)),
            ],
          ),
        ],
      ),
    );
  }

  // ─── TOTAL ───
  Widget _buildTotalSection(AppLocalizations l10n) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [AppColors.navy, Color(0xFF10243E), AppColors.cobaltHover],
        ),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.cobalt.withValues(alpha: 0.2)),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(l10n.totalServiceQuotation, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w800, letterSpacing: 0.5, color: Color(0xFFBFDBFE))),
              Text(
                '${_fmt(_serviceSubtotal)} + ${_fmt(_platformFee)}',
                style: const TextStyle(fontSize: 10, fontFamily: 'monospace', color: AppColors.emerald),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Container(height: 1, color: Colors.white.withValues(alpha: 0.1)),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(l10n.customerServiceTotal, style: TextStyle(fontSize: 10, color: Colors.white.withValues(alpha: 0.7))),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Icon(Icons.check_circle_rounded, size: 14, color: AppColors.emerald),
                      const SizedBox(width: 4),
                      Text(l10n.readyForApproval, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: AppColors.emerald)),
                    ],
                  ),
                ],
              ),
              Text(
                _fmt(_customerTotal),
                style: const TextStyle(fontSize: 26, fontWeight: FontWeight.w800, fontFamily: 'monospace', color: Colors.white),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Container(height: 1, color: Colors.white.withValues(alpha: 0.1)),
          const SizedBox(height: 10),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(Icons.info_outline_rounded, size: 14, color: Colors.white.withValues(alpha: 0.6)),
              const SizedBox(width: 6),
              Expanded(
                child: Text(
                  l10n.platformFeePolicy,
                  style: TextStyle(fontSize: 10, color: Colors.white.withValues(alpha: 0.7), height: 1.5),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ─── NOTES ───
  Widget _buildNotesSection(AppLocalizations l10n) {
    return AppCard(
      padding: const EdgeInsets.all(14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(l10n.quotationNotes, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: AppColors.textPrimary)),
          const SizedBox(height: 8),
          TextField(
            controller: _notesController,
            maxLines: 3,
            style: const TextStyle(fontSize: 12, color: AppColors.textPrimary),
            decoration: InputDecoration(
              isDense: true,
              contentPadding: const EdgeInsets.all(10),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide(color: AppColors.border)),
              hintText: l10n.quotationNotesHint,
              hintStyle: TextStyle(fontSize: 12, color: AppColors.textSlate),
            ),
          ),
          const SizedBox(height: 6),
          Row(
            children: [
              Icon(Icons.schedule_rounded, size: 12, color: AppColors.textMuted),
              const SizedBox(width: 4),
              Text(l10n.quotationValidity, style: const TextStyle(fontSize: 10, color: AppColors.textMuted)),
            ],
          ),
        ],
      ),
    );
  }
}

// ─── SHARED HELPER WIDGETS ───

class _QuotationBanner extends StatelessWidget {
  final AppLocalizations l10n;
  final String inrLabel;
  const _QuotationBanner({required this.l10n, required this.inrLabel});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: const LinearGradient(colors: [Color(0xFF1D4ED8), AppColors.cobalt]),
        borderRadius: BorderRadius.circular(14),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      child: Row(
        children: [
          Container(
            width: 28, height: 28,
            decoration: BoxDecoration(color: Colors.white.withValues(alpha: 0.15), borderRadius: BorderRadius.circular(8)),
            child: const Icon(Icons.receipt_long_rounded, size: 16, color: Colors.white),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(l10n.serviceQuotation, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w800, color: Colors.white, letterSpacing: 0.5)),
                Text(l10n.createdAfterDiagnosis, style: TextStyle(fontSize: 10, color: Colors.white.withValues(alpha: 0.8))),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(color: Colors.white.withValues(alpha: 0.2), borderRadius: BorderRadius.circular(4), border: Border.all(color: Colors.white.withValues(alpha: 0.2))),
            child: Text(inrLabel, style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w700, color: Colors.white)),
          ),
        ],
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String number;
  final String title;
  final Widget? trailing;
  const _SectionHeader({required this.number, required this.title, this.trailing});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _NumberBadge(number: number),
        const SizedBox(width: 8),
        Expanded(child: Text(title, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w800, letterSpacing: 0.3, color: AppColors.textPrimary))),
        ?trailing,
      ],
    );
  }
}

class _NumberBadge extends StatelessWidget {
  final String number;
  final Color? bgColor;
  final Color? textColor;
  const _NumberBadge({required this.number, this.bgColor, this.textColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 20, height: 20,
      decoration: BoxDecoration(
        color: bgColor ?? AppColors.cobaltLight,
        shape: BoxShape.circle,
      ),
      alignment: Alignment.center,
      child: Text(number, style: TextStyle(fontSize: 10, fontWeight: FontWeight.w700, color: textColor ?? AppColors.cobalt)),
    );
  }
}

class _MiniField extends StatelessWidget {
  final String label;
  final double width;
  final String value;
  final bool isNumeric;
  final String? prefix;
  final ValueChanged<String> onChanged;

  const _MiniField({
    required this.label,
    required this.width,
    required this.value,
    this.isNumeric = true,
    this.prefix,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 8, fontWeight: FontWeight.w600, color: AppColors.textMuted)),
        const SizedBox(height: 2),
        SizedBox(
          width: width,
          child: Row(
            children: [
              if (prefix != null) Text(prefix!, style: const TextStyle(fontSize: 10, color: AppColors.textSecondary)),
              Expanded(
                child: TextFormField(
                  initialValue: value,
                  keyboardType: isNumeric ? TextInputType.number : TextInputType.text,
                  style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: AppColors.textPrimary),
                  decoration: const InputDecoration(
                    isDense: true,
                    contentPadding: EdgeInsets.symmetric(vertical: 3),
                    border: UnderlineInputBorder(),
                  ),
                  onChanged: onChanged,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _BottomActionBar extends StatelessWidget {
  final String amountLabel;
  final String amount;
  final String buttonLabel;
  final VoidCallback onPressed;
  final IconData icon;
  final String? subNote;

  const _BottomActionBar({
    required this.amountLabel,
    required this.amount,
    required this.buttonLabel,
    required this.onPressed,
    required this.icon,
    this.subNote,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white.withValues(alpha: 0.95),
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(amountLabel, style: const TextStyle(fontSize: 12, color: AppColors.textMuted)),
                Text(amount, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700, fontFamily: 'monospace', color: AppColors.navy)),
              ],
            ),
            const SizedBox(height: 10),
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton.icon(
                onPressed: onPressed,
                icon: Icon(icon, size: 18),
                label: Text(buttonLabel, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w700, letterSpacing: 0.5)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.cobalt,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  elevation: 2,
                ),
              ),
            ),
            if (subNote != null) ...[
              const SizedBox(height: 6),
              Text(subNote!, style: const TextStyle(fontSize: 9, color: AppColors.textSlate), textAlign: TextAlign.center),
            ],
          ],
        ),
      ),
    );
  }
}
