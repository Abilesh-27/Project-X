import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:stitch_worker/l10n/generated/app_localizations.dart';
import '../../app/theme/app_colors.dart';
import '../../app/router.dart';
import '../../core/widgets/app_header.dart';

class CourseItem {
  final String id;
  final String title;
  final String category;
  final String duration;
  final int modulesCount;
  final double progress; // 0.0 to 1.0
  final bool isCompleted;
  final bool hasCertificate;
  final IconData icon;

  const CourseItem({
    required this.id,
    required this.title,
    required this.category,
    required this.duration,
    required this.modulesCount,
    this.progress = 0.0,
    this.isCompleted = false,
    this.hasCertificate = true,
    required this.icon,
  });
}

/// Courses & Training Tab Screen.
/// Faithfully reproduces `courses_training_screen/code.html` from Stitch UI reference.
class CoursesScreen extends StatefulWidget {
  const CoursesScreen({super.key});

  @override
  State<CoursesScreen> createState() => _CoursesScreenState();
}

class _CoursesScreenState extends State<CoursesScreen> {
  String _selectedCategory = 'all';

  final List<CourseItem> _courses = const [
    CourseItem(
      id: 'CRS-101',
      title: 'High-Voltage Safety & Modern Circuitry',
      category: 'safety',
      duration: '4 hours',
      modulesCount: 6,
      progress: 0.65,
      icon: Icons.bolt,
    ),
    CourseItem(
      id: 'CRS-102',
      title: 'Domestic Pipeline Leakage & P-Trap Diagnostics',
      category: 'technical',
      duration: '6 hours',
      modulesCount: 8,
      progress: 0.20,
      icon: Icons.plumbing,
    ),
    CourseItem(
      id: 'CRS-103',
      title: 'Cooperative Workforce Ethics & Customer Protocol',
      category: 'soft_skills',
      duration: '2 hours',
      modulesCount: 3,
      progress: 1.0,
      isCompleted: true,
      hasCertificate: true,
      icon: Icons.handshake_outlined,
    ),
    CourseItem(
      id: 'CRS-104',
      title: 'ISO-45001 Occupational Health & Sanitization',
      category: 'safety',
      duration: '5 hours',
      modulesCount: 7,
      progress: 0.0,
      icon: Icons.shield_outlined,
    ),
  ];

