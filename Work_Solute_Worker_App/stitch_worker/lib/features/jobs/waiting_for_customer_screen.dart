import 'dart:async';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:stitch_worker/l10n/generated/app_localizations.dart';
import '../../app/router.dart';
import '../../app/theme/app_colors.dart';
import '../../core/models/job_model.dart';
import '../../core/widgets/app_header.dart';
import '../../core/widgets/shared_widgets.dart';

/// WAITING FOR CUSTOMER SELECTION → CUSTOMER SELECTED YOU ✓ (PLAN.md §20).
/// A live countdown represents the selection-expiry window; once the
/// customer picks this worker, the screen flips to the confirmation
/// banner and the worker can continue to the Job Confirmed screen.
class WaitingForCustomerScreen extends StatefulWidget {
  final Job job;
  const WaitingForCustomerScreen({super.key, required this.job});

  @override
  State<WaitingForCustomerScreen> createState() => _WaitingForCustomerScreenState();
}

class _WaitingForCustomerScreenState extends State<WaitingForCustomerScreen> {
  Duration _remaining = const Duration(minutes: 14, seconds: 32);
  bool _isSelected = false;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (!mounted) return;
      if (_isSelected) return;
      setState(() {
        if (_remaining.inSeconds > 0) {
          _remaining -= const Duration(seconds: 1);
        }
      });
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _simulateCustomerSelection() {
    setState(() => _isSelected = true);
  }

  String _formatDuration(Duration d) {
    final m = d.inMinutes.toString().padLeft(2, '0');
    final s = (d.inSeconds % 60).toString().padLeft(2, '0');
    return '$m:$s';
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final job = widget.job;

    return Scaffold(
      backgroundColor: AppColors.surfaceAlt,
      body: Column(
        children: [
          AppHeader(
            title: _isSelected ? l10n.jobConfirmed : l10n.waitingForCustomer,
            subtitle: l10n.customerJobId(job.jobId),
            onBack: () => context.pop(),
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                if (_isSelected) _buildSelectedBanner(l10n) else _buildWaitingBanner(l10n),
                const SizedBox(height: 16),
                AppCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(job.serviceName, style: Theme.of(context).textTheme.titleSmall),
                      const SizedBox(height: 4),
                      Text('${job.customerName} • ${job.addressShort ?? job.address}', style: Theme.of(context).textTheme.bodySmall),
                      const Divider(height: 24),
                      Row(
                        children: [
                          Expanded(child: _StatRow(label: l10n.onsiteFee, value: '${l10n.rupeeSymbol}${job.onsiteFee.toStringAsFixed(0)}')),
                          Expanded(child: _StatRow(label: l10n.distance, value: '${job.distance?.toStringAsFixed(1) ?? '-'} ${l10n.km}')),
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
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 20),
        decoration: BoxDecoration(
          color: AppColors.cardWhite,
          border: const Border(top: BorderSide(color: AppColors.border)),
        ),
        child: SafeArea(
          top: false,
          child: _isSelected
              ? ElevatedButton(
                  onPressed: () => context.go(
                    Routes.jobConfirmed,
                    extra: job.copyWithStatus(JobStatus.confirmed),
                  ),
                  child: Text(l10n.jobConfirmed),
                )
              : OutlinedButton(
                  // Demo-only affordance: in production this state advances
                  // automatically when the customer confirms their choice.
                  onPressed: _simulateCustomerSelection,
                  child: Text(l10n.customerSelectedYou),
                ),
        ),
      ),
    );
  }

  Widget _buildWaitingBanner(AppLocalizations l10n) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.cobaltLight,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.cobalt.withValues(alpha: 0.2)),
      ),
      child: Column(
        children: [
          SizedBox(
            width: 56,
            height: 56,
            child: Stack(
              alignment: Alignment.center,
              children: [
                const CircularProgressIndicator(strokeWidth: 3, color: AppColors.cobalt),
                const Icon(Icons.hourglass_top_rounded, color: AppColors.cobalt, size: 22),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Text(
            l10n.waitingForCustomer.toUpperCase(),
            style: Theme.of(context).textTheme.titleSmall?.copyWith(color: AppColors.cobaltHover),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 4),
          Text(l10n.candidateStatus, style: Theme.of(context).textTheme.bodyMedium, textAlign: TextAlign.center),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
            decoration: BoxDecoration(color: AppColors.cardWhite, borderRadius: BorderRadius.circular(10)),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('${l10n.selectionExpiry} ', style: Theme.of(context).textTheme.bodySmall),
                Text(
                  _formatDuration(_remaining),
                  style: const TextStyle(fontWeight: FontWeight.w700, color: AppColors.cobalt),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSelectedBanner(AppLocalizations l10n) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.emeraldBg,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.emerald.withValues(alpha: 0.3)),
      ),
      child: Column(
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: const BoxDecoration(color: AppColors.emerald, shape: BoxShape.circle),
            child: const Icon(Icons.check_rounded, color: Colors.white, size: 28),
          ),
          const SizedBox(height: 12),
          Text(
            l10n.customerSelectedYou,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(color: AppColors.emeraldDark),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 4),
          Text(l10n.jobConfirmed, style: Theme.of(context).textTheme.bodyMedium, textAlign: TextAlign.center),
        ],
      ),
    );
  }
}

class _StatRow extends StatelessWidget {
  final String label;
  final String value;
  const _StatRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: Theme.of(context).textTheme.labelMedium),
        const SizedBox(height: 2),
        Text(value, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 14)),
      ],
    );
  }
}
