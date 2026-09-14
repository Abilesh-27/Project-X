import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:stitch_worker/l10n/generated/app_localizations.dart';
import '../../app/router.dart';
import '../../app/theme/app_colors.dart';
import '../../core/models/job_model.dart';
import '../../core/widgets/app_header.dart';
import '../../core/widgets/shared_widgets.dart';

enum _Severity { low, active, urgent }

/// INSPECTION & DIAGNOSIS SCREEN (PLAN.md §31/§32 — Inspection UI + Diagnosis UI).
///
/// Reached after Arrival + OTP Verification for onsite-required jobs. Shows
/// the customer-reported issue and their pre-visit photos, then collects the
/// worker's on-site technical findings (root cause, severity, corrective
/// action, notes, proof photos) that feed directly into the canonical
/// [Job.workerDiagnosis] / [Job.recommendedSolution] fields used throughout
/// the rest of the job lifecycle (Quotation, Invoice, etc.).
///
/// On "Complete Inspection" the job transitions to [JobStatus.quotationDraft]
/// — the Quotation Builder screen (PLAN.md §33) is the next implementation
/// phase, so — consistent with the stub pattern already used at the end of
/// [OtpVerificationScreen] — this screen returns to the dashboard with a
/// clear confirmation rather than dead-ending on a route that doesn't exist
/// yet. Replace the `context.go('/')` call in [_completeInspection] with a
/// push to the Quotation Builder route once it exists.
class InspectionDiagnosisScreen extends StatefulWidget {
  final Job job;
  const InspectionDiagnosisScreen({super.key, required this.job});

  @override
  State<InspectionDiagnosisScreen> createState() => _InspectionDiagnosisScreenState();
}

class _InspectionDiagnosisScreenState extends State<InspectionDiagnosisScreen> {
  static const String _defaultDefect =
      'Hairline fracture across 32mm PVC P-Trap collar junction; severely degraded compression washer gasket causing continuous seepage into lower cabinetry under active line pressure.';
  static const String _defaultSolution =
      'Replace cracked 32mm heavy-duty P-trap assembly, install new commercial silicone gasket, apply anti-fungal waterproof sealant tape, and test flow under 5-minute continuous run.';
  static const String _defaultObservations =
      'Main shutoff valve in working condition. Cabinet wood has minor dampness; dry before seal.';

  late Job _job;
  late final TextEditingController _defectController;
  late final TextEditingController _solutionController;
  late final TextEditingController _notesController;
  _Severity _severity = _Severity.active;

  /// Proof photos captured on-site by the worker. Demo-seeded with 2 entries
  /// matching the UI_REFERENCE mock; "Take Camera Shot" / "Upload File"
  /// simulate capture since no camera/image-picker package is wired in yet
  /// (see journey_tracking_screen.dart's simulated-GPS precedent).
  final List<String> _proofPhotos = [];
  static const int _maxProofPhotos = 4;

  @override
  void initState() {
    super.initState();
    _job = widget.job.status == JobStatus.inspection
        ? widget.job
        : widget.job.copyWithStatus(JobStatus.inspection);
    final initialDefect = (_job.workerDiagnosis != null && _job.workerDiagnosis!.trim().isNotEmpty)
        ? _job.workerDiagnosis!
        : _defaultDefect;
    final initialSolution = (_job.recommendedSolution != null && _job.recommendedSolution!.trim().isNotEmpty)
        ? _job.recommendedSolution!
        : _defaultSolution;
    _defectController = TextEditingController(text: initialDefect);
    _solutionController = TextEditingController(text: initialSolution);
    _notesController = TextEditingController(text: _defaultObservations);
    _proofPhotos.addAll(['Collar crack closeup', 'Water level mark closeup']);
  }

