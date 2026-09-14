import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:stitch_worker/l10n/generated/app_localizations.dart';
import '../../app/router.dart';
import '../../app/theme/app_colors.dart';
import '../../core/models/job_model.dart';
import '../../core/widgets/app_header.dart';
import '../../core/widgets/shared_widgets.dart';

/// New Job Request screen — matches UI_REFERENCE/customer_job_details_with_problem_photos.
/// Worker reviews a fresh request and Accepts or Declines.
/// Schedule validation runs before Accept; on conflict, routes to
/// the CANNOT ACCEPT THIS REQUEST screen instead of proceeding.
class NewJobRequestScreen extends StatefulWidget {
  final Job job;
  const NewJobRequestScreen({super.key, required this.job});

  @override
  State<NewJobRequestScreen> createState() => _NewJobRequestScreenState();
}

class _NewJobRequestScreenState extends State<NewJobRequestScreen> {
  bool _isAccepted = false;
  bool _isProcessing = false;

  /// Simulated schedule-validation check (PLAN.md §19). In production this
  /// consults the worker's real calendar; here it flags an overlap against
  /// the demo institution job so the CANNOT ACCEPT flow is reachable.
  bool get _hasScheduleConflict {
    final other = DemoData.institutionJob;
    return widget.job.scheduledStart.isBefore(other.scheduledEnd) &&
        widget.job.scheduledEnd.isAfter(other.scheduledStart);
  }

  void _handleAccept() {
    if (_hasScheduleConflict) {
      context.push(Routes.scheduleConflict, extra: widget.job);
      return;
    }
    setState(() => _isProcessing = true);
    Future.delayed(const Duration(milliseconds: 700), () {
      if (!mounted) return;
      setState(() {
        _isProcessing = false;
        _isAccepted = true;
      });
      Future.delayed(const Duration(milliseconds: 900), () {
        if (!mounted) return;
        context.push(
          Routes.waitingForCustomer,
          extra: widget.job.copyWithStatus(JobStatus.waitingForCustomer),
        );
      });
    });
  }

