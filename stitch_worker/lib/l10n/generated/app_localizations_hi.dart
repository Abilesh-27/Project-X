// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Hindi (`hi`).
class AppLocalizationsHi extends AppLocalizations {
  AppLocalizationsHi([String locale = 'hi']) : super(locale);

  @override
  String get appTitle => 'WORK SOLUTE';

  @override
  String get cooperativePlatform => 'सहकारी कार्यकर्ता मंच';

  @override
  String get verifiedFieldPortal => 'सत्यापित फील्ड कार्यबल पोर्टल';

  @override
  String get navHome => 'होम';

  @override
  String get navCustomer => 'ग्राहक';

  @override
  String get navInstitution => 'संस्थान';

  @override
  String get navCourses => 'पाठ्यक्रम';

  @override
  String get navSchemes => 'योजनाएँ';

  @override
  String get navProfile => 'प्रोफ़ाइल';

  @override
  String get loginTitle => 'कर्मचारी लॉगिन';

  @override
  String get loginSubtitle =>
      'अपने कार्य, असाइनमेंट और प्रत्यक्ष सहकारी भुगतान प्रबंधित करने के लिए साइन इन करें।';

  @override
  String get workerIdLabel => 'कर्मचारी आईडी';

  @override
  String get workerIdHint => 'उदा. WKR-2847';

  @override
  String get passwordLabel => 'पासवर्ड';

  @override
  String get forgotPassword => 'पासवर्ड भूल गए?';

  @override
  String get loginButton => 'लॉगिन';

  @override
  String get secureAccess => 'सुरक्षित कर्मचारी प्रवेश • 256-बिट एन्क्रिप्टेड';

  @override
  String get societyNote =>
      'अपनी सहकारी समिति द्वारा प्रदान किए गए क्रेडेंशियल्स का उपयोग करें।';

  @override
  String get langPersistNote =>
      'चुनी गई भाषा डैशबोर्ड, कोटेशन और योजनाओं पर लागू रहती है।';

  @override
  String get needHelp => 'साइन इन करने में सहायता चाहिए?';

  @override
  String get societyHelpdesk => 'समिति सहायता केंद्र';

  @override
  String get footerText => 'X को-ऑपरेटिव फेडरेशन लिमिटेड • संस्करण 2.4.0';

  @override
  String get selectLanguage => 'भाषा चुनें';

  @override
  String get langSubtitle => 'अपनी पसंदीदा भाषा चुनें';

  @override
  String get langPersistInfo =>
      'भाषा प्राथमिकता डैशबोर्ड, ग्राहक, कोटेशन, योजनाएँ और इनवॉइस स्क्रीन पर लागू रहती है।';

  @override
  String get verifyingCredentials => 'क्रेडेंशियल सत्यापित हो रहे हैं...';

  @override
  String get forgotPasswordTitle => 'पासवर्ड भूल गए';

  @override
  String get forgotPasswordSubtitle =>
      'सत्यापन OTP प्राप्त करने के लिए अपना कर्मचारी आईडी दर्ज करें।';

  @override
  String get sendOtp => 'OTP भेजें';

  @override
  String get enterOtp => 'OTP दर्ज करें';

  @override
  String get otpSentTo => 'आपके पंजीकृत मोबाइल नंबर पर OTP भेजा गया';

  @override
  String get newPassword => 'नया पासवर्ड';

  @override
  String get confirmPassword => 'पासवर्ड की पुष्टि करें';

  @override
  String get resetPassword => 'पासवर्ड रीसेट करें';

  @override
  String get passwordResetSuccess =>
      'पासवर्ड सफलतापूर्वक रीसेट किया गया! कृपया अपने नए पासवर्ड से लॉगिन करें।';

  @override
  String get accountLockedTitle => 'खाता लॉक';

  @override
  String get accountLockedMsg =>
      'कई बार गलत लॉगिन प्रयास के कारण आपका खाता अस्थायी रूप से लॉक कर दिया गया है। कृपया अपनी सहकारी समिति सहायता केंद्र से संपर्क करें।';

  @override
  String get sessionExpiredTitle => 'सत्र समाप्त';

  @override
  String get sessionExpiredMsg =>
      'आपका सत्र समाप्त हो गया है। जारी रखने के लिए कृपया फिर से लॉगिन करें।';

  @override
  String get reLogin => 'पुनः लॉगिन';

  @override
  String get contactSupport => 'सहायता से संपर्क करें';

  @override
  String get goodMorning => 'सुप्रभात';

  @override
  String get goodAfternoon => 'शुभ दोपहर';

  @override
  String get goodEvening => 'शुभ संध्या';

  @override
  String get verified => 'सत्यापित';

  @override
  String get activeDay => 'सक्रिय दिन';

  @override
  String get inactiveDay => 'निष्क्रिय दिन';

  @override
  String get onCall => 'ऑन-कॉल';

  @override
  String get readyToReceive => 'कार्य प्राप्त करने के लिए तैयार';

  @override
  String get requestsPaused => 'नए कार्य अनुरोध रुके हुए हैं';

  @override
  String serviceStartsIn(String time) {
    return '$time में सेवा शुरू';
  }

  @override
  String startsIn(String minutes) {
    return '$minutes मिनट में शुरू';
  }

  @override
  String customerJobId(String id) {
    return 'ग्राहक कार्य #$id';
  }

  @override
  String get scheduled => 'अनुसूचित';

  @override
  String get customer => 'ग्राहक';

  @override
  String get institution => 'संस्थान';

  @override
  String get startJourney => 'यात्रा शुरू करें';

  @override
  String get onTime => 'समय पर';

  @override
  String get delayed => 'विलंबित';

  @override
  String get cancel => 'रद्द करें';

  @override
  String get todaysLiveActivity => 'आज की लाइव गतिविधि';

  @override
  String get serviceInProgress => 'सेवा प्रगति पर';

  @override
  String get enRoute => 'रास्ते में';

  @override
  String get arrived => 'पहुँच गए';

  @override
  String get inProgress => 'प्रगति पर';

  @override
  String get completed => 'पूर्ण';

  @override
  String get openJob => 'कार्य खोलें';

  @override
  String get importantAlert => 'महत्वपूर्ण सूचना';

  @override
  String get otpRequired => 'OTP आवश्यक';

  @override
  String get newRequests => 'नए अनुरोध';

  @override
  String get accepted => 'स्वीकृत';

  @override
  String get upcoming => 'आगामी';

  @override
  String get pending => 'लंबित';

  @override
  String get assigned => 'सौंपे गए';

  @override
  String get b2cDirect => 'B2C प्रत्यक्ष';

  @override
  String get b2bGovt => 'B2B / सरकारी';

  @override
  String get individualServices => 'व्यक्तिगत ग्राहक सेवाएँ';

  @override
  String get orgWorkforce => 'संगठन और कार्यबल असाइनमेंट';

  @override
  String get viewCustomer => 'ग्राहक देखें';

  @override
  String get viewInstitution => 'संस्थान देखें';

  @override
  String activeJobId(String id) {
    return 'सक्रिय कार्य #$id';
  }

  @override
  String assignmentId(String id) {
    return 'असाइनमेंट #$id';
  }

  @override
  String get summary => 'सारांश';

  @override
  String get viewBreakdown => 'विवरण देखें';

  @override
  String get jobsCompleted => 'पूर्ण';

  @override
  String get jobsCancelled => 'रद्द';

  @override
  String get earnings => 'आय';

  @override
  String get rating => 'रेटिंग';

  @override
  String get reportDelay => 'विलंब की रिपोर्ट करें';

  @override
  String get expectedDelayTime => 'अपेक्षित विलंब समय';

  @override
  String get selectReason => 'कारण चुनें';

  @override
  String get heavyTraffic => 'रास्ते में भारी ट्रैफिक';

  @override
  String get previousJobLate => 'पिछला ग्राहक कार्य देर से चल रहा है';

  @override
  String get vehicleBreakdown => 'वाहन / परिवहन खराबी';

  @override
  String get spareParts => 'आवश्यक स्पेयर पार्ट्स ले रहे हैं';

  @override
  String get weather => 'मौसम की स्थिति';

  @override
  String get emergency => 'आपातकालीन स्थिति';

  @override
  String get other => 'अन्य कारण';

  @override
  String get dismiss => 'खारिज करें';

  @override
  String get notifyClientDelay => 'ग्राहक को विलंब सूचित करें';

  @override
  String get delayConfirmed =>
      'विलंब की रिपोर्ट। ग्राहक को संशोधित आगमन समय अपडेट किया गया।';

  @override
  String get onTimeConfirmed =>
      'समय पर पुष्टि। ग्राहक को सूचित किया गया। प्रस्थान उलटी गिनती सक्रिय।';

