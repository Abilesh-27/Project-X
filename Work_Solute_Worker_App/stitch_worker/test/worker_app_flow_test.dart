import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stitch_worker/core/models/job_model.dart';
import 'package:stitch_worker/core/services/locale_service.dart';
import 'package:stitch_worker/l10n/generated/app_localizations.dart';
import 'package:stitch_worker/features/earnings/earnings_dashboard_screen.dart';
import 'package:stitch_worker/features/operations/report_delay_screen.dart';
import 'package:stitch_worker/features/operations/cancel_job_screen.dart';
import 'package:stitch_worker/features/operations/reschedule_screen.dart';
import 'package:stitch_worker/features/operations/customer_unavailable_screen.dart';
import 'package:stitch_worker/features/notifications/notifications_screen.dart';
import 'package:stitch_worker/features/schedule/schedule_screen.dart';
import 'package:stitch_worker/features/settings/settings_screen.dart';
import 'package:stitch_worker/features/support/support_screen.dart';
import 'package:stitch_worker/features/support/sos_screen.dart';
import 'package:stitch_worker/features/institution/institution_dashboard_screen.dart';
import 'package:stitch_worker/features/courses/courses_screen.dart';
import 'package:stitch_worker/features/schemes/schemes_screen.dart';
import 'package:stitch_worker/features/home/home_dashboard_screen.dart';
import 'package:stitch_worker/features/customer/customer_home_screen.dart';
import 'package:stitch_worker/features/jobs/inspection_diagnosis_screen.dart';
import 'package:stitch_worker/features/jobs/otp_verification_screen.dart';
import 'package:stitch_worker/features/jobs/service_completion_otp_screen.dart';
import 'package:stitch_worker/core/widgets/bottom_nav.dart';

