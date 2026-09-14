import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:stitch_worker/l10n/generated/app_localizations.dart';
import '../../app/theme/app_colors.dart';
import '../../app/router.dart';
import '../../core/widgets/app_header.dart';

class SchemeItem {
  final String id;
  final String title;
  final String category;
  final String coverage;
  final String status; // 'Approved', 'In Review', 'Eligible'
  final String description;
  final IconData icon;

  const SchemeItem({
    required this.id,
    required this.title,
    required this.category,
    required this.coverage,
    required this.status,
    required this.description,
    required this.icon,
  });
}

/// Schemes & Welfare Tab Screen.
/// Faithfully reproduces `schemes_welfare_screen/code.html` from Stitch UI reference.
class SchemesScreen extends StatefulWidget {
  const SchemesScreen({super.key});

  @override
  State<SchemesScreen> createState() => _SchemesScreenState();
}

class _SchemesScreenState extends State<SchemesScreen> {
  String _selectedCategory = 'all';

  final List<SchemeItem> _schemes = const [
    SchemeItem(
      id: 'SCH-101',
      title: 'Pradhan Mantri Suraksha Bima Yojana',
      category: 'insurance',
      coverage: '₹2,00,000 Accidental Cover',
      status: 'Approved',
      description: 'Central government accidental death and permanent disability protection policy.',
      icon: Icons.shield,
    ),
    SchemeItem(
      id: 'SCH-102',
      title: 'Cooperative Emergency Relief Fund',
      category: 'welfare',
      coverage: 'Up to ₹50,000 Grant',
      status: 'In Review',
      description: 'Instant financial aid during natural calamity, illness, or equipment destruction.',
      icon: Icons.volunteer_activism,
    ),
    SchemeItem(
      id: 'SCH-103',
      title: 'Worker Family Health Protection Scheme',
      category: 'health',
      coverage: '₹5,00,000 Cashless Hospitalization',
      status: 'Approved',
      description: 'Comprehensive cashless hospitalization across 12,000+ empanelled network hospitals.',
      icon: Icons.health_and_safety,
    ),
    SchemeItem(
      id: 'SCH-104',
      title: 'Child Education Higher Scholarship Grant',
      category: 'financial',
      coverage: '₹15,000 / Year per Child',
      status: 'Eligible',
      description: 'Tuition and book allowance for dependent children studying in recognized schools/polytechnics.',
      icon: Icons.school,
    ),
  ];

  List<SchemeItem> get _filteredSchemes {
    if (_selectedCategory == 'all') return _schemes;
    return _schemes.where((s) => s.category == _selectedCategory).toList();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final filtered = _filteredSchemes;

    return Column(
      children: [
        AppHeader(
          title: l10n.schemesTitle,
          subtitle: 'Social Welfare & Insurance Protection',
          actions: [
            HeaderNotificationButton(
              badgeCount: 1,
              onTap: () => context.push(Routes.notifications),
            ),
          ],
        ),
        Expanded(
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              // 1. Overview Metrics Card
              _buildMetricsCard(l10n),
              const SizedBox(height: 14),

              // 2. Featured Scheme High-Visibility Card
              _buildFeaturedSchemeBanner(l10n),
              const SizedBox(height: 16),

              // 3. Category Filters
              _buildCategoryPills(l10n),
              const SizedBox(height: 14),

              // 4. Scheme Cards List
              ...filtered.map((s) => _buildSchemeCard(s, l10n)),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildMetricsCard(AppLocalizations l10n) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.cardWhite,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        children: [
          _buildMetricCol(l10n.eligibleSchemes, '6', '100% Valid', AppColors.emeraldDark),
          _buildDivider(),
          _buildMetricCol(l10n.appliedSchemes, '2', 'In Review', AppColors.amberDark),
          _buildDivider(),
          _buildMetricCol(l10n.approvedSchemes, '3', 'Active Care', AppColors.cobalt),
        ],
      ),
    );
  }

  Widget _buildMetricCol(String label, String value, String sub, Color color) {
    return Expanded(
      child: Column(
        children: [
          Text(label, style: const TextStyle(fontSize: 10, color: AppColors.textMuted, fontWeight: FontWeight.bold)),
          const SizedBox(height: 3),
          Text(value, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w900, color: color)),
          const SizedBox(height: 1),
          Text(sub, style: const TextStyle(fontSize: 9, color: AppColors.textMuted)),
        ],
      ),
    );
  }

