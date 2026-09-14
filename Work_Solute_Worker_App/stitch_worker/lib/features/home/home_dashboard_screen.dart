import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:stitch_worker/l10n/generated/app_localizations.dart';
import '../../app/theme/app_colors.dart';
import '../../app/router.dart';
import '../../core/models/job_model.dart';
import '../../core/widgets/shared_widgets.dart';

/// Worker Home Dashboard — faithful to the Stitch reference UI.
/// Navy header with worker identity → scrollable content:
///   1. Active Day toggle
///   2. Upcoming job card with START JOURNEY
///   3. Today's Live Activity stepper
///   4. B2C / B2B tabs
///   5. Daily summary
class HomeDashboardScreen extends StatefulWidget {
  const HomeDashboardScreen({super.key});

  @override
  State<HomeDashboardScreen> createState() => _HomeDashboardScreenState();
}

class _HomeDashboardScreenState extends State<HomeDashboardScreen> {
  bool _isActiveDay = true;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Column(
      children: [
        _buildDashboardHeader(l10n),
        Expanded(
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              _buildActiveDayCard(l10n),
              const SizedBox(height: 14),
              _buildUpcomingJobCard(l10n),
              const SizedBox(height: 14),
              _buildLiveActivityCard(l10n),
              const SizedBox(height: 14),
              _buildImportantAlertCard(l10n),
              const SizedBox(height: 14),
              _buildCustomerWorkCard(l10n),
              const SizedBox(height: 14),
              _buildInstitutionWorkCard(l10n),
              const SizedBox(height: 14),
              _buildDailySummary(l10n),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ],
    );
  }