  void _showDeclineSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) => _DeclineReasonSheet(
        onConfirm: () {
          Navigator.pop(ctx);
          context.pop();
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final job = widget.job;
    final platformFee = job.onsiteFee * (job.platformFeePercent / 100);
    final total = job.onsiteFee + platformFee;

    return Scaffold(
      backgroundColor: AppColors.surfaceAlt,
      body: Column(
        children: [
          AppHeader(
            title: l10n.newServiceRequest,
            subtitle: '${l10n.customer} • ${l10n.customerJobId(job.jobId)}',
            onBack: () => context.pop(),
            actions: [HeaderNotificationButton(badgeCount: 0)],
            bottom: Align(
              alignment: Alignment.centerLeft,
              child: StatusChip.warning(l10n.newRequestBadge),
            ),
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 140),
              children: [
                _buildCustomerCard(l10n, job),
                const SizedBox(height: 12),
                _buildServiceCard(l10n, job),
                const SizedBox(height: 12),
                _buildPhotosCard(l10n, job),
                const SizedBox(height: 12),
                _buildScheduleCard(l10n, job),
                const SizedBox(height: 12),
                _buildFeeCard(l10n, job, platformFee, total),
                if (job.customerInstructions.isNotEmpty) ...[
                  const SizedBox(height: 12),
                  _buildInstructionsCard(l10n, job),
                ],
              ],
            ),
          ),
        ],
      ),
      bottomSheet: _buildActionBar(l10n),
    );
  }

  Widget _buildCustomerCard(AppLocalizations l10n, Job job) {
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Stack(
                children: [
                  Container(
                    width: 48,
                    height: 48,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                        colors: [AppColors.cobalt, AppColors.indigo],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      job.customerInitials,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  Positioned(
                    right: -1,
                    bottom: -1,
                    child: Container(
                      width: 16,
                      height: 16,
                      decoration: BoxDecoration(
                        color: AppColors.emerald,
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 2),
                      ),
                      child: const Icon(Icons.check, color: Colors.white, size: 10),
                    ),
                  ),
                ],
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
                            style: Theme.of(context).textTheme.titleSmall,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        const SizedBox(width: 6),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                          decoration: BoxDecoration(
                            color: AppColors.emeraldBg,
                            borderRadius: BorderRadius.circular(6),
                            border: Border.all(color: AppColors.emerald.withValues(alpha: 0.3)),
                          ),
                          child: Text(
                            l10n.verifiedClient,
                            style: const TextStyle(
                              fontSize: 9,
                              fontWeight: FontWeight.w700,
                              color: AppColors.emeraldDark,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 2),
                    Text(
                      l10n.customerJobId(job.jobId),
                      style: const TextStyle(
                        color: AppColors.cobalt,
                        fontWeight: FontWeight.w600,
                        fontSize: 12,
                      ),
                    ),
                    if (job.customerMemberSinceYear != null)
                      Text(
                        l10n.memberSince(
                          job.customerMemberSinceYear!,
                          '${job.customerCompletedServices}',
                        ),
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                  ],
                ),
              ),
              _CircleIconButton(icon: Icons.call_rounded, onTap: () {}),
            ],
          ),
          const Divider(height: 24),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(Icons.location_on_rounded, size: 16, color: AppColors.cobalt),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  job.address,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildServiceCard(AppLocalizations l10n, Job job) {
    return AppCard(
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
                    Text(
                      job.serviceCategory.toUpperCase(),
                      style: const TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
                        color: AppColors.cobalt,
                        letterSpacing: 0.5,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(job.serviceName, style: Theme.of(context).textTheme.titleMedium),
                  ],
                ),
              ),
              if (job.onsiteFee > 0)
                StatusChip.info(l10n.onsiteRequired.toUpperCase()),
            ],
          ),
          const SizedBox(height: 10),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: AppColors.surfaceAlt,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppColors.border),
            ),
            child: Text(
              job.reportedProblem ?? '',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPhotosCard(AppLocalizations l10n, Job job) {
    if (job.problemPhotoLabels.isEmpty) return const SizedBox.shrink();
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                l10n.customerProblemPhotos,
                style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w700, letterSpacing: 0.3),
              ),
              const Spacer(),
              Text(
                l10n.viewAllPhotos('${job.problemPhotoLabels.length}'),
                style: const TextStyle(color: AppColors.cobalt, fontSize: 11, fontWeight: FontWeight.w700),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: job.problemPhotoLabels.asMap().entries.map((e) {
              final isLast = e.key == job.problemPhotoLabels.length - 1;
              return Expanded(
                child: Padding(
                  padding: EdgeInsets.only(right: isLast ? 0 : 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AspectRatio(
                        aspectRatio: 4 / 3,
                        child: Container(
                          decoration: BoxDecoration(
                            color: AppColors.cobaltLight,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: AppColors.border),
                          ),
                          child: const Icon(Icons.image_outlined, color: AppColors.cobalt, size: 28),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        e.value,
                        style: Theme.of(context).textTheme.labelMedium,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        l10n.photoTapToView,
                        style: const TextStyle(fontSize: 9, color: AppColors.cobalt),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: AppColors.surfaceAlt,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: AppColors.border),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(Icons.info_outline_rounded, size: 16, color: AppColors.cobalt),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    l10n.photoDisambiguationNote,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildScheduleCard(AppLocalizations l10n, Job job) {
    final start = job.scheduledStart;
    final timeLabel = '${start.hour.toString().padLeft(2, '0')}:${start.minute.toString().padLeft(2, '0')}';
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            l10n.scheduleLogistics.toUpperCase(),
            style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: AppColors.textMuted, letterSpacing: 0.4),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: _MiniInfoTile(
                  icon: Icons.calendar_today_rounded,
                  label: l10n.requestedTime,
                  value: timeLabel,
                  sub: '${l10n.estimatedDuration}: 60-90 ${l10n.mins}',
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _MiniInfoTile(
                  icon: Icons.near_me_rounded,
                  label: l10n.distance,
                  value: '${job.distance?.toStringAsFixed(1) ?? '-'} ${l10n.km}',
                  sub: job.distance != null ? l10n.travelTimeApprox('${(job.distance! * 3.6).round()}') : null,
                  subColor: AppColors.emeraldDark,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFeeCard(AppLocalizations l10n, Job job, double platformFee, double total) {
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  l10n.onsiteFee.toUpperCase(),
                  style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w700, letterSpacing: 0.3),
                ),
              ),
              TextButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.edit_rounded, size: 14),
                label: Text(l10n.editFee),
                style: TextButton.styleFrom(
                  backgroundColor: AppColors.cobaltLight,
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  minimumSize: Size.zero,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.surfaceAlt,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppColors.border),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  textBaseline: TextBaseline.alphabetic,
                  children: [
                    Text(
                      '${l10n.rupeeSymbol}${job.onsiteFee.toStringAsFixed(0)}',
                      style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w900, color: AppColors.textPrimary),
                    ),
                  ],
                ),
                Text(
                  l10n.youReceiveFullPayout('${l10n.rupeeSymbol}${job.onsiteFee.toStringAsFixed(0)}'),
                  style: const TextStyle(color: AppColors.emeraldDark, fontWeight: FontWeight.w700, fontSize: 11),
                ),
                const Divider(height: 20),
                _FeeRow(label: l10n.onsiteFee, value: job.onsiteFee, currency: l10n.rupeeSymbol),
                _FeeRow(
                  label: l10n.platformFeePercent(job.platformFeePercent.toStringAsFixed(0)),
                  value: platformFee,
                  currency: l10n.rupeeSymbol,
                ),
                const Divider(height: 16),
                _FeeRow(
                  label: l10n.totalCustomerPays,
                  value: total,
                  currency: l10n.rupeeSymbol,
                  bold: true,
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: AppColors.cobaltLight,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              l10n.guaranteedPayoutNote,
              style: const TextStyle(fontSize: 11, color: AppColors.textSecondary),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInstructionsCard(AppLocalizations l10n, Job job) {
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            l10n.customerInstructionsTitle.toUpperCase(),
            style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: AppColors.textMuted, letterSpacing: 0.4),
          ),
          const SizedBox(height: 8),
          ...job.customerInstructions.map(
            (note) => Padding(
              padding: const EdgeInsets.only(bottom: 6),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('•  ', style: TextStyle(color: AppColors.cobalt, fontWeight: FontWeight.w700)),
                  Expanded(child: Text(note, style: Theme.of(context).textTheme.bodyMedium)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionBar(AppLocalizations l10n) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 20),
      decoration: BoxDecoration(
        color: AppColors.cardWhite,
        border: const Border(top: BorderSide(color: AppColors.border)),
        boxShadow: [BoxShadow(color: AppColors.navy.withValues(alpha: 0.08), blurRadius: 16, offset: const Offset(0, -4))],
      ),
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (_isAccepted)
              Container(
                margin: const EdgeInsets.only(bottom: 12),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppColors.emeraldBg,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppColors.emerald.withValues(alpha: 0.3)),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 22,
                      height: 22,
                      decoration: const BoxDecoration(color: AppColors.emerald, shape: BoxShape.circle),
                      alignment: Alignment.center,
                      child: const Icon(Icons.check, color: Colors.white, size: 14),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        l10n.jobAcceptedWaitingNote,
                        style: const TextStyle(color: AppColors.emeraldDark, fontWeight: FontWeight.w600, fontSize: 12),
                      ),
                    ),
                  ],
                ),
              )
            else
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: _isProcessing ? null : _showDeclineSheet,
                      style: OutlinedButton.styleFrom(
                        foregroundColor: AppColors.rose,
                        side: const BorderSide(color: AppColors.rose, width: 1.5),
                      ),
                      child: Text(l10n.decline),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: _isProcessing ? null : _handleAccept,
                      child: _isProcessing
                          ? const SizedBox(
                              width: 18,
                              height: 18,
                              child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                            )
                          : Text(l10n.accept),
                    ),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}