  Widget _buildDivider() {
    return Container(width: 1, height: 28, color: AppColors.divider);
  }

  Widget _buildFeaturedSchemeBanner(AppLocalizations l10n) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF0F223D), Color(0xFF1D4ED8)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: AppColors.navy.withValues(alpha: 0.2),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  l10n.featuredScheme.toUpperCase(),
                  style: const TextStyle(color: Colors.white, fontSize: 9.5, fontWeight: FontWeight.bold),
                ),
              ),
              Row(
                children: [
                  const Icon(Icons.verified, size: 14, color: AppColors.emerald),
                  const SizedBox(width: 4),
                  Text(l10n.activeCoverage, style: const TextStyle(color: AppColors.emerald, fontSize: 10, fontWeight: FontWeight.bold)),
                ],
              ),
            ],
          ),
          const SizedBox(height: 10),
          const Text(
            'Worker Health Protection Scheme',
            style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 3),
          const Text(
            'Cashless hospitalization up to ₹5,00,000 for field worker and immediate family.',
            style: TextStyle(color: Colors.white70, fontSize: 11),
          ),
          const SizedBox(height: 12),
          ElevatedButton(
            onPressed: () => _showSchemeDetails(l10n),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: AppColors.navy,
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            ),
            child: Text(l10n.viewHealthCardAndHospitals, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryPills(AppLocalizations l10n) {
    final categories = [
      {'key': 'all', 'label': '${l10n.filterAll} (8)'},
      {'key': 'insurance', 'label': l10n.insuranceCategory},
      {'key': 'welfare', 'label': l10n.welfareCategory},
      {'key': 'health', 'label': 'Health'},
      {'key': 'financial', 'label': l10n.financialCategory},
    ];

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: categories.map((cat) {
          final isSelected = _selectedCategory == cat['key'];
          return GestureDetector(
            onTap: () => setState(() => _selectedCategory = cat['key']!),
            child: Container(
              margin: const EdgeInsets.only(right: 8),
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
              decoration: BoxDecoration(
                color: isSelected ? AppColors.cobalt : AppColors.cardWhite,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: isSelected ? AppColors.cobalt : AppColors.border,
                ),
              ),
              child: Text(
                cat['label']!,
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                  color: isSelected ? Colors.white : AppColors.textSecondary,
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildSchemeCard(SchemeItem scheme, AppLocalizations l10n) {
    Color statusColor = AppColors.emerald;
    if (scheme.status == 'In Review') statusColor = AppColors.amber;
    if (scheme.status == 'Eligible') statusColor = AppColors.cobalt;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.cardWhite,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: AppColors.cobaltLight,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(scheme.icon, color: AppColors.cobalt, size: 22),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          scheme.id,
                          style: const TextStyle(fontSize: 10, color: AppColors.textMuted, fontWeight: FontWeight.bold),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 1.5),
                          decoration: BoxDecoration(
                            color: statusColor.withValues(alpha: 0.12),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            scheme.status,
                            style: TextStyle(fontSize: 9.5, fontWeight: FontWeight.bold, color: statusColor),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 2),
                    Text(
                      scheme.title,
                      style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: AppColors.textPrimary),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            scheme.description,
            style: const TextStyle(fontSize: 11, color: AppColors.textSecondary, height: 1.3),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                scheme.coverage,
                style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w800, color: AppColors.navy),
              ),
              if (scheme.status == 'Eligible')
                TextButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Submitting application for ${scheme.title}...')),
                    );
                  },
                  child: Text(l10n.applyNow, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: AppColors.cobalt)),
                )
              else
                TextButton(
                  onPressed: () => _showSchemeDetails(l10n),
                  child: Text(l10n.viewStatus, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: AppColors.textMuted)),
                ),
            ],
          ),
        ],
      ),
    );
  }

  void _showSchemeDetails(AppLocalizations l10n) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text(l10n.schemeVerificationCard, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Beneficiary: Ramesh Kumar (WKR-2847)', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 6),
            Text(l10n.policyNumberLabel),
            const SizedBox(height: 4),
            Text(l10n.policyStatusLabel),
            const SizedBox(height: 4),
            Text(l10n.tpaHelplineLabel),
          ],
        ),
        actions: [
          ElevatedButton(
            onPressed: () => Navigator.pop(ctx),
            style: ElevatedButton.styleFrom(backgroundColor: AppColors.cobalt, foregroundColor: Colors.white),
            child: Text(l10n.close),
          ),
        ],
      ),
    );
  }
}