  @override
  String get cancelJob => 'यह असाइनमेंट रद्द करें?';

  @override
  String get cancelJobWarning =>
      '1 घंटे के भीतर रद्द करने से आपके वर्कर रिस्पॉन्स स्कोर पर प्रभाव पड़ता है।';

  @override
  String get reasonForCancellation => 'रद्द करने का कारण';

  @override
  String get emergencyPersonal => 'आपातकालीन व्यक्तिगत समस्या';

  @override
  String get healthIssue => 'स्वास्थ्य / चिकित्सा अस्वस्थता';

  @override
  String get toolsBreakdown => 'उपकरण / वाहन खराबी';

  @override
  String get cannotReachCustomer => 'ग्राहक स्थान तक पहुँचने में असमर्थ';

  @override
  String get scheduleConflict => 'समय संघर्ष';

  @override
  String get unsafeLocation => 'असुरक्षित स्थान की रिपोर्ट करें';

  @override
  String get incorrectJobDetails => 'गलत कार्य विवरण';

  @override
  String get keepJob => 'कार्य जारी रखें';

  @override
  String get confirmCancel => 'रद्द करने की पुष्टि करें';

  @override
  String get jobCancelled => 'कार्य रद्द';

  @override
  String get cancelledBy => 'द्वारा रद्द';

  @override
  String get penalty => 'जुर्माना/शुल्क';

  @override
  String get customerNotified => 'ग्राहक को सूचित किया गया';

  @override
  String get newServiceRequest => 'नया सेवा अनुरोध';

  @override
  String get reportedProblem => 'रिपोर्ट की गई समस्या';

  @override
  String get requestedDate => 'अनुरोधित तिथि';

  @override
  String get requestedTime => 'अनुरोधित समय';

  @override
  String get estimatedDuration => 'अनुमानित अवधि';

  @override
  String get distance => 'दूरी';

  @override
  String get location => 'स्थान';

  @override
  String get onsiteRequired => 'ऑनसाइट आवश्यक';

  @override
  String get onsiteFee => 'ऑनसाइट शुल्क';

  @override
  String get scheduleCompatibility => 'अनुसूची संगतता';

  @override
  String get decline => 'अस्वीकार करें';

  @override
  String get accept => 'स्वीकार करें';

  @override
  String get cannotAccept => 'यह अनुरोध स्वीकार नहीं किया जा सकता';

  @override
  String get waitingForCustomer => 'ग्राहक के चयन की प्रतीक्षा';

  @override
  String get candidateStatus => 'आपकी उम्मीदवारी लंबित है';

  @override
  String get selectionExpiry => 'चयन समाप्ति';

  @override
  String get customerSelectedYou => 'ग्राहक ने आपको चुना ✓';

  @override
  String get jobConfirmed => 'काम की पुष्टि हुई';

  @override
  String get confirmedJobDetails => 'पुष्टि किए गए कार्य विवरण';

  @override
  String get reschedule => 'पुनर्निर्धारित करें';

  @override
  String get contactCustomer => 'ग्राहक से संपर्क करें';

  @override
  String get mapView => 'मानचित्र दृश्य';

  @override
  String get platformFee => 'प्लेटफ़ॉर्म शुल्क';

  @override
  String get notes => 'नोट्स';

  @override
  String get reminderTitle => 'कार्य 1 घंटे में शुरू होगा';

  @override
  String get liveJourneyTracking => 'लाइव यात्रा ट्रैकिंग';

  @override
  String get enRouteTransit => 'रास्ते में (परिवहन)';

  @override
  String get telemetryActive => 'टेली-टेलीमेट्री सक्रिय';

  @override
  String get journeyProgress => 'यात्रा प्रगति';

  @override
  String stageOf(String current, String total) {
    return 'चरण $current / $total';
  }

  @override
  String get remaining => 'शेष';

  @override
  String get travelTime => 'यात्रा समय';

  @override
  String get targetEta => 'लक्ष्य ETA';

  @override
  String get liveGpsActive => 'लाइव GPS सक्रिय';

  @override
  String gpsAccuracy(String meters) {
    return '±$metersमी सटीकता';
  }

  @override
  String get syncedJustNow => 'सिंक: अभी';

  @override
  String nextManeuver(String distance) {
    return 'अगला मोड़ $distance में';
  }

  @override
  String get geoFencedCheckIn => 'जियो-फेंस्ड चेक-इन';

  @override
  String get sosHelp => 'SOS सहायता';

  @override
  String get iHaveArrived => 'मैं पहुँच गया — OTP सत्यापित करें';

  @override
  String get shiftReportingDuty => 'शिफ्ट रिपोर्टिंग ड्यूटी';

  @override
  String requiredBy(String time) {
    return '$time तक आवश्यक';
  }

  @override
  String aheadOfSchedule(String minutes) {
    return '$minutes मिनट समय से पहले';
  }

  @override
  String get verifyArrival => 'आगमन सत्यापित करें';

  @override
  String get arrivedAtSite => 'स्थान पर पहुँचे';

  @override
  String get proximityConfirmed => 'निकटता पुष्टि';

  @override
  String get attendancePasscode => 'उपस्थिति पासकोड';

  @override
  String get enterOtpAtLocation => 'सेवा स्थान पर दिया गया OTP दर्ज करें';

  @override
  String otpExpiresIn(String time) {
    return 'OTP $time में समाप्त होगा';
  }

  @override
  String get resendOtp => 'OTP पुनः भेजें';

  @override
  String get verifyAndCheckIn => 'सत्यापित करें और चेक इन करें';

  @override
  String get verificationDetails => 'सत्यापन विवरण';

  @override
  String get locationDetected => 'स्थान पता लगाया गया';

  @override
  String get workerId => 'कर्मचारी आईडी';

  @override
  String get gpsAccuracyLabel => 'GPS सटीकता';

  @override
  String get highPrecision => 'उच्च सटीकता';

  @override
  String get active => 'सक्रिय';

  @override
  String get currentGeoLocation => 'वर्तमान जियो-स्थान';

  @override
  String get arrivalTimestamp => 'आगमन समय';

  @override
  String get needHelpPasscode => 'पासकोड में सहायता चाहिए?';

  @override
  String get callDutyCoordinator => 'ड्यूटी समन्वयक को कॉल करें';

  @override
  String get arrivalVerified => 'आगमन सत्यापित';

  @override
  String get inspectionReady => 'निरीक्षण तैयार';

  @override
  String get incorrectOtp => 'गलत OTP। कृपया पुनः प्रयास करें।';

  @override
  String get otpExpired => 'OTP समाप्त हो गया। कृपया नया अनुरोध करें।';

  @override
  String get customerNotResponding => 'ग्राहक प्रतिक्रिया नहीं दे रहा';

  @override
  String get callCustomer => 'कॉल';

  @override
  String get messageCustomer => 'संदेश';

  @override
  String get waitForCustomer => 'प्रतीक्षा करें';

  @override
  String get reportUnavailable => 'ग्राहक अनुपलब्ध रिपोर्ट करें';

  @override
  String get inspectionDiagnosis => 'निरीक्षण और निदान';

  @override
  String get onSiteActive => 'ऑन-साइट सक्रिय';

  @override
  String get arrivalOtpVerified => 'आगमन OTP सत्यापित';

  @override
  String get sequentialWorkflow => 'क्रमिक कार्यप्रवाह';

  @override
  String get otpCheck => 'OTP जाँच';

  @override
  String get inspection => 'निरीक्षण';

  @override
  String get quotation => 'कोटेशन';

  @override
  String get approval => 'स्वीकृति';

  @override
  String get done => 'पूर्ण';

  @override
  String get activeNow => 'अभी सक्रिय';

  @override
  String get locked => 'लॉक';

  @override
  String get pricingLocked => 'मूल्य निर्धारण लॉक';

  @override
  String get physicalDiagnosis => 'भौतिक निदान';

  @override
  String get customerReportedIssue => 'ग्राहक द्वारा रिपोर्ट की गई समस्या';

  @override
  String get customerAttachedPhotos => 'ग्राहक द्वारा संलग्न फ़ोटो';

  @override
  String get viewFull => 'पूरा देखें';

  @override
  String get workerInspectionFindings => 'कर्मचारी निरीक्षण निष्कर्ष';

  @override
  String get editable => 'संपादन योग्य';

  @override
  String get observedDefect => 'देखा गया भौतिक दोष / मूल कारण';

  @override
  String get diagnosisSeverity => 'निदान गंभीरता स्तर';

  @override
  String get lowDrip => 'कम (टपकाव)';

  @override
  String get activeLeak => 'सक्रिय रिसाव';

  @override
  String get shutoffUrgent => 'बंद करें (जरूरी)';