class _MiniInfoTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final String? sub;
  final Color? subColor;

  const _MiniInfoTile({required this.icon, required this.label, required this.value, this.sub, this.subColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: AppColors.surfaceAlt,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 14, color: AppColors.cobalt),
              const SizedBox(width: 6),
              Expanded(
                child: Text(label, style: Theme.of(context).textTheme.labelMedium, overflow: TextOverflow.ellipsis),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(value, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 13)),
          if (sub != null)
            Text(sub!, style: TextStyle(fontSize: 10, color: subColor ?? AppColors.textMuted)),
        ],
      ),
    );
  }
}

class _FeeRow extends StatelessWidget {
  final String label;
  final double value;
  final String currency;
  final bool bold;

  const _FeeRow({required this.label, required this.value, required this.currency, this.bold = false});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        children: [
          Expanded(
            child: Text(
              label,
              style: TextStyle(fontSize: 12, color: AppColors.textSecondary, fontWeight: bold ? FontWeight.w700 : FontWeight.w500),
            ),
          ),
          Text(
            '$currency${value.toStringAsFixed(2)}',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w700,
              color: bold ? AppColors.cobalt : AppColors.textPrimary,
            ),
          ),
        ],
      ),
    );
  }
}

class _CircleIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  const _CircleIconButton({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 36,
        height: 36,
        decoration: BoxDecoration(color: AppColors.cobaltLight, borderRadius: BorderRadius.circular(10)),
        child: Icon(icon, size: 16, color: AppColors.cobalt),
      ),
    );
  }
}

