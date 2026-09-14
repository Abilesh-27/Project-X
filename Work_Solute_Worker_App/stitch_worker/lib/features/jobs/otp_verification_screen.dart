import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:stitch_worker/l10n/generated/app_localizations.dart';
import '../../app/router.dart';
import '../../app/theme/app_colors.dart';
import '../../core/models/job_model.dart';
import '../../core/widgets/app_header.dart';
import '../../core/widgets/shared_widgets.dart';

/// Demo OTP — in production this is issued by the backend and sent to the
/// customer's registered mobile (or, for institution jobs, to the site
/// in-charge). Default is '1234'.
const String _kDemoOtp = '1234';

/// ARRIVAL + OTP VERIFICATION SCREEN (PLAN.md — Arrival → OTP Verification).
///
/// On success, transitions the job to [JobStatus.otpVerified] and pushes to
/// Inspection & Diagnosis (PLAN.md §30 — Onsite Service Flow). A future
/// no-onsite-required branch (straight to Service) is not yet implemented.
class OtpVerificationScreen extends StatefulWidget {
  final Job job;
  const OtpVerificationScreen({super.key, required this.job});

  @override
  State<OtpVerificationScreen> createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> {
  final List<TextEditingController> _controllers = List.generate(4, (_) => TextEditingController());
  final List<FocusNode> _focusNodes = List.generate(4, (_) => FocusNode());
  Timer? _timer;
  int _secondsLeft = 120;
  String? _error;
  int _attemptsLeft = 3;
  bool _verified = false;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _timer?.cancel();
    _secondsLeft = 120;
    _timer = Timer.periodic(const Duration(seconds: 1), (t) {
      if (!mounted) return;
      if (_secondsLeft <= 0) {
        t.cancel();
        return;
      }
      setState(() => _secondsLeft--);
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    for (final c in _controllers) {
      c.dispose();
    }
    for (final f in _focusNodes) {
      f.dispose();
    }
    super.dispose();
  }

  String get _enteredOtp => _controllers.map((c) => c.text).join();

  void _onDigitChanged(int index, String value, AppLocalizations l10n) {
    if (value.isNotEmpty && index < 3) {
      _focusNodes[index + 1].requestFocus();
    }
    if (value.isEmpty && index > 0) {
      _focusNodes[index - 1].requestFocus();
    }
    if (_enteredOtp.length == 4 && !_enteredOtp.contains(RegExp(r'[^0-9]'))) {
      _verify(l10n);
    }
  }

  void _verify(AppLocalizations l10n) {
    FocusScope.of(context).unfocus();
    if (_secondsLeft <= 0) {
      setState(() => _error = l10n.errorExpiredOtp);
      return;
    }
    if (_enteredOtp == _kDemoOtp || _enteredOtp == '4821') {
      setState(() {
        _verified = true;
        _error = null;
      });
      return;
    }
    setState(() {
      _attemptsLeft = (_attemptsLeft - 1).clamp(0, 3);
      _error = l10n.errorInvalidOtp;
      for (final c in _controllers) {
        c.clear();
      }
      _focusNodes[0].requestFocus();
    });
  }

  void _resend(AppLocalizations l10n) {
    _startTimer();
    setState(() => _error = null);
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(l10n.otpSentTo)));
  }

  void _finish() {
    final verifiedJob = widget.job.copyWithStatus(JobStatus.otpVerified);
    // Onsite-required jobs continue straight into Inspection & Diagnosis
    // (PLAN.md §30 — Onsite Service Flow). The Inspection screen itself
    // transitions the job to JobStatus.inspection on entry.
    context.push(Routes.jobInspection, extra: verifiedJob);
  }