  @override
  String get requiredAction => 'आवश्यक तकनीकी सुधारात्मक कार्रवाई';

  @override
  String get onSiteObservations => 'ऑन-साइट अवलोकन और पूर्व-आवश्यकताएँ';

  @override
  String get technicianPhotos => 'तकनीशियन लाइव प्रमाण फ़ोटो';

  @override
  String get photosAttached => 'संलग्न';

  @override
  String get photoVerifyNote =>
      'ये फ़ोटो मरम्मत से पहले की क्षतिग्रस्त स्थिति को सत्यापित करती हैं।';

  @override
  String get completeInspection => 'निरीक्षण पूर्ण करें →';

  @override
  String get completeInspectionNote =>
      'निरीक्षण पूर्ण करने से सेवा कोटेशन चरण खुलता है।';

  @override
  String get nextUnlockQuotation =>
      'अगला: कोटेशन अनलॉक करने के लिए निरीक्षण पूरा करें';

  @override
  String get inspectionPrerequisitesNote =>
      'कोटेशन अनलॉक करने के लिए देखा गया दोष दर्ज करें और कम से कम 1 प्रमाण फ़ोटो संलग्न करें।';

  @override
  String get quotationTitle => 'कोटेशन';

  @override
  String get inspectionCompleted => 'निरीक्षण पूर्ण';

  @override
  String get onSiteService => 'ऑन-साइट सेवा';

  @override
  String get customerProblemPhotos => 'ग्राहक समस्या फ़ोटो';

  @override
  String get inspectionSummary => 'निरीक्षण सारांश';

  @override
  String get customerReportedProblem => 'ग्राहक की रिपोर्ट की गई समस्या';

  @override
  String get workerDiagnosis => 'कर्मचारी निदान';

  @override
  String get recommendedSolution => 'अनुशंसित समाधान';

  @override
  String get workerInspectionPhotos => 'कर्मचारी निरीक्षण फ़ोटो';

  @override
  String get verifiedOnSite => 'ऑन-साइट सत्यापित';

  @override
  String get serviceQuotation => 'सेवा कोटेशन';

  @override
  String get labourServiceCharge => 'श्रम / सेवा शुल्क';

  @override
  String get workerEditable => 'कर्मचारी द्वारा संपादनीय';

  @override
  String get materialCostItemized => 'सामग्री लागत (आइटमवार)';

  @override
  String get addMaterial => 'सामग्री जोड़ें';

  @override
  String get otherServiceCharges => 'अन्य सेवा शुल्क';

  @override
  String get serviceSubtotal => 'सेवा उप-योग';

  @override
  String platformFeePercent(String percent) {
    return 'प्लेटफ़ॉर्म शुल्क ($percent%)';
  }

  @override
  String get autoCalculated => 'स्वचालित गणना';

  @override
  String get totalServiceQuotation => 'कुल सेवा कोटेशन';

  @override
  String get customerServiceTotal => 'ग्राहक सेवा कुल';

  @override
  String get readyForApproval => 'ग्राहक अनुमोदन के लिए तैयार';

  @override
  String platformFeeNote(String percent, String amount) {
    return '₹$amount सेवा उप-योग का $percent% • ग्राहक भुगतान में जोड़ा गया';
  }

  @override
  String get quotationStatus => 'कोटेशन स्थिति';

  @override
  String get waitingForApproval => 'ग्राहक अनुमोदन की प्रतीक्षा में';

  @override
  String get ifApproved => 'यदि स्वीकृत:';

  @override
  String get ifRejected => 'यदि अस्वीकृत:';

  @override
  String get sendQuotation => 'कोटेशन भेजें';

  @override
  String get quotationApproved => 'कोटेशन स्वीकृत ✓';

  @override
  String get quotationNotApproved => 'कोटेशन अस्वीकृत';

  @override
  String get rejectionReason => 'अस्वीकृति का कारण';

  @override
  String get startService => 'सेवा शुरू करें';

  @override
  String get serviceCompletion => 'सेवा पूर्णता';

  @override
  String get workCompleted => 'कार्य पूर्ण हुआ';

  @override
  String get onSiteVerified => 'ऑन-साइट सत्यापित';

  @override
  String get serviceSummary => 'सेवा सारांश';

  @override
  String get problemAddressed => 'हल की गई समस्या';

  @override
  String get workPerformed => 'किया गया कार्य';

  @override
  String get completionNotes => 'पूर्णता टिप्पणियां';

  @override
  String get proofOfWork => 'कार्य का प्रमाण';

  @override
  String get beforeVsAfter => 'पहले बनाम बाद का सत्यापन';

  @override
  String get verifiedByTech => 'तकनीशियन द्वारा सत्यापित';

  @override
  String get addPhotoTestProof => '+ अतिरिक्त फ़ोटो / परीक्षण प्रमाण जोड़ें';

  @override
  String get finalServiceCost => 'अंतिम सेवा लागत';

  @override
  String get labourServiceChargeLabel => 'श्रम / सेवा शुल्क';

  @override
  String get materialCost => 'सामग्री लागत';

  @override
  String get otherCharges => 'अन्य लागू सेवा शुल्क';

  @override
  String get serviceSubtotalLabel => 'सेवा उप-योग';

  @override
  String get cooperativePlatformFee => 'सहकारी प्लेटफ़ॉर्म शुल्क';

  @override
  String get finalServiceAmount => 'अंतिम सेवा राशि';

  @override
  String get quotationMatched => 'कोटेशन मिलान';

  @override
  String get materialBillProof => 'सामग्री और बिल प्रमाण';

  @override
  String itemsVerified(String count) {
    return '$count आइटम सत्यापित';
  }

  @override
  String get billAttached => 'बिल संलग्न';

  @override
  String get takeBillPhoto => 'बिल की फोटो लें';

  @override
  String get uploadReceipt => 'रसीद अपलोड करें';

  @override
  String get addMaterialBill => '+ अतिरिक्त सामग्री / बिल जोड़ें';

  @override
  String get verifiedMaterialCost => 'सत्यापित सामग्री लागत';

  @override
  String get materialBillNote =>
      'सामग्री बिल फ़ोटो वास्तविक सामग्री लागत के प्रमाण के रूप में संलग्न हैं।';

  @override
  String get paymentStatus => 'भुगतान स्थिति';

  @override
  String get awaitingPayment => 'भुगतान की प्रतीक्षा में';

  @override
  String get customerPaymentPayable => 'ग्राहक भुगतान देय';

  @override
  String get paymentModeOptions => 'भुगतान विधि विकल्प / स्थिति';

  @override
  String get paymentPromptNote =>
      'ग्राहक को ऐप / नकद या UPI से सहकारी एस्क्रो में भुगतान के लिए प्रेरित किया गया।';

  @override
  String get waitingForPayment => 'ग्राहक के भुगतान पुष्टि की प्रतीक्षा';

  @override
  String get refresh => 'रिफ्रेश';

  @override
  String get confirmPayment => 'भुगतान पुष्टि करें';

  @override
  String get requestPayment => 'भुगतान का अनुरोध करें';

  @override
  String get invoiceDetails => 'चालान विवरण';

  @override
  String get taxInvoice => 'कर चालान';

  @override
  String get originalForRecipient => 'प्राप्तकर्ता के लिए मूल प्रति';

  @override
  String get paid => 'भुगतान किया';

  @override
  String get verifiedReceipt => 'सत्यापित सहकारी डिजिटल रसीद';

  @override
  String paidOn(String date, String time) {
    return '$date को $time पर भुगतान';
  }

  @override
  String get gstinActive => 'GSTIN सक्रिय';

  @override
  String get billedTo => 'बिल प्राप्तकर्ता (ग्राहक)';

  @override
  String get fulfilledBy => 'पूर्ति करने वाला';

  @override
  String get licensedTrade => 'लाइसेंसधारी फील्ड प्लंबिंग तकनीशियन';

  @override
  String get cooperativeNode => 'सहकारी नोड';

  @override
  String get jobSpecification => 'कार्य विनिर्देश';

  @override
  String get completedAt => 'पूर्ण होने का समय';

  @override
  String get billingBreakdown => 'बिलिंग विवरण';

  @override
  String get currencyInr => 'मुद्रा: INR (₹)';

  @override
  String get totalPaid => 'कुल भुगतान (कर सहित)';

  @override
  String get settledInFull => 'पूर्ण भुगतान प्राप्त';

  @override
  String get clearBillingPolicy => 'स्पष्ट बिलिंग नीति';

  @override
  String get transactionRecord => 'लेनदेन रिकॉर्ड';

  @override
  String get paymentSuccessful => 'भुगतान सफल';

  @override
  String get paymentMethod => 'भुगतान विधि';

  @override
  String get transactionId => 'लेनदेन आईडी';

