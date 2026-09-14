// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'WORK SOLUTE';

  @override
  String get cooperativePlatform => 'Cooperative Worker Platform';

  @override
  String get verifiedFieldPortal => 'Verified Field Workforce Portal';

  @override
  String get navHome => 'HOME';

  @override
  String get navCustomer => 'CUSTOMER';

  @override
  String get navInstitution => 'INSTITUTION';

  @override
  String get navCourses => 'COURSES';

  @override
  String get navSchemes => 'SCHEMES';

  @override
  String get navProfile => 'Profile';

  @override
  String get loginTitle => 'Worker Login';

  @override
  String get loginSubtitle =>
      'Sign in to manage your work, assignments and direct cooperative payouts.';

  @override
  String get workerIdLabel => 'Worker ID';

  @override
  String get workerIdHint => 'e.g. WKR-2847';

  @override
  String get passwordLabel => 'Password';

  @override
  String get forgotPassword => 'Forgot Password?';

  @override
  String get loginButton => 'LOGIN';

  @override
  String get secureAccess => 'Secure Worker Access • 256-Bit Encrypted';

  @override
  String get societyNote =>
      'Use the credentials provided by your Cooperative Society.';

  @override
  String get langPersistNote =>
      'Selected language carries over to Dashboard, Quotations & Schemes.';

  @override
  String get needHelp => 'Need help signing in?';

  @override
  String get societyHelpdesk => 'Society Helpdesk';

  @override
  String get footerText => 'X COOPERATIVE FEDERATION LTD • VERSION 2.4.0';

  @override
  String get selectLanguage => 'Select Language';

  @override
  String get langSubtitle => 'Choose your preferred language';

  @override
  String get langPersistInfo =>
      'Preference persists across Dashboard, Customer, Quotation, Schemes and Invoice screens.';

  @override
  String get verifyingCredentials => 'Verifying Worker Credentials...';

  @override
  String get forgotPasswordTitle => 'Forgot Password';

  @override
  String get forgotPasswordSubtitle =>
      'Enter your Worker ID to receive a verification OTP.';

  @override
  String get sendOtp => 'Send OTP';

  @override
  String get enterOtp => 'Enter OTP';

  @override
  String get otpSentTo => 'OTP sent to your registered mobile number';

  @override
  String get newPassword => 'New Password';

  @override
  String get confirmPassword => 'Confirm Password';

  @override
  String get resetPassword => 'Reset Password';

  @override
  String get passwordResetSuccess =>
      'Password reset successfully! Please login with your new password.';

  @override
  String get accountLockedTitle => 'Account Locked';

  @override
  String get accountLockedMsg =>
      'Your account has been temporarily locked due to multiple failed login attempts. Please contact your cooperative society helpdesk.';

  @override
  String get sessionExpiredTitle => 'Session Expired';

  @override
  String get sessionExpiredMsg =>
      'Your session has expired. Please login again to continue.';

  @override
  String get reLogin => 'Re-Login';

  @override
  String get contactSupport => 'Contact Support';

  @override
  String get goodMorning => 'Good Morning';

  @override
  String get goodAfternoon => 'Good Afternoon';

  @override
  String get goodEvening => 'Good Evening';

  @override
  String get verified => 'Verified';

  @override
  String get activeDay => 'ACTIVE DAY';

  @override
  String get inactiveDay => 'INACTIVE DAY';

  @override
  String get onCall => 'ON-CALL';

  @override
  String get readyToReceive => 'Ready to receive work';

  @override
  String get requestsPaused => 'New work requests are paused';

  @override
  String serviceStartsIn(String time) {
    return 'SERVICE STARTS IN $time';
  }

  @override
  String startsIn(String minutes) {
    return 'Starts in ${minutes}m';
  }

  @override
  String customerJobId(String id) {
    return 'Customer Job #$id';
  }

  @override
  String get scheduled => 'Scheduled';

  @override
  String get customer => 'Customer';

  @override
  String get institution => 'Institution';

  @override
  String get startJourney => 'START JOURNEY';

  @override
  String get onTime => 'ON TIME';

  @override
  String get delayed => 'DELAYED';

  @override
  String get cancel => 'CANCEL';

  @override
  String get todaysLiveActivity => 'Today\'s Live Activity';

  @override
  String get serviceInProgress => 'Service In Progress';

  @override
  String get enRoute => 'En Route';

  @override
  String get arrived => 'Arrived';

  @override
  String get inProgress => 'In Progress';

  @override
  String get completed => 'Completed';

  @override
  String get openJob => 'Open Job';

  @override
  String get importantAlert => 'Important Alert';

  @override
  String get otpRequired => 'OTP Required';

  @override
  String get newRequests => 'New Requests';

  @override
  String get accepted => 'Accepted';

  @override
  String get upcoming => 'Upcoming';

  @override
  String get pending => 'Pending';

  @override
  String get assigned => 'Assigned';

  @override
  String get b2cDirect => 'B2C Direct';

  @override
  String get b2bGovt => 'B2B / Govt';

  @override
  String get individualServices => 'Individual customer services';

  @override
  String get orgWorkforce => 'Organization & workforce assignments';

  @override
  String get viewCustomer => 'VIEW CUSTOMER';

  @override
  String get viewInstitution => 'VIEW INSTITUTION';

  @override
  String activeJobId(String id) {
    return 'Active Job #$id';
  }

  @override
  String assignmentId(String id) {
    return 'Assignment #$id';
  }

  @override
  String get summary => 'Summary';

  @override
  String get viewBreakdown => 'View Breakdown';

  @override
  String get jobsCompleted => 'Completed';

  @override
  String get jobsCancelled => 'Cancelled';

  @override
  String get earnings => 'Earnings';

  @override
  String get rating => 'Rating';

  @override
  String get reportDelay => 'Report Dispatch Delay';

  @override
  String get expectedDelayTime => 'Expected Delay Time';

  @override
  String get selectReason => 'Select Reason';

  @override
  String get heavyTraffic => 'Heavy traffic on route';

  @override
  String get previousJobLate => 'Previous client job running late';

  @override
  String get vehicleBreakdown => 'Vehicle / transit breakdown';

  @override
  String get spareParts => 'Picking up required spare parts';

  @override
  String get weather => 'Weather conditions';

  @override
  String get emergency => 'Emergency situation';

  @override
  String get other => 'Other reason';

  @override
  String get dismiss => 'Dismiss';

  @override
  String get notifyClientDelay => 'Notify Client of Delay';

  @override
  String get delayConfirmed =>
      'Delay Reported. Customer updated with revised arrival time.';

  @override
  String get onTimeConfirmed =>
      'Confirmed ON TIME. Customer notified. Departure countdown active.';

  @override
  String get cancelJob => 'Cancel This Assignment?';

  @override
  String get cancelJobWarning =>
      'Cancelling within 1 hour impacts your worker response score.';

  @override
  String get reasonForCancellation => 'Reason for cancellation';

  @override
  String get emergencyPersonal => 'Emergency personal issue';

  @override
  String get healthIssue => 'Health / Medical unwell';

  @override
  String get toolsBreakdown => 'Tools / Vehicle breakdown';

  @override
  String get cannotReachCustomer => 'Unable to reach customer location';

  @override
  String get scheduleConflict => 'Schedule conflict';

  @override
  String get unsafeLocation => 'Report Unsafe Location';

  @override
  String get incorrectJobDetails => 'Incorrect job details';

  @override
  String get keepJob => 'Keep Job';

  @override
  String get confirmCancel => 'Confirm Cancel';

  @override
  String get jobCancelled => 'JOB CANCELLED';

  @override
  String get cancelledBy => 'Cancelled by';

  @override
  String get penalty => 'Penalty/Fee';

  @override
  String get customerNotified => 'Customer notified';

  @override
  String get newServiceRequest => 'New Service Request';

  @override
  String get reportedProblem => 'Reported Problem';

  @override
  String get requestedDate => 'Requested Date';

  @override
  String get requestedTime => 'Requested Time';

  @override
  String get estimatedDuration => 'Estimated Duration';

  @override
  String get distance => 'Distance';

  @override
  String get location => 'Location';

  @override
  String get onsiteRequired => 'Onsite Required';

  @override
  String get onsiteFee => 'Onsite Fee';

  @override
  String get scheduleCompatibility => 'Schedule Compatibility';

  @override
  String get decline => 'DECLINE';

  @override
  String get accept => 'ACCEPT';

  @override
  String get cannotAccept => 'CANNOT ACCEPT THIS REQUEST';

  @override
  String get waitingForCustomer => 'Waiting for Customer Selection';

  @override
  String get candidateStatus => 'Your candidate status is pending';

  @override
  String get selectionExpiry => 'Selection expires in';

  @override
  String get customerSelectedYou => 'CUSTOMER SELECTED YOU ✓';

  @override
  String get jobConfirmed => 'JOB CONFIRMED';

  @override
  String get confirmedJobDetails => 'Confirmed Job Details';

  @override
  String get reschedule => 'Reschedule';

  @override
  String get contactCustomer => 'Contact Customer';

  @override
  String get mapView => 'Map View';

  @override
  String get platformFee => 'Platform Fee';

  @override
  String get notes => 'Notes';

  @override
  String get reminderTitle => 'JOB STARTS IN 1 HOUR';

  @override
  String get liveJourneyTracking => 'Live Journey Tracking';

  @override
  String get enRouteTransit => 'EN ROUTE (TRANSIT)';

  @override
  String get telemetryActive => 'Tele-Telemetry Active';

  @override
  String get journeyProgress => 'JOURNEY PROGRESS';

  @override
  String stageOf(String current, String total) {
    return 'Stage $current of $total';
  }

  @override
  String get remaining => 'REMAINING';

  @override
  String get travelTime => 'TRAVEL TIME';

  @override
  String get targetEta => 'TARGET ETA';

  @override
  String get liveGpsActive => 'Live GPS Active';

  @override
  String gpsAccuracy(String meters) {
    return '±${meters}m accuracy';
  }

  @override
  String get syncedJustNow => 'Synced: Just now';

  @override
  String nextManeuver(String distance) {
    return 'NEXT MANEUVER IN $distance';
  }

  @override
  String get geoFencedCheckIn => 'Geo-Fenced Check-In';

  @override
  String get sosHelp => 'SOS HELP';

  @override
  String get iHaveArrived => 'I HAVE ARRIVED — VERIFY OTP';

  @override
  String get shiftReportingDuty => 'SHIFT REPORTING DUTY';

  @override
  String requiredBy(String time) {
    return 'Required by $time';
  }

  @override
  String aheadOfSchedule(String minutes) {
    return '${minutes}m Ahead of Schedule';
  }

  @override
  String get verifyArrival => 'Verify Arrival';

  @override
  String get arrivedAtSite => 'ARRIVED AT SITE';

  @override
  String get proximityConfirmed => 'Proximity Confirmed';

  @override
  String get attendancePasscode => 'Attendance Passcode';

  @override
  String get enterOtpAtLocation =>
      'Enter the OTP provided at the service location';

  @override
  String otpExpiresIn(String time) {
    return 'OTP expires in $time';
  }

  @override
  String get resendOtp => 'Resend OTP';

  @override
  String get verifyAndCheckIn => 'VERIFY & CHECK IN';

  @override
  String get verificationDetails => 'VERIFICATION DETAILS';

  @override
  String get locationDetected => 'LOCATION DETECTED';

  @override
  String get workerId => 'Worker ID';

  @override
  String get gpsAccuracyLabel => 'GPS Accuracy';

  @override
  String get highPrecision => 'High Precision';

  @override
  String get active => 'Active';

  @override
  String get currentGeoLocation => 'Current Geo-Location';

  @override
  String get arrivalTimestamp => 'Arrival Timestamp';

  @override
  String get needHelpPasscode => 'Need help with passcode?';

  @override
  String get callDutyCoordinator => 'Call Duty Coordinator';

  @override
  String get arrivalVerified => 'ARRIVAL VERIFIED';

  @override
  String get inspectionReady => 'INSPECTION READY';

  @override
  String get incorrectOtp => 'Incorrect OTP. Please try again.';

  @override
  String get otpExpired => 'OTP has expired. Please request a new one.';

  @override
  String get customerNotResponding => 'Customer Not Responding';

  @override
  String get callCustomer => 'Call';

  @override
  String get messageCustomer => 'Message';

  @override
  String get waitForCustomer => 'Wait';

  @override
  String get reportUnavailable => 'Report Customer Unavailable';

  @override
  String get inspectionDiagnosis => 'Inspection & Diagnosis';

  @override
  String get onSiteActive => 'ON-SITE ACTIVE';

  @override
  String get arrivalOtpVerified => 'Arrival OTP Verified';

  @override
  String get sequentialWorkflow => 'SEQUENTIAL WORKFLOW';

  @override
  String get otpCheck => 'OTP Check';

  @override
  String get inspection => 'Inspection';

  @override
  String get quotation => 'Quotation';

  @override
  String get approval => 'Approval';

  @override
  String get done => 'Done';

  @override
  String get activeNow => 'Active Now';

  @override
  String get locked => 'Locked';

  @override
  String get pricingLocked => 'Pricing Locked';

  @override
  String get physicalDiagnosis => 'Physical Diagnosis';

  @override
  String get customerReportedIssue => 'CUSTOMER REPORTED ISSUE';

  @override
  String get customerAttachedPhotos => 'Customer Attached Photos';

  @override
  String get viewFull => 'View Full';

  @override
  String get workerInspectionFindings => 'Worker Inspection Findings';

  @override
  String get editable => 'EDITABLE';

  @override
  String get observedDefect => 'Observed Physical Defect / Root Cause';

  @override
  String get diagnosisSeverity => 'Diagnosis Severity Level';

  @override
  String get lowDrip => 'Low (Drip)';

  @override
  String get activeLeak => 'Active Leak';

  @override
  String get shutoffUrgent => 'Shutoff Urgent';

  @override
  String get requiredAction => 'Required Technical Corrective Action';

  @override
  String get onSiteObservations => 'On-Site Observations & Pre-requisites';

  @override
  String get technicianPhotos => 'Technician Live Proof Photos';

  @override
  String get photosAttached => 'Attached';

  @override
  String get photoVerifyNote =>
      'These photos verify the pre-repair damaged state to avoid disputes before parts are dismantled.';

  @override
  String get completeInspection => 'COMPLETE INSPECTION →';

  @override
  String get completeInspectionNote =>
      'Completing inspection unlocks the Service Quotation phase without premature pricing.';

  @override
  String get nextUnlockQuotation =>
      'Next: Complete inspection to unlock quotation';

  @override
  String get inspectionPrerequisitesNote =>
      'Enter observed defect and attach at least 1 proof photo to unlock quotation.';

  @override
  String get quotationTitle => 'Quotation';

  @override
  String get inspectionCompleted => 'INSPECTION COMPLETED';

  @override
  String get onSiteService => 'ON-SITE SERVICE';

  @override
  String get customerProblemPhotos => 'CUSTOMER PROBLEM PHOTOS';

  @override
  String get inspectionSummary => 'INSPECTION SUMMARY';

  @override
  String get customerReportedProblem => 'CUSTOMER REPORTED PROBLEM';

  @override
  String get workerDiagnosis => 'WORKER DIAGNOSIS';

  @override
  String get recommendedSolution => 'RECOMMENDED SOLUTION';

  @override
  String get workerInspectionPhotos => 'WORKER INSPECTION PHOTOS';

  @override
  String get verifiedOnSite => 'Verified On-Site';

  @override
  String get serviceQuotation => 'SERVICE QUOTATION';

  @override
  String get labourServiceCharge => 'Labour / Service Charge';

  @override
  String get workerEditable => 'Worker Editable';

  @override
  String get materialCostItemized => 'Material Cost (Itemized)';

  @override
  String get addMaterial => 'Add Material';

  @override
  String get otherServiceCharges => 'Other Service Charges';

  @override
  String get serviceSubtotal => 'SERVICE SUBTOTAL';

  @override
  String platformFeePercent(String percent) {
    return 'Platform Fee ($percent%)';
  }

  @override
  String get autoCalculated => 'Auto-Calculated';

  @override
  String get totalServiceQuotation => 'TOTAL SERVICE QUOTATION';

  @override
  String get customerServiceTotal => 'Customer Service Total';

  @override
  String get readyForApproval => 'Ready for Customer Approval';

  @override
  String platformFeeNote(String percent, String amount) {
    return '$percent% of $amount Service Subtotal • Added to customer payment';
  }

  @override
  String get quotationStatus => 'Quotation Status';

  @override
  String get waitingForApproval => 'WAITING FOR CUSTOMER APPROVAL';

  @override
  String get ifApproved => 'If Approved:';

  @override
  String get ifRejected => 'If Rejected:';

  @override
  String get sendQuotation => 'SEND QUOTATION';

  @override
  String get quotationApproved => 'QUOTATION APPROVED ✓';

  @override
  String get quotationNotApproved => 'QUOTATION NOT APPROVED';

  @override
  String get rejectionReason => 'Rejection reason';

  @override
  String get startService => 'START SERVICE';

  @override
  String get serviceCompletion => 'Service Completion';

  @override
  String get workCompleted => 'WORK COMPLETED';

  @override
  String get onSiteVerified => 'ON-SITE VERIFIED';

  @override
  String get serviceSummary => 'Service Summary';

  @override
  String get problemAddressed => 'Problem Addressed';

  @override
  String get workPerformed => 'Work Performed';

  @override
  String get completionNotes => 'Completion Notes';

  @override
  String get proofOfWork => 'Proof of Work';

  @override
  String get beforeVsAfter => 'Before vs After verification';

  @override
  String get verifiedByTech => 'Verified by Tech';

  @override
  String get addPhotoTestProof => '+ Add Additional Photo / Test Proof';

  @override
  String get finalServiceCost => 'Final Service Cost';

  @override
  String get labourServiceChargeLabel => 'Labour / Service Charge';

  @override
  String get materialCost => 'Material Cost';

  @override
  String get otherCharges => 'Other Applicable Service Charges';

  @override
  String get serviceSubtotalLabel => 'Service Subtotal';

  @override
  String get cooperativePlatformFee => 'Cooperative Platform Fee';

  @override
  String get finalServiceAmount => 'FINAL SERVICE AMOUNT';

  @override
  String get quotationMatched => 'Quotation Matched';

  @override
  String get materialBillProof => 'MATERIAL & BILL PROOF';

  @override
  String itemsVerified(String count) {
    return '$count Items Verified';
  }

  @override
  String get billAttached => 'BILL ATTACHED';

  @override
  String get takeBillPhoto => 'Take Bill Photo';

  @override
  String get uploadReceipt => 'Upload Receipt';

  @override
  String get addMaterialBill => '+ Add Additional Material / Bill';

  @override
  String get verifiedMaterialCost => 'Verified Material Cost';

  @override
  String get materialBillNote =>
      'Material bill photos are attached as proof of actual material cost. They verify expenditures and do not add any extra charges.';

  @override
  String get paymentStatus => 'Payment Status';

  @override
  String get awaitingPayment => 'AWAITING PAYMENT';

  @override
  String get customerPaymentPayable => 'Customer Payment Payable';

  @override
  String get paymentModeOptions => 'Payment Mode Options / Status';

  @override
  String get paymentPromptNote =>
      'Customer prompted via App / Cash or UPI to Cooperative Escrow.';

  @override
  String get waitingForPayment =>
      'Waiting for customer to confirm payment on their app';

  @override
  String get refresh => 'Refresh';

  @override
  String get confirmPayment => 'CONFIRM PAYMENT';

  @override
  String get requestPayment => 'REQUEST PAYMENT';

  @override
  String get invoiceDetails => 'Invoice Details';

  @override
  String get taxInvoice => 'TAX INVOICE';

  @override
  String get originalForRecipient => 'ORIGINAL FOR RECIPIENT';

  @override
  String get paid => 'PAID';

  @override
  String get verifiedReceipt => 'Verified Cooperative Digital Receipt';

  @override
  String paidOn(String date, String time) {
    return 'Paid on $date at $time';
  }

  @override
  String get gstinActive => 'GSTIN ACTIVE';

  @override
  String get billedTo => 'Billed To (Customer)';

  @override
  String get fulfilledBy => 'Fulfilled By';

  @override
  String get licensedTrade => 'Licensed Field Plumbing Tech';

  @override
  String get cooperativeNode => 'Cooperative Node';

  @override
  String get jobSpecification => 'JOB SPECIFICATION';

  @override
  String get completedAt => 'Completed at';

  @override
  String get billingBreakdown => 'Billing Breakdown';

  @override
  String get currencyInr => 'CURRENCY: INR (₹)';

  @override
  String get totalPaid => 'TOTAL PAID (INCL. TAXES)';

  @override
  String get settledInFull => 'Settled in Full';

  @override
  String get clearBillingPolicy => 'Clear Billing Policy';

  @override
  String get transactionRecord => 'Transaction Record';

  @override
  String get paymentSuccessful => 'Payment Successful';

  @override
  String get paymentMethod => 'Payment Method';

  @override
  String get transactionId => 'Transaction ID';

  @override
  String get bankUtrReference => 'Bank UTR Reference';

  @override
  String get transactionTimestamp => 'Transaction Timestamp';

  @override
  String get serviceInfoScope => 'Service Information & Scope';

  @override
  String get reportedIssue => 'REPORTED ISSUE';

  @override
  String get technicalWork => 'TECHNICAL WORK PERFORMED';

  @override
  String get materialsVerified => 'MATERIALS VERIFIED & INSTALLED';

  @override
  String get proofOfServiceLabel => 'Proof of Service';

  @override
  String photosVerified(String count) {
    return '$count PHOTOS VERIFIED';
  }

  @override
  String get downloadInvoice => 'DOWNLOAD INVOICE';

  @override
  String get viewServiceHistory => 'View Full Service History & Diagnostics';

  @override
  String get shareInvoice => 'Share';

  @override
  String get printInvoice => 'Print';

  @override
  String get jobCompleted => 'JOB COMPLETED ✓';

  @override
  String get completionTime => 'Completion Time';

  @override
  String get finalAmount => 'Final Amount';

  @override
  String get invoiceNumber => 'Invoice Number';

  @override
  String get thankYou =>
      'Thank you for using the cooperative service platform.';

  @override
  String get warrantyNote =>
      'For warranty claims or queries, please reference Job';

  @override
  String get ratingTitle => 'Rate This Service';

  @override
  String get ratingSubtitle => 'Your feedback helps improve worker quality';

  @override
  String get starRating => 'Star Rating';

  @override
  String get feedbackPlaceholder => 'Share your feedback (optional)';

  @override
  String get submitRating => 'SUBMIT RATING & CLOSE';

  @override
  String get jobHistory => 'Job History';

  @override
  String get all => 'All';

  @override
  String get filterCompleted => 'Completed';

  @override
  String get filterCancelled => 'Cancelled';

  @override
  String get filterRejected => 'Rejected';

  @override
  String get filterInProgress => 'In Progress';

  @override
  String get service => 'Service';

  @override
  String get date => 'Date';

  @override
  String get amount => 'Amount';

  @override
  String get status => 'Status';

  @override
  String get earningsTitle => 'Earnings & Settlements';

  @override
  String get today => 'Today';

  @override
  String get weekly => 'Weekly';

  @override
  String get monthly => 'Monthly';

  @override
  String get financialYear => 'Financial Year';

  @override
  String get serviceEarnings => 'Service / Labour';

  @override
  String get onsiteEarnings => 'On-site Visit Fees';

  @override
  String get reimbursements => 'Reimbursements';

  @override
  String get bonuses => 'Performance Bonus';

  @override
  String get deductions => 'TDS / Cooperative Fee';

  @override
  String get pendingEarnings => 'Pending Payout';

  @override
  String get settledEarnings => 'Settled Payout';

  @override
  String get settlementTitle => 'Settlements';

  @override
  String get pendingSettlement => 'Pending Settlement';

  @override
  String get includedJobs => 'Included Jobs';

  @override
  String get expectedSettlement => 'Expected Settlement';

  @override
  String get settlementMethod => 'Settlement Method';

  @override
  String get settlementHistory => 'Settlement History';

  @override
  String get settlementId => 'Settlement ID';

  @override
  String get notificationsTitle => 'Notifications';

  @override
  String unread(String count) {
    return 'Unread';
  }

  @override
  String get markRead => 'Mark read';

  @override
  String get justNow => 'Just now';

  @override
  String minutesAgo(String count) {
    return '${count}m ago';
  }

  @override
  String hoursAgo(String count) {
    return '${count}h ago';
  }

  @override
  String get myProfile => 'My Profile';

  @override
  String get workerIdentity => 'Worker Identity & Credentials';

  @override
  String get cooperativeTier => 'Cooperative Tier';

  @override
  String get onTimeRate => '100% On-time';

  @override
  String get clientSide => 'Client side';

  @override
  String get thisFy => 'This FY';

  @override
  String topPercent(String percent) {
    return 'Top $percent%';
  }

  @override
  String get settlementThreshold => 'Settlement Threshold Alert';

  @override
  String get jobDispatchGateRule => 'Job Dispatch Gate Rule';

  @override
  String get newRequestsPaused => 'NEW REQUESTS PAUSED';

  @override
  String get thresholdReachedMsg =>
      'Settlement threshold reached. New job requests are paused until settlement is processed.';

  @override
  String get pendingSettlementLabel => 'PENDING SETTLEMENT';

  @override
  String get policyThreshold => 'POLICY THRESHOLD';

  @override
  String get autoHoldTrigger => 'Auto-hold trigger';

  @override
  String get settlementStatus => 'Settlement Status';

  @override
  String get processing => 'Processing';

  @override
  String get expectedSettlementTime => 'Expected Settlement';

  @override
  String get lastSettlement => 'Last Settlement';

  @override
  String get skills => 'Skills';

  @override
  String get certifications => 'Certifications';

  @override
  String get performance => 'Performance';

  @override
  String get documents => 'Documents';

  @override
  String get availability => 'Availability';

  @override
  String get paymentDetails => 'Payment Details';

  @override
  String get settings => 'Settings';

  @override
  String get language => 'Language';

  @override
  String get support => 'Support';

  @override
  String get logout => 'Logout';

  @override
  String get logoutConfirm => 'Are you sure you want to log out?';

  @override
  String get yes => 'Yes';

  @override
  String get no => 'No';

  @override
  String get availabilityTitle => 'Worker Availability';

  @override
  String get activeStatus => 'ACTIVE';

  @override
  String get inactiveStatus => 'INACTIVE';

  @override
  String get busyStatus => 'BUSY';

  @override
  String get workingHours => 'Working Hours';

  @override
  String get serviceAvailability => 'Service Availability';

  @override
  String get scheduleTitle => 'Worker Schedule';

  @override
  String get calendar => 'Calendar';

  @override
  String get upcomingJobs => 'Upcoming Jobs';

  @override
  String get completedJobs => 'Completed Jobs';

  @override
  String get blockedTimes => 'Blocked Times';

  @override
  String get rescheduleTitle => 'Reschedule Appointment';

  @override
  String get currentAppointment => 'Current Appointment';

  @override
  String get selectNewTime => 'Select New Time';

  @override
  String get reason => 'Reason';

  @override
  String get customerApproval => 'Customer Approval';

  @override
  String get rescheduleRequested => 'Reschedule Requested';

  @override
  String get rescheduleWaiting => 'Waiting for Approval';

  @override
  String get rescheduleApproved => 'Reschedule Approved';

  @override
  String get rescheduleRejected => 'Reschedule Rejected';

  @override
  String get coursesTraining => 'Courses & Training';

  @override
  String get improveSkills => 'Improve your skills & earn new certifications';

  @override
  String get enrolled => 'Enrolled';

  @override
  String get total => 'Total';

  @override
  String get finished => 'Finished';

  @override
  String get certificates => 'Certificates';

  @override
  String get recommended => 'Recommended';

  @override
  String get mandatory => 'Mandatory';

  @override
  String get advanced => 'Advanced';

  @override
  String get courseDetails => 'Course Details';

  @override
  String get enrollNow => 'Enroll Now';

  @override
  String get continueTraining => 'Continue Training';

  @override
  String get viewCertificate => 'View Certificate';

  @override
  String get progress => 'Progress';

  @override
  String get lessons => 'Lessons';

  @override
  String get duration => 'Duration';

  @override
  String get certificate => 'Certificate';

  @override
  String get schemesWelfare => 'Schemes & Welfare';

  @override
  String get benefitsProtection => 'Benefits, protection & cooperative support';

  @override
  String get available => 'Available';

  @override
  String get explore => 'Explore';

  @override
  String get eligible => 'Eligible';

  @override
  String get valid => '100% Valid';

  @override
  String get applied => 'Applied';

  @override
  String get inReview => 'In Review';

  @override
  String get approved => 'Approved';

  @override
  String get activeCare => 'Active Care';

  @override
  String get insurance => 'INSURANCE';

  @override
  String get welfare => 'WELFARE';

  @override
  String get pension => 'PENSION';

  @override
  String get training => 'TRAINING';

  @override
  String get schemeDetails => 'Scheme Details';

  @override
  String get eligibility => 'Eligibility';

  @override
  String get applyNow => 'Apply Now';

  @override
  String get applicationSubmitted => 'Application Submitted';

  @override
  String get applicationApproved => 'Application Approved';

  @override
  String get applicationRejected => 'Application Rejected';

  @override
  String get supportTitle => 'Help & Support';

  @override
  String get helpCenter => 'Help Center';

  @override
  String get faq => 'FAQ';

  @override
  String get contactSupportAction => 'Contact Support';

  @override
  String get paymentIssue => 'Payment Issue';

  @override
  String get jobDispute => 'Job Scope Dispute';

  @override
  String get technicalIssue => 'Technical Issue';

  @override
  String get customerIssue => 'Customer Issue';

  @override
  String get unsafeLocationReport => 'Unsafe Location';

  @override
  String get sosTitle => 'Emergency SOS';

  @override
  String get emergencyAssistance => 'Emergency Assistance';

  @override
  String get callEmergencyServices => 'Call Emergency Services';

  @override
  String get cooperativeSupport => 'Cooperative Support';

  @override
  String get shareLiveLocation => 'Share Live GPS Location';

  @override
  String get securitySettings => 'Security Settings';

  @override
  String get changePassword => 'Change Password';

  @override
  String get biometricLogin => 'Biometric Login';

  @override
  String get sessionManagement => 'Session / Device Management';

  @override
  String get accountLockInfo => 'Account Lock Information';

  @override
  String get locationPermTitle => 'Location Permission Required';

  @override
  String get locationPermMsg =>
      'Location access is required for journey tracking, arrival verification, customer safety, and service verification.';

  @override
  String get cameraPermTitle => 'Camera Access Required';

  @override
  String get cameraPermMsg =>
      'Camera access is required for inspection photos, material proof, before/after evidence, and service documentation.';

  @override
  String get notifPermTitle => 'Notification Permission';

  @override
  String get notifPermMsg =>
      'Notifications are needed for new job alerts, customer selection updates, reminders, quotation results, and payment updates.';

  @override
  String get allow => 'Allow';

  @override
  String get notNow => 'Not Now';

  @override
  String get noRequests => 'No new requests at the moment';

  @override
  String get noUpcomingJobs => 'No upcoming jobs for this date';

  @override
  String get noActiveJob => 'No active job right now';

  @override
  String get noCompletedJobs => 'No completed jobs yet';

  @override
  String get noNotifications => 'No notifications available';

  @override
  String get noCourses => 'No courses available';

  @override
  String get noSchemes => 'No schemes available';

  @override
  String get noEarnings => 'No earnings recorded yet';

  @override
  String get noSettlements => 'No settlements to show';

  @override
  String get errorServerUnavailable =>
      'Server is temporarily unavailable. Please try again later.';

  @override
  String get errorNetworkUnavailable =>
      'No internet connection. Please check your network settings.';

  @override
  String get errorApiFailure => 'Something went wrong. Please try again.';

  @override
  String get errorTimeout => 'Request timed out. Please try again.';

  @override
  String get errorInvalidOtp => 'Invalid OTP. Please check and try again.';

  @override
  String get errorExpiredOtp => 'OTP has expired. Please request a new one.';

  @override
  String get errorPaymentFailed =>
      'Payment failed. Please try again or use an alternate payment method.';

  @override
  String get errorUploadFailed =>
      'Upload failed. Please check your connection and try again.';

  @override
  String get errorGpsUnavailable =>
      'GPS signal is not available. Please enable location services.';

  @override
  String get errorPermissionDenied =>
      'Permission denied. This feature requires the requested permission.';

  @override
  String get errorGeofenceFailed =>
      'Geofence verification failed. Please ensure you are at the correct location.';

  @override
  String get errorSessionExpired =>
      'Your session has expired. Please login again.';

  @override
  String get retry => 'Retry';

  @override
  String get tryAgain => 'Try Again';

  @override
  String get goBack => 'Go Back';

  @override
  String get paymentPending => 'Payment Pending';

  @override
  String get paymentProcessing => 'PAYMENT PROCESSING';

  @override
  String get paymentCompleted => 'Payment Completed';

  @override
  String get paymentFailed => 'PAYMENT FAILED';

  @override
  String get partialPayment => 'Partial Payment';

  @override
  String get received => 'Received';

  @override
  String get remainingAmount => 'Remaining';

  @override
  String get retryPayment => 'Retry Payment';

  @override
  String get alternatePayment => 'Alternate Payment Method';

  @override
  String get gpsWeak => 'GPS signal is weak';

  @override
  String get gpsSearching => 'Searching for GPS signal...';

  @override
  String get gpsFixed => 'GPS signal acquired';

  @override
  String get offline => 'You are offline';

  @override
  String get syncing => 'Syncing...';

  @override
  String get reconnecting => 'Reconnecting...';

  @override
  String get failedAction => 'Action failed. Will retry when connected.';

  @override
  String get mins => 'mins';

  @override
  String get km => 'km';

  @override
  String get hrs => 'hrs';

  @override
  String get items => 'items';

  @override
  String get rupeeSymbol => '₹';

  @override
  String get confirmAction => 'Confirm';

  @override
  String get cancelAction => 'Cancel';

  @override
  String get save => 'Save';

  @override
  String get edit => 'Edit';

  @override
  String get delete => 'Delete';

  @override
  String get close => 'Close';

  @override
  String get next => 'Next';

  @override
  String get back => 'Back';

  @override
  String get submit => 'Submit';

  @override
  String get apply => 'Apply';

  @override
  String get view => 'View';

  @override
  String get download => 'Download';

  @override
  String get share => 'Share';

  @override
  String get search => 'Search';

  @override
  String get filter => 'Filter';

  @override
  String get sortBy => 'Sort by';

  @override
  String get clearAll => 'Clear All';

  @override
  String get seeAll => 'See All';

  @override
  String get loadMore => 'Load More';

  @override
  String get ok => 'OK';

  @override
  String get newRequestBadge => 'NEW REQUEST';

  @override
  String get verifiedClient => 'Verified Client';

  @override
  String memberSince(String year, String count) {
    return 'Member since $year • $count completed services';
  }

  @override
  String viewAllPhotos(String count) {
    return 'View All Photos ($count)';
  }

  @override
  String get photoTapToView => 'Tap to view';

  @override
  String get photoDisambiguationNote =>
      'Customer pre-visit photos help assess tools & spare parts. Worker inspection photos are recorded separately after arrival & OTP verification.';

  @override
  String get scheduleLogistics => 'Schedule & Logistics';

  @override
  String travelTimeApprox(String minutes) {
    return '~$minutes mins travel time';
  }

  @override
  String get editFee => 'Edit Fee';

  @override
  String youReceiveFullPayout(String amount) {
    return 'You Receive: $amount (100% Payout)';
  }

  @override
  String get totalCustomerPays => 'Total Customer Pays';

  @override
  String get guaranteedPayoutNote =>
      'Your visit fee is credited even if the customer doesn\'t proceed after inspection.';

  @override
  String get customerInstructionsTitle => 'Customer Instructions';

  @override
  String get jobAcceptedWaitingNote =>
      'Waiting for customer confirmation & selection.';

  @override
  String get conflictExplanation =>
      'This request could not be validated against your current schedule, working hours, or service zone.';

  @override
  String get institutionAssignment => 'INSTITUTION ASSIGNMENT';

  @override
  String get customerJobRequest => 'CUSTOMER JOB REQUEST';

  @override
  String get viaMainRoad => 'Via main road (Traffic flowing normally)';

  @override
  String askCustomerForOtp(String name) {
    return 'Ask $name for the 6-digit code sent to their registered mobile.';
  }

  @override
  String otpAttemptsLeft(String count) {
    return '$count attempts left';
  }

  @override
  String get verifyAndStartService => 'VERIFY & START SERVICE';

  @override
  String get strictProgressiveDisclosure => 'Strict Progressive Disclosure';

  @override
  String get inspectionFindingsSubtitle =>
      'Official technical diagnosis at location';

  @override
  String uploadedPriorToArrival(String name) {
    return 'Uploaded by $name prior to technician arrival';
  }

  @override
  String get takeCameraShot => 'Take Camera Shot';

  @override
  String get uploadFile => 'Upload File';

  @override
  String get addPhoto => 'Add Photo';

  @override
  String maxPhotosNote(String count) {
    return '(Max $count)';
  }

  @override
  String get removePhoto => 'Remove photo';

  @override
  String get quotationBuilder => 'Quotation Builder';

  @override
  String get quotationPreview => 'Quotation Preview';

  @override
  String get quotationSent => 'Quotation Sent';

  @override
  String get createdAfterDiagnosis =>
      'Created after technical on-site diagnosis';

  @override
  String get labourDescription => 'Service description';

  @override
  String get labourEstimate => 'Estimated duration: 45 – 60 mins';

  @override
  String get materialName => 'Material name';

  @override
  String get materialQty => 'Qty';

  @override
  String get materialUnit => 'unit';

  @override
  String get materialUnitPrice => 'Unit price';

  @override
  String materialSubtotal(String count) {
    return 'Material Subtotal ($count items)';
  }

  @override
  String get otherChargesHint =>
      'Debris disposal, specialized tools (Optional)';

  @override
  String get serviceSubtotalBreakdown => 'Service Subtotal Breakdown:';

  @override
  String get platformFeePolicy =>
      'Platform fee is added separately to the service quotation. On-site visit charges are handled separately and are not included in this quotation.';

  @override
  String get quotationNotes => 'Quotation Notes';

  @override
  String get quotationNotesHint => 'Add any notes for the customer (optional)';

  @override
  String get quotationValidity => 'Valid for 24 hours from time of submission';

  @override
  String sendQuotationAmount(String amount) {
    return 'SEND QUOTATION — $amount';
  }

  @override
  String get digitalPushNote =>
      'Prompt digital push sent directly to customer\'s app';

  @override
  String quotationWaitingMsg(String name, String amount) {
    return 'Customer $name will receive this itemized quotation of $amount on their mobile app for immediate one-tap review and digital authorization.';
  }

  @override
  String get approvedAction =>
      'Tap \"START SERVICE\" to begin the repair work.';

  @override
  String get rejectedAction =>
      'Job closure handled according to standard cooperative policy.';

  @override
  String get paymentAfterApproval =>
      'Payment & invoice will generate strictly after quotation is approved and physical service is completed.';

  @override
  String get quotationAmount => 'Service Quotation Amount:';

  @override
  String get previewQuotation => 'PREVIEW QUOTATION';

  @override
  String get confirmAndSend => 'CONFIRM & SEND QUOTATION';

  @override
  String get quotationSentSuccess => 'Quotation sent successfully to customer';

  @override
  String get backToHome => 'BACK TO HOME';

  @override
  String get removeMaterial => 'Remove material';

  @override
  String get inr => 'INR (₹)';

  @override
  String get labourChargeAmount => 'Labour charge amount';

  @override
  String get otherChargesAmount => 'Other charges amount';

  @override
  String get quotationSentWaiting =>
      'Your quotation has been sent. Waiting for customer response.';

  @override
  String get customerAccepted => 'CUSTOMER ACCEPTED';

  @override
  String get customerRejected => 'CUSTOMER REJECTED';

  @override
  String get quotationAcceptedMsg =>
      'Customer has approved your quotation. You can now start the service.';

  @override
  String get quotationRejectedMsg =>
      'Customer has declined the quotation. Job will be closed per cooperative policy.';

  @override
  String get serviceExecution => 'Service Execution';

  @override
  String get workInProgress => 'WORK IN PROGRESS';

  @override
  String get addProofPhoto => '+ Add Additional Photo / Test Proof';

  @override
  String get materialAndBillProof => 'Material & Bill Proof';

  @override
  String get viewBill => 'View';

  @override
  String get replaceBill => 'Replace';

  @override
  String get materialProofNote =>
      'Material bill photos are attached as proof of actual material cost. They verify expenditure and do not add any extra charges.';

  @override
  String get completeService => 'COMPLETE SERVICE';

  @override
  String get paymentSuccess => 'PAYMENT SUCCESSFUL';

  @override
  String get bankUtr => 'Bank UTR Reference';

  @override
  String get timestamp => 'Timestamp';

  @override
  String get shareOrPrint => 'Share / Print';

  @override
  String get ratingFeedback => 'Rating & Feedback';

  @override
  String get rateCustomer => 'Rate Customer Experience';

  @override
  String get jobCompletedSuccess => 'Job Completed Successfully!';

  @override
  String get viewInvoice => 'VIEW INVOICE';

  @override
  String get cleanWorkArea => 'Clean Work Area & Handover';

  @override
  String get customerInstructionFollowed =>
      'Customer instructions adhered to during repair';

  @override
  String get todayEarnings => 'Today';

  @override
  String get weekEarnings => 'This Week';

  @override
  String get monthEarnings => 'This Month';

  @override
  String get fyEarnings => 'Financial Year';

  @override
  String get materialReimbursements => 'Material Reimbursement';

  @override
  String get settlementDate => 'Settlement Date';

  @override
  String get settlementAmount => 'Amount';

  @override
  String get settledToBank => 'Settled to Bank Account';

  @override
  String get inEscrow => 'In Escrow';

  @override
  String get transactions => 'Transactions';

  @override
  String get reportDelayTitle => 'Report Dispatch Delay';

  @override
  String get delayExpectedTime => 'Expected Delay Time';

  @override
  String get min15 => '+15 Mins';

  @override
  String get min30 => '+30 Mins';

  @override
  String get min45 => '+45 Mins';

  @override
  String get customTime => 'Custom';

  @override
  String get selectDelayReason => 'Select Delay Reason';

  @override
  String get trafficCongestion => 'Heavy traffic on route';

  @override
  String get prevJobLate => 'Previous client job running late';

  @override
  String get vehicleIssue => 'Vehicle / transit breakdown';

  @override
  String get partsPickup => 'Picking up required spare parts';

  @override
  String get weatherDelay => 'Severe weather disruption';

  @override
  String get emergencyDelay => 'Personal / family emergency';

  @override
  String get notifyDelay => 'Notify Customer of Delay';

  @override
  String get delayReportedSuccess =>
      'Delay reported. Customer has been notified.';

  @override
  String get cancelAssignmentTitle => 'Cancel This Assignment?';

  @override
  String get cancelWarning =>
      'Are you sure you want to cancel? Cancelling within 1 hour impacts your worker response score.';

  @override
  String get cancelReasonLabel => 'Reason for cancellation';

  @override
  String get reasonConflict => 'Schedule conflict';

  @override
  String get reasonEmergency => 'Emergency / family urgency';

  @override
  String get reasonVehicle => 'Vehicle / transit problem';

  @override
  String get reasonCustomerUnavailable => 'Customer unavailable at site';

  @override
  String get reasonUnsafeLocation => 'Unsafe / inaccessible location';

  @override
  String get reasonIncorrectJob => 'Incorrect job details / scope mismatch';

  @override
  String get reasonOther => 'Other reason';

  @override
  String get jobCancelledLogged => 'Job Cancelled';

  @override
  String get cancelNotificationSent =>
      'Customer & cooperative dispatch have been notified.';

  @override
  String get logged => 'Logged';

  @override
  String get selectNewSlot => 'Select New Date & Time';

  @override
  String get rescheduleReason => 'Reason for Reschedule';

  @override
  String get requestCustomerApproval => 'Request Customer Approval';

  @override
  String get rescheduleStatusRequested => 'Requested';

  @override
  String get rescheduleStatusWaiting => 'Waiting for Customer';

  @override
  String get rescheduleStatusApproved => 'Approved';

  @override
  String get rescheduleStatusRejected => 'Declined';

  @override
  String get rescheduleSuccess => 'Reschedule request sent to customer';

  @override
  String get customerUnavailableTitle => 'Customer Unavailable at Site';

  @override
  String get stepCallCustomer => 'Call Customer';

  @override
  String get stepSendMessage => 'Send In-App Message';

  @override
  String get stepWaitTimer => 'Waiting Protocol Timer';

  @override
  String get stepArrivalEvidence => 'Verify GPS Arrival Evidence';

  @override
  String get claimOnsiteFee => 'Claim Guaranteed Onsite Fee (₹150)';

  @override
  String get recordUnavailable => 'Report Customer Unavailable & Close';

  @override
  String get unavailableLogged =>
      'Customer unavailable logged. ₹150 onsite fee credited to your pending settlement.';

  @override
  String get callNow => 'Call Now';

  @override
  String get messageNow => 'Send Message';

  @override
  String get waitingRemaining => '10:00 Waiting Time Remaining';

  @override
  String get markAllRead => 'Mark read';

  @override
  String get filterAll => 'All';

  @override
  String get filterCustomer => 'Customer';

  @override
  String get filterInstitution => 'Institution';

  @override
  String get filterSystem => 'System';

  @override
  String get workerCredentials => 'Worker Identity & Credentials';

  @override
  String get completedStat => 'Completed';

  @override
  String get cancelledStat => 'Cancelled';

  @override
  String get earningsStat => 'Earnings';

  @override
  String get ratingStat => 'Rating';

  @override
  String get skillsAndCertifications => 'Skills & Certifications';

  @override
  String get accountQuickLinks => 'Account & Work Settings';

  @override
  String get workerSchedule => 'Worker Schedule';

  @override
  String get availabilityStatus => 'Availability Status';

  @override
  String get bankAndPayouts => 'Bank & Payout Accounts';

  @override
  String get documentsKyc => 'Documents & KYC Verification';

  @override
  String get settingsTitle => 'Settings';

  @override
  String get helpAndSupport => 'Help & Support';

  @override
  String get emergencySos => 'Emergency SOS';

  @override
  String get statusActive => 'ACTIVE';

  @override
  String get statusInactive => 'INACTIVE';

  @override
  String get statusBusy => 'BUSY';

  @override
  String get statusPaused => 'REQUESTS PAUSED';

  @override
  String get workHours => 'Working Hours';

  @override
  String get upcomingAppointments => 'Upcoming Appointments';

  @override
  String get blockedTime => 'Blocked Time Slots';

  @override
  String get appPreferences => 'App Preferences';

  @override
  String get pushNotifications => 'Push Notifications';

  @override
  String get smsAlerts => 'SMS Alerts';

  @override
  String get locationServices => 'Location Services (Always Allow)';

  @override
  String get cameraPermission => 'Camera & Media Access';

  @override
  String get cooperativeHelpline => 'Cooperative Helpline';

  @override
  String get emergencySosTitle => 'Emergency SOS';

  @override
  String get call112 => 'National Emergency Services (112)';

  @override
  String get callDispatch => 'Cooperative Emergency Dispatch';

  @override
  String get faqTitle => 'Frequently Asked Questions';

  @override
  String get paymentDispute => 'Payment Dispute';

  @override
  String get sosAlertSent =>
      'SOS alert & current location dispatched to cooperative control center.';

  @override
  String get institutionDashboard => 'Institution Assignments';

  @override
  String get shiftHours => 'Shift Hours';

  @override
  String get fixedDuty => '8h Fixed Duty';

  @override
  String get guaranteedPay => 'Guaranteed Pay';

  @override
  String get directEscrow => 'Direct Escrow';

  @override
  String get peerRoster => 'Peer Roster';

  @override
  String get allDispatched => 'All Dispatched';

  @override
  String get liveDeployment => 'Live Deployment';

  @override
  String get stageAssigned => 'Assigned';

  @override
  String get stageJourney => 'Journey';

  @override
  String get stageEnRoute => 'En Route';

  @override
  String get stageArrived => 'Arrived';

  @override
  String get stageToolInspection => 'Tool Check';

  @override
  String get stageServiceWork => 'Service Work';

  @override
  String get stageSupervisorSignoff => 'Sign-off';

  @override
  String get stageCompleted => 'Completed';

  @override
  String get siteSupervisor => 'Site Supervisor';

  @override
  String get equipmentChecklist => 'Equipment Checklist';

  @override
  String get allToolsVerified => 'All safety & sanitization equipment verified';

  @override
  String get coursesTitle => 'Training & Upskilling';

  @override
  String get certificatesEarned => 'Certificates';

  @override
  String get recommendedForYou => 'Recommended for You';

  @override
  String get technicalCourses => 'Technical';

  @override
  String get safetyCourses => 'Safety';

  @override
  String get startCourse => 'Start Course';

  @override
  String get resumeCourse => 'Resume';

  @override
  String get hours => 'hours';

  @override
  String get modules => 'modules';

  @override
  String get schemesTitle => 'Cooperative Welfare & Schemes';

  @override
  String get eligibleSchemes => 'Eligible';

  @override
  String get appliedSchemes => 'Applied';

  @override
  String get approvedSchemes => 'Approved';

  @override
  String get featuredScheme => 'Featured Scheme';

  @override
  String get viewStatus => 'View Status';

  @override
  String get coverage => 'Coverage';

  @override
  String get insuranceCategory => 'Insurance';

  @override
  String get welfareCategory => 'Welfare';

  @override
  String get financialCategory => 'Financial';

  @override
  String get noRequestsMsg => 'No new service requests available right now';

  @override
  String get networkErrorTitle => 'No Internet Connection';

  @override
  String get networkErrorMsg =>
      'Please check your mobile data or Wi-Fi connection and retry.';

  @override
  String get gpsErrorTitle => 'Location Permission Required';

  @override
  String get gpsErrorMsg =>
      'GPS access is required to track journeys and verify on-site arrival.';

  @override
  String get enableGps => 'Enable GPS';

  @override
  String get cameraErrorTitle => 'Camera Permission Required';

  @override
  String get cameraErrorMsg =>
      'Camera access is needed to capture inspection and bill proof photos.';

  @override
  String get grantPermission => 'Grant Permission';

  @override
  String get disputeTitle => 'Job Dispute Reported';

  @override
  String get disputeMsg =>
      'A dispute has been raised on this job. Cooperative support is reviewing the case.';

  @override
  String get cancellationReasonLabel => 'Reason';

  @override
  String get cancellationTimestampLabel => 'Timestamp';

  @override
  String get cancellationStatusLabel => 'Status';

  @override
  String get connectingSupportHotline =>
      'Connecting to Society Helpdesk Hotline...';

  @override
  String get callSupportNumber => 'Call 1800-425-9988';

  @override
  String get supportTicketCreated =>
      'Support ticket created successfully! Ticket #TKT-8421';

  @override
  String get logTicket => 'Log Ticket';

  @override
  String get telemetryDispatched => 'Live location telemetry dispatched!';

  @override
  String dialingNumber(String number) {
    return 'Dialing $number...';
  }

  @override
  String get activeCoverage => 'Active Coverage';

  @override
  String get viewHealthCardAndHospitals => 'View Health Card & Hospitals';

  @override
  String get schemeVerificationCard => 'Scheme Verification Card';

  @override
  String get policyNumberLabel => 'Cooperative Society Policy: COOP-MED-84920';

  @override
  String get policyStatusLabel => 'Status: Active • Auto-renewed annually';

  @override
  String get tpaHelplineLabel => 'TPA Helpline: 1800-22-9988';

  @override
  String get customerServicesTitle => 'Customer Services';

  @override
  String get customerServicesB2C => 'Customer Services (B2C)';

  @override
  String urgentCount(String count) {
    return '$count urgent';
  }

  @override
  String nextScheduledAt(String time) {
    return 'Next: $time';
  }

  @override
  String get thisMonth => 'This Month';

  @override
  String reviewsCount(String count) {
    return '($count reviews)';
  }

  @override
  String get jobInProgress => 'Job In Progress';

  @override
  String estFee(String amount) {
    return '₹$amount Est.';
  }

  @override
  String get jobDetailsAndBill => 'Job Details & Bill';

  @override
  String get mapNavigation => 'Map Navigation';

  @override
  String get incomingRequestsDirect => 'Incoming Requests (Direct)';

  @override
  String get yourProposedOnsiteFee => 'Your Proposed On-Site Fee:';

  @override
  String get setOnsiteFee => 'Set On-Site Fee:';

  @override
  String acceptWithFee(String amount) {
    return 'Accept with ₹$amount';
  }

  @override
  String get reviewAndProposeFee => 'Review & Propose Fee';

  @override
  String get confirmedVisitsNext24h => 'Confirmed Visits (Next 24h)';

  @override
  String remainingCount(String count) {
    return '$count Remaining';
  }

  @override
  String get fieldHelpSafetySos => 'Field Help & Safety SOS';

  @override
  String get directAgentResolutionLine => 'Direct 24/7 Agent Resolution Line';

  @override
  String get otpAlertDescription =>
      'Customer OTP verified. Please enter completion OTP before generating final invoice.';

  @override
  String viewAllCount(String count) {
    return 'View All ($count)';
  }

  @override
  String get confirmed => 'Confirmed';

  @override
  String get serviceCompletionOtpTitle => 'Service Completion OTP';

  @override
  String get serviceCompletionOtpSubtitle => 'Customer Service Sign-Off';

  @override
  String askCustomerForCompletionOtp(String customerName) {
    return 'Ask $customerName for the 4-digit completion OTP to verify satisfactory service.';
  }

  @override
  String get completionOtpVerified => 'Service Completion OTP Verified';

  @override
  String get proceedToPayment => 'PROCEED TO BILLING & PAYMENT';

  @override
  String get verifyEndOtpAndComplete => 'VERIFY END OTP & COMPLETE';

  @override
  String get signedOff => 'Signed Off';

  @override
  String get serviceCompletedProofAttached =>
      'Proof Photos Attached & Area Cleaned';
}
