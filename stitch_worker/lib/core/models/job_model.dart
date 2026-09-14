/// Canonical job status state machine from PLAN.md §69.
/// Business logic uses these status codes exclusively.
/// UI maps these to localized display strings — never the reverse.
enum JobStatus {
  newRequest,
  workerAccepted,
  waitingForCustomer,
  customerSelected,
  confirmed,
  reminder,
  enRoute,
  arrived,
  otpVerified,
  inspection,
  quotationDraft,
  quotationSent,
  quotationAccepted,
  quotationRejected,
  serviceInProgress,
  paymentPending,
  paymentProcessing,
  paymentCompleted,
  paymentFailed,
  invoiceGenerated,
  completed,
  visitFeeSettlement,
  cancelled,
  customerUnavailable,
  disputed,
  closed,
}

/// The type of job source — Customer (B2C) or Institution (B2B).
enum JobType { customer, institution }

/// Canonical job model consumed by all screens.
/// The same job instance must retain consistent data throughout its lifecycle.
class Job {
  final String jobId;
  final JobType type;
  final JobStatus status;
  final String customerName;
  final String customerInitials;
  final String serviceName;
  final String serviceCategory;
  final String address;
  final String? addressShort;
  final DateTime scheduledStart;
  final DateTime scheduledEnd;
  final double onsiteFee;
  final double labourCharge;
  final double materialCost;
  final double otherCharges;
  final double platformFeePercent;
  final String? customerPhone;
  final String? reportedProblem;
  final String? workerDiagnosis;
  final String? recommendedSolution;
  final double? distance;
  final String? institutionName;
  final String? assignmentId;
  final String? customerMemberSinceYear;
  final int customerCompletedServices;
  final List<String> problemPhotoLabels;
  final List<String> customerInstructions;

  const Job({
    required this.jobId,
    required this.type,
    required this.status,
    required this.customerName,
    required this.customerInitials,
    required this.serviceName,
    required this.serviceCategory,
    required this.address,
    this.addressShort,
    required this.scheduledStart,
    required this.scheduledEnd,
    this.onsiteFee = 150.0,
    this.labourCharge = 0.0,
    this.materialCost = 0.0,
    this.otherCharges = 0.0,
    this.platformFeePercent = 10.0,
    this.customerPhone,
    this.reportedProblem,
    this.workerDiagnosis,
    this.recommendedSolution,
    this.distance,
    this.institutionName,
    this.assignmentId,
    this.customerMemberSinceYear,
    this.customerCompletedServices = 0,
    this.problemPhotoLabels = const [],
    this.customerInstructions = const [],
  });

  /// Service subtotal = labour + material + other
  double get serviceSubtotal => labourCharge + materialCost + otherCharges;

  /// Platform fee in rupees
  double get platformFeeAmount => serviceSubtotal * (platformFeePercent / 100);

  /// Total payable by customer = subtotal + platform fee
  double get customerTotal => serviceSubtotal + platformFeeAmount;

  /// Create a copy with a new status (state machine transition)
  Job copyWithStatus(JobStatus newStatus) {
    return copyWith(status: newStatus);
  }

  /// Full copyWith — used when multiple fields need updating (e.g. quotation pricing).
  Job copyWith({
    JobStatus? status,
    double? labourCharge,
    double? materialCost,
    double? otherCharges,
    double? onsiteFee,
    double? platformFeePercent,
    String? workerDiagnosis,
    String? recommendedSolution,
    String? reportedProblem,
  }) {
    return Job(
      jobId: jobId,
      type: type,
      status: status ?? this.status,
      customerName: customerName,
      customerInitials: customerInitials,
      serviceName: serviceName,
      serviceCategory: serviceCategory,
      address: address,
      addressShort: addressShort,
      scheduledStart: scheduledStart,
      scheduledEnd: scheduledEnd,
      onsiteFee: onsiteFee ?? this.onsiteFee,
      labourCharge: labourCharge ?? this.labourCharge,
      materialCost: materialCost ?? this.materialCost,
      otherCharges: otherCharges ?? this.otherCharges,
      platformFeePercent: platformFeePercent ?? this.platformFeePercent,
      customerPhone: customerPhone,
      reportedProblem: reportedProblem ?? this.reportedProblem,
      workerDiagnosis: workerDiagnosis ?? this.workerDiagnosis,
      recommendedSolution: recommendedSolution ?? this.recommendedSolution,
      distance: distance,
      institutionName: institutionName,
      assignmentId: assignmentId,
      customerMemberSinceYear: customerMemberSinceYear,
      customerCompletedServices: customerCompletedServices,
      problemPhotoLabels: problemPhotoLabels,
      customerInstructions: customerInstructions,
    );
  }
}

/// Worker profile model
class WorkerProfile {
  final String workerId;
  final String name;
  final String initials;
  final String role;
  final double rating;
  final String tier;
  final int completedJobs;
  final int cancelledJobs;
  final double totalEarnings;
  final bool isVerified;
  final bool isAvailable;