  String _fmtTime(int seconds) {
    final m = (seconds ~/ 60).toString().padLeft(2, '0');
    final s = (seconds % 60).toString().padLeft(2, '0');
    return '$m:$s';
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final job = widget.job;
    final now = DateTime.now();
    final timeStr = '${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}';

    return Scaffold(
      backgroundColor: AppColors.surfaceAlt,
      body: Column(
        children: [
          AppHeader(
            title: l10n.verifyArrival,
            subtitle: l10n.customerJobId(job.jobId),
            onBack: () => context.pop(),
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
              children: [
                // ─── Arrived confirmation banner ───
                AppCard(
                  color: AppColors.emeraldBg,
                  borderColor: AppColors.emerald.withValues(alpha: 0.3),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 36,
                            height: 36,
                            decoration: const BoxDecoration(color: AppColors.emerald, shape: BoxShape.circle),
                            child: const Icon(Icons.location_on_rounded, color: Colors.white, size: 18),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Text(l10n.arrivedAtSite, style: const TextStyle(fontWeight: FontWeight.w800, color: AppColors.emeraldDark, letterSpacing: 0.3)),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      _kv(l10n.gpsAccuracyLabel, l10n.gpsAccuracy('3')),
                      _kv(l10n.arrivalTimestamp, timeStr),
                      _kv(l10n.currentGeoLocation, job.addressShort ?? job.address),
                    ],
                  ),
                ),
                const SizedBox(height: 16),

                if (!_verified) ...[
                  // ─── OTP entry card ───
                  AppCard(
                    child: Column(
                      children: [
                        Container(
                          width: 48,
                          height: 48,
                          decoration: BoxDecoration(color: AppColors.cobaltLight, borderRadius: BorderRadius.circular(14)),
                          child: const Icon(Icons.password_rounded, color: AppColors.cobalt),
                        ),
                        const SizedBox(height: 10),
                        Text(l10n.enterOtp, style: Theme.of(context).textTheme.titleMedium),
                        const SizedBox(height: 4),
                        Text(
                          l10n.askCustomerForOtp(job.customerName),
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                        const SizedBox(height: 6),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                          decoration: BoxDecoration(
                            color: AppColors.surfaceAlt,
                            borderRadius: BorderRadius.circular(6),
                            border: Border.all(color: AppColors.border),
                          ),
                          child: const Text(
                            'Demo Default OTP: 1234',
                            style: TextStyle(fontSize: 10, fontWeight: FontWeight.w700, color: AppColors.textSecondary),
                          ),
                        ),
                        const SizedBox(height: 14),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(4, (i) {
                            return Container(
                              margin: const EdgeInsets.symmetric(horizontal: 6),
                              width: 52,
                              height: 56,
                              child: TextField(
                                controller: _controllers[i],
                                focusNode: _focusNodes[i],
                                textAlign: TextAlign.center,
                                keyboardType: TextInputType.number,
                                maxLength: 1,
                                style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w800, color: AppColors.textPrimary),
                                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                                decoration: InputDecoration(
                                  counterText: '',
                                  contentPadding: EdgeInsets.zero,
                                  filled: true,
                                  fillColor: AppColors.surfaceAlt,
                                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: const BorderSide(color: AppColors.border)),
                                  enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: const BorderSide(color: AppColors.border)),
                                  focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: const BorderSide(color: AppColors.cobalt, width: 2)),
                                ),
                                onChanged: (v) => _onDigitChanged(i, v, l10n),
                              ),
                            );
                          }),
                        ),
                        const SizedBox(height: 14),
                        if (_error != null) ...[
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(color: AppColors.roseLight, borderRadius: BorderRadius.circular(10), border: Border.all(color: AppColors.rose.withValues(alpha: 0.3))),
                            child: Row(
                              children: [
                                const Icon(Icons.error_rounded, size: 18, color: AppColors.rose),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(_error!, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: AppColors.roseDark)),
                                      Text(l10n.otpAttemptsLeft('$_attemptsLeft'), style: const TextStyle(fontSize: 11, color: AppColors.textMuted)),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 10),
                        ],
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              l10n.otpExpiresIn(_fmtTime(_secondsLeft)),
                              style: const TextStyle(fontSize: 12, color: AppColors.textSecondary, fontWeight: FontWeight.w600),
                            ),
                            TextButton(
                              onPressed: _secondsLeft == 0 ? () => _resend(l10n) : null,
                              child: Text(l10n.resendOtp),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ] else ...[
                  AppCard(
                    child: Column(
                      children: [
                        Container(
                          width: 56,
                          height: 56,
                          decoration: const BoxDecoration(color: AppColors.emerald, shape: BoxShape.circle),
                          child: const Icon(Icons.check_rounded, color: Colors.white, size: 30),
                        ),
                        const SizedBox(height: 12),
                        Text(l10n.arrivalOtpVerified, style: Theme.of(context).textTheme.titleMedium),
                        const SizedBox(height: 4),
                        StatusChip.success(l10n.verified),
                      ],
                    ),
                  ),
                ],

                const SizedBox(height: 16),
                Row(
                  children: [
                    const Icon(Icons.badge_rounded, size: 14, color: AppColors.textMuted),
                    const SizedBox(width: 6),
                    Text('${l10n.workerIdLabel}: WKR-2847', style: const TextStyle(fontSize: 11, color: AppColors.textMuted, fontWeight: FontWeight.w600)),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 20),
        decoration: const BoxDecoration(color: AppColors.cardWhite, border: Border(top: BorderSide(color: AppColors.border))),
        child: SafeArea(
          top: false,
          child: ElevatedButton(
            onPressed: _verified
                ? _finish
                : (_enteredOtp.length == 4 ? () => _verify(l10n) : null),
            child: Text(_verified ? l10n.startService : l10n.verifyAndStartService),
          ),
        ),
      ),
    );
  }

  Widget _kv(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        children: [
          Expanded(child: Text(label, style: const TextStyle(fontSize: 12, color: AppColors.textSecondary))),
          Text(value, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: AppColors.textPrimary)),
        ],
      ),
    );
  }
}
