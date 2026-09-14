import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:stitch_worker/l10n/generated/app_localizations.dart';
import '../../app/router.dart';
import '../../app/theme/app_colors.dart';
import '../../core/models/job_model.dart';
import '../../core/widgets/app_header.dart';
import '../../core/widgets/shared_widgets.dart';

/// RATING & COMPLETION SCREEN (PLAN.md §41, §42)
///
/// Final stage of the customer job lifecycle:
/// - Success badge: JOB COMPLETED SUCCESSFULLY!
/// - Rate customer experience (5 stars + feedback tags)
/// - Final earnings summary for worker
/// - "SUBMIT RATING & CLOSE" -> returns to Home Dashboard with updated job list
class JobRatingScreen extends StatefulWidget {
  final Job job;
  const JobRatingScreen({super.key, required this.job});

  @override
  State<JobRatingScreen> createState() => _JobRatingScreenState();
}

class _JobRatingScreenState extends State<JobRatingScreen> {
  int _rating = 5;
  final TextEditingController _feedbackController = TextEditingController();

  @override
  void dispose() {
    _feedbackController.dispose();
    super.dispose();
  }

  String _fmt(double v) => '₹${v.toStringAsFixed(2)}';

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final job = widget.job;
    // Worker earnings = Labour charge + Material reimbursement
    final workerEarnings = job.labourCharge + job.materialCost;

    return Scaffold(
      backgroundColor: AppColors.surfaceAlt,
      body: Column(
        children: [
          // ─── HEADER ───
          AppHeader(
            title: l10n.ratingFeedback,
            subtitle: '${l10n.customerJobId(job.jobId)} • ${job.customerName}',
            onBack: () => context.go(Routes.home),
            bottom: Row(
              children: [
                StatusChip.success(l10n.completed),
                const SizedBox(width: 8),
                StatusChip(
                  label: l10n.onSiteService,
                  backgroundColor: AppColors.onDarkOverlay10,
                  textColor: AppColors.onDarkSecondary,
                  icon: Icons.shield_outlined,
                ),
              ],
            ),
          ),

          // ─── CONTENT ───
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              children: [
                // SUCCESS BANNER
                Container(
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    color: AppColors.cardWhite,
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: AppColors.emerald.withValues(alpha: 0.3)),
                    boxShadow: [
                      BoxShadow(color: AppColors.textPrimary.withValues(alpha: 0.05), blurRadius: 10, offset: const Offset(0, 2)),
                    ],
                  ),
                  child: Column(
                    children: [
                      Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          color: AppColors.emerald.withValues(alpha: 0.1),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.celebration_rounded, color: AppColors.emerald, size: 34),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        l10n.jobCompletedSuccess,
                        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w800, color: AppColors.textPrimary),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '#${job.jobId} • ${job.serviceName}',
                        style: const TextStyle(fontSize: 12, color: AppColors.textMuted),
                      ),
                      const SizedBox(height: 14),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                        decoration: BoxDecoration(
                          color: AppColors.emerald.withValues(alpha: 0.08),
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: AppColors.emerald.withValues(alpha: 0.2)),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(Icons.account_balance_wallet_rounded, size: 16, color: AppColors.emerald),
                            const SizedBox(width: 6),
                            Text('Worker Payout: ${_fmt(workerEarnings)}', style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w800, color: AppColors.emerald)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 14),

                // RATING CARD
                AppCard(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Text(
                        l10n.rateCustomer,
                        style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w800, color: AppColors.textPrimary),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'How was your experience working with ${job.customerName}?',
                        style: const TextStyle(fontSize: 11, color: AppColors.textSecondary),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 14),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(5, (index) {
                          final star = index + 1;
                          return IconButton(
                            iconSize: 32,
                            icon: Icon(
                              star <= _rating ? Icons.star_rounded : Icons.star_border_rounded,
                              color: AppColors.amber,
                            ),
                            onPressed: () => setState(() => _rating = star),
                          );
                        }),
                      ),
                      const SizedBox(height: 12),
                      TextField(
                        controller: _feedbackController,
                        maxLines: 2,
                        style: const TextStyle(fontSize: 12),
                        decoration: InputDecoration(
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: const BorderSide(color: AppColors.borderLight)),
                          hintText: 'Add brief feedback for customer (optional)',
                          hintStyle: const TextStyle(fontSize: 11, color: AppColors.textSlate),
                          contentPadding: const EdgeInsets.all(10),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 90),
              ],
            ),
          ),
        ],
      ),

      // ─── BOTTOM ACTION BAR ───
      bottomSheet: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: AppColors.cardWhite,
          border: const Border(top: BorderSide(color: AppColors.borderLight)),
          boxShadow: [
            BoxShadow(color: AppColors.textPrimary.withValues(alpha: 0.08), blurRadius: 16, offset: const Offset(0, -4)),
          ],
        ),
        child: SafeArea(
          top: false,
          child: SizedBox(
            width: double.infinity,
            height: 48,
            child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.cobalt,
                foregroundColor: AppColors.cardWhite,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                elevation: 2,
              ),
              icon: const Icon(Icons.done_all_rounded, size: 20),
              label: Text(
                l10n.submitRating,
                style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 13, letterSpacing: 0.3),
              ),
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Rating recorded. Job closed successfully!')),
                );
                context.go(Routes.home);
              },
            ),
          ),
        ),
      ),
    );
  }
}