  const WorkerProfile({
    required this.workerId,
    required this.name,
    required this.initials,
    required this.role,
    this.rating = 4.85,
    this.tier = 'Tier 1',
    this.completedJobs = 47,
    this.cancelledJobs = 2,
    this.totalEarnings = 48200,
    this.isVerified = true,
    this.isAvailable = true,
  });
}

/// Demo data matching PLAN.md §68 — consistent across all screens.
class DemoData {
  DemoData._();

  static const worker = WorkerProfile(
    workerId: 'WKR-2847',
    name: 'Ramesh Kumar',
    initials: 'RK',
    role: 'Senior Field Electrician',
  );

  static final customerJob = Job(
    jobId: 'C-4821',
    type: JobType.customer,
    status: JobStatus.confirmed,
    customerName: 'Priya Sharma',
    customerInitials: 'PS',
    serviceName: 'Plumbing Repair',
    serviceCategory: 'Plumbing Repair • Sink & Pipe Leakage',
    address: 'Flat 402, Shivani Apartments, Sector 22, Dwarka, New Delhi - 110077',
    addressShort: 'Sector 22, Dwarka',
    scheduledStart: DateTime(2024, 10, 24, 14, 0),
    scheduledEnd: DateTime(2024, 10, 24, 15, 30),
    onsiteFee: 150.0,
    labourCharge: 350.0,
    materialCost: 300.0,
    otherCharges: 0.0,
    platformFeePercent: 10.0,
    customerPhone: '+919871234567',
    reportedProblem:
        'Kitchen sink drain pipe leak and water seepage under cabinet with damp odor. Pools whenever water runs for more than 30 seconds.',
    workerDiagnosis:
        'Hairline fracture across 32mm PVC P-Trap collar junction; degraded rubber washer seal causing persistent drip leak under sink cabinet.',
    recommendedSolution:
        'Replace fractured 32mm PVC P-Trap with heavy-duty commercial unit, install new high-grade silicone gasket, apply sealant tape, and test pressure flow.',
    distance: 3.2,
    customerMemberSinceYear: '2023',
    customerCompletedServices: 14,
    problemPhotoLabels: ['Sink Drain Leak', 'Valve Drip'],
    customerInstructions: [
      'Please bring a pipe wrench, Teflon sealant tape, and a replacement washer kit.',
      'Building has elevator access; ring bell 402 on the 4th floor.',
      'Mask and cooperative ID card recommended during visit.',
    ],
  );

  /// A fresh, not-yet-accepted request — drives the New Job Request screen.
  static final newRequestJob = Job(
    jobId: 'C-4825',
    type: JobType.customer,
    status: JobStatus.newRequest,
    customerName: 'Priya Sharma',
    customerInitials: 'PS',
    serviceName: 'Plumbing Repair & Pipeline Leakage',
    serviceCategory: 'Home Services • On-Site Inspection',
    address: 'Flat 402, Shivani Apartments, Sector 22, Dwarka, South West Delhi - 110077',
    addressShort: 'Sector 22, Dwarka',
    scheduledStart: DateTime(2024, 10, 25, 14, 30),
    scheduledEnd: DateTime(2024, 10, 25, 16, 0),
    onsiteFee: 150.0,
    platformFeePercent: 10.0,
    customerPhone: '+919876543210',
    reportedProblem:
        'Main kitchen sink pipe dripping continuously and water pressure dropped across bathroom fixtures. Requires diagnosis, pipe resealing/replacement, and quick system flush.',
    distance: 3.8,
    customerMemberSinceYear: '2023',
    customerCompletedServices: 14,
    problemPhotoLabels: ['Sink Drain Leak', 'Valve Drip'],
    customerInstructions: [
      'Please bring a pipe wrench, Teflon sealant tape, and a replacement washer kit.',
      'Building has elevator access; ring bell 402 on the 4th floor.',
      'Mask and cooperative ID card recommended during visit.',
    ],
  );

  static final institutionJob = Job(
    jobId: 'JB-8841-DL',
    type: JobType.institution,
    status: JobStatus.enRoute,
    customerName: 'AIIMS New Delhi',
    customerInitials: 'AI',
    serviceName: 'Sanitation & Ward 4B Hygiene Support',
    serviceCategory: 'Sanitation',
    address: 'Ansari Nagar, Gate 4 Service Entry, Emergency Wing Loading Bay, New Delhi - 110029',
    addressShort: 'Ansari Nagar (Gate 4 Wing)',
    scheduledStart: DateTime(2024, 10, 24, 8, 0),
    scheduledEnd: DateTime(2024, 10, 24, 16, 0),
    institutionName: 'AIIMS New Delhi',
    assignmentId: 'JB-8841-DL',
    distance: 2.1,
  );
}