  @override
  String get bankUtrReference => 'बैंक UTR संदर्भ';

  @override
  String get transactionTimestamp => 'लेनदेन समय';

  @override
  String get serviceInfoScope => 'सेवा जानकारी और दायरा';

  @override
  String get reportedIssue => 'रिपोर्ट की गई समस्या';

  @override
  String get technicalWork => 'तकनीकी कार्य किया गया';

  @override
  String get materialsVerified => 'सामग्री सत्यापित और स्थापित';

  @override
  String get proofOfServiceLabel => 'सेवा का प्रमाण';

  @override
  String photosVerified(String count) {
    return '$count फ़ोटो सत्यापित';
  }

  @override
  String get downloadInvoice => 'चालान डाउनलोड करें';

  @override
  String get viewServiceHistory => 'पूर्ण सेवा इतिहास और निदान देखें';

  @override
  String get shareInvoice => 'शेयर';

  @override
  String get printInvoice => 'प्रिंट';

  @override
  String get jobCompleted => 'कार्य पूर्ण ✓';

  @override
  String get completionTime => 'पूर्णता समय';

  @override
  String get finalAmount => 'अंतिम राशि';

  @override
  String get invoiceNumber => 'इनवॉइस नंबर';

  @override
  String get thankYou => 'सहकारी सेवा मंच का उपयोग करने के लिए धन्यवाद।';

  @override
  String get warrantyNote =>
      'वारंटी दावों या प्रश्नों के लिए, कृपया कार्य का संदर्भ दें';

  @override
  String get ratingTitle => 'इस सेवा को रेट करें';

  @override
  String get ratingSubtitle =>
      'आपकी प्रतिक्रिया कर्मचारी गुणवत्ता सुधारने में सहायता करती है';

  @override
  String get starRating => 'स्टार रेटिंग';

  @override
  String get feedbackPlaceholder => 'अपनी प्रतिक्रिया साझा करें (वैकल्पिक)';

  @override
  String get submitRating => 'रेटिंग सबमिट करें और बंद करें';

  @override
  String get jobHistory => 'कार्य इतिहास';

  @override
  String get all => 'सभी';

  @override
  String get filterCompleted => 'पूर्ण';

  @override
  String get filterCancelled => 'रद्द';

  @override
  String get filterRejected => 'अस्वीकृत';

  @override
  String get filterInProgress => 'प्रगति पर';

  @override
  String get service => 'सेवा';

  @override
  String get date => 'तिथि';

  @override
  String get amount => 'राशि';

  @override
  String get status => 'स्थिति';

  @override
  String get earningsTitle => 'कमाई और निपटान';

  @override
  String get today => 'आज';

  @override
  String get weekly => 'साप्ताहिक';

  @override
  String get monthly => 'मासिक';

  @override
  String get financialYear => 'वित्तीय वर्ष';

  @override
  String get serviceEarnings => 'सेवा / मजदूरी';

  @override
  String get onsiteEarnings => 'साइट विजिट शुल्क';

  @override
  String get reimbursements => 'प्रतिपूर्ति';

  @override
  String get bonuses => 'प्रदर्शन बोनस';

  @override
  String get deductions => 'टीडीएस / सहकारी शुल्क';

  @override
  String get pendingEarnings => 'लंबित भुगतान';

  @override
  String get settledEarnings => 'निपटारा हुआ भुगतान';

  @override
  String get settlementTitle => 'निपटान';

  @override
  String get pendingSettlement => 'लंबित निपटान';

  @override
  String get includedJobs => 'शामिल कार्य';

  @override
  String get expectedSettlement => 'अपेक्षित निपटान';

  @override
  String get settlementMethod => 'निपटान विधि';

  @override
  String get settlementHistory => 'निपटान इतिहास';

  @override
  String get settlementId => 'निपटान आईडी';

  @override
  String get notificationsTitle => 'सूचनाएं';

  @override
  String unread(String count) {
    return 'अपठित';
  }

  @override
  String get markRead => 'पढ़ा हुआ चिन्हित करें';

  @override
  String get justNow => 'अभी';

  @override
  String minutesAgo(String count) {
    return '$count मिनट पहले';
  }

  @override
  String hoursAgo(String count) {
    return '$count घंटे पहले';
  }

  @override
  String get myProfile => 'मेरी प्रोफाइल';

  @override
  String get workerIdentity => 'कर्मचारी पहचान और प्रमाणपत्र';

  @override
  String get cooperativeTier => 'सहकारी स्तर';

  @override
  String get onTimeRate => '100% समय पर';

  @override
  String get clientSide => 'ग्राहक पक्ष';

  @override
  String get thisFy => 'इस वित्तीय वर्ष';

  @override
  String topPercent(String percent) {
    return 'शीर्ष $percent%';
  }

  @override
  String get settlementThreshold => 'निपटान सीमा चेतावनी';

  @override
  String get jobDispatchGateRule => 'कार्य प्रेषण गेट नियम';

  @override
  String get newRequestsPaused => 'नए अनुरोध रुके';

  @override
  String get thresholdReachedMsg =>
      'निपटान सीमा पहुँच गई। निपटान प्रक्रिया पूर्ण होने तक नए कार्य अनुरोध रुके हुए हैं।';

  @override
  String get pendingSettlementLabel => 'लंबित निपटान';

  @override
  String get policyThreshold => 'नीति सीमा';

  @override
  String get autoHoldTrigger => 'स्वचालित रोक';

  @override
  String get settlementStatus => 'निपटान स्थिति';

  @override
  String get processing => 'प्रसंस्करण';

  @override
  String get expectedSettlementTime => 'अपेक्षित निपटान';

  @override
  String get lastSettlement => 'अंतिम निपटान';

  @override
  String get skills => 'कौशल';

  @override
  String get certifications => 'प्रमाणपत्र';

  @override
  String get performance => 'प्रदर्शन';

  @override
  String get documents => 'दस्तावेज़';

  @override
  String get availability => 'उपलब्धता';

  @override
  String get paymentDetails => 'भुगतान विवरण';

  @override
  String get settings => 'सेटिंग्स';

  @override
  String get language => 'भाषा';

  @override
  String get support => 'सहायता';

  @override
  String get logout => 'लॉग आउट';

  @override
  String get logoutConfirm => 'क्या आप वाकई लॉग आउट करना चाहते हैं?';

  @override
  String get yes => 'हाँ';

  @override
  String get no => 'नहीं';

  @override
  String get availabilityTitle => 'कर्मचारी उपलब्धता';

  @override
  String get activeStatus => 'सक्रिय';

  @override
  String get inactiveStatus => 'निष्क्रिय';

  @override
  String get busyStatus => 'व्यस्त';

  @override
  String get workingHours => 'कार्य समय';

  @override
  String get serviceAvailability => 'सेवा उपलब्धता';

  @override
  String get scheduleTitle => 'कार्यकर्ता शेड्यूल';

  @override
  String get calendar => 'कैलेंडर';

  @override
  String get upcomingJobs => 'आगामी कार्य';

  @override
  String get completedJobs => 'पूर्ण कार्य';

  @override
  String get blockedTimes => 'अवरुद्ध समय';

  @override
  String get rescheduleTitle => 'पुनर्निर्धारण करें';

  @override
  String get currentAppointment => 'वर्तमान अपॉइंटमेंट';

  @override
  String get selectNewTime => 'नया समय चुनें';

  @override
  String get reason => 'कारण';

  @override
  String get customerApproval => 'ग्राहक अनुमोदन';

  @override
  String get rescheduleRequested => 'पुनर्निर्धारण अनुरोधित';

  @override
  String get rescheduleWaiting => 'अनुमोदन की प्रतीक्षा';

  @override
  String get rescheduleApproved => 'पुनर्निर्धारण स्वीकृत';

  @override
  String get rescheduleRejected => 'पुनर्निर्धारण अस्वीकृत';

  @override
  String get coursesTraining => 'पाठ्यक्रम और प्रशिक्षण';

  @override
  String get improveSkills => 'अपने कौशल सुधारें और नए प्रमाणपत्र अर्जित करें';

  @override
  String get enrolled => 'नामांकित';

  @override
  String get total => 'कुल';

  @override
  String get finished => 'समाप्त';

  @override
  String get certificates => 'प्रमाणपत्र';

  @override
  String get recommended => 'अनुशंसित';

  @override
  String get mandatory => 'अनिवार्य';

  @override
  String get advanced => 'उन्नत';

  @override
  String get courseDetails => 'पाठ्यक्रम विवरण';

  @override
  String get enrollNow => 'अभी नामांकन करें';

  @override
  String get continueTraining => 'प्रशिक्षण जारी रखें';

  @override
  String get viewCertificate => 'प्रमाणपत्र देखें';

