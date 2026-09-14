import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../core/widgets/bottom_nav.dart';
import '../core/models/job_model.dart';
import '../features/auth/login_screen.dart';
import '../features/home/home_dashboard_screen.dart';
import '../features/customer/customer_home_screen.dart';
import '../features/institution/institution_dashboard_screen.dart';
import '../features/courses/courses_screen.dart';
import '../features/schemes/schemes_screen.dart';
import '../features/earnings/earnings_dashboard_screen.dart';
import '../features/notifications/notifications_screen.dart';
import '../features/profile/worker_profile_screen.dart';
import '../features/schedule/schedule_screen.dart';
import '../features/settings/settings_screen.dart';
import '../features/support/support_screen.dart';
import '../features/support/sos_screen.dart';
import '../features/operations/report_delay_screen.dart';
import '../features/operations/cancel_job_screen.dart';
import '../features/operations/reschedule_screen.dart';
import '../features/operations/customer_unavailable_screen.dart';
import '../features/jobs/new_job_request_screen.dart';
import '../features/jobs/schedule_conflict_screen.dart';
import '../features/jobs/waiting_for_customer_screen.dart';
import '../features/jobs/job_confirmed_screen.dart';
import '../features/jobs/journey_tracking_screen.dart';
import '../features/jobs/otp_verification_screen.dart';
import '../features/jobs/inspection_diagnosis_screen.dart';
import '../features/jobs/quotation_builder_screen.dart';
import '../features/jobs/quotation_preview_screen.dart';
import '../features/jobs/quotation_sent_screen.dart';
import '../features/jobs/customer_quotation_decision_screen.dart';
import '../features/jobs/service_execution_screen.dart';
import '../features/jobs/service_completion_otp_screen.dart';
import '../features/jobs/payment_screen.dart';
import '../features/jobs/invoice_screen.dart';
import '../features/jobs/job_rating_screen.dart';

/// Route paths — centralized to avoid typos.
class Routes {
  Routes._();
  static const String login = '/login';
  static const String home = '/';
  static const String customer = '/customer';
  static const String institution = '/institution';
  static const String courses = '/courses';
  static const String schemes = '/schemes';
  static const String profile = '/profile';
  static const String schedule = '/schedule';
  static const String notifications = '/notifications';
  static const String settings = '/settings';
  static const String support = '/support';
  static const String sos = '/sos';
  static const String earnings = '/earnings';

  // Operational screens
  static const String reportDelay = '/job/delay';
  static const String cancelJob = '/job/cancel';
  static const String reschedule = '/job/reschedule';
  static const String customerUnavailable = '/job/customer-unavailable';

  // Job lifecycle (pushed full-screen, outside the bottom-nav shell).
  static const String jobRequest = '/job-request';
  static const String scheduleConflict = '/job-request/conflict';
  static const String waitingForCustomer = '/job/waiting';
  static const String jobConfirmed = '/job/confirmed';
  static const String jobJourney = '/job/journey';
  static const String jobOtp = '/job/otp';
  static const String jobInspection = '/job/inspection';
  static const String jobQuotation = '/job/quotation';
  static const String jobQuotationPreview = '/job/quotation/preview';
  static const String jobQuotationSent = '/job/quotation/sent';
  static const String jobCustomerDecision = '/job/customer-decision';
  static const String jobServiceExecution = '/job/service-execution';
  static const String serviceCompletionOtp = '/job/completion-otp';
  static const String jobPayment = '/job/payment';
  static const String jobInvoice = '/job/invoice';
  static const String jobRating = '/job/rating';
}