  List<CourseItem> get _filteredCourses {
    if (_selectedCategory == 'all') return _courses;
    return _courses.where((c) => c.category == _selectedCategory).toList();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final filtered = _filteredCourses;

    return Column(
      children: [
        AppHeader(
          title: l10n.coursesTitle,
          subtitle: 'Certified Skills & Cooperative Academy',
          actions: [
            HeaderNotificationButton(
              badgeCount: 2,
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

              // 2. Category Filter Pills
              _buildCategoryPills(l10n),
              const SizedBox(height: 14),

              // 3. Section: Recommended for You
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(width: 8, height: 8, decoration: const BoxDecoration(color: AppColors.cobalt, shape: BoxShape.circle)),
                      const SizedBox(width: 6),
                      Text(
                        l10n.recommendedForYou.toUpperCase(),
                        style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: AppColors.textPrimary),
                      ),
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    decoration: BoxDecoration(
                      color: AppColors.cobaltLight,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: const Text(
                      'Matches Domain',
                      style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: AppColors.cobalt),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),

              // 4. Course Cards
              ...filtered.map((c) => _buildCourseCard(c, l10n)),
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
          _buildMetricCol(l10n.enrolled, '4', 'Total', AppColors.cobalt),
          _buildDivider(),
          _buildMetricCol(l10n.inProgress, '2', 'Active', AppColors.amberDark),
          _buildDivider(),
          _buildMetricCol('Completed', '6', 'Finished', AppColors.emeraldDark),
          _buildDivider(),
          _buildMetricCol(l10n.certificatesEarned, '5', 'Verified', Colors.purple.shade700),
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

  Widget _buildCategoryPills(AppLocalizations l10n) {
    final categories = [
      {'key': 'all', 'label': '${l10n.filterAll} (12)'},
      {'key': 'technical', 'label': l10n.technicalCourses},
      {'key': 'safety', 'label': l10n.safetyCourses},
      {'key': 'soft_skills', 'label': 'Ethics & Soft Skills'},
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

  Widget _buildCourseCard(CourseItem course, AppLocalizations l10n) {
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: AppColors.cobaltLight,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppColors.cobalt.withValues(alpha: 0.15)),
                ),
                child: Icon(course.icon, color: AppColors.cobalt, size: 22),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                          decoration: BoxDecoration(
                            color: AppColors.surfaceAlt,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            course.category.toUpperCase(),
                            style: const TextStyle(fontSize: 9, fontWeight: FontWeight.bold, color: AppColors.textMuted),
                          ),
                        ),
                        if (course.hasCertificate)
                          Row(
                            children: const [
                              Icon(Icons.military_tech, size: 14, color: AppColors.amberDark),
                              SizedBox(width: 2),
                              Text('Certified', style: TextStyle(fontSize: 10, color: AppColors.amberDark, fontWeight: FontWeight.bold)),
                            ],
                          ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      course.title,
                      style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: AppColors.textPrimary),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      '${course.duration} • ${course.modulesCount} ${l10n.modules}',
                      style: const TextStyle(fontSize: 11, color: AppColors.textMuted),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),

          // Progress Bar
          if (course.progress > 0 && !course.isCompleted) ...[
            ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: LinearProgressIndicator(
                value: course.progress,
                backgroundColor: AppColors.surfaceAlt,
                valueColor: const AlwaysStoppedAnimation(AppColors.amber),
                minHeight: 6,
              ),
            ),
            const SizedBox(height: 6),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${(course.progress * 100).toInt()}% In Progress',
                  style: const TextStyle(fontSize: 10, color: AppColors.amberDark, fontWeight: FontWeight.bold),
                ),
                TextButton(
                  onPressed: () => _openCourseSimulator(course),
                  style: TextButton.styleFrom(padding: EdgeInsets.zero, minimumSize: const Size(60, 24)),
                  child: Text(l10n.resumeCourse, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold)),
                ),
              ],
            ),
          ] else if (course.isCompleted) ...[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: const [
                    Icon(Icons.check_circle, size: 16, color: AppColors.emeraldDark),
                    SizedBox(width: 4),
                    Text('Completed & Verified', style: TextStyle(fontSize: 11, color: AppColors.emeraldDark, fontWeight: FontWeight.bold)),
                  ],
                ),
                TextButton(
                  onPressed: () => _showCertificateModal(course, l10n),
                  child: Text(l10n.viewCertificate, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold)),
                ),
              ],
            ),
          ] else ...[
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () => _openCourseSimulator(course),
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: AppColors.cobalt),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  padding: const EdgeInsets.symmetric(vertical: 8),
                ),
                child: Text(l10n.startCourse, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: AppColors.cobalt)),
              ),
            ),
          ],
        ],
      ),
    );
  }

  void _openCourseSimulator(CourseItem course) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Starting interactive training module for: ${course.title}')),
    );
  }

  void _showCertificateModal(CourseItem course, AppLocalizations l10n) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Row(
          children: const [
            Icon(Icons.military_tech, color: AppColors.amberDark),
            SizedBox(width: 8),
            Text('Certificate of Completion', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(course.title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
            const SizedBox(height: 6),
            const Text('Awarded to: Ramesh Kumar (WKR-2847)'),
            const SizedBox(height: 4),
            const Text('Accredited by: National Cooperative Skills Federation'),
            const SizedBox(height: 4),
            const Text('Certificate ID: CERT-84920491'),
          ],
        ),
        actions: [
          ElevatedButton(
            onPressed: () => Navigator.pop(ctx),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.cobalt,
              foregroundColor: Colors.white,
            ),
            child: Text(l10n.close),
          ),
        ],
      ),
    );
  }
}