  @override
  String get progress => 'प्रगति';

  @override
  String get lessons => 'पाठ';

  @override
  String get duration => 'अवधि';

  @override
  String get certificate => 'प्रमाणपत्र';

  @override
  String get schemesWelfare => 'योजनाएँ और कल्याण';

  @override
  String get benefitsProtection => 'लाभ, सुरक्षा और सहकारी सहायता';

  @override
  String get available => 'उपलब्ध';

  @override
  String get explore => 'खोजें';

  @override
  String get eligible => 'पात्र';

  @override
  String get valid => '100% मान्य';

  @override
  String get applied => 'आवेदित';

  @override
  String get inReview => 'समीक्षा में';

  @override
  String get approved => 'स्वीकृत';

  @override
  String get activeCare => 'सक्रिय देखभाल';

  @override
  String get insurance => 'बीमा';

  @override
  String get welfare => 'कल्याण';

  @override
  String get pension => 'पेंशन';

  @override
  String get training => 'प्रशिक्षण';

  @override
  String get schemeDetails => 'योजना विवरण';

  @override
  String get eligibility => 'पात्रता';

  @override
  String get applyNow => 'अभी आवेदन करें';

  @override
  String get applicationSubmitted => 'आवेदन जमा किया गया';

  @override
  String get applicationApproved => 'आवेदन स्वीकृत';

  @override
  String get applicationRejected => 'आवेदन अस्वीकृत';

  @override
  String get supportTitle => 'सहायता और समर्थन';

  @override
  String get helpCenter => 'सहायता केंद्र';

  @override
  String get faq => 'सामान्य प्रश्न';

  @override
  String get contactSupportAction => 'सहायता से संपर्क करें';

  @override
  String get paymentIssue => 'भुगतान समस्या';

  @override
  String get jobDispute => 'कार्य का दायरा विवाद';

  @override
  String get technicalIssue => 'तकनीकी समस्या';

  @override
  String get customerIssue => 'ग्राहक समस्या';

  @override
  String get unsafeLocationReport => 'असुरक्षित स्थान';

  @override
  String get sosTitle => 'आपातकालीन SOS';

  @override
  String get emergencyAssistance => 'आपातकालीन सहायता';

  @override
  String get callEmergencyServices => 'आपातकालीन सेवाओं को कॉल करें';

  @override
  String get cooperativeSupport => 'सहकारी सहायता';

  @override
  String get shareLiveLocation => 'लाइव जीपीएस स्थान साझा करें';

  @override
  String get securitySettings => 'सुरक्षा सेटिंग्स';

  @override
  String get changePassword => 'पासवर्ड बदलें';

  @override
  String get biometricLogin => 'बायोमेट्रिक लॉगिन';

  @override
  String get sessionManagement => 'सत्र / डिवाइस प्रबंधन';

  @override
  String get accountLockInfo => 'खाता लॉक जानकारी';

  @override
  String get locationPermTitle => 'स्थान अनुमति आवश्यक';

  @override
  String get locationPermMsg =>
      'यात्रा ट्रैकिंग, आगमन सत्यापन, ग्राहक सुरक्षा और सेवा सत्यापन के लिए स्थान अनुमति आवश्यक है।';

  @override
  String get cameraPermTitle => 'कैमरा एक्सेस आवश्यक';

  @override
  String get cameraPermMsg =>
      'निरीक्षण फ़ोटो, सामग्री प्रमाण, पहले/बाद साक्ष्य और सेवा दस्तावेज़ीकरण के लिए कैमरा एक्सेस आवश्यक है।';

  @override
  String get notifPermTitle => 'सूचना अनुमति';

  @override
  String get notifPermMsg =>
      'नए कार्य अलर्ट, ग्राहक चयन अपडेट, रिमाइंडर, कोटेशन परिणाम और भुगतान अपडेट के लिए सूचनाएँ आवश्यक हैं।';

  @override
  String get allow => 'अनुमति दें';

  @override
  String get notNow => 'अभी नहीं';

  @override
  String get noRequests => 'इस समय कोई नया अनुरोध नहीं';

  @override
  String get noUpcomingJobs => 'इस तिथि के लिए कोई आगामी कार्य नहीं है';

  @override
  String get noActiveJob => 'अभी कोई सक्रिय कार्य नहीं';

  @override
  String get noCompletedJobs => 'अभी तक कोई पूर्ण कार्य नहीं';

  @override
  String get noNotifications => 'कोई सूचना उपलब्ध नहीं है';

  @override
  String get noCourses => 'कोई पाठ्यक्रम उपलब्ध नहीं';

  @override
  String get noSchemes => 'कोई योजना उपलब्ध नहीं';

  @override
  String get noEarnings => 'अभी तक कोई आय दर्ज नहीं';

  @override
  String get noSettlements => 'दिखाने के लिए कोई निपटान नहीं';

  @override
  String get errorServerUnavailable =>
      'सर्वर अस्थायी रूप से अनुपलब्ध है। कृपया बाद में पुनः प्रयास करें।';

  @override
  String get errorNetworkUnavailable =>
      'इंटरनेट कनेक्शन नहीं है। कृपया अपनी नेटवर्क सेटिंग्स जाँचें।';

  @override
  String get errorApiFailure => 'कुछ गलत हो गया। कृपया पुनः प्रयास करें।';

  @override
  String get errorTimeout =>
      'अनुरोध का समय समाप्त हो गया। कृपया पुनः प्रयास करें।';

  @override
  String get errorInvalidOtp => 'अमान्य OTP। कृपया जाँचें और पुनः प्रयास करें।';

  @override
  String get errorExpiredOtp => 'OTP समाप्त हो गया है। कृपया नया अनुरोध करें।';

  @override
  String get errorPaymentFailed =>
      'भुगतान विफल। कृपया पुनः प्रयास करें या वैकल्पिक भुगतान विधि का उपयोग करें।';

  @override
  String get errorUploadFailed =>
      'अपलोड विफल। कृपया अपना कनेक्शन जाँचें और पुनः प्रयास करें।';

  @override
  String get errorGpsUnavailable =>
      'GPS सिग्नल उपलब्ध नहीं है। कृपया स्थान सेवाएँ सक्षम करें।';

  @override
  String get errorPermissionDenied =>
      'अनुमति अस्वीकृत। इस सुविधा के लिए अनुरोधित अनुमति आवश्यक है।';

  @override
  String get errorGeofenceFailed =>
      'जियोफेंस सत्यापन विफल। कृपया सुनिश्चित करें कि आप सही स्थान पर हैं।';

  @override
  String get errorSessionExpired =>
      'आपका सत्र समाप्त हो गया है। कृपया फिर से लॉगिन करें।';

  @override
  String get retry => 'पुनः प्रयास करें';

  @override
  String get tryAgain => 'फिर कोशिश करें';

  @override
  String get goBack => 'वापस जाएँ';

  @override
  String get paymentPending => 'भुगतान लंबित';

  @override
  String get paymentProcessing => 'भुगतान संसाधित हो रहा है';

  @override
  String get paymentCompleted => 'भुगतान पूर्ण';

  @override
  String get paymentFailed => 'भुगतान विफल';

  @override
  String get partialPayment => 'आंशिक भुगतान';

  @override
  String get received => 'प्राप्त';

  @override
  String get remainingAmount => 'शेष';

  @override
  String get retryPayment => 'भुगतान पुनः प्रयास';

  @override
  String get alternatePayment => 'वैकल्पिक भुगतान विधि';

  @override
  String get gpsWeak => 'GPS सिग्नल कमजोर है';

  @override
  String get gpsSearching => 'GPS सिग्नल खोज रहे हैं...';

  @override
  String get gpsFixed => 'GPS सिग्नल प्राप्त';

  @override
  String get offline => 'आप ऑफ़लाइन हैं';

  @override
  String get syncing => 'सिंक हो रहा है...';

  @override
  String get reconnecting => 'पुनः कनेक्ट हो रहा है...';

  @override
  String get failedAction => 'कार्रवाई विफल। कनेक्ट होने पर पुनः प्रयास होगा।';

  @override
  String get mins => 'मिनट';

  @override
  String get km => 'किमी';

  @override
  String get hrs => 'घंटे';

  @override
  String get items => 'आइटम';

  @override
  String get rupeeSymbol => '₹';

  @override
  String get confirmAction => 'पुष्टि करें';

  @override
  String get cancelAction => 'रद्द करें';

  @override
  String get save => 'सहेजें';

  @override
  String get edit => 'संपादित करें';

  @override
  String get delete => 'हटाएँ';

  @override
  String get close => 'बंद करें';

  @override
  String get next => 'अगला';

  @override
  String get back => 'पीछे';

  @override
  String get submit => 'जमा करें';