  @override
  void dispose() {
    _defectController.dispose();
    _solutionController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  bool get _hasDefect => _defectController.text.trim().isNotEmpty;
  bool get _hasSolution => _solutionController.text.trim().isNotEmpty;
  bool get _hasPhotos => _proofPhotos.isNotEmpty;

  bool get _canComplete => _hasDefect && _hasSolution && _hasPhotos;

  void _addProofPhoto(String label) {
    if (_proofPhotos.length >= _maxProofPhotos) return;
    setState(() => _proofPhotos.add(label));
  }

  void _removeProofPhoto(int index) {
    setState(() => _proofPhotos.removeAt(index));
  }

  void _completeInspection(AppLocalizations l10n) {
    if (!_canComplete) return;
    final updated = _job.copyWith(
      status: JobStatus.quotationDraft,
      workerDiagnosis: _defectController.text.trim(),
      recommendedSolution: _solutionController.text.trim(),
    );
    context.push(Routes.jobQuotation, extra: updated);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('${l10n.inspectionCompleted} — ${updated.jobId}')),
    );
  }

  String _severityLabel(AppLocalizations l10n, _Severity s) {
    switch (s) {
      case _Severity.low:
        return l10n.lowDrip;
      case _Severity.active:
        return l10n.activeLeak;
      case _Severity.urgent:
        return l10n.shutoffUrgent;
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final job = _job;

    return Scaffold(
      backgroundColor: AppColors.surfaceAlt,
      body: Column(
        children: [
          AppHeader(
            title: l10n.inspectionDiagnosis,
            subtitle: job.customerName.isNotEmpty
                ? '${l10n.customerJobId(job.jobId)} • ${job.customerName}'
                : l10n.customerJobId(job.jobId),
            onBack: () => context.pop(),
            bottom: Row(
              children: [
                StatusChip(
                  label: l10n.onSiteActive,
                  backgroundColor: AppColors.onDarkOverlay15,
                  textColor: AppColors.emerald,
                  showDot: true,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: StatusChip(
                    label: l10n.arrivalOtpVerified,
                    backgroundColor: AppColors.onDarkOverlay10,
                    textColor: AppColors.onDarkSecondary,
                    icon: Icons.check_circle_rounded,
                  ),
                ),
              ],
            ),
          ),
          _WorkflowStepper(l10n: l10n),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 120),
              children: [
                // ─── Customer info card ───
                AppCard(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 48,
                        height: 48,
                        decoration: BoxDecoration(color: AppColors.cobalt, borderRadius: BorderRadius.circular(12)),
                        alignment: Alignment.center,
                        child: Text(
                          job.customerInitials,
                          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 16),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Flexible(
                                  child: Text(
                                    job.customerName,
                                    style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 15, color: AppColors.textPrimary),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                const SizedBox(width: 6),
                                StatusChip.success(l10n.verified),
                              ],
                            ),
                            const SizedBox(height: 2),
                            Text(
                              job.serviceCategory,
                              style: const TextStyle(color: AppColors.cobalt, fontWeight: FontWeight.w700, fontSize: 11),
                            ),
                            const SizedBox(height: 8),
                            Row(
                              children: [
                                const Icon(Icons.location_on_outlined, size: 13, color: AppColors.textMuted),
                                const SizedBox(width: 4),
                                Expanded(
                                  child: Text(
                                    job.addressShort ?? job.address,
                                    style: const TextStyle(fontSize: 11, color: AppColors.textSecondary),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 4),
                      _IconCircleButton(
                        icon: Icons.call_rounded,
                        onTap: () => _showComingSoon(l10n.callCustomer),
                      ),
                      const SizedBox(width: 6),
                      _IconCircleButton(
                        icon: Icons.chat_bubble_outline_rounded,
                        onTap: () => _showComingSoon(l10n.messageCustomer),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 12),

                // ─── Customer reported issue ───
                AppCard(
                  color: AppColors.indigo.withValues(alpha: 0.06),
                  borderColor: AppColors.indigo.withValues(alpha: 0.15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.forum_rounded, size: 16, color: AppColors.indigo),
                          const SizedBox(width: 8),
                          Text(
                            l10n.customerReportedIssue,
                            style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 11, color: AppColors.indigo, letterSpacing: 0.3),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: AppColors.cardWhite.withValues(alpha: 0.9),
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: AppColors.indigo.withValues(alpha: 0.15)),
                        ),
                        child: Text(
                          '“${job.reportedProblem ?? ''}”',
                          style: const TextStyle(fontSize: 12, fontStyle: FontStyle.italic, color: AppColors.textSecondary, height: 1.4),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 12),

                // ─── Customer attached photos ───
                if (job.problemPhotoLabels.isNotEmpty) ...[
                  AppCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      const Icon(Icons.photo_library_outlined, size: 15, color: AppColors.cobalt),
                                      const SizedBox(width: 6),
                                      Flexible(
                                        child: Text(
                                          l10n.customerAttachedPhotos,
                                          style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 13, color: AppColors.textPrimary),
                                        ),
                                      ),
                                      const SizedBox(width: 4),
                                      Text('(${job.problemPhotoLabels.length})', style: const TextStyle(fontSize: 11, color: AppColors.textMuted)),
                                    ],
                                  ),
                                  const SizedBox(height: 2),
                                  Text(
                                    l10n.uploadedPriorToArrival(job.customerName),
                                    style: const TextStyle(fontSize: 10, color: AppColors.textMuted),
                                  ),
                                ],
                              ),
                            ),
                            TextButton(
                              onPressed: () => _showComingSoon(l10n.viewFull),
                              child: Text(l10n.viewFull),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            for (int i = 0; i < job.problemPhotoLabels.length; i++) ...[
                              if (i > 0) const SizedBox(width: 10),
                              Expanded(child: _CustomerPhotoTile(label: job.problemPhotoLabels[i])),
                            ],
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),
                ],

                // ─── Worker inspection findings (editable) ───
                AppCard(
                  borderColor: AppColors.cobalt.withValues(alpha: 0.4),
                  borderRadius: 16,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 28,
                            height: 28,
                            decoration: BoxDecoration(color: AppColors.cobaltLight, borderRadius: BorderRadius.circular(8)),
                            alignment: Alignment.center,
                            child: const Icon(Icons.build_rounded, size: 14, color: AppColors.cobalt),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(l10n.workerInspectionFindings, style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 13, color: AppColors.textPrimary)),
                                Text(l10n.inspectionFindingsSubtitle, style: const TextStyle(fontSize: 10, color: AppColors.textMuted)),
                              ],
                            ),
                          ),
                          StatusChip.success(l10n.editable),
                        ],
                      ),
                      const SizedBox(height: 14),

                      _FieldLabel(text: l10n.observedDefect, required: true),
                      const SizedBox(height: 6),
                      TextField(
                        controller: _defectController,
                        maxLines: 3,
                        onChanged: (_) => setState(() {}),
                        style: const TextStyle(fontSize: 12, color: AppColors.textPrimary, height: 1.4),
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: AppColors.surfaceAlt,
                          contentPadding: const EdgeInsets.all(10),
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: const BorderSide(color: AppColors.border)),
                          enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: const BorderSide(color: AppColors.border)),
                          focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: const BorderSide(color: AppColors.cobalt, width: 2)),
                        ),
                      ),
                      const SizedBox(height: 14),

                      _FieldLabel(text: l10n.diagnosisSeverity),
                      const SizedBox(height: 6),
                      Row(
                        children: _Severity.values.map((s) {
                          final selected = s == _severity;
                          return Expanded(
                            child: Padding(
                              padding: EdgeInsets.only(right: s == _Severity.values.last ? 0 : 8),
                              child: GestureDetector(
                                onTap: () => setState(() => _severity = s),
                                child: Container(
                                  padding: const EdgeInsets.symmetric(vertical: 9),
                                  decoration: BoxDecoration(
                                    color: selected ? AppColors.amberLight : AppColors.cardWhite,
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(color: selected ? AppColors.amber : AppColors.border, width: selected ? 2 : 1),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      if (selected) ...[
                                        Container(width: 6, height: 6, decoration: const BoxDecoration(color: AppColors.amber, shape: BoxShape.circle)),
                                        const SizedBox(width: 5),
                                      ],
                                      Flexible(
                                        child: Text(
                                          _severityLabel(l10n, s),
                                          textAlign: TextAlign.center,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            fontSize: 11,
                                            fontWeight: selected ? FontWeight.w800 : FontWeight.w600,
                                            color: selected ? AppColors.amberDark : AppColors.textSecondary,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                      const SizedBox(height: 14),

                      _FieldLabel(text: l10n.requiredAction, required: true),
                      const SizedBox(height: 6),
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: AppColors.cobaltLight.withValues(alpha: 0.5),
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: AppColors.cobalt.withValues(alpha: 0.2)),
                        ),
                        child: Text(
                          _solutionController.text,
                          style: const TextStyle(fontSize: 12, color: AppColors.textPrimary, height: 1.4),
                        ),
                      ),
                      const SizedBox(height: 14),

                      _FieldLabel(text: l10n.onSiteObservations),
                      const SizedBox(height: 6),
                      TextField(
                        controller: _notesController,
                        style: const TextStyle(fontSize: 12, color: AppColors.textPrimary),
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: AppColors.surfaceAlt,
                          contentPadding: const EdgeInsets.all(10),
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: const BorderSide(color: AppColors.border)),
                          enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: const BorderSide(color: AppColors.border)),
                          focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: const BorderSide(color: AppColors.cobalt, width: 2)),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 12),

                // ─── Technician proof photos ───
                AppCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.camera_alt_rounded, size: 15, color: AppColors.cobalt),
                          const SizedBox(width: 6),
                          Flexible(
                            child: Text(l10n.technicianPhotos, style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 13, color: AppColors.textPrimary)),
                          ),
                          const SizedBox(width: 6),
                          StatusChip.success(l10n.viewAllPhotos('${_proofPhotos.length}')),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: AppColors.amberLight,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: AppColors.amber.withValues(alpha: 0.3)),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Icon(Icons.shield_outlined, size: 14, color: AppColors.amberDark),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(l10n.photoVerifyNote, style: const TextStyle(fontSize: 11, color: AppColors.amberDark, height: 1.3)),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 12),
                      GridView.count(
                        crossAxisCount: 3,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        mainAxisSpacing: 10,
                        crossAxisSpacing: 10,
                        children: [
                          for (int i = 0; i < _proofPhotos.length; i++) _ProofPhotoTile(label: _proofPhotos[i], onRemove: () => _removeProofPhoto(i), removeTooltip: l10n.removePhoto),
                          if (_proofPhotos.length < _maxProofPhotos)
                            _AddPhotoSlot(
                              addLabel: l10n.addPhoto,
                              maxNote: l10n.maxPhotosNote('$_maxProofPhotos'),
                              onTap: () => _addProofPhoto('${l10n.proofOfWork} ${_proofPhotos.length + 1}'),
                            ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          Expanded(
                            child: OutlinedButton.icon(
                              onPressed: _proofPhotos.length >= _maxProofPhotos
                                  ? null
                                  : () => _addProofPhoto('${l10n.proofOfWork} ${_proofPhotos.length + 1}'),
                              icon: const Icon(Icons.camera_alt_outlined, size: 16),
                              label: Text(l10n.takeCameraShot, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w700)),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: OutlinedButton.icon(
                              onPressed: _proofPhotos.length >= _maxProofPhotos
                                  ? null
                                  : () => _addProofPhoto('${l10n.proofOfWork} ${_proofPhotos.length + 1}'),
                              icon: const Icon(Icons.folder_open_outlined, size: 16),
                              label: Text(l10n.uploadFile, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w700)),
                            ),
                          ),
                        ],
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
        padding: const EdgeInsets.fromLTRB(16, 10, 16, 18),
        decoration: BoxDecoration(
          color: AppColors.cardWhite,
          border: const Border(top: BorderSide(color: AppColors.border)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.06),
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
                  Expanded(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.arrow_circle_right_rounded, size: 14, color: AppColors.cobalt),
                        const SizedBox(width: 6),
                        Expanded(
                          child: Text(
                            l10n.nextUnlockQuotation,
                            style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: AppColors.textSecondary),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    l10n.stageOf('2', '4'),
                    style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w800, color: AppColors.textPrimary),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  InkWell(
                    onTap: () => _showComingSoon(l10n.callCustomer),
                    borderRadius: BorderRadius.circular(12),
                    child: Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        color: AppColors.surfaceAlt,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: AppColors.border),
                      ),
                      child: const Icon(Icons.phone_rounded, size: 18, color: AppColors.textPrimary),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: SizedBox(
                      height: 48,
                      child: ElevatedButton(
                        onPressed: _canComplete ? () => _completeInspection(l10n) : null,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.cobalt,
                          foregroundColor: Colors.white,
                          disabledBackgroundColor: AppColors.border,
                          disabledForegroundColor: AppColors.textMuted,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                          elevation: _canComplete ? 2 : 0,
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.check_circle_outline_rounded, size: 18),
                            const SizedBox(width: 8),
                            Flexible(
                              child: FittedBox(
                                fit: BoxFit.scaleDown,
                                child: Text(
                                  l10n.completeInspection,
                                  style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 13, letterSpacing: 0.5),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                _canComplete ? l10n.completeInspectionNote : l10n.inspectionPrerequisitesNote,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: _canComplete ? FontWeight.w500 : FontWeight.w600,
                  color: _canComplete ? AppColors.textMuted : AppColors.amberDark,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showComingSoon(String label) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(label)));
  }
}

