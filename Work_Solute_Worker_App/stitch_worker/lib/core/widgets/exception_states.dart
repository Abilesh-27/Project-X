import 'package:flutter/material.dart';
import '../../app/theme/app_colors.dart';

/// Reusable Standard Exception State Component.
/// Explains: WHAT HAPPENED + WHAT THE WORKER CAN DO NEXT.
class ExceptionStateCard extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final Color iconBgColor;
  final String title;
  final String description;
  final String? actionLabel;
  final VoidCallback? onAction;
  final String? secondaryActionLabel;
  final VoidCallback? onSecondaryAction;

  const ExceptionStateCard({
    super.key,
    required this.icon,
    this.iconColor = AppColors.cobalt,
    this.iconBgColor = AppColors.cobaltLight,
    required this.title,
    required this.description,
    this.actionLabel,
    this.onAction,
    this.secondaryActionLabel,
    this.onSecondaryAction,
  });

  factory ExceptionStateCard.networkError({VoidCallback? onRetry}) {
    return ExceptionStateCard(
      icon: Icons.wifi_off_rounded,
      iconColor: AppColors.roseDark,
      iconBgColor: AppColors.roseLight,
      title: 'No Internet Connection',
      description: 'Your mobile network or Wi-Fi is disconnected. Please re-enable connectivity to sync active job status and OTP verification.',
      actionLabel: 'Retry Connection',
      onAction: onRetry,
    );
  }

  factory ExceptionStateCard.gpsDenied({VoidCallback? onGrant}) {
    return ExceptionStateCard(
      icon: Icons.location_off_rounded,
      iconColor: AppColors.amberDark,
      iconBgColor: AppColors.amberLight,
      title: 'GPS Location Access Required',
      description: 'Location telemetry is required by cooperative safety rules to verify your on-site arrival and calculate distance reimbursements.',
      actionLabel: 'Enable Location Access',
      onAction: onGrant,
    );
  }

  factory ExceptionStateCard.cameraDenied({VoidCallback? onGrant}) {
    return ExceptionStateCard(
      icon: Icons.no_photography_rounded,
      iconColor: AppColors.amberDark,
      iconBgColor: AppColors.amberLight,
      title: 'Camera Access Needed',
      description: 'Camera access is required to capture before/after work verification photos and physical cash memo receipts for material reimbursements.',
      actionLabel: 'Grant Camera Permission',
      onAction: onGrant,
    );
  }

  factory ExceptionStateCard.sessionExpired({VoidCallback? onLogin}) {
    return ExceptionStateCard(
      icon: Icons.lock_clock_outlined,
      iconColor: AppColors.navy,
      iconBgColor: AppColors.surfaceAlt,
      title: 'Session Expired',
      description: 'Your secure session has timed out due to inactivity. Please log in with your cooperative credentials to resume.',
      actionLabel: 'Log In Again',
      onAction: onLogin,
    );
  }

  factory ExceptionStateCard.accountLocked({VoidCallback? onContactHelpdesk}) {
    return ExceptionStateCard(
      icon: Icons.lock_person_outlined,
      iconColor: AppColors.roseDark,
      iconBgColor: AppColors.roseLight,
      title: 'Account Temporarily Locked',
      description: 'Multiple failed PIN attempts detected. Contact your cooperative society administrator or call the 24/7 hotline to unlock.',
      actionLabel: 'Contact Society Helpdesk',
      onAction: onContactHelpdesk,
    );
  }

  factory ExceptionStateCard.disputeActive({VoidCallback? onViewDetails}) {
    return ExceptionStateCard(
      icon: Icons.gavel_rounded,
      iconColor: AppColors.amberDark,
      iconBgColor: AppColors.amberLight,
      title: 'Job Scope Dispute Under Review',
      description: 'A disagreement on job pricing or diagnosis has been escalated to cooperative mediation. Work is temporarily paused until resolved.',
      actionLabel: 'View Dispute Details',
      onAction: onViewDetails,
    );
  }

  factory ExceptionStateCard.noActiveJob() {
    return const ExceptionStateCard(
      icon: Icons.assignment_turned_in_outlined,
      iconColor: AppColors.cobalt,
      iconBgColor: AppColors.cobaltLight,
      title: 'No Active Job In Progress',
      description: 'You currently have no ongoing assignments. Turn on "Active Day" toggle on the Home screen to receive new incoming job alerts.',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: AppColors.cardWhite,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: AppColors.border),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.03),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: iconBgColor,
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, color: iconColor, size: 30),
              ),
              const SizedBox(height: 16),
              Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                description,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 12,
                  color: AppColors.textSecondary,
                  height: 1.4,
                ),
              ),
              if (actionLabel != null && onAction != null) ...[
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: onAction,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.cobalt,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      elevation: 0,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    ),
                    child: Text(actionLabel!, style: const TextStyle(fontSize: 12.5, fontWeight: FontWeight.bold)),
                  ),
                ),
              ],
              if (secondaryActionLabel != null && onSecondaryAction != null) ...[
                const SizedBox(height: 8),
                TextButton(
                  onPressed: onSecondaryAction,
                  child: Text(secondaryActionLabel!, style: const TextStyle(fontSize: 12, color: AppColors.textMuted)),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