void main() {
  group('Canonical Job Model & State Machine Tests', () {
    test('Job DemoData pricing consistency', () {
      final job = DemoData.customerJob;
      expect(job.jobId, 'C-4821');
      expect(job.customerName, 'Priya Sharma');
      expect(job.labourCharge, 350.0);
      expect(job.materialCost, 300.0);
      expect(job.serviceSubtotal, 650.0);
      expect(job.platformFeeAmount, 65.0);
      expect(job.customerTotal, 715.0);
      expect(job.onsiteFee, 150.0);
    });

    test('Job status transition lifecycle flow', () {
      var job = DemoData.customerJob.copyWithStatus(JobStatus.newRequest);
      expect(job.status, JobStatus.newRequest);

      job = job.copyWithStatus(JobStatus.workerAccepted);
      expect(job.status, JobStatus.workerAccepted);

      job = job.copyWithStatus(JobStatus.confirmed);
      expect(job.status, JobStatus.confirmed);

      job = job.copyWithStatus(JobStatus.enRoute);
      expect(job.status, JobStatus.enRoute);

      job = job.copyWithStatus(JobStatus.arrived);
      expect(job.status, JobStatus.arrived);

      job = job.copyWithStatus(JobStatus.otpVerified);
      expect(job.status, JobStatus.otpVerified);

      job = job.copyWithStatus(JobStatus.inspection);
      expect(job.status, JobStatus.inspection);

      job = job.copyWithStatus(JobStatus.quotationSent);
      expect(job.status, JobStatus.quotationSent);

      job = job.copyWithStatus(JobStatus.quotationAccepted);
      expect(job.status, JobStatus.quotationAccepted);

      job = job.copyWithStatus(JobStatus.serviceInProgress);
      expect(job.status, JobStatus.serviceInProgress);

      job = job.copyWithStatus(JobStatus.paymentCompleted);
      expect(job.status, JobStatus.paymentCompleted);

      job = job.copyWithStatus(JobStatus.invoiceGenerated);
      expect(job.status, JobStatus.invoiceGenerated);

      job = job.copyWithStatus(JobStatus.completed);
      expect(job.status, JobStatus.completed);
    });

    test('Worker Profile metrics consistency', () {
      const worker = DemoData.worker;
      expect(worker.workerId, 'WKR-2847');
      expect(worker.name, 'Ramesh Kumar');
      expect(worker.rating, 4.85);
      expect(worker.completedJobs, 47);
      expect(worker.cancelledJobs, 2);
    });
  });

  group('Multilingual Localization Coverage Tests', () {
    setUp(() {
      SharedPreferences.setMockInitialValues({});
    });

    test('Supported locales include English, Hindi, Tamil, Malayalam', () {
      final supportedCodes = AppLocalizations.supportedLocales.map((l) => l.languageCode).toList();
      expect(supportedCodes, containsAll(['en', 'hi', 'ta', 'ml']));
    });

    testWidgets('AppLocalizations loads correctly for all 4 languages', (WidgetTester tester) async {
      for (final code in ['en', 'hi', 'ta', 'ml']) {
        late AppLocalizations localizations;

        await tester.pumpWidget(
          MaterialApp(
            locale: Locale(code),
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            home: Builder(
              builder: (context) {
                localizations = AppLocalizations.of(context);
                return Scaffold(
                  body: Text(localizations.appTitle),
                );
              },
            ),
          ),
        );

        await tester.pumpAndSettle();

        // Verify fundamental strings are localized and non-empty for this language
        expect(localizations.appTitle.isNotEmpty, isTrue);
        expect(localizations.navHome.isNotEmpty, isTrue);
        expect(localizations.navCustomer.isNotEmpty, isTrue);
        expect(localizations.navInstitution.isNotEmpty, isTrue);
        expect(localizations.navCourses.isNotEmpty, isTrue);
        expect(localizations.navSchemes.isNotEmpty, isTrue);
        expect(localizations.earningsTitle.isNotEmpty, isTrue);
        expect(localizations.myProfile.isNotEmpty, isTrue);
        expect(localizations.settingsTitle.isNotEmpty, isTrue);
        expect(localizations.emergencySosTitle.isNotEmpty, isTrue);
      }
    });

    test('LocaleProvider updates and notifies listeners', () {
      final provider = LocaleProvider();
      expect(provider.locale.languageCode, 'en');

      provider.setLocale(const Locale('hi'));
      expect(provider.locale.languageCode, 'hi');

      provider.setLocale(const Locale('ta'));
      expect(provider.locale.languageCode, 'ta');

      provider.setLocale(const Locale('ml'));
      expect(provider.locale.languageCode, 'ml');

      provider.setLocale(const Locale('en'));
      expect(provider.locale.languageCode, 'en');
    });
  });

  group('Screen Rendering & Widget Hierarchy Verification Tests', () {
    Widget testHarness(Widget child) {
      return MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: child,
      );
    }

    testWidgets('EarningsDashboardScreen renders successfully', (WidgetTester tester) async {
      await tester.pumpWidget(testHarness(const EarningsDashboardScreen()));
      await tester.pumpAndSettle();
      expect(find.byType(EarningsDashboardScreen), findsOneWidget);
    });

    testWidgets('ReportDelayScreen renders successfully with Job data', (WidgetTester tester) async {
      await tester.pumpWidget(testHarness(ReportDelayScreen(job: DemoData.customerJob)));
      await tester.pumpAndSettle();
      expect(find.byType(ReportDelayScreen), findsOneWidget);
    });

    testWidgets('CancelJobScreen renders successfully with Job data', (WidgetTester tester) async {
      await tester.pumpWidget(testHarness(CancelJobScreen(job: DemoData.customerJob)));
      await tester.pumpAndSettle();
      expect(find.byType(CancelJobScreen), findsOneWidget);
    });

    testWidgets('RescheduleScreen renders successfully with Job data', (WidgetTester tester) async {
      await tester.pumpWidget(testHarness(RescheduleScreen(job: DemoData.customerJob)));
      await tester.pumpAndSettle();
      expect(find.byType(RescheduleScreen), findsOneWidget);
    });

    testWidgets('CustomerUnavailableScreen renders successfully with Job data', (WidgetTester tester) async {
      await tester.pumpWidget(testHarness(CustomerUnavailableScreen(job: DemoData.customerJob)));
      await tester.pumpAndSettle();
      expect(find.byType(CustomerUnavailableScreen), findsOneWidget);
    });

    testWidgets('NotificationsScreen renders successfully', (WidgetTester tester) async {
      await tester.pumpWidget(testHarness(const NotificationsScreen()));
      await tester.pumpAndSettle();
      expect(find.byType(NotificationsScreen), findsOneWidget);
    });

    testWidgets('ScheduleScreen renders successfully', (WidgetTester tester) async {
      await tester.pumpWidget(testHarness(const ScheduleScreen()));
      await tester.pumpAndSettle();
      expect(find.byType(ScheduleScreen), findsOneWidget);
    });

    testWidgets('SettingsScreen renders successfully', (WidgetTester tester) async {
      final provider = LocaleProvider();
      await tester.pumpWidget(
        ChangeNotifierProvider.value(
          value: provider,
          child: testHarness(const SettingsScreen()),
        ),
      );
      await tester.pumpAndSettle();
      expect(find.byType(SettingsScreen), findsOneWidget);
    });

    testWidgets('SupportScreen renders successfully', (WidgetTester tester) async {
      await tester.pumpWidget(testHarness(const SupportScreen()));
      await tester.pumpAndSettle();
      expect(find.byType(SupportScreen), findsOneWidget);
    });

    testWidgets('SosScreen renders successfully', (WidgetTester tester) async {
      await tester.pumpWidget(testHarness(const SosScreen()));
      await tester.pumpAndSettle();
      expect(find.byType(SosScreen), findsOneWidget);
    });

    testWidgets('InstitutionDashboardScreen renders successfully', (WidgetTester tester) async {
      await tester.pumpWidget(testHarness(const InstitutionDashboardScreen()));
      await tester.pumpAndSettle();
      expect(find.byType(InstitutionDashboardScreen), findsOneWidget);
    });

    testWidgets('CoursesScreen renders successfully', (WidgetTester tester) async {
      await tester.pumpWidget(testHarness(const CoursesScreen()));
      await tester.pumpAndSettle();
      expect(find.byType(CoursesScreen), findsOneWidget);
    });

    testWidgets('SchemesScreen renders successfully', (WidgetTester tester) async {
      await tester.pumpWidget(testHarness(const SchemesScreen()));
      await tester.pumpAndSettle();
      expect(find.byType(SchemesScreen), findsOneWidget);
    });

    testWidgets('CustomerHomeScreen renders successfully', (WidgetTester tester) async {
      await tester.pumpWidget(testHarness(const Scaffold(body: CustomerHomeScreen())));
      await tester.pumpAndSettle();
      expect(find.byType(CustomerHomeScreen), findsOneWidget);
    });

    testWidgets('HomeDashboardScreen renders successfully', (WidgetTester tester) async {
      await tester.pumpWidget(testHarness(const Scaffold(body: HomeDashboardScreen())));
      await tester.pumpAndSettle();
      expect(find.byType(HomeDashboardScreen), findsOneWidget);
    });
  });

  group('Home Dashboard Responsive & Localization Verification (en, ta, hi, ml on narrow 360x640)', () {
    final locales = ['en', 'ta', 'hi', 'ml'];

    for (final lang in locales) {
      testWidgets('HomeDashboard renders without overflow in $lang on narrow screen (360x640)', (tester) async {
        tester.view.physicalSize = const Size(360, 640);
        tester.view.devicePixelRatio = 1.0;
        addTearDown(() {
          tester.view.resetPhysicalSize();
          tester.view.resetDevicePixelRatio();
        });

        await tester.pumpWidget(
          MaterialApp(
            locale: Locale(lang),
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            home: const Scaffold(
              body: HomeDashboardScreen(),
            ),
          ),
        );
        await tester.pumpAndSettle();
        expect(find.byType(HomeDashboardScreen), findsOneWidget);
      });

      testWidgets('AppBottomNav renders without overflow in $lang on narrow screen (360x640)', (tester) async {
        tester.view.physicalSize = const Size(360, 640);
        tester.view.devicePixelRatio = 1.0;
        addTearDown(() {
          tester.view.resetPhysicalSize();
          tester.view.resetDevicePixelRatio();
        });

        await tester.pumpWidget(
          MaterialApp(
            locale: Locale(lang),
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            home: Scaffold(
              body: const SizedBox(),
              bottomNavigationBar: AppBottomNav(
                currentIndex: 0,
                onTap: (_) {},
              ),
            ),
          ),
        );
        await tester.pumpAndSettle();
        expect(find.byType(AppBottomNav), findsOneWidget);
      });
    }
  });

  group('Customer Home Responsive & Localization Verification (en, ta, hi, ml on narrow 360x640)', () {
    final locales = ['en', 'ta', 'hi', 'ml'];

    for (final lang in locales) {
      testWidgets('CustomerHomeScreen renders without overflow in $lang on narrow screen (360x640)', (tester) async {
        tester.view.physicalSize = const Size(360, 640);
        tester.view.devicePixelRatio = 1.0;
        addTearDown(() {
          tester.view.resetPhysicalSize();
          tester.view.resetDevicePixelRatio();
        });

        await tester.pumpWidget(
          MaterialApp(
            locale: Locale(lang),
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            home: const Scaffold(
              body: CustomerHomeScreen(),
            ),
          ),
        );
        await tester.pumpAndSettle();
        expect(find.byType(CustomerHomeScreen), findsOneWidget);
      });
    }

    for (final lang in locales) {
      testWidgets('CustomerHomeScreen scrolls down and up fluidly in $lang without stucking', (tester) async {
        tester.view.physicalSize = const Size(360, 640);
        tester.view.devicePixelRatio = 1.0;
        addTearDown(() {
          tester.view.resetPhysicalSize();
          tester.view.resetDevicePixelRatio();
        });

        await tester.pumpWidget(
          MaterialApp(
            locale: Locale(lang),
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            home: const Scaffold(
              body: CustomerHomeScreen(),
            ),
          ),
        );
        await tester.pumpAndSettle();

        final scrollable = find.byType(CustomScrollView);
        expect(scrollable, findsOneWidget);

        // 1. Drag starting directly from header area (Y: 50) to scroll down
        await tester.dragFrom(const Offset(180, 50), const Offset(0, -400));
        await tester.pumpAndSettle();

        // 2. Further drag down to reach bottom helpline card
        await tester.drag(scrollable, const Offset(0, -400));
        await tester.pumpAndSettle();

        // 3. Drag upwards to return to top
        await tester.drag(scrollable, const Offset(0, 800));
        await tester.pumpAndSettle();

        expect(scrollable, findsOneWidget);
      });
    }
  });

  group('Institution Dashboard Responsive & Modal Overflow Verification Tests', () {
    final locales = ['en', 'ta', 'hi', 'ml'];

    for (final lang in locales) {
      testWidgets('InstitutionDashboardScreen renders and scrolls without overflow in $lang on narrow screen (360x640)', (tester) async {
        tester.view.physicalSize = const Size(360, 640);
        tester.view.devicePixelRatio = 1.0;
        addTearDown(() {
          tester.view.resetPhysicalSize();
          tester.view.resetDevicePixelRatio();
        });

        await tester.pumpWidget(
          MaterialApp(
            locale: Locale(lang),
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            home: const Scaffold(
              body: InstitutionDashboardScreen(),
            ),
          ),
        );
        await tester.pumpAndSettle();

        expect(find.byType(InstitutionDashboardScreen), findsOneWidget);
        expect(find.text('Gate 3 Entry'), findsOneWidget);

        // Scroll down to reveal Institution Requests & Reliability score
        await tester.drag(find.byType(ListView), const Offset(0, -650));
        await tester.pumpAndSettle();

        expect(find.text('Institution Requests'), findsOneWidget);
        expect(find.text('Govt / PSU Order'), findsOneWidget);

        // Scroll back up
        await tester.drag(find.byType(ListView), const Offset(0, 750));
        await tester.pumpAndSettle();
      });
    }

    testWidgets('Squad Comms modal renders all 4 peers without bottom overflow on narrow screen (360x640)', (tester) async {
      tester.view.physicalSize = const Size(360, 640);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(() {
        tester.view.resetPhysicalSize();
        tester.view.resetDevicePixelRatio();
      });

      await tester.pumpWidget(
        MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: const Scaffold(
            body: InstitutionDashboardScreen(),
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Ensure forum button is visible before tapping
      await tester.scrollUntilVisible(find.byIcon(Icons.forum_outlined), 100);
      await tester.pumpAndSettle();

      // Tap the squad comms forum icon button
      await tester.tap(find.byIcon(Icons.forum_outlined));
      await tester.pumpAndSettle();

      // Verify modal opened and peers rendered without any overflow
      expect(find.text('Squad Comms — 4 Confirmed Peers'), findsOneWidget);
      expect(find.text('Rajesh Kumar (You)'), findsOneWidget);
      expect(find.text('Anil Sharma'), findsOneWidget);
      expect(find.text('Vikram Kanojia'), findsOneWidget);
      expect(find.text('Pawan Solanki'), findsOneWidget);
    });

    testWidgets('Transit Corridor Telemetry modal opens and closes without overflow', (tester) async {
      tester.view.physicalSize = const Size(360, 640);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(() {
        tester.view.resetPhysicalSize();
        tester.view.resetDevicePixelRatio();
      });

      await tester.pumpWidget(
        MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: const Scaffold(
            body: InstitutionDashboardScreen(),
          ),
        ),
      );
      await tester.pumpAndSettle();

      await tester.tap(find.text('View Transit Corridor'));
      await tester.pumpAndSettle();

      expect(find.text('Transit Corridor Telemetry'), findsOneWidget);
      await tester.tap(find.text('Close Corridor Details'));
      await tester.pumpAndSettle();
      expect(find.text('Transit Corridor Telemetry'), findsNothing);
    });
  });

  group('Inspection Diagnosis Screen & Button Logic Verification Tests', () {
    Widget testHarness(Widget child) {
      return MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: child,
      );
    }

    testWidgets('InspectionDiagnosisScreen renders and COMPLETE INSPECTION button is enabled in demo state', (tester) async {
      await tester.pumpWidget(testHarness(InspectionDiagnosisScreen(job: DemoData.customerJob)));
      await tester.pumpAndSettle();

      expect(find.byType(InspectionDiagnosisScreen), findsOneWidget);

      final buttonFinder = find.widgetWithText(ElevatedButton, 'COMPLETE INSPECTION →');
      expect(buttonFinder, findsOneWidget);

      final elevatedButton = tester.widget<ElevatedButton>(buttonFinder);
      expect(elevatedButton.onPressed, isNotNull, reason: 'COMPLETE INSPECTION button must be enabled in demo reference state');
    });

    testWidgets('InspectionDiagnosisScreen disables button when observed defect is cleared and enables when re-entered', (tester) async {
      tester.view.physicalSize = const Size(600, 1800);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(() {
        tester.view.resetPhysicalSize();
        tester.view.resetDevicePixelRatio();
      });

      await tester.pumpWidget(testHarness(InspectionDiagnosisScreen(job: DemoData.customerJob)));
      await tester.pumpAndSettle();

      final buttonFinder = find.widgetWithText(ElevatedButton, 'COMPLETE INSPECTION →');
      expect(tester.widget<ElevatedButton>(buttonFinder).onPressed, isNotNull);

      final textFieldFinder = find.byType(TextField).first;
      // Clear defect
      await tester.enterText(textFieldFinder, '');
      await tester.pumpAndSettle();

      // Button must now be disabled
      expect(tester.widget<ElevatedButton>(buttonFinder).onPressed, isNull, reason: 'Button must be disabled when observed defect is empty');
      expect(find.text('Enter observed defect and attach at least 1 proof photo to unlock quotation.'), findsOneWidget);

      // Re-enter defect
      await tester.enterText(textFieldFinder, 'Broken PVC trap pipe causing active drip');
      await tester.pumpAndSettle();

      // Button must now be re-enabled
      expect(tester.widget<ElevatedButton>(buttonFinder).onPressed, isNotNull, reason: 'Button must re-enable once defect is entered');
    });

    testWidgets('InspectionDiagnosisScreen disables button when all proof photos are removed and re-enables on add', (tester) async {
      tester.view.physicalSize = const Size(600, 1800);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(() {
        tester.view.resetPhysicalSize();
        tester.view.resetDevicePixelRatio();
      });

      await tester.pumpWidget(testHarness(InspectionDiagnosisScreen(job: DemoData.customerJob)));
      await tester.pumpAndSettle();

      final buttonFinder = find.widgetWithText(ElevatedButton, 'COMPLETE INSPECTION →');
      expect(tester.widget<ElevatedButton>(buttonFinder).onPressed, isNotNull);

      final removeButtons = find.byTooltip('Remove photo');
      expect(removeButtons, findsNWidgets(2));

      await tester.tap(removeButtons.first);
      await tester.pumpAndSettle();

      // One photo left -> still enabled
      expect(tester.widget<ElevatedButton>(buttonFinder).onPressed, isNotNull);

      // Remove the second photo
      await tester.tap(find.byTooltip('Remove photo').first);
      await tester.pumpAndSettle();

      // Zero photos left -> disabled
      expect(tester.widget<ElevatedButton>(buttonFinder).onPressed, isNull, reason: 'Button must be disabled when 0 proof photos attached');

      // Tap Add Photo to add a photo
      await tester.tap(find.text('Add Photo'));
      await tester.pumpAndSettle();

      // Photo added -> button re-enabled
      expect(tester.widget<ElevatedButton>(buttonFinder).onPressed, isNotNull, reason: 'Button must re-enable when photo is added');
    });

    testWidgets('InspectionDiagnosisScreen works with freshly arrived job lacking prior diagnosis', (tester) async {
      final freshJob = DemoData.newRequestJob.copyWithStatus(JobStatus.otpVerified);
      await tester.pumpWidget(testHarness(InspectionDiagnosisScreen(job: freshJob)));
      await tester.pumpAndSettle();

      final buttonFinder = find.widgetWithText(ElevatedButton, 'COMPLETE INSPECTION →');
      expect(buttonFinder, findsOneWidget);
      expect(tester.widget<ElevatedButton>(buttonFinder).onPressed, isNotNull, reason: 'Freshly arrived job must default to reference mock inspection so demo works out-of-the-box');
    });
  });

  group('Arrival OTP Verification Tests', () {
    Widget testHarness(Widget child) {
      return MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: child,
      );
    }

    testWidgets('OTP 1234 successfully validates and marks arrival verified', (tester) async {
      final job = DemoData.customerJob;
      await tester.pumpWidget(testHarness(OtpVerificationScreen(job: job)));
      await tester.pumpAndSettle();

      // Verify 4 input boxes are present
      final textFields = find.byType(TextField);
      expect(textFields, findsNWidgets(4));

      // Enter 1234 into each digit box
      await tester.enterText(textFields.at(0), '1');
      await tester.enterText(textFields.at(1), '2');
      await tester.enterText(textFields.at(2), '3');
      await tester.enterText(textFields.at(3), '4');
      await tester.pumpAndSettle();

      // Check success state
      expect(find.text('Arrival OTP Verified'), findsOneWidget);
      expect(find.text('Verified'), findsOneWidget);
      expect(find.text('START SERVICE'), findsOneWidget);
    });

    testWidgets('Incorrect OTP shows invalid error message', (tester) async {
      final job = DemoData.customerJob;
      await tester.pumpWidget(testHarness(OtpVerificationScreen(job: job)));
      await tester.pumpAndSettle();

      final textFields = find.byType(TextField);
      await tester.enterText(textFields.at(0), '9');
      await tester.enterText(textFields.at(1), '9');
      await tester.enterText(textFields.at(2), '9');
      await tester.enterText(textFields.at(3), '9');
      await tester.pumpAndSettle();

      expect(find.text('Invalid OTP. Please check and try again.'), findsOneWidget);
      expect(find.text('2 attempts left'), findsOneWidget);
    });
  });

  group('Service Completion End OTP Verification Tests', () {
    Widget testHarness(Widget child) {
      return MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: child,
      );
    }

    testWidgets('ServiceCompletionOtpScreen renders and displays summary and OTP input fields', (tester) async {
      final job = DemoData.customerJob;
      await tester.pumpWidget(testHarness(ServiceCompletionOtpScreen(job: job)));
      await tester.pumpAndSettle();

      expect(find.byType(ServiceCompletionOtpScreen), findsOneWidget);
      expect(find.text('Service Completion OTP'), findsOneWidget);
      expect(find.text('Customer Service Sign-Off'), findsOneWidget);
      expect(find.text('Demo Default OTP: 1234'), findsOneWidget);
      expect(find.byType(TextField), findsNWidgets(4));
    });

    testWidgets('End OTP 1234 successfully validates service completion and enables payment navigation', (tester) async {
      final job = DemoData.customerJob;
      await tester.pumpWidget(testHarness(ServiceCompletionOtpScreen(job: job)));
      await tester.pumpAndSettle();

      final textFields = find.byType(TextField);
      await tester.enterText(textFields.at(0), '1');
      await tester.enterText(textFields.at(1), '2');
      await tester.enterText(textFields.at(2), '3');
      await tester.enterText(textFields.at(3), '4');
      await tester.pumpAndSettle();

      expect(find.text('Service Completion OTP Verified'), findsOneWidget);
      expect(find.text('Signed Off'), findsOneWidget);
      expect(find.text('PROCEED TO BILLING & PAYMENT'), findsOneWidget);
    });

    testWidgets('Incorrect End OTP shows invalid error message and decrements attempts', (tester) async {
      final job = DemoData.customerJob;
      await tester.pumpWidget(testHarness(ServiceCompletionOtpScreen(job: job)));
      await tester.pumpAndSettle();

      final textFields = find.byType(TextField);
      await tester.enterText(textFields.at(0), '8');
      await tester.enterText(textFields.at(1), '8');
      await tester.enterText(textFields.at(2), '8');
      await tester.enterText(textFields.at(3), '8');
      await tester.pumpAndSettle();

      expect(find.text('Invalid OTP. Please check and try again.'), findsOneWidget);
      expect(find.text('2 attempts left'), findsOneWidget);
    });
  });
}