class _WorkflowStepper extends StatelessWidget {
  final AppLocalizations l10n;
  const _WorkflowStepper({required this.l10n});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.cardWhite,
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Text(
                  l10n.sequentialWorkflow,
                  style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w800, color: AppColors.cobalt, letterSpacing: 0.4),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(color: AppColors.cobaltLight, borderRadius: BorderRadius.circular(4)),
                child: Text(l10n.strictProgressiveDisclosure, style: const TextStyle(fontSize: 9, fontWeight: FontWeight.w800, color: AppColors.cobalt)),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(child: _StepCapsule(label: '1. ${l10n.otpCheck}', state: _StepState.done, doneLabel: l10n.verified)),
              const SizedBox(width: 6),
              Expanded(child: _StepCapsule(label: '2. ${l10n.inspection}', state: _StepState.active, activeLabel: l10n.activeNow)),
              const SizedBox(width: 6),
              Expanded(child: _StepCapsule(label: '3. ${l10n.quotation}', state: _StepState.locked, lockedLabel: l10n.locked)),
              const SizedBox(width: 6),
              Expanded(child: _StepCapsule(label: '4. ${l10n.approval}', state: _StepState.locked, lockedLabel: l10n.locked)),
            ],
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
            decoration: BoxDecoration(color: AppColors.surfaceAlt, borderRadius: BorderRadius.circular(8), border: Border.all(color: AppColors.border)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Row(
                    children: [
                      const Icon(Icons.info_outline_rounded, size: 13, color: AppColors.cobalt),
                      const SizedBox(width: 6),
                      Expanded(
                        child: Text(
                          '${l10n.stageOf('2', '4')}: ${l10n.physicalDiagnosis}',
                          style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: AppColors.textSecondary),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 6),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(color: AppColors.amberLight, borderRadius: BorderRadius.circular(4), border: Border.all(color: AppColors.amber.withValues(alpha: 0.4))),
                  child: Text(l10n.pricingLocked, style: const TextStyle(fontSize: 9, fontWeight: FontWeight.w800, color: AppColors.amberDark)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

enum _StepState { done, active, locked }

class _StepCapsule extends StatelessWidget {
  final String label;
  final _StepState state;
  final String? doneLabel;
  final String? activeLabel;
  final String? lockedLabel;

  const _StepCapsule({required this.label, required this.state, this.doneLabel, this.activeLabel, this.lockedLabel});

  @override
  Widget build(BuildContext context) {
    late final Color bg;
    late final Color fg;
    late final Color border;
    late final IconData icon;
    String sub;

    switch (state) {
      case _StepState.done:
        bg = AppColors.emeraldBg;
        fg = AppColors.emeraldDark;
        border = AppColors.emerald.withValues(alpha: 0.3);
        icon = Icons.check_circle_rounded;
        sub = doneLabel ?? '';
        break;
      case _StepState.active:
        bg = AppColors.cobalt;
        fg = Colors.white;
        border = AppColors.cobalt;
        icon = Icons.search_rounded;
        sub = activeLabel ?? '';
        break;
      case _StepState.locked:
        bg = AppColors.surfaceAlt;
        fg = AppColors.textMuted;
        border = AppColors.border;
        icon = Icons.lock_outline_rounded;
        sub = lockedLabel ?? '';
        break;
    }

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 4),
      decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(10), border: Border.all(color: border)),
      child: Column(
        children: [
          Icon(icon, size: 15, color: fg),
          const SizedBox(height: 3),
          Text(
            label,
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(fontSize: 9, fontWeight: FontWeight.w800, color: fg),
          ),
          Text(
            sub,
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(fontSize: 8, color: fg.withValues(alpha: 0.85)),
          ),
        ],
      ),
    );
  }
}

class _FieldLabel extends StatelessWidget {
  final String text;
  final bool required;
  const _FieldLabel({required this.text, this.required = false});

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w800, color: AppColors.textSecondary),
        children: [
          TextSpan(text: text),
          if (required) const TextSpan(text: ' *', style: TextStyle(color: AppColors.rose)),
        ],
      ),
    );
  }
}

