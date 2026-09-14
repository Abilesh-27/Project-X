import 'dart:async';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:stitch_worker/l10n/generated/app_localizations.dart';
import '../../app/router.dart';
import '../../app/theme/app_colors.dart';
import '../../core/models/job_model.dart';
import '../../core/widgets/app_header.dart';
import '../../core/widgets/shared_widgets.dart';

/// LIVE JOURNEY TRACKING SCREEN (PLAN.md — Start Journey → GPS → Arrival).
///
/// Simulates live GPS telemetry (distance/ETA count down on a timer) so the
/// screen feels alive without a real location backend. On "I HAVE ARRIVED"
/// the job transitions to [JobStatus.arrived] and the worker is pushed to
/// OTP verification — the canonical state machine is the single source of
/// truth; this screen only ever moves a job forward along it.
class JourneyTrackingScreen extends StatefulWidget {
  final Job job;
  const JourneyTrackingScreen({super.key, required this.job});

  @override
  State<JourneyTrackingScreen> createState() => _JourneyTrackingScreenState();
}

class _JourneyTrackingScreenState extends State<JourneyTrackingScreen> {
  late Job _job;
  Timer? _ticker;

  // Simulated telemetry — counts down as "time passes".
  double _remainingKm = 2.1;
  int _etaMinutes = 11;

  @override
  void initState() {
    super.initState();
    _job = widget.job.status == JobStatus.enRoute
        ? widget.job
        : widget.job.copyWithStatus(JobStatus.enRoute);
    _ticker = Timer.periodic(const Duration(seconds: 4), (_) {
      if (!mounted) return;
      setState(() {
        _remainingKm = (_remainingKm - 0.3).clamp(0.0, 99.0);
        _etaMinutes = (_etaMinutes - 1).clamp(0, 999);
      });
    });
  }

  @override
  void dispose() {
    _ticker?.cancel();
    super.dispose();
  }

  void _notComingYet(String label) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(label)),
    );
  }

  void _onArrived() {
    final arrived = _job.copyWithStatus(JobStatus.arrived);
    context.push(Routes.jobOtp, extra: arrived);
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
            title: l10n.liveJourneyTracking,
            subtitle: l10n.customerJobId(job.jobId),
            onBack: () => context.pop(),
            actions: [HeaderNotificationButton(badgeCount: 3)],
            bottom: Row(
              children: [
                Expanded(child: StatusChip.success(l10n.enRouteTransit)),
                const SizedBox(width: 8),
                Icon(Icons.wifi_tethering_rounded, size: 14, color: Colors.white.withValues(alpha: 0.7)),
                const SizedBox(width: 4),
                Text(
                  l10n.telemetryActive,
                  style: TextStyle(color: Colors.white.withValues(alpha: 0.7), fontSize: 11, fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
              children: [
                _JobSummaryCard(job: job, l10n: l10n, onNotComingYet: _notComingYet),
                const SizedBox(height: 12),
                _JourneyStepper(l10n: l10n),
                const SizedBox(height: 12),
                _MapCard(
                  l10n: l10n,
                  remainingKm: _remainingKm,
                  etaMinutes: _etaMinutes,
                  onRecenter: () => _notComingYet(l10n.liveGpsActive),
                ),
                const SizedBox(height: 12),
                _NextManeuverCard(l10n: l10n),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: () => _notComingYet(l10n.reportDelay),
                        icon: const Icon(Icons.schedule_rounded, size: 16),
                        label: Text(l10n.reportDelay, textAlign: TextAlign.center, overflow: TextOverflow.ellipsis),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: () => _notComingYet(l10n.contactCustomer),
                        icon: const Icon(Icons.call_rounded, size: 16),
                        label: Text(l10n.contactCustomer, overflow: TextOverflow.ellipsis),
                      ),
                    ),
                  ],
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
          child: ElevatedButton.icon(
            onPressed: _onArrived,
            style: ElevatedButton.styleFrom(backgroundColor: AppColors.emeraldDark),
            icon: const Icon(Icons.check_circle_rounded, size: 18),
            label: Text(l10n.iHaveArrived),
          ),
        ),
      ),
    );
  }
}

class _JobSummaryCard extends StatelessWidget {
  final Job job;
  final AppLocalizations l10n;
  final void Function(String) onNotComingYet;
  const _JobSummaryCard({required this.job, required this.l10n, required this.onNotComingYet});