  @override
  String get apply => 'लागू करें';

  @override
  String get view => 'देखें';

  @override
  String get download => 'डाउनलोड';

  @override
  String get share => 'शेयर';

  @override
  String get search => 'खोजें';

  @override
  String get filter => 'फ़िल्टर';

  @override
  String get sortBy => 'क्रमबद्ध करें';

  @override
  String get clearAll => 'सब हटाएँ';

  @override
  String get seeAll => 'सभी देखें';

  @override
  String get loadMore => 'और लोड करें';

  @override
  String get ok => 'ठीक';

  @override
  String get newRequestBadge => 'नई रिक्वेस्ट';

  @override
  String get verifiedClient => 'सत्यापित ग्राहक';

  @override
  String memberSince(String year, String count) {
    return '$year से सदस्य • $count पूर्ण सेवाएं';
  }

  @override
  String viewAllPhotos(String count) {
    return 'सभी फ़ोटो देखें ($count)';
  }

  @override
  String get photoTapToView => 'देखने के लिए टैप करें';

  @override
  String get photoDisambiguationNote =>
      'ग्राहक की विज़िट-पूर्व फ़ोटो उपकरण और स्पेयर पार्ट्स का आकलन करने में मदद करती हैं। वर्कर की निरीक्षण फ़ोटो आगमन और OTP सत्यापन के बाद अलग से दर्ज की जाती हैं।';

  @override
  String get scheduleLogistics => 'शेड्यूल और लॉजिस्टिक्स';

  @override
  String travelTimeApprox(String minutes) {
    return '~$minutes मिनट यात्रा समय';
  }

  @override
  String get editFee => 'शुल्क संपादित करें';

  @override
  String youReceiveFullPayout(String amount) {
    return 'आपको मिलेगा: $amount (100% भुगतान)';
  }

  @override
  String get totalCustomerPays => 'कुल ग्राहक भुगतान';

  @override
  String get guaranteedPayoutNote =>
      'यदि निरीक्षण के बाद ग्राहक आगे नहीं बढ़ता है, तब भी आपका विज़िट शुल्क जमा किया जाएगा।';

  @override
  String get customerInstructionsTitle => 'ग्राहक निर्देश';

  @override
  String get jobAcceptedWaitingNote =>
      'ग्राहक की पुष्टि और चयन की प्रतीक्षा है।';

  @override
  String get conflictExplanation =>
      'इस अनुरोध को आपके वर्तमान शेड्यूल, कार्य के घंटों या सेवा क्षेत्र के विरुद्ध सत्यापित नहीं किया जा सका।';

  @override
  String get institutionAssignment => 'संस्थान असाइनमेंट';

  @override
  String get customerJobRequest => 'ग्राहक जॉब अनुरोध';

  @override
  String get viaMainRoad => 'मुख्य सड़क से (यातायात सामान्य रूप से चल रहा है)';

  @override
  String askCustomerForOtp(String name) {
    return '$name से उनके पंजीकृत मोबाइल पर भेजा गया 6 अंकों का कोड पूछें।';
  }

  @override
  String otpAttemptsLeft(String count) {
    return '$count प्रयास शेष';
  }

  @override
  String get verifyAndStartService => 'सत्यापित करें और सेवा शुरू करें';

  @override
  String get strictProgressiveDisclosure => 'सख्त क्रमिक प्रकटीकरण';

  @override
  String get inspectionFindingsSubtitle => 'स्थान पर आधिकारिक तकनीकी निदान';

  @override
  String uploadedPriorToArrival(String name) {
    return 'तकनीशियन के आने से पहले $name द्वारा अपलोड किया गया';
  }

  @override
  String get takeCameraShot => 'कैमरा शॉट लें';

  @override
  String get uploadFile => 'फ़ाइल अपलोड करें';

  @override
  String get addPhoto => 'फ़ोटो जोड़ें';

  @override
  String maxPhotosNote(String count) {
    return '(अधिकतम $count)';
  }

  @override
  String get removePhoto => 'फ़ोटो हटाएं';

  @override
  String get quotationBuilder => 'कोटेशन बिल्डर';

  @override
  String get quotationPreview => 'कोटेशन पूर्वावलोकन';

  @override
  String get quotationSent => 'कोटेशन भेजा गया';

  @override
  String get createdAfterDiagnosis => 'तकनीकी ऑन-साइट निदान के बाद बनाया गया';

  @override
  String get labourDescription => 'सेवा विवरण';

  @override
  String get labourEstimate => 'अनुमानित अवधि: 45 – 60 मिनट';

  @override
  String get materialName => 'सामग्री का नाम';

  @override
  String get materialQty => 'मात्रा';

  @override
  String get materialUnit => 'इकाई';

  @override
  String get materialUnitPrice => 'इकाई मूल्य';

  @override
  String materialSubtotal(String count) {
    return 'सामग्री उप-योग ($count आइटम)';
  }

  @override
  String get otherChargesHint => 'मलबा निपटान, विशेष उपकरण (वैकल्पिक)';

  @override
  String get serviceSubtotalBreakdown => 'सेवा उप-योग विवरण:';

  @override
  String get platformFeePolicy =>
      'प्लेटफ़ॉर्म शुल्क सेवा कोटेशन में अलग से जोड़ा जाता है। ऑन-साइट विज़िट शुल्क अलग से संभाले जाते हैं और इस कोटेशन में शामिल नहीं हैं।';

  @override
  String get quotationNotes => 'कोटेशन नोट्स';

  @override
  String get quotationNotesHint => 'ग्राहक के लिए कोई नोट जोड़ें (वैकल्पिक)';

  @override
  String get quotationValidity => 'जमा करने के समय से 24 घंटे तक मान्य';

  @override
  String sendQuotationAmount(String amount) {
    return 'कोटेशन भेजें — $amount';
  }

  @override
  String get digitalPushNote => 'ग्राहक के ऐप पर सीधे डिजिटल पुश भेजा गया';

  @override
  String quotationWaitingMsg(String name, String amount) {
    return 'ग्राहक $name को $amount का यह आइटमवार कोटेशन उनके मोबाइल ऐप पर तत्काल एक-टैप समीक्षा और डिजिटल प्राधिकरण के लिए प्राप्त होगा।';
  }

  @override
  String get approvedAction =>
      'मरम्मत कार्य शुरू करने के लिए \"सेवा शुरू करें\" टैप करें।';

  @override
  String get rejectedAction =>
      'मानक सहकारी नीति के अनुसार कार्य बंद किया जाएगा।';

  @override
  String get paymentAfterApproval =>
      'भुगतान और चालान कोटेशन स्वीकृत होने और भौतिक सेवा पूरी होने के बाद ही जारी होगा।';

  @override
  String get quotationAmount => 'सेवा कोटेशन राशि:';

  @override
  String get previewQuotation => 'कोटेशन पूर्वावलोकन';

  @override
  String get confirmAndSend => 'पुष्टि करें और कोटेशन भेजें';

  @override
  String get quotationSentSuccess => 'कोटेशन ग्राहक को सफलतापूर्वक भेजा गया';

  @override
  String get backToHome => 'होम पर वापस जाएं';

  @override
  String get removeMaterial => 'सामग्री हटाएं';

  @override
  String get inr => 'INR (₹)';

  @override
  String get labourChargeAmount => 'श्रम शुल्क राशि';

  @override
  String get otherChargesAmount => 'अन्य शुल्क राशि';

  @override
  String get quotationSentWaiting =>
      'आपका कोटेशन भेज दिया गया है। ग्राहक प्रतिक्रिया की प्रतीक्षा में।';

  @override
  String get customerAccepted => 'ग्राहक ने स्वीकार किया';

  @override
  String get customerRejected => 'ग्राहक ने अस्वीकार किया';

  @override
  String get quotationAcceptedMsg =>
      'ग्राहक ने आपका कोटेशन स्वीकार कर लिया है। अब आप सेवा शुरू कर सकते हैं।';

  @override
  String get quotationRejectedMsg =>
      'ग्राहक ने कोटेशन अस्वीकार कर दिया है। सहकारी नीति के अनुसार कार्य बंद किया जाएगा।';

  @override
  String get serviceExecution => 'सेवा निष्पादन';

  @override
  String get workInProgress => 'कार्य प्रगति पर है';

  @override
  String get addProofPhoto => '+ अतिरिक्त फोटो / परीक्षण प्रमाण जोड़ें';

  @override
  String get materialAndBillProof => 'सामग्री और बिल प्रमाण';

  @override
  String get viewBill => 'देखें';

  @override
  String get replaceBill => 'बदलें';