  // ─── Navy Header ────────────────────────────────────────
  Widget _buildDashboardHeader(AppLocalizations l10n) {
    final worker = DemoData.worker;
    final hour = DateTime.now().hour;
    final greeting = hour < 12 ? l10n.goodMorning : (hour < 17 ? l10n.goodAfternoon : l10n.goodEvening);

    return Container(
      color: AppColors.navy,
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 4, 20, 20),
          child: Row(
            children: [
              // Worker avatar
              GestureDetector(
                onTap: () => context.push(Routes.profile),
                child: Stack(
                  children: [
                    Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: const LinearGradient(
                          colors: [Color(0xFF1D4ED8), Color(0xFF6366F1)],
                        ),
                        border: Border.all(color: Colors.white.withValues(alpha: 0.2), width: 2),
                      ),
                      child: Center(
                        child: Text(
                          worker.initials,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        width: 16,
                        height: 16,
                        decoration: BoxDecoration(
                          color: AppColors.emerald,
                          shape: BoxShape.circle,
                          border: Border.all(color: AppColors.navy, width: 2),
                        ),
                        child: const Icon(Icons.check, size: 10, color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 14),
              // Greeting + worker info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Flexible(
                          child: Text(
                            greeting.toUpperCase(),
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 1,
                              color: Colors.blue.shade200.withValues(alpha: 0.9),
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Container(
                          width: 4,
                          height: 4,
                          margin: const EdgeInsets.symmetric(horizontal: 6),
                          decoration: BoxDecoration(
                            color: Colors.blue.shade400,
                            shape: BoxShape.circle,
                          ),
                        ),
                        Text(
                          l10n.verified,
                          style: const TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                            color: AppColors.emerald,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 2),
                    Text(
                      worker.name,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w800,
                        letterSpacing: -0.3,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      '${worker.workerId} • ${worker.role}',
                      style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.6),
                        fontSize: 11,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              // Notification bell
              GestureDetector(
                onTap: () => context.push(Routes.notifications),
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white.withValues(alpha: 0.1),
                    border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
                  ),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      const Icon(Icons.notifications_outlined, color: Colors.white, size: 20),
                      Positioned(
                        top: 8,
                        right: 8,
                        child: Container(
                          width: 8,
                          height: 8,
                          decoration: BoxDecoration(
                            color: AppColors.amber,
                            shape: BoxShape.circle,
                            border: Border.all(color: AppColors.navy, width: 2),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ─── Active Day Toggle ──────────────────────────────────
  Widget _buildActiveDayCard(AppLocalizations l10n) {
    return AppCard(
      padding: const EdgeInsets.all(14),
      child: Row(
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: _isActiveDay ? AppColors.emeraldBg : AppColors.roseLight,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: _isActiveDay ? AppColors.emerald.withValues(alpha: 0.3) : AppColors.rose.withValues(alpha: 0.3),
              ),
            ),
            child: Center(
              child: Container(
                width: 12,
                height: 12,
                decoration: BoxDecoration(
                  color: _isActiveDay ? AppColors.emerald : AppColors.rose,
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Wrap(
                  crossAxisAlignment: WrapCrossAlignment.center,
                  spacing: 8,
                  runSpacing: 4,
                  children: [
                    Text(
                      _isActiveDay ? '🟢 ${l10n.activeDay}' : '🔴 ${l10n.inactiveDay}',
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w800,
                        color: AppColors.textPrimary,
                        letterSpacing: 0.3,
                      ),
                    ),
                    if (_isActiveDay)
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          color: AppColors.emeraldBg,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          l10n.onCall.toUpperCase(),
                          style: const TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w700,
                            color: AppColors.emeraldDark,
                          ),
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 2),
                Text(
                  _isActiveDay ? l10n.readyToReceive : l10n.requestsPaused,
                  style: const TextStyle(
                    fontSize: 11,
                    color: AppColors.textSecondary,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () => setState(() => _isActiveDay = !_isActiveDay),
            child: Container(
              width: 48,
              height: 28,
              decoration: BoxDecoration(
                color: _isActiveDay ? AppColors.cobalt : AppColors.textSlate,
                borderRadius: BorderRadius.circular(14),
              ),
              padding: const EdgeInsets.all(2),
              child: AnimatedAlign(
                duration: const Duration(milliseconds: 200),
                alignment: _isActiveDay ? Alignment.centerRight : Alignment.centerLeft,
                child: Container(
                  width: 24,
                  height: 24,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: _isActiveDay
                      ? const Icon(Icons.check, size: 14, color: AppColors.cobalt)
                      : null,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ─── Upcoming Job Card ──────────────────────────────────
  Widget _buildUpcomingJobCard(AppLocalizations l10n) {
    final job = DemoData.customerJob;
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.white, Colors.blue.shade50.withValues(alpha: 0.4), Colors.indigo.shade50.withValues(alpha: 0.3)],
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.blue.shade200, width: 2),
        boxShadow: [
          BoxShadow(
            color: AppColors.cobalt.withValues(alpha: 0.1),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      padding: const EdgeInsets.all(14),
      child: Column(
        children: [
          // "Service starts in" header
          Wrap(
            alignment: WrapAlignment.spaceBetween,
            crossAxisAlignment: WrapCrossAlignment.center,
            spacing: 8,
            runSpacing: 6,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.cobaltLight,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.blue.shade200),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 6,
                      height: 6,
                      decoration: const BoxDecoration(
                        color: AppColors.cobalt,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 6),
                    ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 220),
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        alignment: Alignment.centerLeft,
                        child: Text(
                          l10n.serviceStartsIn('1 ${l10n.hrs}').toUpperCase(),
                          style: const TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w800,
                            color: AppColors.cobalt,
                            letterSpacing: 0.5,
                          ),
                          maxLines: 1,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: AppColors.amberLight,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.amber.shade200),
                ),
                child: Text(
                  l10n.startsIn('58'),
                  style: const TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                    color: AppColors.amberDark,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          // Job details card
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.8),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.blue.shade100),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Wrap(
                  alignment: WrapAlignment.spaceBetween,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  spacing: 8,
                  runSpacing: 4,
                  children: [
                    Text(
                      job.serviceName,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w800,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(
                        color: AppColors.cobaltLight,
                        borderRadius: BorderRadius.circular(4),
                        border: Border.all(color: Colors.blue.shade200),
                      ),
                      child: Text(
                        l10n.customerJobId(job.jobId),
                        style: const TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w700,
                          color: AppColors.cobalt,
                          letterSpacing: 0.3,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                _jobDetailRow(Icons.person_outline, '${l10n.customer}: ${job.customerName}'),
                const SizedBox(height: 4),
                _jobDetailRow(Icons.access_time, '${l10n.scheduled}: 10:00 AM – 11:30 AM'),
                const SizedBox(height: 4),
                _jobDetailRow(Icons.location_on_outlined, job.addressShort ?? job.address),
              ],
            ),
          ),
          const SizedBox(height: 12),
          // START JOURNEY button
          SizedBox(
            width: double.infinity,
            height: 42,
            child: ElevatedButton(
              onPressed: () {
                context.push(Routes.jobJourney, extra: job);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.cobalt,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                elevation: 2,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.arrow_forward, size: 16),
                  const SizedBox(width: 8),
                  Text(
                    l10n.startJourney.toUpperCase(),
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 0.5,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 10),
          // ON TIME / DELAYED / CANCEL buttons
          Container(
            padding: const EdgeInsets.only(top: 10),
            decoration: BoxDecoration(
              border: Border(top: BorderSide(color: AppColors.border.withValues(alpha: 0.8))),
            ),
            child: Row(
              children: [
                Expanded(
                  child: _actionButton(
                    label: l10n.onTime.toUpperCase(),
                    color: AppColors.emeraldDark,
                    dotColor: const Color(0xFFA7F3D0),
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(l10n.onTimeConfirmed)),
                      );
                    },
                  ),
                ),
                const SizedBox(width: 6),
                Expanded(
                  child: _actionButton(
                    label: l10n.delayed.toUpperCase(),
                    color: AppColors.amber,
                    dotColor: const Color(0xFFFDE68A),
                    onTap: () => context.push(Routes.reportDelay, extra: job),
                  ),
                ),
                const SizedBox(width: 6),
                Expanded(
                  child: _actionButton(
                    label: l10n.cancel.toUpperCase(),
                    color: AppColors.rose,
                    dotColor: AppColors.rose,
                    isOutlined: true,
                    onTap: () => context.push(Routes.cancelJob, extra: job),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _jobDetailRow(IconData icon, String text) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 2),
          child: Icon(icon, size: 14, color: AppColors.textSlate),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 11,
              color: AppColors.textSecondary,
              fontWeight: FontWeight.w500,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  Widget _actionButton({
    required String label,
    required Color color,
    required Color dotColor,
    bool isOutlined = false,
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 36,
        decoration: BoxDecoration(
          color: isOutlined ? Colors.white : color,
          borderRadius: BorderRadius.circular(10),
          border: isOutlined ? Border.all(color: color.withValues(alpha: 0.3)) : null,
          boxShadow: isOutlined
              ? null
              : [BoxShadow(color: color.withValues(alpha: 0.25), blurRadius: 6, offset: const Offset(0, 2))],
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 6,
                  height: 6,
                  decoration: BoxDecoration(
                    color: isOutlined ? color : dotColor,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 4),
                Flexible(
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      label,
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w800,
                        color: isOutlined ? color : Colors.white,
                      ),
                      maxLines: 1,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ─── Today's Live Activity ─────────────────────────────
  Widget _buildLiveActivityCard(AppLocalizations l10n) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF1E3A5F), Color(0xFF1E1B4B)],
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.blue.shade800.withValues(alpha: 0.4)),
      ),
      child: Column(
        children: [
          // Header
          Wrap(
            alignment: WrapAlignment.spaceBetween,
            crossAxisAlignment: WrapCrossAlignment.center,
            spacing: 8,
            runSpacing: 6,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 8,
                    height: 8,
                    decoration: const BoxDecoration(
                      color: AppColors.amber,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    l10n.todaysLiveActivity.toUpperCase(),
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w800,
                      color: Colors.blue.shade200,
                      letterSpacing: 0.5,
                    ),
                  ),
                ],
              ),
              StatusChip.warning(l10n.serviceInProgress),
            ],
          ),
          const SizedBox(height: 12),
          // Stepper
          Container(
            padding: const EdgeInsets.only(top: 8),
            decoration: BoxDecoration(
              border: Border(top: BorderSide(color: Colors.white.withValues(alpha: 0.1))),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _stepItem(l10n.enRoute, AppColors.emerald, true),
                const SizedBox(width: 6),
                _stepItem(l10n.arrived, AppColors.emerald, true),
                const SizedBox(width: 6),
                _stepItem(l10n.inProgress, AppColors.amber, true),
                const SizedBox(width: 6),
                _stepItem(l10n.completed, Colors.white.withValues(alpha: 0.2), false),
              ],
            ),
          ),
          const SizedBox(height: 14),
          // Open Job button
          SizedBox(
            width: double.infinity,
            height: 42,
            child: OutlinedButton(
              onPressed: () {
                context.push(Routes.jobServiceExecution, extra: DemoData.customerJob);
              },
              style: OutlinedButton.styleFrom(
                foregroundColor: Colors.white,
                side: BorderSide(color: Colors.white.withValues(alpha: 0.25)),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
                minimumSize: const Size(double.infinity, 42),
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    l10n.openJob.toUpperCase(),
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.6,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(width: 6),
                  const Icon(Icons.arrow_forward_rounded, size: 14, color: Colors.white70),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _stepItem(String label, Color color, bool active) {
    return Expanded(
      child: Column(
        children: [
          Container(
            height: 4,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 9,
              fontWeight: active ? FontWeight.w700 : FontWeight.w500,
              color: active ? Colors.white.withValues(alpha: 0.9) : Colors.white.withValues(alpha: 0.4),
            ),
            maxLines: 2,
            softWrap: true,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  // ─── Important Alerts Banner ────────────────────────────
  Widget _buildImportantAlertCard(AppLocalizations l10n) {
    return GestureDetector(
      onTap: () => context.push(Routes.serviceCompletionOtp, extra: DemoData.customerJob),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: AppColors.amberLight,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.amber.shade200),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 28,
              height: 28,
              decoration: BoxDecoration(
                color: AppColors.amber,
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(Icons.warning_amber_rounded, color: Colors.white, size: 18),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Text(
                          '${l10n.importantAlert}: ${l10n.otpRequired}',
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF78350F),
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(width: 6),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          color: AppColors.amber.withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(6),
                          border: Border.all(color: AppColors.amber.withValues(alpha: 0.3)),
                        ),
                        child: const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              'ENTER OTP',
                              style: TextStyle(fontSize: 9, fontWeight: FontWeight.w800, color: Color(0xFF78350F)),
                            ),
                            SizedBox(width: 2),
                            Icon(Icons.arrow_forward_rounded, size: 10, color: Color(0xFF78350F)),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    l10n.otpAlertDescription,
                    style: TextStyle(
                      fontSize: 11,
                      color: Colors.amber.shade900,
                      height: 1.3,
                    ),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ─── Customer Work Card (Distinct White Card) ────────────
  Widget _buildCustomerWorkCard(AppLocalizations l10n) {
    return AppCard(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      color: AppColors.cobaltLight,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.blue.shade100),
                    ),
                    child: const Icon(Icons.person_rounded, color: AppColors.cobalt, size: 20),
                  ),
                  const SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            l10n.customer,
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w800,
                              color: AppColors.textPrimary,
                            ),
                          ),
                          const SizedBox(width: 6),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                            decoration: BoxDecoration(
                              color: AppColors.cobaltLight,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text(
                              '3 ${l10n.newRequests.split(' ').first}',
                              style: const TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w700,
                                color: AppColors.cobalt,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 2),
                      Text(
                        l10n.individualServices,
                        style: const TextStyle(
                          fontSize: 11,
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: AppColors.surfaceAlt,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  l10n.b2cDirect.toUpperCase(),
                  style: const TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textSecondary,
                    letterSpacing: 0.5,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),

          // Metrics Row
          Container(
            padding: const EdgeInsets.symmetric(vertical: 8),
            decoration: BoxDecoration(
              border: Border.symmetric(
                horizontal: BorderSide(color: AppColors.border.withValues(alpha: 0.6)),
              ),
            ),
            child: Row(
              children: [
                _miniMetricItem('3', l10n.newRequests, AppColors.amber),
                _miniMetricItem('2', l10n.accepted, AppColors.emerald),
                _miniMetricItem('4', l10n.upcoming, AppColors.cobalt),
              ],
            ),
          ),
          const SizedBox(height: 12),

          // Current / Next Active Customer Job Details
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.cobaltLight.withValues(alpha: 0.4),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.blue.shade100),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(4),
                        border: Border.all(color: Colors.blue.shade200),
                      ),
                      child: Text(
                        l10n.activeJobId('C-4821'),
                        style: const TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w700,
                          color: AppColors.cobalt,
                        ),
                      ),
                    ),
                    StatusChip.success(l10n.inProgress),
                  ],
                ),
                const SizedBox(height: 6),
                const Text(
                  'Plumbing Repair & Pipeline Leakage',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 6),
                _jobDetailRow(Icons.person_outline, '${l10n.customer}: Anil Sharma'),
                const SizedBox(height: 3),
                _jobDetailRow(Icons.access_time, '${l10n.scheduled}: 10:00 AM – 11:30 AM'),
                const SizedBox(height: 3),
                _jobDetailRow(Icons.location_on_outlined, 'Sector 14, Noida (G-402, Green Meadows)'),
              ],
            ),
          ),
          const SizedBox(height: 12),

          // Primary View Customer Button
          SizedBox(
            width: double.infinity,
            height: 40,
            child: ElevatedButton(
              onPressed: () => context.go('/customer'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.cobalt,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                elevation: 0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    l10n.viewCustomer.toUpperCase(),
                    style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w700, letterSpacing: 0.5),
                  ),
                  const SizedBox(width: 6),
                  const Icon(Icons.arrow_forward_rounded, size: 14),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ─── Institution Work Card (Strictly Separate White Card) ─
  Widget _buildInstitutionWorkCard(AppLocalizations l10n) {
    const purpleBrand = Color(0xFF7E22CE);
    const purpleLight = Color(0xFFFAF5FF);
    const purpleBorder = Color(0xFFE9D5FF);

    return AppCard(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      color: const Color(0xFFF3E8FF),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: purpleBorder),
                    ),
                    child: const Icon(Icons.business_rounded, color: purpleBrand, size: 20),
                  ),
                  const SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            l10n.institution,
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w800,
                              color: AppColors.textPrimary,
                            ),
                          ),
                          const SizedBox(width: 6),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                            decoration: BoxDecoration(
                              color: const Color(0xFFF3E8FF),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Text(
                              '1 New',
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w700,
                                color: purpleBrand,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 2),
                      Text(
                        l10n.orgWorkforce,
                        style: const TextStyle(
                          fontSize: 11,
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: purpleLight,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: purpleBorder.withValues(alpha: 0.6)),
                ),
                child: Text(
                  l10n.b2bGovt.toUpperCase(),
                  style: const TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                    color: purpleBrand,
                    letterSpacing: 0.5,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),

          // Metrics Row
          Container(
            padding: const EdgeInsets.symmetric(vertical: 8),
            decoration: BoxDecoration(
              border: Border.symmetric(
                horizontal: BorderSide(color: AppColors.border.withValues(alpha: 0.6)),
              ),
            ),
            child: Row(
              children: [
                _miniMetricItem('1', l10n.newRequests, purpleBrand),
                _miniMetricItem('2', l10n.pending, AppColors.amber),
                _miniMetricItem('3', l10n.assigned, AppColors.emerald),
              ],
            ),
          ),
          const SizedBox(height: 12),

          // Current / Next Assignment Details
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: purpleLight,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: purpleBorder),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(4),
                        border: Border.all(color: purpleBorder),
                      ),
                      child: Text(
                        l10n.assignmentId('JB-8841-DL'),
                        style: const TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w700,
                          color: purpleBrand,
                        ),
                      ),
                    ),
                    StatusChip.info(l10n.enRoute),
                  ],
                ),
                const SizedBox(height: 6),
                const Text(
                  'AIIMS New Delhi • Ward 4B Sanitation & Electrical',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 6),
                _jobDetailRow(Icons.domain_rounded, 'Domain: Facility Sanitation & Switchgear'),
                const SizedBox(height: 3),
                _jobDetailRow(Icons.access_time, 'Sat, 19 Oct • 08:00 AM - 12:00 PM • Team of 4'),
                const SizedBox(height: 3),
                _jobDetailRow(Icons.location_on_outlined, 'Ansari Nagar, New Delhi (Main Hospital Block)'),
              ],
            ),
          ),
          const SizedBox(height: 12),

          // Primary View Institution Button
          SizedBox(
            width: double.infinity,
            height: 40,
            child: ElevatedButton(
              onPressed: () => context.go('/institution'),
              style: ElevatedButton.styleFrom(
                backgroundColor: purpleBrand,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                elevation: 0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    l10n.viewInstitution.toUpperCase(),
                    style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w700, letterSpacing: 0.5),
                  ),
                  const SizedBox(width: 6),
                  const Icon(Icons.arrow_forward_rounded, size: 14),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _miniMetricItem(String count, String label, Color color) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 2),
        padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 4),
        decoration: BoxDecoration(
          color: AppColors.surfaceAlt,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: AppColors.border.withValues(alpha: 0.5)),
        ),
        child: Column(
          children: [
            Text(
              count,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800, color: color),
            ),
            const SizedBox(height: 2),
            FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                label,
                style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w600, color: AppColors.textSecondary),
                maxLines: 1,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ─── Daily Summary ──────────────────────────────────────
  Widget _buildDailySummary(AppLocalizations l10n) {
    final worker = DemoData.worker;
    return AppCard(
      padding: const EdgeInsets.all(14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                l10n.summary.toUpperCase(),
                style: const TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w800,
                  color: AppColors.textMuted,
                  letterSpacing: 0.5,
                ),
              ),
              GestureDetector(
                onTap: () {},
                child: Text(
                  l10n.viewBreakdown,
                  style: const TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: AppColors.cobalt,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          GestureDetector(
            onTap: () => context.push(Routes.earnings),
            child: Row(
              children: [
                _summaryItem(l10n.jobsCompleted, '${worker.completedJobs}', AppColors.emerald),
                _summaryItem(l10n.jobsCancelled, '${worker.cancelledJobs}', AppColors.rose),
                _summaryItem(l10n.earnings, '₹${worker.totalEarnings.toStringAsFixed(0)}', AppColors.cobalt),
                _summaryItem(l10n.rating, '${worker.rating}', AppColors.amber),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _summaryItem(String label, String value, Color color) {
    return Expanded(
      child: Column(
        children: [
          Text(
            value,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w800,
              color: color,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            label,
            style: const TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w600,
              color: AppColors.textMuted,
            ),
            textAlign: TextAlign.center,
            maxLines: 2,
            softWrap: true,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
