import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:stitch_worker/l10n/generated/app_localizations.dart';
import '../../app/theme/app_colors.dart';
import '../../app/router.dart';

/// Worker Help & Support Screen.
class SupportScreen extends StatelessWidget {
  const SupportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    final topics = [
      {'icon': Icons.account_balance_wallet_outlined, 'title': l10n.paymentDispute, 'sub': 'Pending settlement or UPI transaction failures'},
      {'icon': Icons.assignment_late_outlined, 'title': l10n.jobDispute, 'sub': 'Customer rejected quotation or scope mismatch'},
      {'icon': Icons.warning_amber_rounded, 'title': l10n.unsafeLocation, 'sub': 'Hazardous premises or hostile customer conditions'},
      {'icon': Icons.build_circle_outlined, 'title': 'Equipment & Material Support', 'sub': 'Cooperative tool depot & material credit bills'},
    ];

    return Scaffold(
      backgroundColor: AppColors.surface,
      appBar: AppBar(
        backgroundColor: AppColors.navy,
        foregroundColor: Colors.white,
        title: Text(
          l10n.supportTitle,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.emergency, color: AppColors.rose),
            onPressed: () => context.push(Routes.sos),
          ),
        ],
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            // Society Helpdesk Hero
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF0F223D), Color(0xFF1E3A8A)],
                ),
                borderRadius: BorderRadius.circular(18),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        l10n.societyHelpdesk.toUpperCase(),
                        style: TextStyle(
                          color: Colors.blue.shade200,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                        decoration: BoxDecoration(
                          color: AppColors.emerald.withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: const Text(
                          'Online 24/7',
                          style: TextStyle(fontSize: 10, color: AppColors.emerald, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Need assistance with your job or payout?',
                    style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'Cooperative officers are available to support all verified field workers.',
                    style: TextStyle(color: Colors.white70, fontSize: 11),
                  ),
                  const SizedBox(height: 14),
                  ElevatedButton.icon(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(l10n.connectingSupportHotline)),
                      );
                    },
                    icon: const Icon(Icons.call, size: 16),
                    label: Text(l10n.callSupportNumber),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.cobalt,
                      foregroundColor: Colors.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Help Topics
            Text(
              'ISSUE CATEGORIES',
              style: const TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.bold,
                letterSpacing: 0.8,
                color: AppColors.textSecondary,
              ),
            ),
            const SizedBox(height: 8),
            ...topics.map((t) => _buildTopicTile(t, context, l10n)),
            const SizedBox(height: 20),

            // FAQ Section
            Text(
              l10n.faqTitle.toUpperCase(),
              style: const TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.bold,
                letterSpacing: 0.8,
                color: AppColors.textSecondary,
              ),
            ),
            const SizedBox(height: 8),
            _buildFaqItem(
              'When are weekly earnings transferred to my bank account?',
              'Weekly settlements occur automatically every Thursday midnight directly to your verified cooperative bank account.',
            ),
            _buildFaqItem(
              'What happens if a customer cancels after I arrive?',
              'If you arrive and the customer cancels or is unavailable after the 10-minute protocol, a guaranteed ₹150 onsite fee is credited to your settlement.',
            ),
            _buildFaqItem(
              'How are material costs reimbursed?',
              'Attach the physical shop cash memo or GST invoice in the Service Execution screen. The verified material amount is refunded 100% without deductions.',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTopicTile(Map<String, dynamic> topic, BuildContext context, AppLocalizations l10n) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: AppColors.cardWhite,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.border),
      ),
      child: Material(
        color: Colors.transparent,
        child: ListTile(
          leading: Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(
              color: AppColors.cobaltLight,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(topic['icon'] as IconData, color: AppColors.cobalt, size: 20),
          ),
          title: Text(
            topic['title'] as String,
            style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: AppColors.textPrimary),
          ),
          subtitle: Text(
            topic['sub'] as String,
            style: const TextStyle(fontSize: 10.5, color: AppColors.textMuted),
          ),
          trailing: const Icon(Icons.chevron_right, size: 18, color: AppColors.textSlate),
          onTap: () {
            _showDisputeDialog(context, topic['title'] as String, l10n);
          },
        ),
      ),
    );
  }

  Widget _buildFaqItem(String question, String answer) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: AppColors.cardWhite,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border),
      ),
      child: Material(
        color: Colors.transparent,
        child: ExpansionTile(
          title: Text(
            question,
            style: const TextStyle(fontSize: 12.5, fontWeight: FontWeight.w600, color: AppColors.textPrimary),
          ),
          childrenPadding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
          children: [
            Text(
              answer,
              style: const TextStyle(fontSize: 11, color: AppColors.textSecondary, height: 1.4),
            ),
          ],
        ),
      ),
    );
  }

  void _showDisputeDialog(BuildContext context, String topic, AppLocalizations l10n) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text(topic, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
        content: Text(
          'An official ticket will be created for cooperative field mediation regarding: $topic. A society officer will contact you within 30 minutes.',
          style: const TextStyle(fontSize: 12),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text(l10n.dismiss, style: const TextStyle(color: AppColors.textMuted)),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(ctx);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(l10n.supportTicketCreated)),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.cobalt,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            ),
            child: Text(l10n.logTicket),
          ),
        ],
      ),
    );
  }
}