  @override
  String get materialProofNote =>
      'सामग्री बिल फोटो वास्तविक लागत के प्रमाण के रूप में संलग्न हैं। वे केवल व्यय सत्यापित करते हैं, कोई अतिरिक्त शुल्क नहीं जोड़ते।';

  @override
  String get completeService => 'सेवा पूर्ण करें';

  @override
  String get paymentSuccess => 'भुगतान सफल';

  @override
  String get bankUtr => 'बैंक यूटीआर संदर्भ';

  @override
  String get timestamp => 'समय';

  @override
  String get shareOrPrint => 'साझा करें / प्रिंट करें';

  @override
  String get ratingFeedback => 'रेटिंग और प्रतिक्रिया';

  @override
  String get rateCustomer => 'ग्राहक अनुभव को रेट करें';

  @override
  String get jobCompletedSuccess => 'कार्य सफलतापूर्वक पूरा हुआ!';

  @override
  String get viewInvoice => 'चालान देखें';

  @override
  String get cleanWorkArea => 'कार्य क्षेत्र साफ किया और सुपुर्द किया';

  @override
  String get customerInstructionFollowed =>
      'मरम्मत के दौरान ग्राहक के निर्देशों का पालन किया गया';

  @override
  String get todayEarnings => 'आज';

  @override
  String get weekEarnings => 'इस सप्ताह';

  @override
  String get monthEarnings => 'इस महीने';

  @override
  String get fyEarnings => 'वित्तीय वर्ष';

  @override
  String get materialReimbursements => 'सामग्री प्रतिपूर्ति';

  @override
  String get settlementDate => 'निपटान तिथि';

  @override
  String get settlementAmount => 'राशि';

  @override
  String get settledToBank => 'बैंक खाते में जमा';

  @override
  String get inEscrow => 'एस्क्रो में सुरक्षित';

  @override
  String get transactions => 'लेन-देन';

  @override
  String get reportDelayTitle => 'देरी की सूचना दें';

  @override
  String get delayExpectedTime => 'अपेक्षित देरी समय';

  @override
  String get min15 => '+15 मिनट';

  @override
  String get min30 => '+30 मिनट';

  @override
  String get min45 => '+45 मिनट';

  @override
  String get customTime => 'कस्टम';

  @override
  String get selectDelayReason => 'देरी का कारण चुनें';

  @override
  String get trafficCongestion => 'रास्ते में भारी ट्रैफिक';

  @override
  String get prevJobLate => 'पिछले कार्य में समय अधिक लगा';

  @override
  String get vehicleIssue => 'वाहन / यात्रा में खराबी';

  @override
  String get partsPickup => 'आवश्यक स्पेयर पार्ट्स लेना';

  @override
  String get weatherDelay => 'खराब मौसम';

  @override
  String get emergencyDelay => 'व्यक्तिगत / पारिवारिक आपातकाल';

  @override
  String get notifyDelay => 'ग्राहक को देरी की सूचना दें';

  @override
  String get delayReportedSuccess =>
      'देरी दर्ज की गई। ग्राहक को सूचित कर दिया गया है।';

  @override
  String get cancelAssignmentTitle => 'क्या आप यह कार्य रद्द करना चाहते हैं?';

  @override
  String get cancelWarning =>
      'क्या आप सुनिश्चित हैं? 1 घंटे के भीतर रद्द करने पर आपके प्रतिक्रिया स्कोर पर असर पड़ता है।';

  @override
  String get cancelReasonLabel => 'रद्द करने का कारण';

  @override
  String get reasonConflict => 'समय का टकराव';

  @override
  String get reasonEmergency => 'आपातकाल / जरूरी काम';

  @override
  String get reasonVehicle => 'वाहन / आवागमन की समस्या';

  @override
  String get reasonCustomerUnavailable => 'ग्राहक साइट पर अनुपलब्ध';

  @override
  String get reasonUnsafeLocation => 'असुरक्षित / दुर्गम स्थान';

  @override
  String get reasonIncorrectJob => 'गलत कार्य विवरण';

  @override
  String get reasonOther => 'अन्य कारण';

  @override
  String get jobCancelledLogged => 'कार्य रद्द हुआ';

  @override
  String get cancelNotificationSent =>
      'ग्राहक और सहकारी डिस्पैच को सूचित कर दिया गया है।';

  @override
  String get logged => 'दर्ज किया गया';

  @override
  String get selectNewSlot => 'नई तिथि और समय चुनें';

  @override
  String get rescheduleReason => 'पुनर्निर्धारण का कारण';

  @override
  String get requestCustomerApproval => 'ग्राहक की स्वीकृति मांगें';

  @override
  String get rescheduleStatusRequested => 'अनुरोध किया';

  @override
  String get rescheduleStatusWaiting => 'ग्राहक की प्रतीक्षा';

  @override
  String get rescheduleStatusApproved => 'स्वीकृत';

  @override
  String get rescheduleStatusRejected => 'अस्वीकृत';

  @override
  String get rescheduleSuccess => 'पुनर्निर्धारण अनुरोध ग्राहक को भेजा गया';

  @override
  String get customerUnavailableTitle => 'ग्राहक साइट पर अनुपलब्ध है';

  @override
  String get stepCallCustomer => 'ग्राहक को कॉल करें';

  @override
  String get stepSendMessage => 'संदेश भेजें';

  @override
  String get stepWaitTimer => 'प्रतीक्षा प्रोटोकॉल टाइमर';

  @override
  String get stepArrivalEvidence => 'जीपीएस आगमन प्रमाण सत्यापित करें';

  @override
  String get claimOnsiteFee => 'गारंटीकृत ऑनसाइट शुल्क का दावा करें (₹150)';

  @override
  String get recordUnavailable => 'ग्राहक अनुपलब्ध दर्ज करें और बंद करें';

  @override
  String get unavailableLogged =>
      'ग्राहक अनुपलब्ध दर्ज किया गया। ₹150 ऑनसाइट शुल्क आपके लंबित भुगतान में जोड़ा गया।';

  @override
  String get callNow => 'अभी कॉल करें';

  @override
  String get messageNow => 'संदेश भेजें';

  @override
  String get waitingRemaining => '10:00 प्रतीक्षा समय शेष';

  @override
  String get markAllRead => 'सभी पढ़ा हुआ चिह्नित करें';

  @override
  String get filterAll => 'सभी';

  @override
  String get filterCustomer => 'ग्राहक';

  @override
  String get filterInstitution => 'संस्थान';

  @override
  String get filterSystem => 'सिस्टम';

  @override
  String get workerCredentials => 'कार्यकर्ता पहचान व साख';

  @override
  String get completedStat => 'पूर्ण कार्य';

  @override
  String get cancelledStat => 'रद्द कार्य';

  @override
  String get earningsStat => 'कमाई';

  @override
  String get ratingStat => 'रेटिंग';

  @override
  String get skillsAndCertifications => 'कौशल और प्रमाणपत्र';

  @override
  String get accountQuickLinks => 'खाता और कार्य सेटिंग्स';

  @override
  String get workerSchedule => 'कार्यकर्ता शेड्यूल';

  @override
  String get availabilityStatus => 'उपलब्धता स्थिति';

  @override
  String get bankAndPayouts => 'बैंक और भुगतान खाते';

  @override
  String get documentsKyc => 'दस्तावेज और केवाईसी';

  @override
  String get settingsTitle => 'सेटिंग्स';

  @override
  String get helpAndSupport => 'सहायता और समर्थन';

  @override
  String get emergencySos => 'आपातकालीन एसओएस';

  @override
  String get statusActive => 'सक्रिय';

  @override
  String get statusInactive => 'निष्क्रिय';

  @override
  String get statusBusy => 'व्यस्त';

  @override
  String get statusPaused => 'अनुरोध रोके गए';

  @override
  String get workHours => 'काम के घंटे';

  @override
  String get upcomingAppointments => 'आगामी कार्य';

  @override
  String get blockedTime => 'अवरुद्ध समय';

  @override
  String get appPreferences => 'ऐप प्राथमिकताएं';

  @override
  String get pushNotifications => 'पुश सूचनाएं';

  @override
  String get smsAlerts => 'एसएमएस अलर्ट';

  @override
  String get locationServices => 'स्थान सेवाएं (हमेशा अनुमति दें)';

  @override
  String get cameraPermission => 'कैमरा और मीडिया पहुंच';

  @override
  String get cooperativeHelpline => 'सहकारी हेल्पलाइन';

  @override
  String get emergencySosTitle => 'आपातकालीन एसओएस';

  @override
  String get call112 => 'राष्ट्रीय आपातकालीन सेवाएं (112)';

  @override
  String get callDispatch => 'सहकारी आपातकालीन डिस्पैच';

  @override
  String get faqTitle => 'अक्सर पूछे जाने वाले प्रश्न';