  @override
  Widget build(BuildContext context) {
    final title = job.type == JobType.institution ? (job.institutionName ?? job.customerName) : job.customerName;
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
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                        color: AppColors.divider,
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(color: AppColors.border),
                      ),
                      child: Text(
                        job.type == JobType.institution ? l10n.institutionAssignment : l10n.customerJobRequest,
                        style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w800, color: AppColors.textSecondary, letterSpacing: 0.4),
                      ),
                    ),
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        Flexible(child: Text(title, style: Theme.of(context).textTheme.titleMedium, overflow: TextOverflow.ellipsis)),
                        const SizedBox(width: 4),
                        const Icon(Icons.verified_rounded, size: 16, color: AppColors.cobalt),
                      ],
                    ),
                    Text(job.serviceName, style: Theme.of(context).textTheme.bodySmall),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () => onNotComingYet(l10n.callCustomer),
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: AppColors.cobaltLight,
                    shape: BoxShape.circle,
                    border: Border.all(color: AppColors.cobalt.withValues(alpha: 0.3)),
                  ),
                  child: const Icon(Icons.call_rounded, size: 16, color: AppColors.cobalt),
                ),
              ),
            ],
          ),
          const Divider(height: 24),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(Icons.location_on_rounded, size: 16, color: AppColors.rose),
              const SizedBox(width: 8),
              Expanded(child: Text(job.address, style: Theme.of(context).textTheme.bodySmall)),
            ],
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            decoration: BoxDecoration(
              color: AppColors.emeraldBg,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: AppColors.emerald.withValues(alpha: 0.3)),
            ),
            child: Row(
              children: [
                Container(width: 8, height: 8, decoration: const BoxDecoration(color: AppColors.emerald, shape: BoxShape.circle)),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    l10n.requiredBy(_fmt(job.scheduledStart)),
                    style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: AppColors.emeraldDark),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _fmt(DateTime d) => '${d.hour.toString().padLeft(2, '0')}:${d.minute.toString().padLeft(2, '0')}';
}

class _JourneyStepper extends StatelessWidget {
  final AppLocalizations l10n;
  const _JourneyStepper({required this.l10n});

  @override
  Widget build(BuildContext context) {
    final labels = [l10n.assigned, l10n.startJourney, l10n.enRoute, l10n.remaining, l10n.arrived];
    // Stage 3 of 5 = "En Route" active, matching the reference stepper.
    const activeIndex = 2;
    return AppCard(
      padding: const EdgeInsets.fromLTRB(14, 14, 14, 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(l10n.journeyProgress, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w800, color: AppColors.textMuted, letterSpacing: 0.4)),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(color: AppColors.cobaltLight, borderRadius: BorderRadius.circular(20)),
                child: Text(l10n.stageOf('${activeIndex + 1}', '${labels.length}'), style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: AppColors.cobalt)),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: List.generate(labels.length * 2 - 1, (i) {
              if (i.isOdd) {
                final leftDone = (i - 1) ~/ 2 < activeIndex;
                return Expanded(child: Container(height: 2, color: leftDone ? AppColors.emerald : AppColors.border));
              }
              final idx = i ~/ 2;
              final done = idx < activeIndex;
              final active = idx == activeIndex;
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: active ? 28 : 22,
                    height: active ? 28 : 22,
                    decoration: BoxDecoration(
                      color: done ? AppColors.emerald : (active ? AppColors.cobalt : AppColors.divider),
                      shape: BoxShape.circle,
                      border: active ? Border.all(color: AppColors.cobaltLight, width: 4) : Border.all(color: AppColors.border),
                    ),
                    child: Center(
                      child: done
                          ? const Icon(Icons.check_rounded, size: 14, color: Colors.white)
                          : Text('${idx + 1}', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w700, color: active ? Colors.white : AppColors.textSlate)),
                    ),
                  ),
                  const SizedBox(height: 4),
                  SizedBox(
                    width: 44,
                    child: Text(
                      labels[idx],
                      textAlign: TextAlign.center,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontSize: 9, fontWeight: active ? FontWeight.w800 : FontWeight.w500, color: active ? AppColors.cobalt : AppColors.textSlate),
                    ),
                  ),
                ],
              );
            }),
          ),
        ],
      ),
    );
  }
}

class _MapCard extends StatelessWidget {
  final AppLocalizations l10n;
  final double remainingKm;
  final int etaMinutes;
  final VoidCallback onRecenter;
  const _MapCard({required this.l10n, required this.remainingKm, required this.etaMinutes, required this.onRecenter});