class _IconCircleButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  const _IconCircleButton({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 32,
        height: 32,
        decoration: BoxDecoration(color: AppColors.surfaceAlt, shape: BoxShape.circle),
        child: Icon(icon, size: 15, color: AppColors.textSecondary),
      ),
    );
  }
}

class _CustomerPhotoTile extends StatelessWidget {
  final String label;
  const _CustomerPhotoTile({required this.label});

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.3,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Container(
            decoration: BoxDecoration(color: AppColors.navyDark, borderRadius: BorderRadius.circular(10)),
            alignment: Alignment.center,
            child: const Icon(Icons.image_rounded, color: Colors.white24, size: 28),
          ),
          Positioned(
            left: 6,
            right: 6,
            bottom: 6,
            child: Text(
              label,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(color: Colors.white, fontSize: 9, fontWeight: FontWeight.w600, height: 1.2),
            ),
          ),
        ],
      ),
    );
  }
}

class _ProofPhotoTile extends StatelessWidget {
  final String label;
  final VoidCallback onRemove;
  final String removeTooltip;
  const _ProofPhotoTile({required this.label, required this.onRemove, required this.removeTooltip});

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Container(
          decoration: BoxDecoration(color: AppColors.navyDark, borderRadius: BorderRadius.circular(10), border: Border.all(color: AppColors.border)),
          alignment: Alignment.center,
          child: const Icon(Icons.image_rounded, color: Colors.white24, size: 24),
        ),
        Positioned(
          top: 4,
          right: 4,
          child: GestureDetector(
            onTap: onRemove,
            child: Tooltip(
              message: removeTooltip,
              child: Container(
                width: 18,
                height: 18,
                decoration: const BoxDecoration(color: AppColors.rose, shape: BoxShape.circle),
                child: const Icon(Icons.close_rounded, size: 12, color: Colors.white),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _AddPhotoSlot extends StatelessWidget {
  final String addLabel;
  final String maxNote;
  final VoidCallback onTap;
  const _AddPhotoSlot({required this.addLabel, required this.maxNote, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.cobaltLight.withValues(alpha: 0.4),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: AppColors.cobalt.withValues(alpha: 0.3), width: 1.5),
        ),
        alignment: Alignment.center,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.add_rounded, color: AppColors.cobalt, size: 18),
            const SizedBox(height: 2),
            Text(addLabel, textAlign: TextAlign.center, style: const TextStyle(fontSize: 8, fontWeight: FontWeight.w800, color: AppColors.cobalt)),
            Text(maxNote, style: const TextStyle(fontSize: 7, color: AppColors.textMuted)),
          ],
        ),
      ),
    );
  }
}
