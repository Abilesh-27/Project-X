import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:stitch_worker/l10n/generated/app_localizations.dart';
import '../../app/theme/app_colors.dart';
import '../../app/router.dart';
import '../../core/models/job_model.dart';
import '../../core/widgets/shared_widgets.dart';

enum AvailabilityState { active, busy, paused, inactive }

/// Worker Profile Screen matching Stitch reference `worker_profile_screen/code.html`.
class WorkerProfileScreen extends StatefulWidget {
  const WorkerProfileScreen({super.key});

  @override
  State<WorkerProfileScreen> createState() => _WorkerProfileScreenState();
}

class _WorkerProfileScreenState extends State<WorkerProfileScreen> {
  AvailabilityState _availability = AvailabilityState.active;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final worker = DemoData.worker;

    return Scaffold(
      backgroundColor: AppColors.surface,
      body: Column(
        children: [
          _buildHeroHeader(worker, l10n),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 32),
              children: [
                _buildMetricsGrid(l10n),
                const SizedBox(height: 16),
                _buildAvailabilitySelector(l10n),
                const SizedBox(height: 16),
                _buildSkillsSection(l10n),
                const SizedBox(height: 16),
                _buildQuickLinksSection(l10n),
                const SizedBox(height: 20),
                _buildEmergencyCard(l10n),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeroHeader(WorkerProfile worker, AppLocalizations l10n) {
    return Container(
      color: AppColors.navy,
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 20),
          child: Column(
            children: [
              // Top bar
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () => context.pop(),
                    child: Container(
                      width: 36,
                      height: 36,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white.withValues(alpha: 0.1),
                      ),
                      child: const Icon(Icons.chevron_left, color: Colors.white, size: 22),
                    ),
                  ),
                  Column(
                    children: [
                      Text(
                        l10n.myProfile,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        l10n.workerCredentials,
                        style: TextStyle(
                          color: Colors.blue.shade200.withValues(alpha: 0.8),
                          fontSize: 10,
                        ),
                      ),
                    ],
                  ),
                  GestureDetector(
                    onTap: () => context.push(Routes.settings),
                    child: Container(
                      width: 36,
                      height: 36,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white.withValues(alpha: 0.1),
                      ),
                      child: const Icon(Icons.settings, color: Colors.white, size: 18),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Hero Identity card
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(color: Colors.white.withValues(alpha: 0.12)),
                ),
                child: Row(
                  children: [
                    Stack(
                      children: [
                        Container(
                          width: 58,
                          height: 58,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: const LinearGradient(
                              colors: [Color(0xFF2563EB), Color(0xFF4F46E5)],
                            ),
                            border: Border.all(color: Colors.white.withValues(alpha: 0.3), width: 2),
                          ),
                          child: Center(
                            child: Text(
                              worker.initials,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: Container(
                            width: 18,
                            height: 18,
                            decoration: BoxDecoration(
                              color: AppColors.emerald,
                              shape: BoxShape.circle,
                              border: Border.all(color: AppColors.navy, width: 2),
                            ),
                            child: const Icon(Icons.check, size: 12, color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                worker.name,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(width: 6),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 1.5),
                                decoration: BoxDecoration(
                                  color: AppColors.emerald.withValues(alpha: 0.2),
                                  borderRadius: BorderRadius.circular(6),
                                  border: Border.all(color: AppColors.emerald.withValues(alpha: 0.4)),
                                ),
                                child: Text(
                                  l10n.verified.toUpperCase(),
                                  style: const TextStyle(
                                    color: AppColors.emerald,
                                    fontSize: 9,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 2),
                          Text(
                            '${worker.workerId} • ${worker.role}',
                            style: TextStyle(color: Colors.blue.shade100, fontSize: 11),
                          ),
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              const Icon(Icons.star, size: 13, color: AppColors.amber),
                              const SizedBox(width: 4),
                              Text(
                                '${worker.rating} Rating',
                                style: const TextStyle(
                                  color: AppColors.amber,
                                  fontSize: 11,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(width: 6),
                              const Text('•', style: TextStyle(color: Colors.white38)),
                              const SizedBox(width: 6),
                              Text(
                                'Cooperative ${worker.tier}',
                                style: const TextStyle(color: Colors.white70, fontSize: 11),
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
        ),
      ),
    );
  }

  Widget _buildMetricsGrid(AppLocalizations l10n) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 8),
      decoration: BoxDecoration(
        color: AppColors.cardWhite,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        children: [
          _buildMetricCol(l10n.completedStat, '47', l10n.onTimeRate, AppColors.emeraldDark),
          _buildDivider(),
          _buildMetricCol(l10n.cancelledStat, '2', l10n.clientSide, AppColors.textMuted),
          _buildDivider(),
          _buildMetricCol(l10n.earningsStat, '₹48.2k', 'This FY', AppColors.cobalt),
          _buildDivider(),
          _buildMetricCol(l10n.ratingStat, '4.85', 'Top 5%', AppColors.amberDark),
        ],
      ),
    );
  }

  Widget _buildMetricCol(String label, String value, String subtext, Color accent) {
    return Expanded(
      child: Column(
        children: [
          Text(
            label.toUpperCase(),
            style: const TextStyle(fontSize: 9, fontWeight: FontWeight.bold, color: AppColors.textMuted),
          ),
          const SizedBox(height: 3),
          Text(
            value,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w900, color: accent),
          ),
          const SizedBox(height: 1),
          Text(
            subtext,
            style: const TextStyle(fontSize: 8.5, color: AppColors.textMuted),
          ),
        ],
      ),
    );
  }

  Widget _buildDivider() {
    return Container(width: 1, height: 28, color: AppColors.divider);
  }

  Widget _buildAvailabilitySelector(AppLocalizations l10n) {
    return AppCard(
      padding: const EdgeInsets.all(14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                l10n.availabilityStatus,
                style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppColors.textPrimary),
              ),
              _buildAvailabilityBadge(l10n),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              _buildAvailabilityButton(AvailabilityState.active, l10n.statusActive, AppColors.emerald),
              const SizedBox(width: 6),
              _buildAvailabilityButton(AvailabilityState.busy, l10n.statusBusy, AppColors.amber),
              const SizedBox(width: 6),
              _buildAvailabilityButton(AvailabilityState.paused, l10n.statusPaused, AppColors.rose),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAvailabilityBadge(AppLocalizations l10n) {
    Color color;
    String text;
    switch (_availability) {
      case AvailabilityState.active:
        color = AppColors.emerald;
        text = l10n.statusActive;
        break;
      case AvailabilityState.busy:
        color = AppColors.amber;
        text = l10n.statusBusy;
        break;
      case AvailabilityState.paused:
        color = AppColors.rose;
        text = l10n.statusPaused;
        break;
      case AvailabilityState.inactive:
        color = AppColors.textMuted;
        text = l10n.statusInactive;
        break;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(width: 6, height: 6, decoration: BoxDecoration(color: color, shape: BoxShape.circle)),
          const SizedBox(width: 5),
          Text(text, style: TextStyle(fontSize: 9.5, fontWeight: FontWeight.bold, color: color)),
        ],
      ),
    );
  }

  Widget _buildAvailabilityButton(AvailabilityState state, String label, Color color) {
    final isSelected = _availability == state;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => _availability = state),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 8),
          decoration: BoxDecoration(
            color: isSelected ? color : AppColors.surfaceAlt,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: isSelected ? color : AppColors.border),
          ),
          child: Center(
            child: Text(
              label,
              style: TextStyle(
                fontSize: 10,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.w600,
                color: isSelected ? Colors.white : AppColors.textSecondary,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSkillsSection(AppLocalizations l10n) {
    final skills = [
      'Licensed Electrician (Grade A)',
      'Plumbing Repair & Pipeline Flushing',
      'High Voltage Certified',
      'Safety Standard ISO-45001',
      'Sanitation Protocol Qualified',
    ];

    return AppCard(
      padding: const EdgeInsets.all(14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            l10n.skillsAndCertifications,
            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppColors.textPrimary),
          ),
          const SizedBox(height: 10),
          Wrap(
            spacing: 6,
            runSpacing: 6,
            children: skills.map((skill) {
              return Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  color: AppColors.cobaltLight,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: AppColors.cobalt.withValues(alpha: 0.2)),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.verified, size: 12, color: AppColors.cobalt),
                    const SizedBox(width: 5),
                    Text(
                      skill,
                      style: const TextStyle(fontSize: 10.5, fontWeight: FontWeight.w600, color: AppColors.cobalt),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickLinksSection(AppLocalizations l10n) {
    return AppCard(
      padding: const EdgeInsets.all(8),
      child: Column(
        children: [
          _buildLinkTile(
            icon: Icons.calendar_month_outlined,
            title: l10n.workerSchedule,
            subtitle: 'View upcoming jobs & work shifts',
            onTap: () => context.push(Routes.schedule),
          ),
          const Divider(height: 1, color: AppColors.divider),
          _buildLinkTile(
            icon: Icons.account_balance_wallet_outlined,
            title: l10n.earningsStat,
            subtitle: '₹48,200.00 • View settlements & payouts',
            onTap: () => context.push(Routes.earnings),
          ),
          const Divider(height: 1, color: AppColors.divider),
          _buildLinkTile(
            icon: Icons.settings_outlined,
            title: l10n.settingsTitle,
            subtitle: 'Languages, permissions & security',
            onTap: () => context.push(Routes.settings),
          ),
          const Divider(height: 1, color: AppColors.divider),
          _buildLinkTile(
            icon: Icons.help_outline,
            title: l10n.helpAndSupport,
            subtitle: 'Society helpdesk & FAQs',
            onTap: () => context.push(Routes.support),
          ),
        ],
      ),
    );
  }

  Widget _buildLinkTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return ListTile(
      dense: true,
      leading: Container(
        width: 36,
        height: 36,
        decoration: BoxDecoration(
          color: AppColors.surfaceAlt,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(icon, color: AppColors.cobalt, size: 18),
      ),
      title: Text(
        title,
        style: const TextStyle(fontSize: 12.5, fontWeight: FontWeight.bold, color: AppColors.textPrimary),
      ),
      subtitle: Text(
        subtitle,
        style: const TextStyle(fontSize: 10, color: AppColors.textMuted),
      ),
      trailing: const Icon(Icons.chevron_right, size: 18, color: AppColors.textSlate),
      onTap: onTap,
    );
  }

  Widget _buildEmergencyCard(AppLocalizations l10n) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.roseLight,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.rose.withValues(alpha: 0.3)),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: const BoxDecoration(
              color: AppColors.rose,
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.emergency, color: Colors.white, size: 22),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  l10n.emergencySos,
                  style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: AppColors.roseDark),
                ),
                const Text(
                  'Immediate alert to cooperative emergency dispatch & 112 services',
                  style: TextStyle(fontSize: 10, color: AppColors.textSecondary),
                ),
              ],
            ),
          ),
          TextButton(
            onPressed: () => context.push(Routes.sos),
            style: TextButton.styleFrom(
              backgroundColor: AppColors.rose,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            ),
            child: const Text('OPEN', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }
}