  @override
  Widget build(BuildContext context) {
    final eta = DateTime.now().add(Duration(minutes: etaMinutes));
    final etaStr = '${eta.hour.toString().padLeft(2, '0')}:${eta.minute.toString().padLeft(2, '0')}';

    return AppCard(
      padding: EdgeInsets.zero,
      child: Column(
        children: [
          SizedBox(
            height: 190,
            child: Stack(
              fit: StackFit.expand,
              children: [
                CustomPaint(painter: _RoutePainter()),
                const Positioned(left: 40, top: 110, child: _WorkerBeacon()),
                const Positioned(right: 30, top: 30, child: _DestinationPin()),
                Positioned(
                  right: 10,
                  top: 10,
                  child: Column(
                    children: [
                      _MapButton(icon: Icons.my_location_rounded, onTap: onRecenter),
                      const SizedBox(height: 8),
                      _MapButton(icon: Icons.volume_up_rounded, onTap: onRecenter, color: AppColors.emeraldDark),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(14),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(child: _Metric(label: l10n.remaining, value: '${remainingKm.toStringAsFixed(1)} ${l10n.km}', color: AppColors.textPrimary)),
                    Container(width: 1, height: 30, color: AppColors.divider),
                    Expanded(child: _Metric(label: l10n.travelTime, value: '$etaMinutes ${l10n.mins}', color: AppColors.cobalt)),
                    Container(width: 1, height: 30, color: AppColors.divider),
                    Expanded(child: _Metric(label: l10n.targetEta, value: etaStr, color: AppColors.emeraldDark)),
                  ],
                ),
                const Divider(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(width: 8, height: 8, decoration: const BoxDecoration(color: AppColors.emerald, shape: BoxShape.circle)),
                        const SizedBox(width: 6),
                        Text(l10n.liveGpsActive, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: AppColors.emeraldDark)),
                        Text(' • ${l10n.gpsAccuracy('3')}', style: const TextStyle(fontSize: 11, color: AppColors.textMuted)),
                      ],
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
}

class _Metric extends StatelessWidget {
  final String label;
  final String value;
  final Color color;
  const _Metric({required this.label, required this.value, required this.color});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(label.toUpperCase(), style: const TextStyle(fontSize: 9, fontWeight: FontWeight.w700, color: AppColors.textMuted, letterSpacing: 0.3)),
        const SizedBox(height: 2),
        Text(value, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800, color: color)),
      ],
    );
  }
}

class _MapButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  final Color? color;
  const _MapButton({required this.icon, required this.onTap, this.color});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 32,
        height: 32,
        decoration: BoxDecoration(
          color: AppColors.cardWhite,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: AppColors.border),
          boxShadow: [BoxShadow(color: AppColors.navy.withValues(alpha: 0.08), blurRadius: 4, offset: const Offset(0, 2))],
        ),
        child: Icon(icon, size: 16, color: color ?? AppColors.cobalt),
      ),
    );
  }
}

class _WorkerBeacon extends StatefulWidget {
  const _WorkerBeacon();
  @override
  State<_WorkerBeacon> createState() => _WorkerBeaconState();
}

class _WorkerBeaconState extends State<_WorkerBeacon> with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(vsync: this, duration: const Duration(seconds: 2))..repeat();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: 44,
          height: 44,
          child: Stack(
            alignment: Alignment.center,
            children: [
              AnimatedBuilder(
                animation: _controller,
                builder: (context, _) {
                  final t = _controller.value;
                  return Container(
                    width: 24 + (t * 20),
                    height: 24 + (t * 20),
                    decoration: BoxDecoration(
                      color: AppColors.cobalt.withValues(alpha: (1 - t) * 0.3),
                      shape: BoxShape.circle,
                    ),
                  );
                },
              ),
              Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(color: AppColors.cobalt, shape: BoxShape.circle, border: Border.all(color: Colors.white, width: 2)),
                child: const Icon(Icons.navigation_rounded, size: 12, color: Colors.white),
              ),
            ],
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 2),
          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
          decoration: BoxDecoration(color: AppColors.navy.withValues(alpha: 0.9), borderRadius: BorderRadius.circular(10)),
          child: const Text('You', style: TextStyle(color: Colors.white, fontSize: 9, fontWeight: FontWeight.w700)),
        ),
      ],
    );
  }
}

class _DestinationPin extends StatelessWidget {
  const _DestinationPin();
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(color: AppColors.rose, borderRadius: BorderRadius.circular(6), border: Border.all(color: Colors.white)),
          child: const Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.home_work_rounded, size: 12, color: Colors.white),
              SizedBox(width: 3),
              Text('Site', style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.w800)),
            ],
          ),
        ),
        Transform.rotate(
          angle: 0.78,
          child: Container(width: 8, height: 8, color: AppColors.rose),
        ),
      ],
    );
  }
}

/// Lightweight stylized route line, matching the reference map's curved
/// arterial path — pure decoration, no real geolocation is drawn here.
class _RoutePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final bg = Paint()..color = const Color(0xFFEBF2F7);
    canvas.drawRect(Offset.zero & size, bg);

    final road = Paint()
      ..color = const Color(0xFFCBD5E1)
      ..strokeWidth = 6
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;
    final roadPath = Path()
      ..moveTo(0, size.height * 0.55)
      ..quadraticBezierTo(size.width * 0.4, size.height * 0.35, size.width, size.height * 0.4);
    canvas.drawPath(roadPath, road);

    final route = Paint()
      ..color = const Color(0xFF2563EB)
      ..strokeWidth = 4
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;
    final routePath = Path()
      ..moveTo(size.width * 0.14, size.height * 0.62)
      ..quadraticBezierTo(size.width * 0.5, size.height * 0.42, size.width * 0.82, size.height * 0.18);
    canvas.drawPath(routePath, route);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _NextManeuverCard extends StatelessWidget {
  final AppLocalizations l10n;
  const _NextManeuverCard({required this.l10n});

  @override
  Widget build(BuildContext context) {
    return AppCard(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(color: AppColors.cobalt, borderRadius: BorderRadius.circular(12)),
            child: const Icon(Icons.turn_slight_right_rounded, color: Colors.white),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(l10n.nextManeuver('650m'), style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w800, color: AppColors.cobalt, letterSpacing: 0.3)),
                const SizedBox(height: 2),
                Text(l10n.viaMainRoad, style: Theme.of(context).textTheme.bodyMedium),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
