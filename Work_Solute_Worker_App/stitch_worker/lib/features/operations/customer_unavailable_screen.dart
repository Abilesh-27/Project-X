import 'dart:async';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:stitch_worker/l10n/generated/app_localizations.dart';
import '../../app/theme/app_colors.dart';
import '../../app/router.dart';
import '../../core/models/job_model.dart';
import '../../core/widgets/shared_widgets.dart';

/// Customer Unavailable Protocol Screen.
/// Guides worker through verification steps: Call -> Message -> 10m Wait -> GPS arrival proof -> Claim ₹150 visit fee.
class CustomerUnavailableScreen extends StatefulWidget {
  final Job job;
  const CustomerUnavailableScreen({super.key, required this.job});

  @override
  State<CustomerUnavailableScreen> createState() => _CustomerUnavailableScreenState();
}

class _CustomerUnavailableScreenState extends State<CustomerUnavailableScreen> {
  bool _callAttempted = true;
  bool _messageSent = true;
  int _secondsRemaining = 480; // 8 minutes remaining
  Timer? _timer;
  bool _isLogged = false;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_secondsRemaining > 0) {
        setState(() => _secondsRemaining--);
      } else {
        _timer?.cancel();
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  String get _formattedTimer {
    final m = (_secondsRemaining ~/ 60).toString().padLeft(2, '0');
    final s = (_secondsRemaining % 60).toString().padLeft(2, '0');
    return '$m:$s';
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Scaffold(
      backgroundColor: AppColors.surface,
      appBar: AppBar(
        backgroundColor: AppColors.navy,
        foregroundColor: Colors.white,
        title: Text(
          l10n.customerUnavailableTitle,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
      ),
      body: SafeArea(
        child: _isLogged
            ? _buildUnavailableLoggedView(l10n)
            : ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  // Target job summary
                  AppCard(
                    padding: const EdgeInsets.all(14),
                    child: Row(
                      children: [
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: AppColors.amber.withValues(alpha: 0.15),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Icon(Icons.person_off_rounded, color: AppColors.amberDark, size: 22),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${widget.job.customerName} • Job #${widget.job.jobId}',
                                style: const TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.textPrimary,
                                ),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                widget.job.address,
                                style: const TextStyle(fontSize: 11, color: AppColors.textMuted),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Timer card
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFF0F223D), Color(0xFF1E3A8A)],
                      ),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      children: [
                        Text(
                          l10n.stepWaitTimer.toUpperCase(),
                          style: TextStyle(
                            color: Colors.blue.shade200,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          _formattedTimer,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 36,
                            fontWeight: FontWeight.w900,
                            letterSpacing: 2,
                          ),
                        ),
                        const SizedBox(height: 4),
                        const Text(
                          'Cooperative protocol requires a 10-minute wait at location',
                          style: TextStyle(color: Colors.white70, fontSize: 11),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 18),

                  // Verification steps
                  _buildProtocolStep(
                    icon: Icons.phone_in_talk,
                    title: l10n.stepCallCustomer,
                    subtitle: '2 Call attempts logged (${widget.job.customerPhone ?? "+91 9871234567"})',
                    isComplete: _callAttempted,
                    actionLabel: l10n.callNow,
                    onAction: () => setState(() => _callAttempted = true),
                  ),
                  const SizedBox(height: 10),
                  _buildProtocolStep(
                    icon: Icons.chat_bubble_outline,
                    title: l10n.stepSendMessage,
                    subtitle: 'Arrival notification SMS and push alert sent',
                    isComplete: _messageSent,
                    actionLabel: l10n.messageNow,
                    onAction: () => setState(() => _messageSent = true),
                  ),
                  const SizedBox(height: 10),
                  _buildProtocolStep(
                    icon: Icons.location_on,
                    title: l10n.stepArrivalEvidence,
                    subtitle: 'GPS Geofence match within 25m of registered site',
                    isComplete: true,
                  ),
                  const SizedBox(height: 18),

                  // Guaranteed visit fee card
                  Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: AppColors.emeraldLight,
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(color: AppColors.emerald.withValues(alpha: 0.4)),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.check_circle, color: AppColors.emeraldDark, size: 22),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                l10n.claimOnsiteFee,
                                style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.emeraldDark,
                                ),
                              ),
                              const SizedBox(height: 2),
                              const Text(
                                'Cooperative guarantees onsite visit compensation for verified arrivals.',
                                style: TextStyle(fontSize: 10, color: AppColors.textSecondary),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Action CTA
                  AppButton(
                    label: l10n.recordUnavailable,
                    icon: Icons.assignment_turned_in,
                    backgroundColor: AppColors.navy,
                    onPressed: () {
                      setState(() => _isLogged = true);
                    },
                  ),
                ],
              ),
      ),
    );
  }

  Widget _buildProtocolStep({
    required IconData icon,
    required String title,
    required String subtitle,
    required bool isComplete,
    String? actionLabel,
    VoidCallback? onAction,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.cardWhite,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        children: [
          Container(
            width: 34,
            height: 34,
            decoration: BoxDecoration(
              color: isComplete
                  ? AppColors.emerald.withValues(alpha: 0.15)
                  : AppColors.surfaceAlt,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              icon,
              size: 18,
              color: isComplete ? AppColors.emeraldDark : AppColors.textMuted,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppColors.textPrimary),
                ),
                Text(subtitle, style: const TextStyle(fontSize: 10, color: AppColors.textMuted)),
              ],
            ),
          ),
          if (isComplete)
            const Icon(Icons.check_circle, size: 18, color: AppColors.emerald)
          else if (actionLabel != null && onAction != null)
            TextButton(
              onPressed: onAction,
              style: TextButton.styleFrom(padding: EdgeInsets.zero, minimumSize: const Size(50, 30)),
              child: Text(actionLabel, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold)),
            ),
        ],
      ),
    );
  }

  Widget _buildUnavailableLoggedView(AppLocalizations l10n) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 64,
              height: 64,
              decoration: BoxDecoration(
                color: AppColors.emeraldLight,
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.verified, size: 36, color: AppColors.emeraldDark),
            ),
            const SizedBox(height: 16),
            const Text(
              'Case Documented & Closed',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              l10n.unavailableLogged,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 12, color: AppColors.textMuted, height: 1.4),
            ),
            const SizedBox(height: 24),
            AppButton(
              label: l10n.close,
              onPressed: () => context.go(Routes.home),
            ),
          ],
        ),
      ),
    );
  }
}
