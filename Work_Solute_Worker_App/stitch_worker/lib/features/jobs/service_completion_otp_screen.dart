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

/// Default End / Service Completion OTP. Default is '1234' with fallback '4821'.
const String _kDefaultEndOtp = '1234';

/// SERVICE COMPLETION OTP SCREEN
///
/// Displayed after work execution is completed and before payment & invoice generation.
/// The customer provides this 4-digit OTP to sign off on satisfactory completion.
class ServiceCompletionOtpScreen extends StatefulWidget {
  final Job job;
  const ServiceCompletionOtpScreen({super.key, required this.job});

  @override
  State<ServiceCompletionOtpScreen> createState() => _ServiceCompletionOtpScreenState();
}

class _ServiceCompletionOtpScreenState extends State<ServiceCompletionOtpScreen> {
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
    if (_enteredOtp == _kDefaultEndOtp || _enteredOtp == '4821') {
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
    final paymentJob = widget.job.copyWithStatus(JobStatus.paymentPending);
    context.push(Routes.jobPayment, extra: paymentJob);
  }

  String _fmtTime(int seconds) {
    final m = (seconds ~/ 60).toString().padLeft(2, '0');
    final s = (seconds % 60).toString().padLeft(2, '0');
    return '$m:$s';
  }

  String _fmt(double v) => '₹${v.toStringAsFixed(2)}';

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final job = widget.job;
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
          AppHeader(
            title: l10n.serviceCompletionOtpTitle,
            subtitle: '${l10n.customerJobId(job.jobId)} • ${job.customerName}',
            onBack: () => context.pop(),
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
              children: [
                // ─── 1. Service Completion Summary Card ───
                AppCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Container(
                                width: 28,
                                height: 28,
                                decoration: BoxDecoration(
                                  color: AppColors.emeraldBg,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: const Icon(Icons.task_alt_rounded, size: 16, color: AppColors.emerald),
                              ),
                              const SizedBox(width: 8),
                              Text(
                                l10n.workCompleted,
                                style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 13, color: AppColors.textPrimary),
                              ),
                            ],
                          ),
                          StatusChip.success(l10n.completed),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: AppColors.surfaceAlt,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: AppColors.border),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              job.serviceName,
                              style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 13, color: AppColors.textPrimary),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              job.address,
                              style: const TextStyle(fontSize: 11, color: AppColors.textSecondary),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 8),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text('Final Bill Total:', style: TextStyle(fontSize: 12, color: AppColors.textSecondary)),
                                Text(_fmt(total), style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w900, color: AppColors.cobalt)),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),
                      Wrap(
                        spacing: 6,
                        runSpacing: 6,
                        children: [
                          _chip('📸 2 Proof Photos Attached'),
                          _chip('🧹 Work Area Cleaned'),
                          _chip('📋 Instructions Followed'),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),

                // ─── 2. End OTP Entry or Verified Card ───
                if (!_verified) ...[
                  AppCard(
                    child: Column(
                      children: [
                        Container(
                          width: 48,
                          height: 48,
                          decoration: BoxDecoration(
                            color: AppColors.amberLight,
                            borderRadius: BorderRadius.circular(14),
                            border: Border.all(color: Colors.amber.shade200),
                          ),
                          child: const Icon(Icons.verified_user_rounded, color: AppColors.amberDark),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          l10n.serviceCompletionOtpSubtitle,
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w800),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          l10n.askCustomerForCompletionOtp(job.customerName),
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

                        // Digit inputs
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
                            decoration: BoxDecoration(
                              color: AppColors.roseLight,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: AppColors.rose.withValues(alpha: 0.3)),
                            ),
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
                    color: AppColors.emeraldBg,
                    borderColor: AppColors.emerald.withValues(alpha: 0.35),
                    child: Column(
                      children: [
                        Container(
                          width: 56,
                          height: 56,
                          decoration: const BoxDecoration(color: AppColors.emerald, shape: BoxShape.circle),
                          child: const Icon(Icons.verified_rounded, color: Colors.white, size: 30),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          l10n.completionOtpVerified,
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w800, color: AppColors.emeraldDark),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 6),
                        StatusChip.success(l10n.signedOff),
                        const SizedBox(height: 10),
                        const Text(
                          'Customer has signed off on the work. Final invoice calculation unlocked.',
                          style: TextStyle(fontSize: 12, color: AppColors.textSecondary),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ],

                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: AppColors.cobaltLight,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.blue.shade100),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.info_outline_rounded, size: 18, color: AppColors.cobalt),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          l10n.otpAlertDescription,
                          style: const TextStyle(fontSize: 11, color: AppColors.cobalt, fontWeight: FontWeight.w600),
                        ),
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
        decoration: const BoxDecoration(
          color: AppColors.cardWhite,
          border: Border(top: BorderSide(color: AppColors.border)),
        ),
        child: SafeArea(
          top: false,
          child: SizedBox(
            width: double.infinity,
            height: 48,
            child: ElevatedButton.icon(
              onPressed: _verified
                  ? _finish
                  : (_enteredOtp.length == 4 ? () => _verify(l10n) : null),
              style: ElevatedButton.styleFrom(
                backgroundColor: _verified ? AppColors.emerald : AppColors.cobalt,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                elevation: 0,
              ),
              icon: Icon(_verified ? Icons.arrow_forward_rounded : Icons.check_circle_outline_rounded, size: 18),
              label: Text(
                _verified ? l10n.proceedToPayment : l10n.verifyEndOtpAndComplete,
                style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 13, letterSpacing: 0.3),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _chip(String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
      decoration: BoxDecoration(
        color: AppColors.surfaceAlt,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: AppColors.border),
      ),
      child: Text(
        label,
        style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w600, color: AppColors.textSecondary),
      ),
    );
  }
}