class _DeclineReasonSheet extends StatefulWidget {
  final VoidCallback onConfirm;
  const _DeclineReasonSheet({required this.onConfirm});

  @override
  State<_DeclineReasonSheet> createState() => _DeclineReasonSheetState();
}

class _DeclineReasonSheetState extends State<_DeclineReasonSheet> {
  int? _selected;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final reasons = [
      l10n.scheduleConflict,
      l10n.emergency,
      l10n.vehicleBreakdown,
      l10n.unsafeLocation,
      l10n.incorrectJobDetails,
      l10n.other,
    ];
    return Container(
      padding: EdgeInsets.fromLTRB(20, 20, 20, 20 + MediaQuery.of(context).viewInsets.bottom),
      decoration: const BoxDecoration(
        color: AppColors.cardWhite,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(l10n.selectReason, style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 4),
          Text(l10n.reasonForCancellation, style: Theme.of(context).textTheme.bodySmall),
          const SizedBox(height: 16),
          ...List.generate(reasons.length, (i) {
            final selected = _selected == i;
            return Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: InkWell(
                onTap: () => setState(() => _selected = i),
                borderRadius: BorderRadius.circular(12),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                  decoration: BoxDecoration(
                    color: selected ? AppColors.cobaltLight : AppColors.surfaceAlt,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: selected ? AppColors.cobalt : AppColors.border),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        selected ? Icons.radio_button_checked : Icons.radio_button_off,
                        size: 18,
                        color: selected ? AppColors.cobalt : AppColors.textMuted,
                      ),
                      const SizedBox(width: 10),
                      Expanded(child: Text(reasons[i], style: Theme.of(context).textTheme.bodyMedium)),
                    ],
                  ),
                ),
              ),
            );
          }),
          const SizedBox(height: 8),
          ElevatedButton(
            onPressed: _selected == null ? null : widget.onConfirm,
            style: ElevatedButton.styleFrom(backgroundColor: AppColors.rose),
            child: Text(l10n.decline),
          ),
        ],
      ),
    );
  }
}
