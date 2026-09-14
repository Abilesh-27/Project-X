import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_hi.dart';
import 'app_localizations_ml.dart';
import 'app_localizations_ta.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'generated/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('hi'),
    Locale('ml'),
    Locale('ta'),
  ];

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'WORK SOLUTE'**
  String get appTitle;

  /// No description provided for @cooperativePlatform.
  ///
  /// In en, this message translates to:
  /// **'Cooperative Worker Platform'**
  String get cooperativePlatform;

  /// No description provided for @verifiedFieldPortal.
  ///
  /// In en, this message translates to:
  /// **'Verified Field Workforce Portal'**
  String get verifiedFieldPortal;

  /// No description provided for @navHome.
  ///
  /// In en, this message translates to:
  /// **'HOME'**
  String get navHome;

  /// No description provided for @navCustomer.
  ///
  /// In en, this message translates to:
  /// **'CUSTOMER'**
  String get navCustomer;

  /// No description provided for @navInstitution.
  ///
  /// In en, this message translates to:
  /// **'INSTITUTION'**
  String get navInstitution;

  /// No description provided for @navCourses.
  ///
  /// In en, this message translates to:
  /// **'COURSES'**
  String get navCourses;

  /// No description provided for @navSchemes.
  ///
  /// In en, this message translates to:
  /// **'SCHEMES'**
  String get navSchemes;

  /// No description provided for @navProfile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get navProfile;

  /// No description provided for @loginTitle.
  ///
  /// In en, this message translates to:
  /// **'Worker Login'**
  String get loginTitle;

  /// No description provided for @loginSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Sign in to manage your work, assignments and direct cooperative payouts.'**
  String get loginSubtitle;

  /// No description provided for @workerIdLabel.
  ///
  /// In en, this message translates to:
  /// **'Worker ID'**
  String get workerIdLabel;

  /// No description provided for @workerIdHint.
  ///
  /// In en, this message translates to:
  /// **'e.g. WKR-2847'**
  String get workerIdHint;

  /// No description provided for @passwordLabel.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get passwordLabel;

  /// No description provided for @forgotPassword.
  ///
  /// In en, this message translates to:
  /// **'Forgot Password?'**
  String get forgotPassword;

  /// No description provided for @loginButton.
  ///
  /// In en, this message translates to:
  /// **'LOGIN'**
  String get loginButton;

  /// No description provided for @secureAccess.
  ///
  /// In en, this message translates to:
  /// **'Secure Worker Access • 256-Bit Encrypted'**
  String get secureAccess;

  /// No description provided for @societyNote.
  ///
  /// In en, this message translates to:
  /// **'Use the credentials provided by your Cooperative Society.'**
  String get societyNote;

  /// No description provided for @langPersistNote.
  ///
  /// In en, this message translates to:
  /// **'Selected language carries over to Dashboard, Quotations & Schemes.'**
  String get langPersistNote;

  /// No description provided for @needHelp.
  ///
  /// In en, this message translates to:
  /// **'Need help signing in?'**
  String get needHelp;

  /// No description provided for @societyHelpdesk.
  ///
  /// In en, this message translates to:
  /// **'Society Helpdesk'**
  String get societyHelpdesk;

  /// No description provided for @footerText.
  ///
  /// In en, this message translates to:
  /// **'X COOPERATIVE FEDERATION LTD • VERSION 2.4.0'**
  String get footerText;

  /// No description provided for @selectLanguage.
  ///
  /// In en, this message translates to:
  /// **'Select Language'**
  String get selectLanguage;

  /// No description provided for @langSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Choose your preferred language'**
  String get langSubtitle;

  /// No description provided for @langPersistInfo.
  ///
  /// In en, this message translates to:
  /// **'Preference persists across Dashboard, Customer, Quotation, Schemes and Invoice screens.'**
  String get langPersistInfo;

  /// No description provided for @verifyingCredentials.
  ///
  /// In en, this message translates to:
  /// **'Verifying Worker Credentials...'**
  String get verifyingCredentials;

  /// No description provided for @forgotPasswordTitle.
  ///
  /// In en, this message translates to:
  /// **'Forgot Password'**
  String get forgotPasswordTitle;

  /// No description provided for @forgotPasswordSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Enter your Worker ID to receive a verification OTP.'**
  String get forgotPasswordSubtitle;

  /// No description provided for @sendOtp.
  ///
  /// In en, this message translates to:
  /// **'Send OTP'**
  String get sendOtp;

  /// No description provided for @enterOtp.
  ///
  /// In en, this message translates to:
  /// **'Enter OTP'**
  String get enterOtp;

  /// No description provided for @otpSentTo.
  ///
  /// In en, this message translates to:
  /// **'OTP sent to your registered mobile number'**
  String get otpSentTo;

  /// No description provided for @newPassword.
  ///
  /// In en, this message translates to:
  /// **'New Password'**
  String get newPassword;

  /// No description provided for @confirmPassword.
  ///
  /// In en, this message translates to:
  /// **'Confirm Password'**
  String get confirmPassword;

  /// No description provided for @resetPassword.
  ///
  /// In en, this message translates to:
  /// **'Reset Password'**
  String get resetPassword;

  /// No description provided for @passwordResetSuccess.
  ///
  /// In en, this message translates to:
  /// **'Password reset successfully! Please login with your new password.'**
  String get passwordResetSuccess;

  /// No description provided for @accountLockedTitle.
  ///
  /// In en, this message translates to:
  /// **'Account Locked'**
  String get accountLockedTitle;

  /// No description provided for @accountLockedMsg.
  ///
  /// In en, this message translates to:
  /// **'Your account has been temporarily locked due to multiple failed login attempts. Please contact your cooperative society helpdesk.'**
  String get accountLockedMsg;

  /// No description provided for @sessionExpiredTitle.
  ///
  /// In en, this message translates to:
  /// **'Session Expired'**
  String get sessionExpiredTitle;

  /// No description provided for @sessionExpiredMsg.
  ///
  /// In en, this message translates to:
  /// **'Your session has expired. Please login again to continue.'**
  String get sessionExpiredMsg;

  /// No description provided for @reLogin.
  ///
  /// In en, this message translates to:
  /// **'Re-Login'**
  String get reLogin;

  /// No description provided for @contactSupport.
  ///
  /// In en, this message translates to:
  /// **'Contact Support'**
  String get contactSupport;

  /// No description provided for @goodMorning.
  ///
  /// In en, this message translates to:
  /// **'Good Morning'**
  String get goodMorning;

  /// No description provided for @goodAfternoon.
  ///
  /// In en, this message translates to:
  /// **'Good Afternoon'**
  String get goodAfternoon;

  /// No description provided for @goodEvening.
  ///
  /// In en, this message translates to:
  /// **'Good Evening'**
  String get goodEvening;

  /// No description provided for @verified.
  ///
  /// In en, this message translates to:
  /// **'Verified'**
  String get verified;

  /// No description provided for @activeDay.
  ///
  /// In en, this message translates to:
  /// **'ACTIVE DAY'**
  String get activeDay;

  /// No description provided for @inactiveDay.
  ///
  /// In en, this message translates to:
  /// **'INACTIVE DAY'**
  String get inactiveDay;

  /// No description provided for @onCall.
  ///
  /// In en, this message translates to:
  /// **'ON-CALL'**
  String get onCall;

  /// No description provided for @readyToReceive.
  ///
  /// In en, this message translates to:
  /// **'Ready to receive work'**
  String get readyToReceive;

  /// No description provided for @requestsPaused.
  ///
  /// In en, this message translates to:
  /// **'New work requests are paused'**
  String get requestsPaused;

  /// No description provided for @serviceStartsIn.
  ///
  /// In en, this message translates to:
  /// **'SERVICE STARTS IN {time}'**
  String serviceStartsIn(String time);

  /// No description provided for @startsIn.
  ///
  /// In en, this message translates to:
  /// **'Starts in {minutes}m'**
  String startsIn(String minutes);

  /// No description provided for @customerJobId.
  ///
  /// In en, this message translates to:
  /// **'Customer Job #{id}'**
  String customerJobId(String id);

  /// No description provided for @scheduled.
  ///
  /// In en, this message translates to:
  /// **'Scheduled'**
  String get scheduled;

  /// No description provided for @customer.
  ///
  /// In en, this message translates to:
  /// **'Customer'**
  String get customer;

  /// No description provided for @institution.
  ///
  /// In en, this message translates to:
  /// **'Institution'**
  String get institution;

  /// No description provided for @startJourney.
  ///
  /// In en, this message translates to:
  /// **'START JOURNEY'**
  String get startJourney;

  /// No description provided for @onTime.
  ///
  /// In en, this message translates to:
  /// **'ON TIME'**
  String get onTime;

  /// No description provided for @delayed.
  ///
  /// In en, this message translates to:
  /// **'DELAYED'**
  String get delayed;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'CANCEL'**
  String get cancel;

  /// No description provided for @todaysLiveActivity.
  ///
  /// In en, this message translates to:
  /// **'Today\'s Live Activity'**
  String get todaysLiveActivity;

  /// No description provided for @serviceInProgress.
  ///
  /// In en, this message translates to:
  /// **'Service In Progress'**
  String get serviceInProgress;

  /// No description provided for @enRoute.
  ///
  /// In en, this message translates to:
  /// **'En Route'**
  String get enRoute;

  /// No description provided for @arrived.
  ///
  /// In en, this message translates to:
  /// **'Arrived'**
  String get arrived;

  /// No description provided for @inProgress.
  ///
  /// In en, this message translates to:
  /// **'In Progress'**
  String get inProgress;

  /// No description provided for @completed.
  ///
  /// In en, this message translates to:
  /// **'Completed'**
  String get completed;

  /// No description provided for @openJob.
  ///
  /// In en, this message translates to:
  /// **'Open Job'**
  String get openJob;

  /// No description provided for @importantAlert.
  ///
  /// In en, this message translates to:
  /// **'Important Alert'**
  String get importantAlert;

  /// No description provided for @otpRequired.
  ///
  /// In en, this message translates to:
  /// **'OTP Required'**
  String get otpRequired;

  /// No description provided for @newRequests.
  ///
  /// In en, this message translates to:
  /// **'New Requests'**
  String get newRequests;

  /// No description provided for @accepted.
  ///
  /// In en, this message translates to:
  /// **'Accepted'**
  String get accepted;

  /// No description provided for @upcoming.
  ///
  /// In en, this message translates to:
  /// **'Upcoming'**
  String get upcoming;

  /// No description provided for @pending.
  ///
  /// In en, this message translates to:
  /// **'Pending'**
  String get pending;

  /// No description provided for @assigned.
  ///
  /// In en, this message translates to:
  /// **'Assigned'**
  String get assigned;

  /// No description provided for @b2cDirect.
  ///
  /// In en, this message translates to:
  /// **'B2C Direct'**
  String get b2cDirect;

  /// No description provided for @b2bGovt.
  ///
  /// In en, this message translates to:
  /// **'B2B / Govt'**
  String get b2bGovt;

  /// No description provided for @individualServices.
  ///
  /// In en, this message translates to:
  /// **'Individual customer services'**
  String get individualServices;

  /// No description provided for @orgWorkforce.
  ///
  /// In en, this message translates to:
  /// **'Organization & workforce assignments'**
  String get orgWorkforce;

  /// No description provided for @viewCustomer.
  ///
  /// In en, this message translates to:
  /// **'VIEW CUSTOMER'**
  String get viewCustomer;

  /// No description provided for @viewInstitution.
  ///
  /// In en, this message translates to:
  /// **'VIEW INSTITUTION'**
  String get viewInstitution;

  /// No description provided for @activeJobId.
  ///
  /// In en, this message translates to:
  /// **'Active Job #{id}'**
  String activeJobId(String id);

  /// No description provided for @assignmentId.
  ///
  /// In en, this message translates to:
  /// **'Assignment #{id}'**
  String assignmentId(String id);

  /// No description provided for @summary.
  ///
  /// In en, this message translates to:
  /// **'Summary'**
  String get summary;

  /// No description provided for @viewBreakdown.
  ///
  /// In en, this message translates to:
  /// **'View Breakdown'**
  String get viewBreakdown;

  /// No description provided for @jobsCompleted.
  ///
  /// In en, this message translates to:
  /// **'Completed'**
  String get jobsCompleted;

  /// No description provided for @jobsCancelled.
  ///
  /// In en, this message translates to:
  /// **'Cancelled'**
  String get jobsCancelled;

  /// No description provided for @earnings.
  ///
  /// In en, this message translates to:
  /// **'Earnings'**
  String get earnings;

  /// No description provided for @rating.
  ///
  /// In en, this message translates to:
  /// **'Rating'**
  String get rating;

  /// No description provided for @reportDelay.
  ///
  /// In en, this message translates to:
  /// **'Report Dispatch Delay'**
  String get reportDelay;

  /// No description provided for @expectedDelayTime.
  ///
  /// In en, this message translates to:
  /// **'Expected Delay Time'**
  String get expectedDelayTime;

  /// No description provided for @selectReason.
  ///
  /// In en, this message translates to:
  /// **'Select Reason'**
  String get selectReason;

  /// No description provided for @heavyTraffic.
  ///
  /// In en, this message translates to:
  /// **'Heavy traffic on route'**
  String get heavyTraffic;

  /// No description provided for @previousJobLate.
  ///
  /// In en, this message translates to:
  /// **'Previous client job running late'**
  String get previousJobLate;

  /// No description provided for @vehicleBreakdown.
  ///
  /// In en, this message translates to:
  /// **'Vehicle / transit breakdown'**
  String get vehicleBreakdown;

  /// No description provided for @spareParts.
  ///
  /// In en, this message translates to:
  /// **'Picking up required spare parts'**
  String get spareParts;

  /// No description provided for @weather.
  ///
  /// In en, this message translates to:
  /// **'Weather conditions'**
  String get weather;

  /// No description provided for @emergency.
  ///
  /// In en, this message translates to:
  /// **'Emergency situation'**
  String get emergency;

  /// No description provided for @other.
  ///
  /// In en, this message translates to:
  /// **'Other reason'**
  String get other;

  /// No description provided for @dismiss.
  ///
  /// In en, this message translates to:
  /// **'Dismiss'**
  String get dismiss;

  /// No description provided for @notifyClientDelay.
  ///
  /// In en, this message translates to:
  /// **'Notify Client of Delay'**
  String get notifyClientDelay;

  /// No description provided for @delayConfirmed.
  ///
  /// In en, this message translates to:
  /// **'Delay Reported. Customer updated with revised arrival time.'**
  String get delayConfirmed;

  /// No description provided for @onTimeConfirmed.
  ///
  /// In en, this message translates to:
  /// **'Confirmed ON TIME. Customer notified. Departure countdown active.'**
  String get onTimeConfirmed;

  /// No description provided for @cancelJob.
  ///
  /// In en, this message translates to:
  /// **'Cancel This Assignment?'**
  String get cancelJob;

  /// No description provided for @cancelJobWarning.
  ///
  /// In en, this message translates to:
  /// **'Cancelling within 1 hour impacts your worker response score.'**
  String get cancelJobWarning;

  /// No description provided for @reasonForCancellation.
  ///
  /// In en, this message translates to:
  /// **'Reason for cancellation'**
  String get reasonForCancellation;

  /// No description provided for @emergencyPersonal.
  ///
  /// In en, this message translates to:
  /// **'Emergency personal issue'**
  String get emergencyPersonal;

  /// No description provided for @healthIssue.
  ///
  /// In en, this message translates to:
  /// **'Health / Medical unwell'**
  String get healthIssue;

  /// No description provided for @toolsBreakdown.
  ///
  /// In en, this message translates to:
  /// **'Tools / Vehicle breakdown'**
  String get toolsBreakdown;

  /// No description provided for @cannotReachCustomer.
  ///
  /// In en, this message translates to:
  /// **'Unable to reach customer location'**
  String get cannotReachCustomer;

  /// No description provided for @scheduleConflict.
  ///
  /// In en, this message translates to:
  /// **'Schedule conflict'**
  String get scheduleConflict;

  /// No description provided for @unsafeLocation.
  ///
  /// In en, this message translates to:
  /// **'Report Unsafe Location'**
  String get unsafeLocation;

  /// No description provided for @incorrectJobDetails.
  ///
  /// In en, this message translates to:
  /// **'Incorrect job details'**
  String get incorrectJobDetails;

  /// No description provided for @keepJob.
  ///
  /// In en, this message translates to:
  /// **'Keep Job'**
  String get keepJob;

  /// No description provided for @confirmCancel.
  ///
  /// In en, this message translates to:
  /// **'Confirm Cancel'**
  String get confirmCancel;

  /// No description provided for @jobCancelled.
  ///
  /// In en, this message translates to:
  /// **'JOB CANCELLED'**
  String get jobCancelled;

  /// No description provided for @cancelledBy.
  ///
  /// In en, this message translates to:
  /// **'Cancelled by'**
  String get cancelledBy;

  /// No description provided for @penalty.
  ///
  /// In en, this message translates to:
  /// **'Penalty/Fee'**
  String get penalty;

  /// No description provided for @customerNotified.
  ///
  /// In en, this message translates to:
  /// **'Customer notified'**
  String get customerNotified;

  /// No description provided for @newServiceRequest.
  ///
  /// In en, this message translates to:
  /// **'New Service Request'**
  String get newServiceRequest;

  /// No description provided for @reportedProblem.
  ///
  /// In en, this message translates to:
  /// **'Reported Problem'**
  String get reportedProblem;

  /// No description provided for @requestedDate.
  ///
  /// In en, this message translates to:
  /// **'Requested Date'**
  String get requestedDate;

  /// No description provided for @requestedTime.
  ///
  /// In en, this message translates to:
  /// **'Requested Time'**
  String get requestedTime;

  /// No description provided for @estimatedDuration.
  ///
  /// In en, this message translates to:
  /// **'Estimated Duration'**
  String get estimatedDuration;

  /// No description provided for @distance.
  ///
  /// In en, this message translates to:
  /// **'Distance'**
  String get distance;

  /// No description provided for @location.
  ///
  /// In en, this message translates to:
  /// **'Location'**
  String get location;

  /// No description provided for @onsiteRequired.
  ///
  /// In en, this message translates to:
  /// **'Onsite Required'**
  String get onsiteRequired;

  /// No description provided for @onsiteFee.
  ///
  /// In en, this message translates to:
  /// **'Onsite Fee'**
  String get onsiteFee;

  /// No description provided for @scheduleCompatibility.
  ///
  /// In en, this message translates to:
  /// **'Schedule Compatibility'**
  String get scheduleCompatibility;

  /// No description provided for @decline.
  ///
  /// In en, this message translates to:
  /// **'DECLINE'**
  String get decline;

  /// No description provided for @accept.
  ///
  /// In en, this message translates to:
  /// **'ACCEPT'**
  String get accept;

  /// No description provided for @cannotAccept.
  ///
  /// In en, this message translates to:
  /// **'CANNOT ACCEPT THIS REQUEST'**
  String get cannotAccept;

  /// No description provided for @waitingForCustomer.
  ///
  /// In en, this message translates to:
  /// **'Waiting for Customer Selection'**
  String get waitingForCustomer;

  /// No description provided for @candidateStatus.
  ///
  /// In en, this message translates to:
  /// **'Your candidate status is pending'**
  String get candidateStatus;

  /// No description provided for @selectionExpiry.
  ///
  /// In en, this message translates to:
  /// **'Selection expires in'**
  String get selectionExpiry;

  /// No description provided for @customerSelectedYou.
  ///
  /// In en, this message translates to:
  /// **'CUSTOMER SELECTED YOU ✓'**
  String get customerSelectedYou;

  /// No description provided for @jobConfirmed.
  ///
  /// In en, this message translates to:
  /// **'JOB CONFIRMED'**
  String get jobConfirmed;

  /// No description provided for @confirmedJobDetails.
  ///
  /// In en, this message translates to:
  /// **'Confirmed Job Details'**
  String get confirmedJobDetails;

  /// No description provided for @reschedule.
  ///
  /// In en, this message translates to:
  /// **'Reschedule'**
  String get reschedule;

  /// No description provided for @contactCustomer.
  ///
  /// In en, this message translates to:
  /// **'Contact Customer'**
  String get contactCustomer;

  /// No description provided for @mapView.
  ///
  /// In en, this message translates to:
  /// **'Map View'**
  String get mapView;

  /// No description provided for @platformFee.
  ///
  /// In en, this message translates to:
  /// **'Platform Fee'**
  String get platformFee;

  /// No description provided for @notes.
  ///
  /// In en, this message translates to:
  /// **'Notes'**
  String get notes;

  /// No description provided for @reminderTitle.
  ///
  /// In en, this message translates to:
  /// **'JOB STARTS IN 1 HOUR'**
  String get reminderTitle;

  /// No description provided for @liveJourneyTracking.
  ///
  /// In en, this message translates to:
  /// **'Live Journey Tracking'**
  String get liveJourneyTracking;

  /// No description provided for @enRouteTransit.
  ///
  /// In en, this message translates to:
  /// **'EN ROUTE (TRANSIT)'**
  String get enRouteTransit;

  /// No description provided for @telemetryActive.
  ///
  /// In en, this message translates to:
  /// **'Tele-Telemetry Active'**
  String get telemetryActive;

  /// No description provided for @journeyProgress.
  ///
  /// In en, this message translates to:
  /// **'JOURNEY PROGRESS'**
  String get journeyProgress;

  /// No description provided for @stageOf.
  ///
  /// In en, this message translates to:
  /// **'Stage {current} of {total}'**
  String stageOf(String current, String total);

  /// No description provided for @remaining.
  ///
  /// In en, this message translates to:
  /// **'REMAINING'**
  String get remaining;

  /// No description provided for @travelTime.
  ///
  /// In en, this message translates to:
  /// **'TRAVEL TIME'**
  String get travelTime;

  /// No description provided for @targetEta.
  ///
  /// In en, this message translates to:
  /// **'TARGET ETA'**
  String get targetEta;

  /// No description provided for @liveGpsActive.
  ///
  /// In en, this message translates to:
  /// **'Live GPS Active'**
  String get liveGpsActive;

  /// No description provided for @gpsAccuracy.
  ///
  /// In en, this message translates to:
  /// **'±{meters}m accuracy'**
  String gpsAccuracy(String meters);

  /// No description provided for @syncedJustNow.
  ///
  /// In en, this message translates to:
  /// **'Synced: Just now'**
  String get syncedJustNow;

  /// No description provided for @nextManeuver.
  ///
  /// In en, this message translates to:
  /// **'NEXT MANEUVER IN {distance}'**
  String nextManeuver(String distance);

  /// No description provided for @geoFencedCheckIn.
  ///
  /// In en, this message translates to:
  /// **'Geo-Fenced Check-In'**
  String get geoFencedCheckIn;

  /// No description provided for @sosHelp.
  ///
  /// In en, this message translates to:
  /// **'SOS HELP'**
  String get sosHelp;

  /// No description provided for @iHaveArrived.
  ///
  /// In en, this message translates to:
  /// **'I HAVE ARRIVED — VERIFY OTP'**
  String get iHaveArrived;

  /// No description provided for @shiftReportingDuty.
  ///
  /// In en, this message translates to:
  /// **'SHIFT REPORTING DUTY'**
  String get shiftReportingDuty;

  /// No description provided for @requiredBy.
  ///
  /// In en, this message translates to:
  /// **'Required by {time}'**
  String requiredBy(String time);

  /// No description provided for @aheadOfSchedule.
  ///
  /// In en, this message translates to:
  /// **'{minutes}m Ahead of Schedule'**
  String aheadOfSchedule(String minutes);

  /// No description provided for @verifyArrival.
  ///
  /// In en, this message translates to:
  /// **'Verify Arrival'**
  String get verifyArrival;

  /// No description provided for @arrivedAtSite.
  ///
  /// In en, this message translates to:
  /// **'ARRIVED AT SITE'**
  String get arrivedAtSite;

  /// No description provided for @proximityConfirmed.
  ///
  /// In en, this message translates to:
  /// **'Proximity Confirmed'**
  String get proximityConfirmed;

  /// No description provided for @attendancePasscode.
  ///
  /// In en, this message translates to:
  /// **'Attendance Passcode'**
  String get attendancePasscode;

  /// No description provided for @enterOtpAtLocation.
  ///
  /// In en, this message translates to:
  /// **'Enter the OTP provided at the service location'**
  String get enterOtpAtLocation;

  /// No description provided for @otpExpiresIn.
  ///
  /// In en, this message translates to:
  /// **'OTP expires in {time}'**
  String otpExpiresIn(String time);

  /// No description provided for @resendOtp.
  ///
  /// In en, this message translates to:
  /// **'Resend OTP'**
  String get resendOtp;

  /// No description provided for @verifyAndCheckIn.
  ///
  /// In en, this message translates to:
  /// **'VERIFY & CHECK IN'**
  String get verifyAndCheckIn;

  /// No description provided for @verificationDetails.
  ///
  /// In en, this message translates to:
  /// **'VERIFICATION DETAILS'**
  String get verificationDetails;

  /// No description provided for @locationDetected.
  ///
  /// In en, this message translates to:
  /// **'LOCATION DETECTED'**
  String get locationDetected;

  /// No description provided for @workerId.
  ///
  /// In en, this message translates to:
  /// **'Worker ID'**
  String get workerId;

  /// No description provided for @gpsAccuracyLabel.
  ///
  /// In en, this message translates to:
  /// **'GPS Accuracy'**
  String get gpsAccuracyLabel;

  /// No description provided for @highPrecision.
  ///
  /// In en, this message translates to:
  /// **'High Precision'**
  String get highPrecision;

  /// No description provided for @active.
  ///
  /// In en, this message translates to:
  /// **'Active'**
  String get active;

  /// No description provided for @currentGeoLocation.
  ///
  /// In en, this message translates to:
  /// **'Current Geo-Location'**
  String get currentGeoLocation;

  /// No description provided for @arrivalTimestamp.
  ///
  /// In en, this message translates to:
  /// **'Arrival Timestamp'**
  String get arrivalTimestamp;

  /// No description provided for @needHelpPasscode.
  ///
  /// In en, this message translates to:
  /// **'Need help with passcode?'**
  String get needHelpPasscode;

  /// No description provided for @callDutyCoordinator.
  ///
  /// In en, this message translates to:
  /// **'Call Duty Coordinator'**
  String get callDutyCoordinator;

  /// No description provided for @arrivalVerified.
  ///
  /// In en, this message translates to:
  /// **'ARRIVAL VERIFIED'**
  String get arrivalVerified;

  /// No description provided for @inspectionReady.
  ///
  /// In en, this message translates to:
  /// **'INSPECTION READY'**
  String get inspectionReady;

  /// No description provided for @incorrectOtp.
  ///
  /// In en, this message translates to:
  /// **'Incorrect OTP. Please try again.'**
  String get incorrectOtp;

  /// No description provided for @otpExpired.
  ///
  /// In en, this message translates to:
  /// **'OTP has expired. Please request a new one.'**
  String get otpExpired;

  /// No description provided for @customerNotResponding.
  ///
  /// In en, this message translates to:
  /// **'Customer Not Responding'**
  String get customerNotResponding;

  /// No description provided for @callCustomer.
  ///
  /// In en, this message translates to:
  /// **'Call'**
  String get callCustomer;

  /// No description provided for @messageCustomer.
  ///
  /// In en, this message translates to:
  /// **'Message'**
  String get messageCustomer;

  /// No description provided for @waitForCustomer.
  ///
  /// In en, this message translates to:
  /// **'Wait'**
  String get waitForCustomer;

  /// No description provided for @reportUnavailable.
  ///
  /// In en, this message translates to:
  /// **'Report Customer Unavailable'**
  String get reportUnavailable;

  /// No description provided for @inspectionDiagnosis.
  ///
  /// In en, this message translates to:
  /// **'Inspection & Diagnosis'**
  String get inspectionDiagnosis;

  /// No description provided for @onSiteActive.
  ///
  /// In en, this message translates to:
  /// **'ON-SITE ACTIVE'**
  String get onSiteActive;

  /// No description provided for @arrivalOtpVerified.
  ///
  /// In en, this message translates to:
  /// **'Arrival OTP Verified'**
  String get arrivalOtpVerified;

  /// No description provided for @sequentialWorkflow.
  ///
  /// In en, this message translates to:
  /// **'SEQUENTIAL WORKFLOW'**
  String get sequentialWorkflow;

  /// No description provided for @otpCheck.
  ///
  /// In en, this message translates to:
  /// **'OTP Check'**
  String get otpCheck;

  /// No description provided for @inspection.
  ///
  /// In en, this message translates to:
  /// **'Inspection'**
  String get inspection;

  /// No description provided for @quotation.
  ///
  /// In en, this message translates to:
  /// **'Quotation'**
  String get quotation;

  /// No description provided for @approval.
  ///
  /// In en, this message translates to:
  /// **'Approval'**
  String get approval;

  /// No description provided for @done.
  ///
  /// In en, this message translates to:
  /// **'Done'**
  String get done;

  /// No description provided for @activeNow.
  ///
  /// In en, this message translates to:
  /// **'Active Now'**
  String get activeNow;

  /// No description provided for @locked.
  ///
  /// In en, this message translates to:
  /// **'Locked'**
  String get locked;

  /// No description provided for @pricingLocked.
  ///
  /// In en, this message translates to:
  /// **'Pricing Locked'**
  String get pricingLocked;

  /// No description provided for @physicalDiagnosis.
  ///
  /// In en, this message translates to:
  /// **'Physical Diagnosis'**
  String get physicalDiagnosis;

  /// No description provided for @customerReportedIssue.
  ///
  /// In en, this message translates to:
  /// **'CUSTOMER REPORTED ISSUE'**
  String get customerReportedIssue;

  /// No description provided for @customerAttachedPhotos.
  ///
  /// In en, this message translates to:
  /// **'Customer Attached Photos'**
  String get customerAttachedPhotos;

  /// No description provided for @viewFull.
  ///
  /// In en, this message translates to:
  /// **'View Full'**
  String get viewFull;

  /// No description provided for @workerInspectionFindings.
  ///
  /// In en, this message translates to:
  /// **'Worker Inspection Findings'**
  String get workerInspectionFindings;

  /// No description provided for @editable.
  ///
  /// In en, this message translates to:
  /// **'EDITABLE'**
  String get editable;

  /// No description provided for @observedDefect.
  ///
  /// In en, this message translates to:
  /// **'Observed Physical Defect / Root Cause'**
  String get observedDefect;

  /// No description provided for @diagnosisSeverity.
  ///
  /// In en, this message translates to:
  /// **'Diagnosis Severity Level'**
  String get diagnosisSeverity;

  /// No description provided for @lowDrip.
  ///
  /// In en, this message translates to:
  /// **'Low (Drip)'**
  String get lowDrip;

  /// No description provided for @activeLeak.
  ///
  /// In en, this message translates to:
  /// **'Active Leak'**
  String get activeLeak;

  /// No description provided for @shutoffUrgent.
  ///
  /// In en, this message translates to:
  /// **'Shutoff Urgent'**
  String get shutoffUrgent;

  /// No description provided for @requiredAction.
  ///
  /// In en, this message translates to:
  /// **'Required Technical Corrective Action'**
  String get requiredAction;

  /// No description provided for @onSiteObservations.
  ///
  /// In en, this message translates to:
  /// **'On-Site Observations & Pre-requisites'**
  String get onSiteObservations;

  /// No description provided for @technicianPhotos.
  ///
  /// In en, this message translates to:
  /// **'Technician Live Proof Photos'**
  String get technicianPhotos;

  /// No description provided for @photosAttached.
  ///
  /// In en, this message translates to:
  /// **'Attached'**
  String get photosAttached;

  /// No description provided for @photoVerifyNote.
  ///
  /// In en, this message translates to:
  /// **'These photos verify the pre-repair damaged state to avoid disputes before parts are dismantled.'**
  String get photoVerifyNote;

  /// No description provided for @completeInspection.
  ///
  /// In en, this message translates to:
  /// **'COMPLETE INSPECTION →'**
  String get completeInspection;

  /// No description provided for @completeInspectionNote.
  ///
  /// In en, this message translates to:
  /// **'Completing inspection unlocks the Service Quotation phase without premature pricing.'**
  String get completeInspectionNote;

  /// No description provided for @nextUnlockQuotation.
  ///
  /// In en, this message translates to:
  /// **'Next: Complete inspection to unlock quotation'**
  String get nextUnlockQuotation;

  /// No description provided for @inspectionPrerequisitesNote.
  ///
  /// In en, this message translates to:
  /// **'Enter observed defect and attach at least 1 proof photo to unlock quotation.'**
  String get inspectionPrerequisitesNote;

  /// No description provided for @quotationTitle.
  ///
  /// In en, this message translates to:
  /// **'Quotation'**
  String get quotationTitle;

  /// No description provided for @inspectionCompleted.
  ///
  /// In en, this message translates to:
  /// **'INSPECTION COMPLETED'**
  String get inspectionCompleted;

  /// No description provided for @onSiteService.
  ///
  /// In en, this message translates to:
  /// **'ON-SITE SERVICE'**
  String get onSiteService;

  /// No description provided for @customerProblemPhotos.
  ///
  /// In en, this message translates to:
  /// **'CUSTOMER PROBLEM PHOTOS'**
  String get customerProblemPhotos;

  /// No description provided for @inspectionSummary.
  ///
  /// In en, this message translates to:
  /// **'INSPECTION SUMMARY'**
  String get inspectionSummary;

  /// No description provided for @customerReportedProblem.
  ///
  /// In en, this message translates to:
  /// **'CUSTOMER REPORTED PROBLEM'**
  String get customerReportedProblem;

  /// No description provided for @workerDiagnosis.
  ///
  /// In en, this message translates to:
  /// **'WORKER DIAGNOSIS'**
  String get workerDiagnosis;

  /// No description provided for @recommendedSolution.
  ///
  /// In en, this message translates to:
  /// **'RECOMMENDED SOLUTION'**
  String get recommendedSolution;

  /// No description provided for @workerInspectionPhotos.
  ///
  /// In en, this message translates to:
  /// **'WORKER INSPECTION PHOTOS'**
  String get workerInspectionPhotos;

  /// No description provided for @verifiedOnSite.
  ///
  /// In en, this message translates to:
  /// **'Verified On-Site'**
  String get verifiedOnSite;

  /// No description provided for @serviceQuotation.
  ///
  /// In en, this message translates to:
  /// **'SERVICE QUOTATION'**
  String get serviceQuotation;

  /// No description provided for @labourServiceCharge.
  ///
  /// In en, this message translates to:
  /// **'Labour / Service Charge'**
  String get labourServiceCharge;

  /// No description provided for @workerEditable.
  ///
  /// In en, this message translates to:
  /// **'Worker Editable'**
  String get workerEditable;

  /// No description provided for @materialCostItemized.
  ///
  /// In en, this message translates to:
  /// **'Material Cost (Itemized)'**
  String get materialCostItemized;

  /// No description provided for @addMaterial.
  ///
  /// In en, this message translates to:
  /// **'Add Material'**
  String get addMaterial;

  /// No description provided for @otherServiceCharges.
  ///
  /// In en, this message translates to:
  /// **'Other Service Charges'**
  String get otherServiceCharges;

  /// No description provided for @serviceSubtotal.
  ///
  /// In en, this message translates to:
  /// **'SERVICE SUBTOTAL'**
  String get serviceSubtotal;

  /// No description provided for @platformFeePercent.
  ///
  /// In en, this message translates to:
  /// **'Platform Fee ({percent}%)'**
  String platformFeePercent(String percent);

  /// No description provided for @autoCalculated.
  ///
  /// In en, this message translates to:
  /// **'Auto-Calculated'**
  String get autoCalculated;

  /// No description provided for @totalServiceQuotation.
  ///
  /// In en, this message translates to:
  /// **'TOTAL SERVICE QUOTATION'**
  String get totalServiceQuotation;

  /// No description provided for @customerServiceTotal.
  ///
  /// In en, this message translates to:
  /// **'Customer Service Total'**
  String get customerServiceTotal;

  /// No description provided for @readyForApproval.
  ///
  /// In en, this message translates to:
  /// **'Ready for Customer Approval'**
  String get readyForApproval;

  /// No description provided for @platformFeeNote.
  ///
  /// In en, this message translates to:
  /// **'{percent}% of {amount} Service Subtotal • Added to customer payment'**
  String platformFeeNote(String percent, String amount);

  /// No description provided for @quotationStatus.
  ///
  /// In en, this message translates to:
  /// **'Quotation Status'**
  String get quotationStatus;

  /// No description provided for @waitingForApproval.
  ///
  /// In en, this message translates to:
  /// **'WAITING FOR CUSTOMER APPROVAL'**
  String get waitingForApproval;

  /// No description provided for @ifApproved.
  ///
  /// In en, this message translates to:
  /// **'If Approved:'**
  String get ifApproved;

  /// No description provided for @ifRejected.
  ///
  /// In en, this message translates to:
  /// **'If Rejected:'**
  String get ifRejected;

  /// No description provided for @sendQuotation.
  ///
  /// In en, this message translates to:
  /// **'SEND QUOTATION'**
  String get sendQuotation;

  /// No description provided for @quotationApproved.
  ///
  /// In en, this message translates to:
  /// **'QUOTATION APPROVED ✓'**
  String get quotationApproved;

  /// No description provided for @quotationNotApproved.
  ///
  /// In en, this message translates to:
  /// **'QUOTATION NOT APPROVED'**
  String get quotationNotApproved;

  /// No description provided for @rejectionReason.
  ///
  /// In en, this message translates to:
  /// **'Rejection reason'**
  String get rejectionReason;

  /// No description provided for @startService.
  ///
  /// In en, this message translates to:
  /// **'START SERVICE'**
  String get startService;

  /// No description provided for @serviceCompletion.
  ///
  /// In en, this message translates to:
  /// **'Service Completion'**
  String get serviceCompletion;

  /// No description provided for @workCompleted.
  ///
  /// In en, this message translates to:
  /// **'WORK COMPLETED'**
  String get workCompleted;

  /// No description provided for @onSiteVerified.
  ///
  /// In en, this message translates to:
  /// **'ON-SITE VERIFIED'**
  String get onSiteVerified;

  /// No description provided for @serviceSummary.
  ///
  /// In en, this message translates to:
  /// **'Service Summary'**
  String get serviceSummary;

  /// No description provided for @problemAddressed.
  ///
  /// In en, this message translates to:
  /// **'Problem Addressed'**
  String get problemAddressed;

  /// No description provided for @workPerformed.
  ///
  /// In en, this message translates to:
  /// **'Work Performed'**
  String get workPerformed;

  /// No description provided for @completionNotes.
  ///
  /// In en, this message translates to:
  /// **'Completion Notes'**
  String get completionNotes;

  /// No description provided for @proofOfWork.
  ///
  /// In en, this message translates to:
  /// **'Proof of Work'**
  String get proofOfWork;

  /// No description provided for @beforeVsAfter.
  ///
  /// In en, this message translates to:
  /// **'Before vs After verification'**
  String get beforeVsAfter;

  /// No description provided for @verifiedByTech.
  ///
  /// In en, this message translates to:
  /// **'Verified by Tech'**
  String get verifiedByTech;

  /// No description provided for @addPhotoTestProof.
  ///
  /// In en, this message translates to:
  /// **'+ Add Additional Photo / Test Proof'**
  String get addPhotoTestProof;

  /// No description provided for @finalServiceCost.
  ///
  /// In en, this message translates to:
  /// **'Final Service Cost'**
  String get finalServiceCost;

  /// No description provided for @labourServiceChargeLabel.
  ///
  /// In en, this message translates to:
  /// **'Labour / Service Charge'**
  String get labourServiceChargeLabel;

  /// No description provided for @materialCost.
  ///
  /// In en, this message translates to:
  /// **'Material Cost'**
  String get materialCost;

  /// No description provided for @otherCharges.
  ///
  /// In en, this message translates to:
  /// **'Other Applicable Service Charges'**
  String get otherCharges;

  /// No description provided for @serviceSubtotalLabel.
  ///
  /// In en, this message translates to:
  /// **'Service Subtotal'**
  String get serviceSubtotalLabel;

  /// No description provided for @cooperativePlatformFee.
  ///
  /// In en, this message translates to:
  /// **'Cooperative Platform Fee'**
  String get cooperativePlatformFee;

  /// No description provided for @finalServiceAmount.
  ///
  /// In en, this message translates to:
  /// **'FINAL SERVICE AMOUNT'**
  String get finalServiceAmount;

  /// No description provided for @quotationMatched.
  ///
  /// In en, this message translates to:
  /// **'Quotation Matched'**
  String get quotationMatched;

  /// No description provided for @materialBillProof.
  ///
  /// In en, this message translates to:
  /// **'MATERIAL & BILL PROOF'**
  String get materialBillProof;

  /// No description provided for @itemsVerified.
  ///
  /// In en, this message translates to:
  /// **'{count} Items Verified'**
  String itemsVerified(String count);

  /// No description provided for @billAttached.
  ///
  /// In en, this message translates to:
  /// **'BILL ATTACHED'**
  String get billAttached;

  /// No description provided for @takeBillPhoto.
  ///
  /// In en, this message translates to:
  /// **'Take Bill Photo'**
  String get takeBillPhoto;

  /// No description provided for @uploadReceipt.
  ///
  /// In en, this message translates to:
  /// **'Upload Receipt'**
  String get uploadReceipt;

  /// No description provided for @addMaterialBill.
  ///
  /// In en, this message translates to:
  /// **'+ Add Additional Material / Bill'**
  String get addMaterialBill;

  /// No description provided for @verifiedMaterialCost.
  ///
  /// In en, this message translates to:
  /// **'Verified Material Cost'**
  String get verifiedMaterialCost;

  /// No description provided for @materialBillNote.
  ///
  /// In en, this message translates to:
  /// **'Material bill photos are attached as proof of actual material cost. They verify expenditures and do not add any extra charges.'**
  String get materialBillNote;

  /// No description provided for @paymentStatus.
  ///
  /// In en, this message translates to:
  /// **'Payment Status'**
  String get paymentStatus;

  /// No description provided for @awaitingPayment.
  ///
  /// In en, this message translates to:
  /// **'AWAITING PAYMENT'**
  String get awaitingPayment;

  /// No description provided for @customerPaymentPayable.
  ///
  /// In en, this message translates to:
  /// **'Customer Payment Payable'**
  String get customerPaymentPayable;

  /// No description provided for @paymentModeOptions.
  ///
  /// In en, this message translates to:
  /// **'Payment Mode Options / Status'**
  String get paymentModeOptions;

  /// No description provided for @paymentPromptNote.
  ///
  /// In en, this message translates to:
  /// **'Customer prompted via App / Cash or UPI to Cooperative Escrow.'**
  String get paymentPromptNote;

  /// No description provided for @waitingForPayment.
  ///
  /// In en, this message translates to:
  /// **'Waiting for customer to confirm payment on their app'**
  String get waitingForPayment;

  /// No description provided for @refresh.
  ///
  /// In en, this message translates to:
  /// **'Refresh'**
  String get refresh;

  /// No description provided for @confirmPayment.
  ///
  /// In en, this message translates to:
  /// **'CONFIRM PAYMENT'**
  String get confirmPayment;

  /// No description provided for @requestPayment.
  ///
  /// In en, this message translates to:
  /// **'REQUEST PAYMENT'**
  String get requestPayment;

  /// No description provided for @invoiceDetails.
  ///
  /// In en, this message translates to:
  /// **'Invoice Details'**
  String get invoiceDetails;

  /// No description provided for @taxInvoice.
  ///
  /// In en, this message translates to:
  /// **'TAX INVOICE'**
  String get taxInvoice;

  /// No description provided for @originalForRecipient.
  ///
  /// In en, this message translates to:
  /// **'ORIGINAL FOR RECIPIENT'**
  String get originalForRecipient;

  /// No description provided for @paid.
  ///
  /// In en, this message translates to:
  /// **'PAID'**
  String get paid;

  /// No description provided for @verifiedReceipt.
  ///
  /// In en, this message translates to:
  /// **'Verified Cooperative Digital Receipt'**
  String get verifiedReceipt;

  /// No description provided for @paidOn.
  ///
  /// In en, this message translates to:
  /// **'Paid on {date} at {time}'**
  String paidOn(String date, String time);

  /// No description provided for @gstinActive.
  ///
  /// In en, this message translates to:
  /// **'GSTIN ACTIVE'**
  String get gstinActive;

  /// No description provided for @billedTo.
  ///
  /// In en, this message translates to:
  /// **'Billed To (Customer)'**
  String get billedTo;

  /// No description provided for @fulfilledBy.
  ///
  /// In en, this message translates to:
  /// **'Fulfilled By'**
  String get fulfilledBy;

  /// No description provided for @licensedTrade.
  ///
  /// In en, this message translates to:
  /// **'Licensed Field Plumbing Tech'**
  String get licensedTrade;

  /// No description provided for @cooperativeNode.
  ///
  /// In en, this message translates to:
  /// **'Cooperative Node'**
  String get cooperativeNode;

  /// No description provided for @jobSpecification.
  ///
  /// In en, this message translates to:
  /// **'JOB SPECIFICATION'**
  String get jobSpecification;

  /// No description provided for @completedAt.
  ///
  /// In en, this message translates to:
  /// **'Completed at'**
  String get completedAt;

  /// No description provided for @billingBreakdown.
  ///
  /// In en, this message translates to:
  /// **'Billing Breakdown'**
  String get billingBreakdown;

  /// No description provided for @currencyInr.
  ///
  /// In en, this message translates to:
  /// **'CURRENCY: INR (₹)'**
  String get currencyInr;

  /// No description provided for @totalPaid.
  ///
  /// In en, this message translates to:
  /// **'TOTAL PAID (INCL. TAXES)'**
  String get totalPaid;

  /// No description provided for @settledInFull.
  ///
  /// In en, this message translates to:
  /// **'Settled in Full'**
  String get settledInFull;

  /// No description provided for @clearBillingPolicy.
  ///
  /// In en, this message translates to:
  /// **'Clear Billing Policy'**
  String get clearBillingPolicy;

  /// No description provided for @transactionRecord.
  ///
  /// In en, this message translates to:
  /// **'Transaction Record'**
  String get transactionRecord;

  /// No description provided for @paymentSuccessful.
  ///
  /// In en, this message translates to:
  /// **'Payment Successful'**
  String get paymentSuccessful;

  /// No description provided for @paymentMethod.
  ///
  /// In en, this message translates to:
  /// **'Payment Method'**
  String get paymentMethod;

  /// No description provided for @transactionId.
  ///
  /// In en, this message translates to:
  /// **'Transaction ID'**
  String get transactionId;

  /// No description provided for @bankUtrReference.
  ///
  /// In en, this message translates to:
  /// **'Bank UTR Reference'**
  String get bankUtrReference;

  /// No description provided for @transactionTimestamp.
  ///
  /// In en, this message translates to:
  /// **'Transaction Timestamp'**
  String get transactionTimestamp;

  /// No description provided for @serviceInfoScope.
  ///
  /// In en, this message translates to:
  /// **'Service Information & Scope'**
  String get serviceInfoScope;

  /// No description provided for @reportedIssue.
  ///
  /// In en, this message translates to:
  /// **'REPORTED ISSUE'**
  String get reportedIssue;

  /// No description provided for @technicalWork.
  ///
  /// In en, this message translates to:
  /// **'TECHNICAL WORK PERFORMED'**
  String get technicalWork;

  /// No description provided for @materialsVerified.
  ///
  /// In en, this message translates to:
  /// **'MATERIALS VERIFIED & INSTALLED'**
  String get materialsVerified;

  /// No description provided for @proofOfServiceLabel.
  ///
  /// In en, this message translates to:
  /// **'Proof of Service'**
  String get proofOfServiceLabel;

  /// No description provided for @photosVerified.
  ///
  /// In en, this message translates to:
  /// **'{count} PHOTOS VERIFIED'**
  String photosVerified(String count);

  /// No description provided for @downloadInvoice.
  ///
  /// In en, this message translates to:
  /// **'DOWNLOAD INVOICE'**
  String get downloadInvoice;

  /// No description provided for @viewServiceHistory.
  ///
  /// In en, this message translates to:
  /// **'View Full Service History & Diagnostics'**
  String get viewServiceHistory;

  /// No description provided for @shareInvoice.
  ///
  /// In en, this message translates to:
  /// **'Share'**
  String get shareInvoice;

  /// No description provided for @printInvoice.
  ///
  /// In en, this message translates to:
  /// **'Print'**
  String get printInvoice;

  /// No description provided for @jobCompleted.
  ///
  /// In en, this message translates to:
  /// **'JOB COMPLETED ✓'**
  String get jobCompleted;

  /// No description provided for @completionTime.
  ///
  /// In en, this message translates to:
  /// **'Completion Time'**
  String get completionTime;

  /// No description provided for @finalAmount.
  ///
  /// In en, this message translates to:
  /// **'Final Amount'**
  String get finalAmount;

  /// No description provided for @invoiceNumber.
  ///
  /// In en, this message translates to:
  /// **'Invoice Number'**
  String get invoiceNumber;

  /// No description provided for @thankYou.
  ///
  /// In en, this message translates to:
  /// **'Thank you for using the cooperative service platform.'**
  String get thankYou;

  /// No description provided for @warrantyNote.
  ///
  /// In en, this message translates to:
  /// **'For warranty claims or queries, please reference Job'**
  String get warrantyNote;

  /// No description provided for @ratingTitle.
  ///
  /// In en, this message translates to:
  /// **'Rate This Service'**
  String get ratingTitle;

  /// No description provided for @ratingSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Your feedback helps improve worker quality'**
  String get ratingSubtitle;

  /// No description provided for @starRating.
  ///
  /// In en, this message translates to:
  /// **'Star Rating'**
  String get starRating;

  /// No description provided for @feedbackPlaceholder.
  ///
  /// In en, this message translates to:
  /// **'Share your feedback (optional)'**
  String get feedbackPlaceholder;

  /// No description provided for @submitRating.
  ///
  /// In en, this message translates to:
  /// **'SUBMIT RATING & CLOSE'**
  String get submitRating;

  /// No description provided for @jobHistory.
  ///
  /// In en, this message translates to:
  /// **'Job History'**
  String get jobHistory;

  /// No description provided for @all.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get all;

  /// No description provided for @filterCompleted.
  ///
  /// In en, this message translates to:
  /// **'Completed'**
  String get filterCompleted;

  /// No description provided for @filterCancelled.
  ///
  /// In en, this message translates to:
  /// **'Cancelled'**
  String get filterCancelled;

  /// No description provided for @filterRejected.
  ///
  /// In en, this message translates to:
  /// **'Rejected'**
  String get filterRejected;

  /// No description provided for @filterInProgress.
  ///
  /// In en, this message translates to:
  /// **'In Progress'**
  String get filterInProgress;

  /// No description provided for @service.
  ///
  /// In en, this message translates to:
  /// **'Service'**
  String get service;

  /// No description provided for @date.
  ///
  /// In en, this message translates to:
  /// **'Date'**
  String get date;

  /// No description provided for @amount.
  ///
  /// In en, this message translates to:
  /// **'Amount'**
  String get amount;

  /// No description provided for @status.
  ///
  /// In en, this message translates to:
  /// **'Status'**
  String get status;

  /// No description provided for @earningsTitle.
  ///
  /// In en, this message translates to:
  /// **'Earnings & Settlements'**
  String get earningsTitle;

  /// No description provided for @today.
  ///
  /// In en, this message translates to:
  /// **'Today'**
  String get today;

  /// No description provided for @weekly.
  ///
  /// In en, this message translates to:
  /// **'Weekly'**
  String get weekly;

  /// No description provided for @monthly.
  ///
  /// In en, this message translates to:
  /// **'Monthly'**
  String get monthly;

  /// No description provided for @financialYear.
  ///
  /// In en, this message translates to:
  /// **'Financial Year'**
  String get financialYear;

  /// No description provided for @serviceEarnings.
  ///
  /// In en, this message translates to:
  /// **'Service / Labour'**
  String get serviceEarnings;

  /// No description provided for @onsiteEarnings.
  ///
  /// In en, this message translates to:
  /// **'On-site Visit Fees'**
  String get onsiteEarnings;

  /// No description provided for @reimbursements.
  ///
  /// In en, this message translates to:
  /// **'Reimbursements'**
  String get reimbursements;

  /// No description provided for @bonuses.
  ///
  /// In en, this message translates to:
  /// **'Performance Bonus'**
  String get bonuses;

  /// No description provided for @deductions.
  ///
  /// In en, this message translates to:
  /// **'TDS / Cooperative Fee'**
  String get deductions;

  /// No description provided for @pendingEarnings.
  ///
  /// In en, this message translates to:
  /// **'Pending Payout'**
  String get pendingEarnings;

  /// No description provided for @settledEarnings.
  ///
  /// In en, this message translates to:
  /// **'Settled Payout'**
  String get settledEarnings;

  /// No description provided for @settlementTitle.
  ///
  /// In en, this message translates to:
  /// **'Settlements'**
  String get settlementTitle;

  /// No description provided for @pendingSettlement.
  ///
  /// In en, this message translates to:
  /// **'Pending Settlement'**
  String get pendingSettlement;

  /// No description provided for @includedJobs.
  ///
  /// In en, this message translates to:
  /// **'Included Jobs'**
  String get includedJobs;

  /// No description provided for @expectedSettlement.
  ///
  /// In en, this message translates to:
  /// **'Expected Settlement'**
  String get expectedSettlement;

  /// No description provided for @settlementMethod.
  ///
  /// In en, this message translates to:
  /// **'Settlement Method'**
  String get settlementMethod;

  /// No description provided for @settlementHistory.
  ///
  /// In en, this message translates to:
  /// **'Settlement History'**
  String get settlementHistory;

  /// No description provided for @settlementId.
  ///
  /// In en, this message translates to:
  /// **'Settlement ID'**
  String get settlementId;

  /// No description provided for @notificationsTitle.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get notificationsTitle;

  /// No description provided for @unread.
  ///
  /// In en, this message translates to:
  /// **'Unread'**
  String unread(String count);

  /// No description provided for @markRead.
  ///
  /// In en, this message translates to:
  /// **'Mark read'**
  String get markRead;

  /// No description provided for @justNow.
  ///
  /// In en, this message translates to:
  /// **'Just now'**
  String get justNow;

  /// No description provided for @minutesAgo.
  ///
  /// In en, this message translates to:
  /// **'{count}m ago'**
  String minutesAgo(String count);

  /// No description provided for @hoursAgo.
  ///
  /// In en, this message translates to:
  /// **'{count}h ago'**
  String hoursAgo(String count);

  /// No description provided for @myProfile.
  ///
  /// In en, this message translates to:
  /// **'My Profile'**
  String get myProfile;

  /// No description provided for @workerIdentity.
  ///
  /// In en, this message translates to:
  /// **'Worker Identity & Credentials'**
  String get workerIdentity;

  /// No description provided for @cooperativeTier.
  ///
  /// In en, this message translates to:
  /// **'Cooperative Tier'**
  String get cooperativeTier;

  /// No description provided for @onTimeRate.
  ///
  /// In en, this message translates to:
  /// **'100% On-time'**
  String get onTimeRate;

  /// No description provided for @clientSide.
  ///
  /// In en, this message translates to:
  /// **'Client side'**
  String get clientSide;

  /// No description provided for @thisFy.
  ///
  /// In en, this message translates to:
  /// **'This FY'**
  String get thisFy;

  /// No description provided for @topPercent.
  ///
  /// In en, this message translates to:
  /// **'Top {percent}%'**
  String topPercent(String percent);

  /// No description provided for @settlementThreshold.
  ///
  /// In en, this message translates to:
  /// **'Settlement Threshold Alert'**
  String get settlementThreshold;

  /// No description provided for @jobDispatchGateRule.
  ///
  /// In en, this message translates to:
  /// **'Job Dispatch Gate Rule'**
  String get jobDispatchGateRule;

  /// No description provided for @newRequestsPaused.
  ///
  /// In en, this message translates to:
  /// **'NEW REQUESTS PAUSED'**
  String get newRequestsPaused;

  /// No description provided for @thresholdReachedMsg.
  ///
  /// In en, this message translates to:
  /// **'Settlement threshold reached. New job requests are paused until settlement is processed.'**
  String get thresholdReachedMsg;

  /// No description provided for @pendingSettlementLabel.
  ///
  /// In en, this message translates to:
  /// **'PENDING SETTLEMENT'**
  String get pendingSettlementLabel;

  /// No description provided for @policyThreshold.
  ///
  /// In en, this message translates to:
  /// **'POLICY THRESHOLD'**
  String get policyThreshold;

  /// No description provided for @autoHoldTrigger.
  ///
  /// In en, this message translates to:
  /// **'Auto-hold trigger'**
  String get autoHoldTrigger;

  /// No description provided for @settlementStatus.
  ///
  /// In en, this message translates to:
  /// **'Settlement Status'**
  String get settlementStatus;

  /// No description provided for @processing.
  ///
  /// In en, this message translates to:
  /// **'Processing'**
  String get processing;

  /// No description provided for @expectedSettlementTime.
  ///
  /// In en, this message translates to:
  /// **'Expected Settlement'**
  String get expectedSettlementTime;

  /// No description provided for @lastSettlement.
  ///
  /// In en, this message translates to:
  /// **'Last Settlement'**
  String get lastSettlement;

  /// No description provided for @skills.
  ///
  /// In en, this message translates to:
  /// **'Skills'**
  String get skills;

  /// No description provided for @certifications.
  ///
  /// In en, this message translates to:
  /// **'Certifications'**
  String get certifications;

  /// No description provided for @performance.
  ///
  /// In en, this message translates to:
  /// **'Performance'**
  String get performance;

  /// No description provided for @documents.
  ///
  /// In en, this message translates to:
  /// **'Documents'**
  String get documents;

  /// No description provided for @availability.
  ///
  /// In en, this message translates to:
  /// **'Availability'**
  String get availability;

  /// No description provided for @paymentDetails.
  ///
  /// In en, this message translates to:
  /// **'Payment Details'**
  String get paymentDetails;

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @support.
  ///
  /// In en, this message translates to:
  /// **'Support'**
  String get support;

  /// No description provided for @logout.
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get logout;

  /// No description provided for @logoutConfirm.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to log out?'**
  String get logoutConfirm;

  /// No description provided for @yes.
  ///
  /// In en, this message translates to:
  /// **'Yes'**
  String get yes;

  /// No description provided for @no.
  ///
  /// In en, this message translates to:
  /// **'No'**
  String get no;

  /// No description provided for @availabilityTitle.
  ///
  /// In en, this message translates to:
  /// **'Worker Availability'**
  String get availabilityTitle;

  /// No description provided for @activeStatus.
  ///
  /// In en, this message translates to:
  /// **'ACTIVE'**
  String get activeStatus;

  /// No description provided for @inactiveStatus.
  ///
  /// In en, this message translates to:
  /// **'INACTIVE'**
  String get inactiveStatus;

  /// No description provided for @busyStatus.
  ///
  /// In en, this message translates to:
  /// **'BUSY'**
  String get busyStatus;

  /// No description provided for @workingHours.
  ///
  /// In en, this message translates to:
  /// **'Working Hours'**
  String get workingHours;

  /// No description provided for @serviceAvailability.
  ///
  /// In en, this message translates to:
  /// **'Service Availability'**
  String get serviceAvailability;

  /// No description provided for @scheduleTitle.
  ///
  /// In en, this message translates to:
  /// **'Worker Schedule'**
  String get scheduleTitle;

  /// No description provided for @calendar.
  ///
  /// In en, this message translates to:
  /// **'Calendar'**
  String get calendar;

  /// No description provided for @upcomingJobs.
  ///
  /// In en, this message translates to:
  /// **'Upcoming Jobs'**
  String get upcomingJobs;

  /// No description provided for @completedJobs.
  ///
  /// In en, this message translates to:
  /// **'Completed Jobs'**
  String get completedJobs;

  /// No description provided for @blockedTimes.
  ///
  /// In en, this message translates to:
  /// **'Blocked Times'**
  String get blockedTimes;

  /// No description provided for @rescheduleTitle.
  ///
  /// In en, this message translates to:
  /// **'Reschedule Appointment'**
  String get rescheduleTitle;

  /// No description provided for @currentAppointment.
  ///
  /// In en, this message translates to:
  /// **'Current Appointment'**
  String get currentAppointment;

  /// No description provided for @selectNewTime.
  ///
  /// In en, this message translates to:
  /// **'Select New Time'**
  String get selectNewTime;

  /// No description provided for @reason.
  ///
  /// In en, this message translates to:
  /// **'Reason'**
  String get reason;

  /// No description provided for @customerApproval.
  ///
  /// In en, this message translates to:
  /// **'Customer Approval'**
  String get customerApproval;

  /// No description provided for @rescheduleRequested.
  ///
  /// In en, this message translates to:
  /// **'Reschedule Requested'**
  String get rescheduleRequested;

  /// No description provided for @rescheduleWaiting.
  ///
  /// In en, this message translates to:
  /// **'Waiting for Approval'**
  String get rescheduleWaiting;

  /// No description provided for @rescheduleApproved.
  ///
  /// In en, this message translates to:
  /// **'Reschedule Approved'**
  String get rescheduleApproved;

  /// No description provided for @rescheduleRejected.
  ///
  /// In en, this message translates to:
  /// **'Reschedule Rejected'**
  String get rescheduleRejected;

  /// No description provided for @coursesTraining.
  ///
  /// In en, this message translates to:
  /// **'Courses & Training'**
  String get coursesTraining;

  /// No description provided for @improveSkills.
  ///
  /// In en, this message translates to:
  /// **'Improve your skills & earn new certifications'**
  String get improveSkills;

  /// No description provided for @enrolled.
  ///
  /// In en, this message translates to:
  /// **'Enrolled'**
  String get enrolled;

  /// No description provided for @total.
  ///
  /// In en, this message translates to:
  /// **'Total'**
  String get total;

  /// No description provided for @finished.
  ///
  /// In en, this message translates to:
  /// **'Finished'**
  String get finished;

  /// No description provided for @certificates.
  ///
  /// In en, this message translates to:
  /// **'Certificates'**
  String get certificates;

  /// No description provided for @recommended.
  ///
  /// In en, this message translates to:
  /// **'Recommended'**
  String get recommended;

  /// No description provided for @mandatory.
  ///
  /// In en, this message translates to:
  /// **'Mandatory'**
  String get mandatory;

  /// No description provided for @advanced.
  ///
  /// In en, this message translates to:
  /// **'Advanced'**
  String get advanced;

  /// No description provided for @courseDetails.
  ///
  /// In en, this message translates to:
  /// **'Course Details'**
  String get courseDetails;

  /// No description provided for @enrollNow.
  ///
  /// In en, this message translates to:
  /// **'Enroll Now'**
  String get enrollNow;

  /// No description provided for @continueTraining.
  ///
  /// In en, this message translates to:
  /// **'Continue Training'**
  String get continueTraining;

  /// No description provided for @viewCertificate.
  ///
  /// In en, this message translates to:
  /// **'View Certificate'**
  String get viewCertificate;

  /// No description provided for @progress.
  ///
  /// In en, this message translates to:
  /// **'Progress'**
  String get progress;

  /// No description provided for @lessons.
  ///
  /// In en, this message translates to:
  /// **'Lessons'**
  String get lessons;

  /// No description provided for @duration.
  ///
  /// In en, this message translates to:
  /// **'Duration'**
  String get duration;

  /// No description provided for @certificate.
  ///
  /// In en, this message translates to:
  /// **'Certificate'**
  String get certificate;

  /// No description provided for @schemesWelfare.
  ///
  /// In en, this message translates to:
  /// **'Schemes & Welfare'**
  String get schemesWelfare;

  /// No description provided for @benefitsProtection.
  ///
  /// In en, this message translates to:
  /// **'Benefits, protection & cooperative support'**
  String get benefitsProtection;

  /// No description provided for @available.
  ///
  /// In en, this message translates to:
  /// **'Available'**
  String get available;

  /// No description provided for @explore.
  ///
  /// In en, this message translates to:
  /// **'Explore'**
  String get explore;

  /// No description provided for @eligible.
  ///
  /// In en, this message translates to:
  /// **'Eligible'**
  String get eligible;

  /// No description provided for @valid.
  ///
  /// In en, this message translates to:
  /// **'100% Valid'**
  String get valid;

  /// No description provided for @applied.
  ///
  /// In en, this message translates to:
  /// **'Applied'**
  String get applied;

  /// No description provided for @inReview.
  ///
  /// In en, this message translates to:
  /// **'In Review'**
  String get inReview;

  /// No description provided for @approved.
  ///
  /// In en, this message translates to:
  /// **'Approved'**
  String get approved;

  /// No description provided for @activeCare.
  ///
  /// In en, this message translates to:
  /// **'Active Care'**
  String get activeCare;

  /// No description provided for @insurance.
  ///
  /// In en, this message translates to:
  /// **'INSURANCE'**
  String get insurance;

  /// No description provided for @welfare.
  ///
  /// In en, this message translates to:
  /// **'WELFARE'**
  String get welfare;

  /// No description provided for @pension.
  ///
  /// In en, this message translates to:
  /// **'PENSION'**
  String get pension;

  /// No description provided for @training.
  ///
  /// In en, this message translates to:
  /// **'TRAINING'**
  String get training;

  /// No description provided for @schemeDetails.
  ///
  /// In en, this message translates to:
  /// **'Scheme Details'**
  String get schemeDetails;

  /// No description provided for @eligibility.
  ///
  /// In en, this message translates to:
  /// **'Eligibility'**
  String get eligibility;

  /// No description provided for @applyNow.
  ///
  /// In en, this message translates to:
  /// **'Apply Now'**
  String get applyNow;

  /// No description provided for @applicationSubmitted.
  ///
  /// In en, this message translates to:
  /// **'Application Submitted'**
  String get applicationSubmitted;

  /// No description provided for @applicationApproved.
  ///
  /// In en, this message translates to:
  /// **'Application Approved'**
  String get applicationApproved;

  /// No description provided for @applicationRejected.
  ///
  /// In en, this message translates to:
  /// **'Application Rejected'**
  String get applicationRejected;

  /// No description provided for @supportTitle.
  ///
  /// In en, this message translates to:
  /// **'Help & Support'**
  String get supportTitle;

  /// No description provided for @helpCenter.
  ///
  /// In en, this message translates to:
  /// **'Help Center'**
  String get helpCenter;

  /// No description provided for @faq.
  ///
  /// In en, this message translates to:
  /// **'FAQ'**
  String get faq;

  /// No description provided for @contactSupportAction.
  ///
  /// In en, this message translates to:
  /// **'Contact Support'**
  String get contactSupportAction;

  /// No description provided for @paymentIssue.
  ///
  /// In en, this message translates to:
  /// **'Payment Issue'**
  String get paymentIssue;

  /// No description provided for @jobDispute.
  ///
  /// In en, this message translates to:
  /// **'Job Scope Dispute'**
  String get jobDispute;

  /// No description provided for @technicalIssue.
  ///
  /// In en, this message translates to:
  /// **'Technical Issue'**
  String get technicalIssue;

  /// No description provided for @customerIssue.
  ///
  /// In en, this message translates to:
  /// **'Customer Issue'**
  String get customerIssue;

  /// No description provided for @unsafeLocationReport.
  ///
  /// In en, this message translates to:
  /// **'Unsafe Location'**
  String get unsafeLocationReport;

  /// No description provided for @sosTitle.
  ///
  /// In en, this message translates to:
  /// **'Emergency SOS'**
  String get sosTitle;

  /// No description provided for @emergencyAssistance.
  ///
  /// In en, this message translates to:
  /// **'Emergency Assistance'**
  String get emergencyAssistance;

  /// No description provided for @callEmergencyServices.
  ///
  /// In en, this message translates to:
  /// **'Call Emergency Services'**
  String get callEmergencyServices;

  /// No description provided for @cooperativeSupport.
  ///
  /// In en, this message translates to:
  /// **'Cooperative Support'**
  String get cooperativeSupport;

  /// No description provided for @shareLiveLocation.
  ///
  /// In en, this message translates to:
  /// **'Share Live GPS Location'**
  String get shareLiveLocation;

  /// No description provided for @securitySettings.
  ///
  /// In en, this message translates to:
  /// **'Security Settings'**
  String get securitySettings;

  /// No description provided for @changePassword.
  ///
  /// In en, this message translates to:
  /// **'Change Password'**
  String get changePassword;

  /// No description provided for @biometricLogin.
  ///
  /// In en, this message translates to:
  /// **'Biometric Login'**
  String get biometricLogin;

  /// No description provided for @sessionManagement.
  ///
  /// In en, this message translates to:
  /// **'Session / Device Management'**
  String get sessionManagement;

  /// No description provided for @accountLockInfo.
  ///
  /// In en, this message translates to:
  /// **'Account Lock Information'**
  String get accountLockInfo;

  /// No description provided for @locationPermTitle.
  ///
  /// In en, this message translates to:
  /// **'Location Permission Required'**
  String get locationPermTitle;

  /// No description provided for @locationPermMsg.
  ///
  /// In en, this message translates to:
  /// **'Location access is required for journey tracking, arrival verification, customer safety, and service verification.'**
  String get locationPermMsg;

  /// No description provided for @cameraPermTitle.
  ///
  /// In en, this message translates to:
  /// **'Camera Access Required'**
  String get cameraPermTitle;

  /// No description provided for @cameraPermMsg.
  ///
  /// In en, this message translates to:
  /// **'Camera access is required for inspection photos, material proof, before/after evidence, and service documentation.'**
  String get cameraPermMsg;

  /// No description provided for @notifPermTitle.
  ///
  /// In en, this message translates to:
  /// **'Notification Permission'**
  String get notifPermTitle;

  /// No description provided for @notifPermMsg.
  ///
  /// In en, this message translates to:
  /// **'Notifications are needed for new job alerts, customer selection updates, reminders, quotation results, and payment updates.'**
  String get notifPermMsg;

  /// No description provided for @allow.
  ///
  /// In en, this message translates to:
  /// **'Allow'**
  String get allow;

  /// No description provided for @notNow.
  ///
  /// In en, this message translates to:
  /// **'Not Now'**
  String get notNow;

  /// No description provided for @noRequests.
  ///
  /// In en, this message translates to:
  /// **'No new requests at the moment'**
  String get noRequests;

  /// No description provided for @noUpcomingJobs.
  ///
  /// In en, this message translates to:
  /// **'No upcoming jobs for this date'**
  String get noUpcomingJobs;

  /// No description provided for @noActiveJob.
  ///
  /// In en, this message translates to:
  /// **'No active job right now'**
  String get noActiveJob;

  /// No description provided for @noCompletedJobs.
  ///
  /// In en, this message translates to:
  /// **'No completed jobs yet'**
  String get noCompletedJobs;

  /// No description provided for @noNotifications.
  ///
  /// In en, this message translates to:
  /// **'No notifications available'**
  String get noNotifications;

  /// No description provided for @noCourses.
  ///
  /// In en, this message translates to:
  /// **'No courses available'**
  String get noCourses;

  /// No description provided for @noSchemes.
  ///
  /// In en, this message translates to:
  /// **'No schemes available'**
  String get noSchemes;

  /// No description provided for @noEarnings.
  ///
  /// In en, this message translates to:
  /// **'No earnings recorded yet'**
  String get noEarnings;

  /// No description provided for @noSettlements.
  ///
  /// In en, this message translates to:
  /// **'No settlements to show'**
  String get noSettlements;

  /// No description provided for @errorServerUnavailable.
  ///
  /// In en, this message translates to:
  /// **'Server is temporarily unavailable. Please try again later.'**
  String get errorServerUnavailable;

  /// No description provided for @errorNetworkUnavailable.
  ///
  /// In en, this message translates to:
  /// **'No internet connection. Please check your network settings.'**
  String get errorNetworkUnavailable;

  /// No description provided for @errorApiFailure.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong. Please try again.'**
  String get errorApiFailure;

  /// No description provided for @errorTimeout.
  ///
  /// In en, this message translates to:
  /// **'Request timed out. Please try again.'**
  String get errorTimeout;

  /// No description provided for @errorInvalidOtp.
  ///
  /// In en, this message translates to:
  /// **'Invalid OTP. Please check and try again.'**
  String get errorInvalidOtp;

  /// No description provided for @errorExpiredOtp.
  ///
  /// In en, this message translates to:
  /// **'OTP has expired. Please request a new one.'**
  String get errorExpiredOtp;

  /// No description provided for @errorPaymentFailed.
  ///
  /// In en, this message translates to:
  /// **'Payment failed. Please try again or use an alternate payment method.'**
  String get errorPaymentFailed;

  /// No description provided for @errorUploadFailed.
  ///
  /// In en, this message translates to:
  /// **'Upload failed. Please check your connection and try again.'**
  String get errorUploadFailed;

  /// No description provided for @errorGpsUnavailable.
  ///
  /// In en, this message translates to:
  /// **'GPS signal is not available. Please enable location services.'**
  String get errorGpsUnavailable;

  /// No description provided for @errorPermissionDenied.
  ///
  /// In en, this message translates to:
  /// **'Permission denied. This feature requires the requested permission.'**
  String get errorPermissionDenied;

  /// No description provided for @errorGeofenceFailed.
  ///
  /// In en, this message translates to:
  /// **'Geofence verification failed. Please ensure you are at the correct location.'**
  String get errorGeofenceFailed;

  /// No description provided for @errorSessionExpired.
  ///
  /// In en, this message translates to:
  /// **'Your session has expired. Please login again.'**
  String get errorSessionExpired;

  /// No description provided for @retry.
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get retry;

  /// No description provided for @tryAgain.
  ///
  /// In en, this message translates to:
  /// **'Try Again'**
  String get tryAgain;

  /// No description provided for @goBack.
  ///
  /// In en, this message translates to:
  /// **'Go Back'**
  String get goBack;

  /// No description provided for @paymentPending.
  ///
  /// In en, this message translates to:
  /// **'Payment Pending'**
  String get paymentPending;

  /// No description provided for @paymentProcessing.
  ///
  /// In en, this message translates to:
  /// **'PAYMENT PROCESSING'**
  String get paymentProcessing;

  /// No description provided for @paymentCompleted.
  ///
  /// In en, this message translates to:
  /// **'Payment Completed'**
  String get paymentCompleted;

  /// No description provided for @paymentFailed.
  ///
  /// In en, this message translates to:
  /// **'PAYMENT FAILED'**
  String get paymentFailed;

  /// No description provided for @partialPayment.
  ///
  /// In en, this message translates to:
  /// **'Partial Payment'**
  String get partialPayment;

  /// No description provided for @received.
  ///
  /// In en, this message translates to:
  /// **'Received'**
  String get received;

  /// No description provided for @remainingAmount.
  ///
  /// In en, this message translates to:
  /// **'Remaining'**
  String get remainingAmount;

  /// No description provided for @retryPayment.
  ///
  /// In en, this message translates to:
  /// **'Retry Payment'**
  String get retryPayment;

  /// No description provided for @alternatePayment.
  ///
  /// In en, this message translates to:
  /// **'Alternate Payment Method'**
  String get alternatePayment;

  /// No description provided for @gpsWeak.
  ///
  /// In en, this message translates to:
  /// **'GPS signal is weak'**
  String get gpsWeak;

  /// No description provided for @gpsSearching.
  ///
  /// In en, this message translates to:
  /// **'Searching for GPS signal...'**
  String get gpsSearching;

  /// No description provided for @gpsFixed.
  ///
  /// In en, this message translates to:
  /// **'GPS signal acquired'**
  String get gpsFixed;

  /// No description provided for @offline.
  ///
  /// In en, this message translates to:
  /// **'You are offline'**
  String get offline;

  /// No description provided for @syncing.
  ///
  /// In en, this message translates to:
  /// **'Syncing...'**
  String get syncing;

  /// No description provided for @reconnecting.
  ///
  /// In en, this message translates to:
  /// **'Reconnecting...'**
  String get reconnecting;

  /// No description provided for @failedAction.
  ///
  /// In en, this message translates to:
  /// **'Action failed. Will retry when connected.'**
  String get failedAction;

  /// No description provided for @mins.
  ///
  /// In en, this message translates to:
  /// **'mins'**
  String get mins;

  /// No description provided for @km.
  ///
  /// In en, this message translates to:
  /// **'km'**
  String get km;

  /// No description provided for @hrs.
  ///
  /// In en, this message translates to:
  /// **'hrs'**
  String get hrs;

  /// No description provided for @items.
  ///
  /// In en, this message translates to:
  /// **'items'**
  String get items;

  /// No description provided for @rupeeSymbol.
  ///
  /// In en, this message translates to:
  /// **'₹'**
  String get rupeeSymbol;

  /// No description provided for @confirmAction.
  ///
  /// In en, this message translates to:
  /// **'Confirm'**
  String get confirmAction;

  /// No description provided for @cancelAction.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancelAction;

  /// No description provided for @save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// No description provided for @edit.
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get edit;

  /// No description provided for @delete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete;

  /// No description provided for @close.
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get close;

  /// No description provided for @next.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get next;

  /// No description provided for @back.
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get back;

  /// No description provided for @submit.
  ///
  /// In en, this message translates to:
  /// **'Submit'**
  String get submit;

  /// No description provided for @apply.
  ///
  /// In en, this message translates to:
  /// **'Apply'**
  String get apply;

  /// No description provided for @view.
  ///
  /// In en, this message translates to:
  /// **'View'**
  String get view;

  /// No description provided for @download.
  ///
  /// In en, this message translates to:
  /// **'Download'**
  String get download;

  /// No description provided for @share.
  ///
  /// In en, this message translates to:
  /// **'Share'**
  String get share;

  /// No description provided for @search.
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get search;

  /// No description provided for @filter.
  ///
  /// In en, this message translates to:
  /// **'Filter'**
  String get filter;

  /// No description provided for @sortBy.
  ///
  /// In en, this message translates to:
  /// **'Sort by'**
  String get sortBy;

  /// No description provided for @clearAll.
  ///
  /// In en, this message translates to:
  /// **'Clear All'**
  String get clearAll;

  /// No description provided for @seeAll.
  ///
  /// In en, this message translates to:
  /// **'See All'**
  String get seeAll;

  /// No description provided for @loadMore.
  ///
  /// In en, this message translates to:
  /// **'Load More'**
  String get loadMore;

  /// No description provided for @ok.
  ///
  /// In en, this message translates to:
  /// **'OK'**
  String get ok;

  /// No description provided for @newRequestBadge.
  ///
  /// In en, this message translates to:
  /// **'NEW REQUEST'**
  String get newRequestBadge;

  /// No description provided for @verifiedClient.
  ///
  /// In en, this message translates to:
  /// **'Verified Client'**
  String get verifiedClient;

  /// No description provided for @memberSince.
  ///
  /// In en, this message translates to:
  /// **'Member since {year} • {count} completed services'**
  String memberSince(String year, String count);

  /// No description provided for @viewAllPhotos.
  ///
  /// In en, this message translates to:
  /// **'View All Photos ({count})'**
  String viewAllPhotos(String count);

  /// No description provided for @photoTapToView.
  ///
  /// In en, this message translates to:
  /// **'Tap to view'**
  String get photoTapToView;

  /// No description provided for @photoDisambiguationNote.
  ///
  /// In en, this message translates to:
  /// **'Customer pre-visit photos help assess tools & spare parts. Worker inspection photos are recorded separately after arrival & OTP verification.'**
  String get photoDisambiguationNote;

  /// No description provided for @scheduleLogistics.
  ///
  /// In en, this message translates to:
  /// **'Schedule & Logistics'**
  String get scheduleLogistics;

  /// No description provided for @travelTimeApprox.
  ///
  /// In en, this message translates to:
  /// **'~{minutes} mins travel time'**
  String travelTimeApprox(String minutes);

  /// No description provided for @editFee.
  ///
  /// In en, this message translates to:
  /// **'Edit Fee'**
  String get editFee;

  /// No description provided for @youReceiveFullPayout.
  ///
  /// In en, this message translates to:
  /// **'You Receive: {amount} (100% Payout)'**
  String youReceiveFullPayout(String amount);

  /// No description provided for @totalCustomerPays.
  ///
  /// In en, this message translates to:
  /// **'Total Customer Pays'**
  String get totalCustomerPays;

  /// No description provided for @guaranteedPayoutNote.
  ///
  /// In en, this message translates to:
  /// **'Your visit fee is credited even if the customer doesn\'t proceed after inspection.'**
  String get guaranteedPayoutNote;

  /// No description provided for @customerInstructionsTitle.
  ///
  /// In en, this message translates to:
  /// **'Customer Instructions'**
  String get customerInstructionsTitle;

  /// No description provided for @jobAcceptedWaitingNote.
  ///
  /// In en, this message translates to:
  /// **'Waiting for customer confirmation & selection.'**
  String get jobAcceptedWaitingNote;

  /// No description provided for @conflictExplanation.
  ///
  /// In en, this message translates to:
  /// **'This request could not be validated against your current schedule, working hours, or service zone.'**
  String get conflictExplanation;

  /// No description provided for @institutionAssignment.
  ///
  /// In en, this message translates to:
  /// **'INSTITUTION ASSIGNMENT'**
  String get institutionAssignment;

  /// No description provided for @customerJobRequest.
  ///
  /// In en, this message translates to:
  /// **'CUSTOMER JOB REQUEST'**
  String get customerJobRequest;

  /// No description provided for @viaMainRoad.
  ///
  /// In en, this message translates to:
  /// **'Via main road (Traffic flowing normally)'**
  String get viaMainRoad;

  /// No description provided for @askCustomerForOtp.
  ///
  /// In en, this message translates to:
  /// **'Ask {name} for the 6-digit code sent to their registered mobile.'**
  String askCustomerForOtp(String name);

  /// No description provided for @otpAttemptsLeft.
  ///
  /// In en, this message translates to:
  /// **'{count} attempts left'**
  String otpAttemptsLeft(String count);

  /// No description provided for @verifyAndStartService.
  ///
  /// In en, this message translates to:
  /// **'VERIFY & START SERVICE'**
  String get verifyAndStartService;

  /// No description provided for @strictProgressiveDisclosure.
  ///
  /// In en, this message translates to:
  /// **'Strict Progressive Disclosure'**
  String get strictProgressiveDisclosure;

  /// No description provided for @inspectionFindingsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Official technical diagnosis at location'**
  String get inspectionFindingsSubtitle;

  /// No description provided for @uploadedPriorToArrival.
  ///
  /// In en, this message translates to:
  /// **'Uploaded by {name} prior to technician arrival'**
  String uploadedPriorToArrival(String name);

  /// No description provided for @takeCameraShot.
  ///
  /// In en, this message translates to:
  /// **'Take Camera Shot'**
  String get takeCameraShot;

  /// No description provided for @uploadFile.
  ///
  /// In en, this message translates to:
  /// **'Upload File'**
  String get uploadFile;

  /// No description provided for @addPhoto.
  ///
  /// In en, this message translates to:
  /// **'Add Photo'**
  String get addPhoto;

  /// No description provided for @maxPhotosNote.
  ///
  /// In en, this message translates to:
  /// **'(Max {count})'**
  String maxPhotosNote(String count);

  /// No description provided for @removePhoto.
  ///
  /// In en, this message translates to:
  /// **'Remove photo'**
  String get removePhoto;

  /// No description provided for @quotationBuilder.
  ///
  /// In en, this message translates to:
  /// **'Quotation Builder'**
  String get quotationBuilder;

  /// No description provided for @quotationPreview.
  ///
  /// In en, this message translates to:
  /// **'Quotation Preview'**
  String get quotationPreview;

  /// No description provided for @quotationSent.
  ///
  /// In en, this message translates to:
  /// **'Quotation Sent'**
  String get quotationSent;

  /// No description provided for @createdAfterDiagnosis.
  ///
  /// In en, this message translates to:
  /// **'Created after technical on-site diagnosis'**
  String get createdAfterDiagnosis;

  /// No description provided for @labourDescription.
  ///
  /// In en, this message translates to:
  /// **'Service description'**
  String get labourDescription;

  /// No description provided for @labourEstimate.
  ///
  /// In en, this message translates to:
  /// **'Estimated duration: 45 – 60 mins'**
  String get labourEstimate;

  /// No description provided for @materialName.
  ///
  /// In en, this message translates to:
  /// **'Material name'**
  String get materialName;

  /// No description provided for @materialQty.
  ///
  /// In en, this message translates to:
  /// **'Qty'**
  String get materialQty;

  /// No description provided for @materialUnit.
  ///
  /// In en, this message translates to:
  /// **'unit'**
  String get materialUnit;

  /// No description provided for @materialUnitPrice.
  ///
  /// In en, this message translates to:
  /// **'Unit price'**
  String get materialUnitPrice;

  /// No description provided for @materialSubtotal.
  ///
  /// In en, this message translates to:
  /// **'Material Subtotal ({count} items)'**
  String materialSubtotal(String count);

  /// No description provided for @otherChargesHint.
  ///
  /// In en, this message translates to:
  /// **'Debris disposal, specialized tools (Optional)'**
  String get otherChargesHint;

  /// No description provided for @serviceSubtotalBreakdown.
  ///
  /// In en, this message translates to:
  /// **'Service Subtotal Breakdown:'**
  String get serviceSubtotalBreakdown;

  /// No description provided for @platformFeePolicy.
  ///
  /// In en, this message translates to:
  /// **'Platform fee is added separately to the service quotation. On-site visit charges are handled separately and are not included in this quotation.'**
  String get platformFeePolicy;

  /// No description provided for @quotationNotes.
  ///
  /// In en, this message translates to:
  /// **'Quotation Notes'**
  String get quotationNotes;

  /// No description provided for @quotationNotesHint.
  ///
  /// In en, this message translates to:
  /// **'Add any notes for the customer (optional)'**
  String get quotationNotesHint;

  /// No description provided for @quotationValidity.
  ///
  /// In en, this message translates to:
  /// **'Valid for 24 hours from time of submission'**
  String get quotationValidity;

  /// No description provided for @sendQuotationAmount.
  ///
  /// In en, this message translates to:
  /// **'SEND QUOTATION — {amount}'**
  String sendQuotationAmount(String amount);

  /// No description provided for @digitalPushNote.
  ///
  /// In en, this message translates to:
  /// **'Prompt digital push sent directly to customer\'s app'**
  String get digitalPushNote;

  /// No description provided for @quotationWaitingMsg.
  ///
  /// In en, this message translates to:
  /// **'Customer {name} will receive this itemized quotation of {amount} on their mobile app for immediate one-tap review and digital authorization.'**
  String quotationWaitingMsg(String name, String amount);

  /// No description provided for @approvedAction.
  ///
  /// In en, this message translates to:
  /// **'Tap \"START SERVICE\" to begin the repair work.'**
  String get approvedAction;

  /// No description provided for @rejectedAction.
  ///
  /// In en, this message translates to:
  /// **'Job closure handled according to standard cooperative policy.'**
  String get rejectedAction;

  /// No description provided for @paymentAfterApproval.
  ///
  /// In en, this message translates to:
  /// **'Payment & invoice will generate strictly after quotation is approved and physical service is completed.'**
  String get paymentAfterApproval;

  /// No description provided for @quotationAmount.
  ///
  /// In en, this message translates to:
  /// **'Service Quotation Amount:'**
  String get quotationAmount;

  /// No description provided for @previewQuotation.
  ///
  /// In en, this message translates to:
  /// **'PREVIEW QUOTATION'**
  String get previewQuotation;

  /// No description provided for @confirmAndSend.
  ///
  /// In en, this message translates to:
  /// **'CONFIRM & SEND QUOTATION'**
  String get confirmAndSend;

  /// No description provided for @quotationSentSuccess.
  ///
  /// In en, this message translates to:
  /// **'Quotation sent successfully to customer'**
  String get quotationSentSuccess;

  /// No description provided for @backToHome.
  ///
  /// In en, this message translates to:
  /// **'BACK TO HOME'**
  String get backToHome;

  /// No description provided for @removeMaterial.
  ///
  /// In en, this message translates to:
  /// **'Remove material'**
  String get removeMaterial;

  /// No description provided for @inr.
  ///
  /// In en, this message translates to:
  /// **'INR (₹)'**
  String get inr;

  /// No description provided for @labourChargeAmount.
  ///
  /// In en, this message translates to:
  /// **'Labour charge amount'**
  String get labourChargeAmount;

  /// No description provided for @otherChargesAmount.
  ///
  /// In en, this message translates to:
  /// **'Other charges amount'**
  String get otherChargesAmount;

  /// No description provided for @quotationSentWaiting.
  ///
  /// In en, this message translates to:
  /// **'Your quotation has been sent. Waiting for customer response.'**
  String get quotationSentWaiting;

  /// No description provided for @customerAccepted.
  ///
  /// In en, this message translates to:
  /// **'CUSTOMER ACCEPTED'**
  String get customerAccepted;

  /// No description provided for @customerRejected.
  ///
  /// In en, this message translates to:
  /// **'CUSTOMER REJECTED'**
  String get customerRejected;

  /// No description provided for @quotationAcceptedMsg.
  ///
  /// In en, this message translates to:
  /// **'Customer has approved your quotation. You can now start the service.'**
  String get quotationAcceptedMsg;

  /// No description provided for @quotationRejectedMsg.
  ///
  /// In en, this message translates to:
  /// **'Customer has declined the quotation. Job will be closed per cooperative policy.'**
  String get quotationRejectedMsg;

  /// No description provided for @serviceExecution.
  ///
  /// In en, this message translates to:
  /// **'Service Execution'**
  String get serviceExecution;

  /// No description provided for @workInProgress.
  ///
  /// In en, this message translates to:
  /// **'WORK IN PROGRESS'**
  String get workInProgress;

  /// No description provided for @addProofPhoto.
  ///
  /// In en, this message translates to:
  /// **'+ Add Additional Photo / Test Proof'**
  String get addProofPhoto;

  /// No description provided for @materialAndBillProof.
  ///
  /// In en, this message translates to:
  /// **'Material & Bill Proof'**
  String get materialAndBillProof;

  /// No description provided for @viewBill.
  ///
  /// In en, this message translates to:
  /// **'View'**
  String get viewBill;

  /// No description provided for @replaceBill.
  ///
  /// In en, this message translates to:
  /// **'Replace'**
  String get replaceBill;

  /// No description provided for @materialProofNote.
  ///
  /// In en, this message translates to:
  /// **'Material bill photos are attached as proof of actual material cost. They verify expenditure and do not add any extra charges.'**
  String get materialProofNote;

  /// No description provided for @completeService.
  ///
  /// In en, this message translates to:
  /// **'COMPLETE SERVICE'**
  String get completeService;

  /// No description provided for @paymentSuccess.
  ///
  /// In en, this message translates to:
  /// **'PAYMENT SUCCESSFUL'**
  String get paymentSuccess;

  /// No description provided for @bankUtr.
  ///
  /// In en, this message translates to:
  /// **'Bank UTR Reference'**
  String get bankUtr;

  /// No description provided for @timestamp.
  ///
  /// In en, this message translates to:
  /// **'Timestamp'**
  String get timestamp;

  /// No description provided for @shareOrPrint.
  ///
  /// In en, this message translates to:
  /// **'Share / Print'**
  String get shareOrPrint;

  /// No description provided for @ratingFeedback.
  ///
  /// In en, this message translates to:
  /// **'Rating & Feedback'**
  String get ratingFeedback;

  /// No description provided for @rateCustomer.
  ///
  /// In en, this message translates to:
  /// **'Rate Customer Experience'**
  String get rateCustomer;

  /// No description provided for @jobCompletedSuccess.
  ///
  /// In en, this message translates to:
  /// **'Job Completed Successfully!'**
  String get jobCompletedSuccess;

  /// No description provided for @viewInvoice.
  ///
  /// In en, this message translates to:
  /// **'VIEW INVOICE'**
  String get viewInvoice;

  /// No description provided for @cleanWorkArea.
  ///
  /// In en, this message translates to:
  /// **'Clean Work Area & Handover'**
  String get cleanWorkArea;

  /// No description provided for @customerInstructionFollowed.
  ///
  /// In en, this message translates to:
  /// **'Customer instructions adhered to during repair'**
  String get customerInstructionFollowed;

  /// No description provided for @todayEarnings.
  ///
  /// In en, this message translates to:
  /// **'Today'**
  String get todayEarnings;

  /// No description provided for @weekEarnings.
  ///
  /// In en, this message translates to:
  /// **'This Week'**
  String get weekEarnings;

  /// No description provided for @monthEarnings.
  ///
  /// In en, this message translates to:
  /// **'This Month'**
  String get monthEarnings;

  /// No description provided for @fyEarnings.
  ///
  /// In en, this message translates to:
  /// **'Financial Year'**
  String get fyEarnings;

  /// No description provided for @materialReimbursements.
  ///
  /// In en, this message translates to:
  /// **'Material Reimbursement'**
  String get materialReimbursements;

  /// No description provided for @settlementDate.
  ///
  /// In en, this message translates to:
  /// **'Settlement Date'**
  String get settlementDate;

  /// No description provided for @settlementAmount.
  ///
  /// In en, this message translates to:
  /// **'Amount'**
  String get settlementAmount;

  /// No description provided for @settledToBank.
  ///
  /// In en, this message translates to:
  /// **'Settled to Bank Account'**
  String get settledToBank;

  /// No description provided for @inEscrow.
  ///
  /// In en, this message translates to:
  /// **'In Escrow'**
  String get inEscrow;

  /// No description provided for @transactions.
  ///
  /// In en, this message translates to:
  /// **'Transactions'**
  String get transactions;

  /// No description provided for @reportDelayTitle.
  ///
  /// In en, this message translates to:
  /// **'Report Dispatch Delay'**
  String get reportDelayTitle;

  /// No description provided for @delayExpectedTime.
  ///
  /// In en, this message translates to:
  /// **'Expected Delay Time'**
  String get delayExpectedTime;

  /// No description provided for @min15.
  ///
  /// In en, this message translates to:
  /// **'+15 Mins'**
  String get min15;

  /// No description provided for @min30.
  ///
  /// In en, this message translates to:
  /// **'+30 Mins'**
  String get min30;

  /// No description provided for @min45.
  ///
  /// In en, this message translates to:
  /// **'+45 Mins'**
  String get min45;

  /// No description provided for @customTime.
  ///
  /// In en, this message translates to:
  /// **'Custom'**
  String get customTime;

  /// No description provided for @selectDelayReason.
  ///
  /// In en, this message translates to:
  /// **'Select Delay Reason'**
  String get selectDelayReason;

  /// No description provided for @trafficCongestion.
  ///
  /// In en, this message translates to:
  /// **'Heavy traffic on route'**
  String get trafficCongestion;

  /// No description provided for @prevJobLate.
  ///
  /// In en, this message translates to:
  /// **'Previous client job running late'**
  String get prevJobLate;

  /// No description provided for @vehicleIssue.
  ///
  /// In en, this message translates to:
  /// **'Vehicle / transit breakdown'**
  String get vehicleIssue;

  /// No description provided for @partsPickup.
  ///
  /// In en, this message translates to:
  /// **'Picking up required spare parts'**
  String get partsPickup;

  /// No description provided for @weatherDelay.
  ///
  /// In en, this message translates to:
  /// **'Severe weather disruption'**
  String get weatherDelay;

  /// No description provided for @emergencyDelay.
  ///
  /// In en, this message translates to:
  /// **'Personal / family emergency'**
  String get emergencyDelay;

  /// No description provided for @notifyDelay.
  ///
  /// In en, this message translates to:
  /// **'Notify Customer of Delay'**
  String get notifyDelay;

  /// No description provided for @delayReportedSuccess.
  ///
  /// In en, this message translates to:
  /// **'Delay reported. Customer has been notified.'**
  String get delayReportedSuccess;

  /// No description provided for @cancelAssignmentTitle.
  ///
  /// In en, this message translates to:
  /// **'Cancel This Assignment?'**
  String get cancelAssignmentTitle;

  /// No description provided for @cancelWarning.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to cancel? Cancelling within 1 hour impacts your worker response score.'**
  String get cancelWarning;

  /// No description provided for @cancelReasonLabel.
  ///
  /// In en, this message translates to:
  /// **'Reason for cancellation'**
  String get cancelReasonLabel;

  /// No description provided for @reasonConflict.
  ///
  /// In en, this message translates to:
  /// **'Schedule conflict'**
  String get reasonConflict;

  /// No description provided for @reasonEmergency.
  ///
  /// In en, this message translates to:
  /// **'Emergency / family urgency'**
  String get reasonEmergency;

  /// No description provided for @reasonVehicle.
  ///
  /// In en, this message translates to:
  /// **'Vehicle / transit problem'**
  String get reasonVehicle;

  /// No description provided for @reasonCustomerUnavailable.
  ///
  /// In en, this message translates to:
  /// **'Customer unavailable at site'**
  String get reasonCustomerUnavailable;

  /// No description provided for @reasonUnsafeLocation.
  ///
  /// In en, this message translates to:
  /// **'Unsafe / inaccessible location'**
  String get reasonUnsafeLocation;

  /// No description provided for @reasonIncorrectJob.
  ///
  /// In en, this message translates to:
  /// **'Incorrect job details / scope mismatch'**
  String get reasonIncorrectJob;

  /// No description provided for @reasonOther.
  ///
  /// In en, this message translates to:
  /// **'Other reason'**
  String get reasonOther;

  /// No description provided for @jobCancelledLogged.
  ///
  /// In en, this message translates to:
  /// **'Job Cancelled'**
  String get jobCancelledLogged;

  /// No description provided for @cancelNotificationSent.
  ///
  /// In en, this message translates to:
  /// **'Customer & cooperative dispatch have been notified.'**
  String get cancelNotificationSent;

  /// No description provided for @logged.
  ///
  /// In en, this message translates to:
  /// **'Logged'**
  String get logged;

  /// No description provided for @selectNewSlot.
  ///
  /// In en, this message translates to:
  /// **'Select New Date & Time'**
  String get selectNewSlot;

  /// No description provided for @rescheduleReason.
  ///
  /// In en, this message translates to:
  /// **'Reason for Reschedule'**
  String get rescheduleReason;

  /// No description provided for @requestCustomerApproval.
  ///
  /// In en, this message translates to:
  /// **'Request Customer Approval'**
  String get requestCustomerApproval;

  /// No description provided for @rescheduleStatusRequested.
  ///
  /// In en, this message translates to:
  /// **'Requested'**
  String get rescheduleStatusRequested;

  /// No description provided for @rescheduleStatusWaiting.
  ///
  /// In en, this message translates to:
  /// **'Waiting for Customer'**
  String get rescheduleStatusWaiting;

  /// No description provided for @rescheduleStatusApproved.
  ///
  /// In en, this message translates to:
  /// **'Approved'**
  String get rescheduleStatusApproved;

  /// No description provided for @rescheduleStatusRejected.
  ///
  /// In en, this message translates to:
  /// **'Declined'**
  String get rescheduleStatusRejected;

  /// No description provided for @rescheduleSuccess.
  ///
  /// In en, this message translates to:
  /// **'Reschedule request sent to customer'**
  String get rescheduleSuccess;

  /// No description provided for @customerUnavailableTitle.
  ///
  /// In en, this message translates to:
  /// **'Customer Unavailable at Site'**
  String get customerUnavailableTitle;

  /// No description provided for @stepCallCustomer.
  ///
  /// In en, this message translates to:
  /// **'Call Customer'**
  String get stepCallCustomer;

  /// No description provided for @stepSendMessage.
  ///
  /// In en, this message translates to:
  /// **'Send In-App Message'**
  String get stepSendMessage;

  /// No description provided for @stepWaitTimer.
  ///
  /// In en, this message translates to:
  /// **'Waiting Protocol Timer'**
  String get stepWaitTimer;

  /// No description provided for @stepArrivalEvidence.
  ///
  /// In en, this message translates to:
  /// **'Verify GPS Arrival Evidence'**
  String get stepArrivalEvidence;

  /// No description provided for @claimOnsiteFee.
  ///
  /// In en, this message translates to:
  /// **'Claim Guaranteed Onsite Fee (₹150)'**
  String get claimOnsiteFee;

  /// No description provided for @recordUnavailable.
  ///
  /// In en, this message translates to:
  /// **'Report Customer Unavailable & Close'**
  String get recordUnavailable;

  /// No description provided for @unavailableLogged.
  ///
  /// In en, this message translates to:
  /// **'Customer unavailable logged. ₹150 onsite fee credited to your pending settlement.'**
  String get unavailableLogged;

  /// No description provided for @callNow.
  ///
  /// In en, this message translates to:
  /// **'Call Now'**
  String get callNow;

  /// No description provided for @messageNow.
  ///
  /// In en, this message translates to:
  /// **'Send Message'**
  String get messageNow;

  /// No description provided for @waitingRemaining.
  ///
  /// In en, this message translates to:
  /// **'10:00 Waiting Time Remaining'**
  String get waitingRemaining;

  /// No description provided for @markAllRead.
  ///
  /// In en, this message translates to:
  /// **'Mark read'**
  String get markAllRead;

  /// No description provided for @filterAll.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get filterAll;

  /// No description provided for @filterCustomer.
  ///
  /// In en, this message translates to:
  /// **'Customer'**
  String get filterCustomer;

  /// No description provided for @filterInstitution.
  ///
  /// In en, this message translates to:
  /// **'Institution'**
  String get filterInstitution;

  /// No description provided for @filterSystem.
  ///
  /// In en, this message translates to:
  /// **'System'**
  String get filterSystem;

  /// No description provided for @workerCredentials.
  ///
  /// In en, this message translates to:
  /// **'Worker Identity & Credentials'**
  String get workerCredentials;

  /// No description provided for @completedStat.
  ///
  /// In en, this message translates to:
  /// **'Completed'**
  String get completedStat;

  /// No description provided for @cancelledStat.
  ///
  /// In en, this message translates to:
  /// **'Cancelled'**
  String get cancelledStat;

  /// No description provided for @earningsStat.
  ///
  /// In en, this message translates to:
  /// **'Earnings'**
  String get earningsStat;

  /// No description provided for @ratingStat.
  ///
  /// In en, this message translates to:
  /// **'Rating'**
  String get ratingStat;

  /// No description provided for @skillsAndCertifications.
  ///
  /// In en, this message translates to:
  /// **'Skills & Certifications'**
  String get skillsAndCertifications;

  /// No description provided for @accountQuickLinks.
  ///
  /// In en, this message translates to:
  /// **'Account & Work Settings'**
  String get accountQuickLinks;

  /// No description provided for @workerSchedule.
  ///
  /// In en, this message translates to:
  /// **'Worker Schedule'**
  String get workerSchedule;

  /// No description provided for @availabilityStatus.
  ///
  /// In en, this message translates to:
  /// **'Availability Status'**
  String get availabilityStatus;

  /// No description provided for @bankAndPayouts.
  ///
  /// In en, this message translates to:
  /// **'Bank & Payout Accounts'**
  String get bankAndPayouts;

  /// No description provided for @documentsKyc.
  ///
  /// In en, this message translates to:
  /// **'Documents & KYC Verification'**
  String get documentsKyc;

  /// No description provided for @settingsTitle.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settingsTitle;

  /// No description provided for @helpAndSupport.
  ///
  /// In en, this message translates to:
  /// **'Help & Support'**
  String get helpAndSupport;

  /// No description provided for @emergencySos.
  ///
  /// In en, this message translates to:
  /// **'Emergency SOS'**
  String get emergencySos;

  /// No description provided for @statusActive.
  ///
  /// In en, this message translates to:
  /// **'ACTIVE'**
  String get statusActive;

  /// No description provided for @statusInactive.
  ///
  /// In en, this message translates to:
  /// **'INACTIVE'**
  String get statusInactive;

  /// No description provided for @statusBusy.
  ///
  /// In en, this message translates to:
  /// **'BUSY'**
  String get statusBusy;

  /// No description provided for @statusPaused.
  ///
  /// In en, this message translates to:
  /// **'REQUESTS PAUSED'**
  String get statusPaused;

  /// No description provided for @workHours.
  ///
  /// In en, this message translates to:
  /// **'Working Hours'**
  String get workHours;

  /// No description provided for @upcomingAppointments.
  ///
  /// In en, this message translates to:
  /// **'Upcoming Appointments'**
  String get upcomingAppointments;

  /// No description provided for @blockedTime.
  ///
  /// In en, this message translates to:
  /// **'Blocked Time Slots'**
  String get blockedTime;

  /// No description provided for @appPreferences.
  ///
  /// In en, this message translates to:
  /// **'App Preferences'**
  String get appPreferences;

  /// No description provided for @pushNotifications.
  ///
  /// In en, this message translates to:
  /// **'Push Notifications'**
  String get pushNotifications;

  /// No description provided for @smsAlerts.
  ///
  /// In en, this message translates to:
  /// **'SMS Alerts'**
  String get smsAlerts;

  /// No description provided for @locationServices.
  ///
  /// In en, this message translates to:
  /// **'Location Services (Always Allow)'**
  String get locationServices;

  /// No description provided for @cameraPermission.
  ///
  /// In en, this message translates to:
  /// **'Camera & Media Access'**
  String get cameraPermission;

  /// No description provided for @cooperativeHelpline.
  ///
  /// In en, this message translates to:
  /// **'Cooperative Helpline'**
  String get cooperativeHelpline;

  /// No description provided for @emergencySosTitle.
  ///
  /// In en, this message translates to:
  /// **'Emergency SOS'**
  String get emergencySosTitle;

  /// No description provided for @call112.
  ///
  /// In en, this message translates to:
  /// **'National Emergency Services (112)'**
  String get call112;

  /// No description provided for @callDispatch.
  ///
  /// In en, this message translates to:
  /// **'Cooperative Emergency Dispatch'**
  String get callDispatch;

  /// No description provided for @faqTitle.
  ///
  /// In en, this message translates to:
  /// **'Frequently Asked Questions'**
  String get faqTitle;

  /// No description provided for @paymentDispute.
  ///
  /// In en, this message translates to:
  /// **'Payment Dispute'**
  String get paymentDispute;

  /// No description provided for @sosAlertSent.
  ///
  /// In en, this message translates to:
  /// **'SOS alert & current location dispatched to cooperative control center.'**
  String get sosAlertSent;

  /// No description provided for @institutionDashboard.
  ///
  /// In en, this message translates to:
  /// **'Institution Assignments'**
  String get institutionDashboard;

  /// No description provided for @shiftHours.
  ///
  /// In en, this message translates to:
  /// **'Shift Hours'**
  String get shiftHours;

  /// No description provided for @fixedDuty.
  ///
  /// In en, this message translates to:
  /// **'8h Fixed Duty'**
  String get fixedDuty;

  /// No description provided for @guaranteedPay.
  ///
  /// In en, this message translates to:
  /// **'Guaranteed Pay'**
  String get guaranteedPay;

  /// No description provided for @directEscrow.
  ///
  /// In en, this message translates to:
  /// **'Direct Escrow'**
  String get directEscrow;

  /// No description provided for @peerRoster.
  ///
  /// In en, this message translates to:
  /// **'Peer Roster'**
  String get peerRoster;

  /// No description provided for @allDispatched.
  ///
  /// In en, this message translates to:
  /// **'All Dispatched'**
  String get allDispatched;

  /// No description provided for @liveDeployment.
  ///
  /// In en, this message translates to:
  /// **'Live Deployment'**
  String get liveDeployment;

  /// No description provided for @stageAssigned.
  ///
  /// In en, this message translates to:
  /// **'Assigned'**
  String get stageAssigned;

  /// No description provided for @stageJourney.
  ///
  /// In en, this message translates to:
  /// **'Journey'**
  String get stageJourney;

  /// No description provided for @stageEnRoute.
  ///
  /// In en, this message translates to:
  /// **'En Route'**
  String get stageEnRoute;

  /// No description provided for @stageArrived.
  ///
  /// In en, this message translates to:
  /// **'Arrived'**
  String get stageArrived;

  /// No description provided for @stageToolInspection.
  ///
  /// In en, this message translates to:
  /// **'Tool Check'**
  String get stageToolInspection;

  /// No description provided for @stageServiceWork.
  ///
  /// In en, this message translates to:
  /// **'Service Work'**
  String get stageServiceWork;

  /// No description provided for @stageSupervisorSignoff.
  ///
  /// In en, this message translates to:
  /// **'Sign-off'**
  String get stageSupervisorSignoff;

  /// No description provided for @stageCompleted.
  ///
  /// In en, this message translates to:
  /// **'Completed'**
  String get stageCompleted;

  /// No description provided for @siteSupervisor.
  ///
  /// In en, this message translates to:
  /// **'Site Supervisor'**
  String get siteSupervisor;

  /// No description provided for @equipmentChecklist.
  ///
  /// In en, this message translates to:
  /// **'Equipment Checklist'**
  String get equipmentChecklist;

  /// No description provided for @allToolsVerified.
  ///
  /// In en, this message translates to:
  /// **'All safety & sanitization equipment verified'**
  String get allToolsVerified;

  /// No description provided for @coursesTitle.
  ///
  /// In en, this message translates to:
  /// **'Training & Upskilling'**
  String get coursesTitle;

  /// No description provided for @certificatesEarned.
  ///
  /// In en, this message translates to:
  /// **'Certificates'**
  String get certificatesEarned;

  /// No description provided for @recommendedForYou.
  ///
  /// In en, this message translates to:
  /// **'Recommended for You'**
  String get recommendedForYou;

  /// No description provided for @technicalCourses.
  ///
  /// In en, this message translates to:
  /// **'Technical'**
  String get technicalCourses;

  /// No description provided for @safetyCourses.
  ///
  /// In en, this message translates to:
  /// **'Safety'**
  String get safetyCourses;

  /// No description provided for @startCourse.
  ///
  /// In en, this message translates to:
  /// **'Start Course'**
  String get startCourse;

  /// No description provided for @resumeCourse.
  ///
  /// In en, this message translates to:
  /// **'Resume'**
  String get resumeCourse;

  /// No description provided for @hours.
  ///
  /// In en, this message translates to:
  /// **'hours'**
  String get hours;

  /// No description provided for @modules.
  ///
  /// In en, this message translates to:
  /// **'modules'**
  String get modules;

  /// No description provided for @schemesTitle.
  ///
  /// In en, this message translates to:
  /// **'Cooperative Welfare & Schemes'**
  String get schemesTitle;

  /// No description provided for @eligibleSchemes.
  ///
  /// In en, this message translates to:
  /// **'Eligible'**
  String get eligibleSchemes;

  /// No description provided for @appliedSchemes.
  ///
  /// In en, this message translates to:
  /// **'Applied'**
  String get appliedSchemes;

  /// No description provided for @approvedSchemes.
  ///
  /// In en, this message translates to:
  /// **'Approved'**
  String get approvedSchemes;

  /// No description provided for @featuredScheme.
  ///
  /// In en, this message translates to:
  /// **'Featured Scheme'**
  String get featuredScheme;

  /// No description provided for @viewStatus.
  ///
  /// In en, this message translates to:
  /// **'View Status'**
  String get viewStatus;

  /// No description provided for @coverage.
  ///
  /// In en, this message translates to:
  /// **'Coverage'**
  String get coverage;

  /// No description provided for @insuranceCategory.
  ///
  /// In en, this message translates to:
  /// **'Insurance'**
  String get insuranceCategory;

  /// No description provided for @welfareCategory.
  ///
  /// In en, this message translates to:
  /// **'Welfare'**
  String get welfareCategory;

  /// No description provided for @financialCategory.
  ///
  /// In en, this message translates to:
  /// **'Financial'**
  String get financialCategory;

  /// No description provided for @noRequestsMsg.
  ///
  /// In en, this message translates to:
  /// **'No new service requests available right now'**
  String get noRequestsMsg;

  /// No description provided for @networkErrorTitle.
  ///
  /// In en, this message translates to:
  /// **'No Internet Connection'**
  String get networkErrorTitle;

  /// No description provided for @networkErrorMsg.
  ///
  /// In en, this message translates to:
  /// **'Please check your mobile data or Wi-Fi connection and retry.'**
  String get networkErrorMsg;

  /// No description provided for @gpsErrorTitle.
  ///
  /// In en, this message translates to:
  /// **'Location Permission Required'**
  String get gpsErrorTitle;

  /// No description provided for @gpsErrorMsg.
  ///
  /// In en, this message translates to:
  /// **'GPS access is required to track journeys and verify on-site arrival.'**
  String get gpsErrorMsg;

  /// No description provided for @enableGps.
  ///
  /// In en, this message translates to:
  /// **'Enable GPS'**
  String get enableGps;

  /// No description provided for @cameraErrorTitle.
  ///
  /// In en, this message translates to:
  /// **'Camera Permission Required'**
  String get cameraErrorTitle;

  /// No description provided for @cameraErrorMsg.
  ///
  /// In en, this message translates to:
  /// **'Camera access is needed to capture inspection and bill proof photos.'**
  String get cameraErrorMsg;

  /// No description provided for @grantPermission.
  ///
  /// In en, this message translates to:
  /// **'Grant Permission'**
  String get grantPermission;

  /// No description provided for @disputeTitle.
  ///
  /// In en, this message translates to:
  /// **'Job Dispute Reported'**
  String get disputeTitle;

  /// No description provided for @disputeMsg.
  ///
  /// In en, this message translates to:
  /// **'A dispute has been raised on this job. Cooperative support is reviewing the case.'**
  String get disputeMsg;

  /// No description provided for @cancellationReasonLabel.
  ///
  /// In en, this message translates to:
  /// **'Reason'**
  String get cancellationReasonLabel;

  /// No description provided for @cancellationTimestampLabel.
  ///
  /// In en, this message translates to:
  /// **'Timestamp'**
  String get cancellationTimestampLabel;

  /// No description provided for @cancellationStatusLabel.
  ///
  /// In en, this message translates to:
  /// **'Status'**
  String get cancellationStatusLabel;

  /// No description provided for @connectingSupportHotline.
  ///
  /// In en, this message translates to:
  /// **'Connecting to Society Helpdesk Hotline...'**
  String get connectingSupportHotline;

  /// No description provided for @callSupportNumber.
  ///
  /// In en, this message translates to:
  /// **'Call 1800-425-9988'**
  String get callSupportNumber;

  /// No description provided for @supportTicketCreated.
  ///
  /// In en, this message translates to:
  /// **'Support ticket created successfully! Ticket #TKT-8421'**
  String get supportTicketCreated;

  /// No description provided for @logTicket.
  ///
  /// In en, this message translates to:
  /// **'Log Ticket'**
  String get logTicket;

  /// No description provided for @telemetryDispatched.
  ///
  /// In en, this message translates to:
  /// **'Live location telemetry dispatched!'**
  String get telemetryDispatched;

  /// No description provided for @dialingNumber.
  ///
  /// In en, this message translates to:
  /// **'Dialing {number}...'**
  String dialingNumber(String number);

  /// No description provided for @activeCoverage.
  ///
  /// In en, this message translates to:
  /// **'Active Coverage'**
  String get activeCoverage;

  /// No description provided for @viewHealthCardAndHospitals.
  ///
  /// In en, this message translates to:
  /// **'View Health Card & Hospitals'**
  String get viewHealthCardAndHospitals;

  /// No description provided for @schemeVerificationCard.
  ///
  /// In en, this message translates to:
  /// **'Scheme Verification Card'**
  String get schemeVerificationCard;

  /// No description provided for @policyNumberLabel.
  ///
  /// In en, this message translates to:
  /// **'Cooperative Society Policy: COOP-MED-84920'**
  String get policyNumberLabel;

  /// No description provided for @policyStatusLabel.
  ///
  /// In en, this message translates to:
  /// **'Status: Active • Auto-renewed annually'**
  String get policyStatusLabel;

  /// No description provided for @tpaHelplineLabel.
  ///
  /// In en, this message translates to:
  /// **'TPA Helpline: 1800-22-9988'**
  String get tpaHelplineLabel;

  /// No description provided for @customerServicesTitle.
  ///
  /// In en, this message translates to:
  /// **'Customer Services'**
  String get customerServicesTitle;

  /// No description provided for @customerServicesB2C.
  ///
  /// In en, this message translates to:
  /// **'Customer Services (B2C)'**
  String get customerServicesB2C;

  /// No description provided for @urgentCount.
  ///
  /// In en, this message translates to:
  /// **'{count} urgent'**
  String urgentCount(String count);

  /// No description provided for @nextScheduledAt.
  ///
  /// In en, this message translates to:
  /// **'Next: {time}'**
  String nextScheduledAt(String time);

  /// No description provided for @thisMonth.
  ///
  /// In en, this message translates to:
  /// **'This Month'**
  String get thisMonth;

  /// No description provided for @reviewsCount.
  ///
  /// In en, this message translates to:
  /// **'({count} reviews)'**
  String reviewsCount(String count);

  /// No description provided for @jobInProgress.
  ///
  /// In en, this message translates to:
  /// **'Job In Progress'**
  String get jobInProgress;

  /// No description provided for @estFee.
  ///
  /// In en, this message translates to:
  /// **'₹{amount} Est.'**
  String estFee(String amount);

  /// No description provided for @jobDetailsAndBill.
  ///
  /// In en, this message translates to:
  /// **'Job Details & Bill'**
  String get jobDetailsAndBill;

  /// No description provided for @mapNavigation.
  ///
  /// In en, this message translates to:
  /// **'Map Navigation'**
  String get mapNavigation;

  /// No description provided for @incomingRequestsDirect.
  ///
  /// In en, this message translates to:
  /// **'Incoming Requests (Direct)'**
  String get incomingRequestsDirect;

  /// No description provided for @yourProposedOnsiteFee.
  ///
  /// In en, this message translates to:
  /// **'Your Proposed On-Site Fee:'**
  String get yourProposedOnsiteFee;

  /// No description provided for @setOnsiteFee.
  ///
  /// In en, this message translates to:
  /// **'Set On-Site Fee:'**
  String get setOnsiteFee;

  /// No description provided for @acceptWithFee.
  ///
  /// In en, this message translates to:
  /// **'Accept with ₹{amount}'**
  String acceptWithFee(String amount);

  /// No description provided for @reviewAndProposeFee.
  ///
  /// In en, this message translates to:
  /// **'Review & Propose Fee'**
  String get reviewAndProposeFee;

  /// No description provided for @confirmedVisitsNext24h.
  ///
  /// In en, this message translates to:
  /// **'Confirmed Visits (Next 24h)'**
  String get confirmedVisitsNext24h;

  /// No description provided for @remainingCount.
  ///
  /// In en, this message translates to:
  /// **'{count} Remaining'**
  String remainingCount(String count);

  /// No description provided for @fieldHelpSafetySos.
  ///
  /// In en, this message translates to:
  /// **'Field Help & Safety SOS'**
  String get fieldHelpSafetySos;

  /// No description provided for @directAgentResolutionLine.
  ///
  /// In en, this message translates to:
  /// **'Direct 24/7 Agent Resolution Line'**
  String get directAgentResolutionLine;

  /// No description provided for @otpAlertDescription.
  ///
  /// In en, this message translates to:
  /// **'Customer OTP verified. Please enter completion OTP before generating final invoice.'**
  String get otpAlertDescription;

  /// No description provided for @viewAllCount.
  ///
  /// In en, this message translates to:
  /// **'View All ({count})'**
  String viewAllCount(String count);

  /// No description provided for @confirmed.
  ///
  /// In en, this message translates to:
  /// **'Confirmed'**
  String get confirmed;

  /// No description provided for @serviceCompletionOtpTitle.
  ///
  /// In en, this message translates to:
  /// **'Service Completion OTP'**
  String get serviceCompletionOtpTitle;

  /// No description provided for @serviceCompletionOtpSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Customer Service Sign-Off'**
  String get serviceCompletionOtpSubtitle;

  /// No description provided for @askCustomerForCompletionOtp.
  ///
  /// In en, this message translates to:
  /// **'Ask {customerName} for the 4-digit completion OTP to verify satisfactory service.'**
  String askCustomerForCompletionOtp(String customerName);

  /// No description provided for @completionOtpVerified.
  ///
  /// In en, this message translates to:
  /// **'Service Completion OTP Verified'**
  String get completionOtpVerified;

  /// No description provided for @proceedToPayment.
  ///
  /// In en, this message translates to:
  /// **'PROCEED TO BILLING & PAYMENT'**
  String get proceedToPayment;

  /// No description provided for @verifyEndOtpAndComplete.
  ///
  /// In en, this message translates to:
  /// **'VERIFY END OTP & COMPLETE'**
  String get verifyEndOtpAndComplete;

  /// No description provided for @signedOff.
  ///
  /// In en, this message translates to:
  /// **'Signed Off'**
  String get signedOff;

  /// No description provided for @serviceCompletedProofAttached.
  ///
  /// In en, this message translates to:
  /// **'Proof Photos Attached & Area Cleaned'**
  String get serviceCompletedProofAttached;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'hi', 'ml', 'ta'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'hi':
      return AppLocalizationsHi();
    case 'ml':
      return AppLocalizationsMl();
    case 'ta':
      return AppLocalizationsTa();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