  @override
  String get paymentDispute => 'भुगतान विवाद';

  @override
  String get sosAlertSent =>
      'एसओएस अलर्ट और स्थान सहकारी नियंत्रण केंद्र को भेज दिया गया है।';

  @override
  String get institutionDashboard => 'संस्थान कार्य';

  @override
  String get shiftHours => 'शिफ्ट का समय';

  @override
  String get fixedDuty => '8 घंटे निश्चित ड्यूटी';

  @override
  String get guaranteedPay => 'गारंटीकृत वेतन';

  @override
  String get directEscrow => 'सीधा एस्क्रो';

  @override
  String get peerRoster => 'सहकर्मी रोस्टर';

  @override
  String get allDispatched => 'सभी तैनात';

  @override
  String get liveDeployment => 'लाइव तैनाती';

  @override
  String get stageAssigned => 'आवंटित';

  @override
  String get stageJourney => 'यात्रा';

  @override
  String get stageEnRoute => 'मार्ग में';

  @override
  String get stageArrived => 'पहुंचे';

  @override
  String get stageToolInspection => 'उपकरण जांच';

  @override
  String get stageServiceWork => 'सेवा कार्य';

  @override
  String get stageSupervisorSignoff => 'हस्ताक्षर';

  @override
  String get stageCompleted => 'पूर्ण हुआ';

  @override
  String get siteSupervisor => 'साइट सुपरवाइजर';

  @override
  String get equipmentChecklist => 'उपकरण चेकलिस्ट';

  @override
  String get allToolsVerified => 'सभी सुरक्षा और स्वच्छता उपकरण सत्यापित';

  @override
  String get coursesTitle => 'प्रशिक्षण और कौशल विकास';

  @override
  String get certificatesEarned => 'प्रमाणपत्र';

  @override
  String get recommendedForYou => 'आपके लिए अनुशंसित';

  @override
  String get technicalCourses => 'तकनीकी';

  @override
  String get safetyCourses => 'सुरक्षा';

  @override
  String get startCourse => 'पाठ्यक्रम शुरू करें';

  @override
  String get resumeCourse => 'जारी रखें';

  @override
  String get hours => 'घंटे';

  @override
  String get modules => 'मॉड्यूल';

  @override
  String get schemesTitle => 'सहकारी कल्याणकारी योजनाएं';

  @override
  String get eligibleSchemes => 'पात्र';

  @override
  String get appliedSchemes => 'आवेदित';

  @override
  String get approvedSchemes => 'स्वीकृत';

  @override
  String get featuredScheme => 'विशेष योजना';

  @override
  String get viewStatus => 'स्थिति देखें';

  @override
  String get coverage => 'कवरेज';

  @override
  String get insuranceCategory => 'बीमा';

  @override
  String get welfareCategory => 'कल्याण';

  @override
  String get financialCategory => 'वित्तीय';

  @override
  String get noRequestsMsg => 'फिलहाल कोई नया सेवा अनुरोध उपलब्ध नहीं है';

  @override
  String get networkErrorTitle => 'इंटरनेट कनेक्शन नहीं है';

  @override
  String get networkErrorMsg =>
      'कृपया अपने मोबाइल डेटा या वाई-फाई कनेक्शन की जांच करें और पुनः प्रयास करें।';

  @override
  String get gpsErrorTitle => 'स्थान अनुमति आवश्यक है';

  @override
  String get gpsErrorMsg =>
      'यात्रा को ट्रैक करने और आगमन सत्यापित करने के लिए जीपीएस आवश्यक है।';

  @override
  String get enableGps => 'जीपीएस सक्षम करें';

  @override
  String get cameraErrorTitle => 'कैमरा अनुमति आवश्यक है';

  @override
  String get cameraErrorMsg =>
      'निरीक्षण और बिल की फोटो लेने के लिए कैमरा पहुंच आवश्यक है।';

  @override
  String get grantPermission => 'अनुमति दें';

  @override
  String get disputeTitle => 'कार्य विवाद दर्ज किया गया';

  @override
  String get disputeMsg =>
      'इस कार्य पर एक विवाद उठाया गया है। सहकारी समर्थन मामले की समीक्षा कर रहा है।';

  @override
  String get cancellationReasonLabel => 'कारण';

  @override
  String get cancellationTimestampLabel => 'समय';

  @override
  String get cancellationStatusLabel => 'स्थिति';

  @override
  String get connectingSupportHotline =>
      'सहकारी सोसायटी हेल्पलाइन से संपर्क किया जा रहा है...';

  @override
  String get callSupportNumber => '1800-425-9988 पर कॉल करें';

  @override
  String get supportTicketCreated =>
      'समर्थन टिकट सफलतापूर्वक बनाया गया! टिकट #TKT-8421';

  @override
  String get logTicket => 'टिकट दर्ज करें';

  @override
  String get telemetryDispatched => 'लाइव स्थान प्रेषित किया गया!';

  @override
  String dialingNumber(String number) {
    return '$number डायल किया जा रहा है...';
  }

  @override
  String get activeCoverage => 'सक्रिय कवरेज';

  @override
  String get viewHealthCardAndHospitals => 'स्वास्थ्य कार्ड और अस्पताल देखें';

  @override
  String get schemeVerificationCard => 'योजना सत्यापन कार्ड';

  @override
  String get policyNumberLabel => 'सहकारी सोसायटी पॉलिसी: COOP-MED-84920';

  @override
  String get policyStatusLabel => 'स्थिति: सक्रिय • वार्षिक नवीनीकृत';

  @override
  String get tpaHelplineLabel => 'टीपीए हेल्पलाइन: 1800-22-9988';

  @override
  String get customerServicesTitle => 'ग्राहक सेवाएं';

  @override
  String get customerServicesB2C => 'ग्राहक सेवाएं (B2C)';

  @override
  String urgentCount(String count) {
    return '$count जरूरी';
  }

  @override
  String nextScheduledAt(String time) {
    return 'अगला: $time';
  }

  @override
  String get thisMonth => 'इस महीने';

  @override
  String reviewsCount(String count) {
    return '($count समीक्षाएं)';
  }

  @override
  String get jobInProgress => 'कार्य प्रगति पर है';

  @override
  String estFee(String amount) {
    return '₹$amount अनुमानित';
  }

  @override
  String get jobDetailsAndBill => 'कार्य विवरण और बिल';

  @override
  String get mapNavigation => 'मानचित्र नेविगेशन';

  @override
  String get incomingRequestsDirect => 'आने वाले अनुरोध (प्रत्यक्ष)';

  @override
  String get yourProposedOnsiteFee => 'आपका प्रस्तावित ऑन-साइट शुल्क:';

  @override
  String get setOnsiteFee => 'ऑन-साइट शुल्क निर्धारित करें:';

  @override
  String acceptWithFee(String amount) {
    return '₹$amount के साथ स्वीकार करें';
  }

  @override
  String get reviewAndProposeFee => 'समीक्षा करें और शुल्क प्रस्तावित करें';

  @override
  String get confirmedVisitsNext24h => 'पुष्टित विज़िट (अगले 24 घंटे)';

  @override
  String remainingCount(String count) {
    return '$count शेष';
  }

  @override
  String get fieldHelpSafetySos => 'फील्ड सहायता और सुरक्षा एसओएस';

  @override
  String get directAgentResolutionLine => 'प्रत्यक्ष 24/7 एजेंट समाधान लाइन';

  @override
  String get otpAlertDescription =>
      'ग्राहक ओटीपी सत्यापित हो गया। कृपया अंतिम इनवॉइस बनाने से पहले पूर्णता ओटीपी दर्ज करें।';

  @override
  String viewAllCount(String count) {
    return 'सभी देखें ($count)';
  }

  @override
  String get confirmed => 'पुष्टित';

  @override
  String get serviceCompletionOtpTitle => 'सेवा पूर्णता ओटीपी';

  @override
  String get serviceCompletionOtpSubtitle => 'ग्राहक सेवा स्वीकृति';

  @override
  String askCustomerForCompletionOtp(String customerName) {
    return 'संतोषजनक सेवा सत्यापित करने के लिए $customerName से 4-अंकीय पूर्णता ओटीपी मांगें।';
  }

  @override
  String get completionOtpVerified => 'सेवा पूर्णता ओटीपी सत्यापित';

  @override
  String get proceedToPayment => 'बिलिंग और भुगतान के लिए आगे बढ़ें';

  @override
  String get verifyEndOtpAndComplete =>
      'अंतिम ओटीपी सत्यापित करें और पूर्ण करें';

  @override
  String get signedOff => 'हस्ताक्षरित';

  @override
  String get serviceCompletedProofAttached =>
      'प्रमाण तस्वीरें संलग्न और कार्यक्षेत्र साफ';
}