/// Main app router configuration.
/// Uses GoRouter for deep-linking capability and declarative routing.
GoRouter createRouter() {
  return GoRouter(
    initialLocation: Routes.login,
    routes: [
      GoRoute(
        path: Routes.login,
        pageBuilder: (context, state) => const NoTransitionPage(
          child: LoginScreen(),
        ),
      ),
      ShellRoute(
        builder: (context, state, child) {
          return AppShell(child: child);
        },
        routes: [
          GoRoute(
            path: Routes.home,
            pageBuilder: (context, state) => const NoTransitionPage(
              child: HomeDashboardScreen(),
            ),
          ),
          GoRoute(
            path: Routes.customer,
            pageBuilder: (context, state) => const NoTransitionPage(
              child: CustomerHomeScreen(),
            ),
          ),
          GoRoute(
            path: Routes.institution,
            pageBuilder: (context, state) => const NoTransitionPage(
              child: InstitutionDashboardScreen(),
            ),
          ),
          GoRoute(
            path: Routes.courses,
            pageBuilder: (context, state) => const NoTransitionPage(
              child: CoursesScreen(),
            ),
          ),
          GoRoute(
            path: Routes.schemes,
            pageBuilder: (context, state) => const NoTransitionPage(
              child: SchemesScreen(),
            ),
          ),
        ],
      ),
      // ─── Secondary & Operational Screens ───
      GoRoute(
        path: Routes.profile,
        pageBuilder: (context, state) => const NoTransitionPage(
          child: WorkerProfileScreen(),
        ),
      ),
      GoRoute(
        path: Routes.schedule,
        pageBuilder: (context, state) => const NoTransitionPage(
          child: ScheduleScreen(),
        ),
      ),
      GoRoute(
        path: Routes.notifications,
        pageBuilder: (context, state) => const NoTransitionPage(
          child: NotificationsScreen(),
        ),
      ),
      GoRoute(
        path: Routes.settings,
        pageBuilder: (context, state) => const NoTransitionPage(
          child: SettingsScreen(),
        ),
      ),
      GoRoute(
        path: Routes.support,
        pageBuilder: (context, state) => const NoTransitionPage(
          child: SupportScreen(),
        ),
      ),
      GoRoute(
        path: Routes.sos,
        pageBuilder: (context, state) => const NoTransitionPage(
          child: SosScreen(),
        ),
      ),
      GoRoute(
        path: Routes.earnings,
        pageBuilder: (context, state) => const NoTransitionPage(
          child: EarningsDashboardScreen(),
        ),
      ),
      GoRoute(
        path: Routes.reportDelay,
        pageBuilder: (context, state) => NoTransitionPage(
          child: ReportDelayScreen(job: (state.extra as Job?) ?? DemoData.customerJob),
        ),
      ),
      GoRoute(
        path: Routes.cancelJob,
        pageBuilder: (context, state) => NoTransitionPage(
          child: CancelJobScreen(job: (state.extra as Job?) ?? DemoData.customerJob),
        ),
      ),
      GoRoute(
        path: Routes.reschedule,
        pageBuilder: (context, state) => NoTransitionPage(
          child: RescheduleScreen(job: (state.extra as Job?) ?? DemoData.customerJob),
        ),
      ),
      GoRoute(
        path: Routes.customerUnavailable,
        pageBuilder: (context, state) => NoTransitionPage(
          child: CustomerUnavailableScreen(job: (state.extra as Job?) ?? DemoData.customerJob),
        ),
      ),
      // ─── Job lifecycle screens (own header/back button, no bottom nav) ───
      GoRoute(
        path: Routes.jobRequest,
        pageBuilder: (context, state) => NoTransitionPage(
          child: NewJobRequestScreen(job: state.extra as Job),
        ),
      ),
      GoRoute(
        path: Routes.scheduleConflict,
        pageBuilder: (context, state) => NoTransitionPage(
          child: ScheduleConflictScreen(job: state.extra as Job),
        ),
      ),
      GoRoute(
        path: Routes.waitingForCustomer,
        pageBuilder: (context, state) => NoTransitionPage(
          child: WaitingForCustomerScreen(job: state.extra as Job),
        ),
      ),
      GoRoute(
        path: Routes.jobConfirmed,
        pageBuilder: (context, state) => NoTransitionPage(
          child: JobConfirmedScreen(job: state.extra as Job),
        ),
      ),
      GoRoute(
        path: Routes.jobJourney,
        pageBuilder: (context, state) => NoTransitionPage(
          child: JourneyTrackingScreen(job: state.extra as Job),
        ),
      ),
      GoRoute(
        path: Routes.jobOtp,
        pageBuilder: (context, state) => NoTransitionPage(
          child: OtpVerificationScreen(job: state.extra as Job),
        ),
      ),
      GoRoute(
        path: Routes.jobInspection,
        pageBuilder: (context, state) => NoTransitionPage(
          child: InspectionDiagnosisScreen(job: (state.extra as Job?) ?? DemoData.customerJob),
        ),
      ),
      GoRoute(
        path: Routes.jobQuotation,
        pageBuilder: (context, state) => NoTransitionPage(
          child: QuotationBuilderScreen(job: state.extra as Job),
        ),
      ),
      GoRoute(
        path: Routes.jobQuotationPreview,
        pageBuilder: (context, state) => NoTransitionPage(
          child: QuotationPreviewScreen(job: state.extra as Job),
        ),
      ),
      GoRoute(
        path: Routes.jobQuotationSent,
        pageBuilder: (context, state) => NoTransitionPage(
          child: QuotationSentScreen(job: state.extra as Job),
        ),
      ),
      GoRoute(
        path: Routes.jobCustomerDecision,
        pageBuilder: (context, state) {
          final extra = state.extra;
          if (extra is Map<String, dynamic>) {
            return NoTransitionPage(
              child: CustomerQuotationDecisionScreen(
                job: extra['job'] as Job,
                isAccepted: extra['isAccepted'] as bool? ?? true,
              ),
            );
          }
          return NoTransitionPage(
            child: CustomerQuotationDecisionScreen(job: extra as Job),
          );
        },
      ),
      GoRoute(
        path: Routes.jobServiceExecution,
        pageBuilder: (context, state) => NoTransitionPage(
          child: ServiceExecutionScreen(job: state.extra as Job),
        ),
      ),
      GoRoute(
        path: Routes.serviceCompletionOtp,
        pageBuilder: (context, state) => NoTransitionPage(
          child: ServiceCompletionOtpScreen(job: state.extra as Job),
        ),
      ),
      GoRoute(
        path: Routes.jobPayment,
        pageBuilder: (context, state) => NoTransitionPage(
          child: PaymentScreen(job: state.extra as Job),
        ),
      ),
      GoRoute(
        path: Routes.jobInvoice,
        pageBuilder: (context, state) => NoTransitionPage(
          child: InvoiceScreen(job: state.extra as Job),
        ),
      ),
      GoRoute(
        path: Routes.jobRating,
        pageBuilder: (context, state) => NoTransitionPage(
          child: JobRatingScreen(job: state.extra as Job),
        ),
      ),
    ],
  );
}

/// App shell with bottom navigation.
/// Wraps all tab-based routes with the persistent bottom nav bar.
class AppShell extends StatelessWidget {
  final Widget child;
  const AppShell({super.key, required this.child});

  int _currentIndex(BuildContext context) {
    final location = GoRouterState.of(context).uri.toString();
    if (location.startsWith(Routes.customer)) return 1;
    if (location.startsWith(Routes.institution)) return 2;
    if (location.startsWith(Routes.courses)) return 3;
    if (location.startsWith(Routes.schemes)) return 4;
    return 0;
  }

  void _onTap(BuildContext context, int index) {
    switch (index) {
      case 0: context.go(Routes.home); break;
      case 1: context.go(Routes.customer); break;
      case 2: context.go(Routes.institution); break;
      case 3: context.go(Routes.courses); break;
      case 4: context.go(Routes.schemes); break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: child,
      bottomNavigationBar: AppBottomNav(
        currentIndex: _currentIndex(context),
        onTap: (i) => _onTap(context, i),
      ),
    );
  }
}
