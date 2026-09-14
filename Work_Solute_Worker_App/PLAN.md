# MASTER PROMPT

## COMPLETE COOPERATIVE WORKER MOBILE APPLICATION

### Flutter + Dart | Android | Exact Existing UI + Complete Workflow + Full Multilingual Support

Build a complete, production-ready **Android Worker Mobile Application** using:

* **Flutter**
* **Dart**
* Material 3 only where it does not conflict with the existing visual design
* Responsive mobile-first layouts
* Proper Flutter localization architecture
* Real navigation and state management
* Clean reusable components
* Production-quality error handling

The application must be based on the **existing uploaded Worker UI project**.

# VERY IMPORTANT: EXISTING UI IS THE SOURCE OF TRUTH

The uploaded project already contains the approved visual design.

**DO NOT redesign the application.**

The new Flutter application must visually match the existing uploaded UI as closely as technically possible.

Treat the uploaded screens as the **master design reference**.

Do not replace the visual language with a generic Flutter UI.

Do not create a new design system.

Do not introduce unrelated styling.

When adding missing screens, make them look as though they were designed at the same time as the existing screens.

---

# 1. EXISTING PRODUCT IDENTITY

Product concept:

**Cooperative Field Worker Platform**

The Worker application is an operational mobile application for field workers to:

* receive service requirements
* evaluate work requests
* accept or decline work
* become available to customers as a worker choice
* receive job confirmation
* navigate to customers
* use GPS tracking
* verify arrival using OTP
* inspect problems
* create quotations
* provide services
* record materials
* collect payment
* generate invoices
* complete jobs
* receive ratings
* track earnings
* view settlements
* access training
* access welfare/insurance schemes
* manage availability
* manage profile and credentials

The application must support both:

1. **Customer work**
2. **Institution work**

---

# 2. EXACT EXISTING VISUAL LANGUAGE

Preserve the visual character already established in the uploaded UI:

## Overall style

* professional
* institutional
* trustworthy
* modern
* field-ready
* operational
* information-dense but clean
* mobile-first
* highly legible
* restrained
* no unnecessary decoration

The application should feel like a **serious field operations product**, not a social media app, gaming app, fintech marketing app, or generic SaaS dashboard.

---

# 3. EXISTING COLOR SYSTEM

Use the existing palette from the uploaded application.

Primary cobalt:

`#1A56DB`

Deep navy:

`#0F223D`

Dark navy:

`#0D1B2A`

Darkest background:

`#0A1628`

Primary page background:

`#F4F7FB`

Soft surface:

`#F8FAFF`

White:

`#FFFFFF`

Light blue:

`#EFF4FF`

Primary text:

`#0F172A`

Secondary text:

`#64748B`

Border:

`#E2E8F0`

Success:

`#10B981`

Success light:

`#E6F7F0`

Warning:

`#F59E0B`

Warning light:

`#FFFBEB`

Error:

`#EF4444`

Error light:

`#FEF2F2`

Do not introduce arbitrary colors.

Use existing colors consistently across all newly created screens.

---

# 4. TYPOGRAPHY

Existing UI primarily uses:

**Inter**

Use Inter throughout.

For multilingual rendering also support appropriate fonts/fallbacks:

* Inter
* Noto Sans Tamil
* Noto Sans Devanagari
* Noto Sans Malayalam

The user-facing language can change, but the visual hierarchy must remain consistent.

Typography hierarchy must remain close to the uploaded UI:

* large page titles
* medium section headings
* compact labels
* strong metrics
* muted metadata
* readable body text

Do not radically increase font sizes.

---

# 5. EXISTING SHAPE LANGUAGE

Preserve existing geometry:

Cards:

approximately 16–24px radius depending on existing screen.

Buttons:

approximately 12px radius.

Pills:

fully rounded.

Avatar:

circular.

Input fields:

rounded approximately 12px.

Do not introduce giant 30–40px radius cards unless the existing screen already uses that treatment.

---

# 6. EXISTING HEADER SYSTEM

Preserve the existing navy header treatment.

Worker screens may contain:

* dark navy top area
* status-bar-safe padding
* back button
* centered title
* worker information
* notification icon
* compact metadata

Use the existing header style rather than creating a different AppBar.

---

# 7. EXISTING CARD SYSTEM

Cards must match the uploaded project:

* white surface
* subtle border
* very light shadow
* moderate radius
* compact spacing
* strong hierarchy
* operational information arranged clearly

Avoid:

* glassmorphism
* excessive blur
* heavy shadows
* gradients everywhere
* decorative blobs
* neon cards

The login screen may retain its existing subtle gradient/header treatment because that is already part of the approved design.

---

# 8. EXISTING NAVIGATION

Preserve the application's established bottom navigation:

**HOME | CUSTOMER | INSTITUTION | COURSES | SCHEMES**

Do not replace it with a new navigation system.

The selected tab must use the existing cobalt treatment.

Unselected tabs use muted slate.

Support safe-area insets.

---

# 9. MAIN WORKER APP STRUCTURE

Create the complete application:

```text
Authentication
│
└── Worker Application
    │
    ├── HOME
    │   ├── Availability
    │   ├── New Requests
    │   ├── Upcoming Jobs
    │   ├── Active Job
    │   ├── Notifications
    │   └── Operations
    │
    ├── CUSTOMER
    │   ├── Requests
    │   ├── Accepted
    │   ├── Waiting for Selection
    │   ├── Confirmed
    │   ├── Active
    │   └── History
    │
    ├── INSTITUTION
    │   ├── Requests
    │   ├── Assignments
    │   ├── Team
    │   ├── Tracking
    │   └── Completed
    │
    ├── COURSES
    │   ├── Available
    │   ├── Enrolled
    │   ├── In Progress
    │   └── Completed
    │
    ├── SCHEMES
    │   ├── Insurance
    │   ├── Welfare
    │   ├── Benefits
    │   └── Applications
    │
    └── PROFILE
        ├── Personal Details
        ├── Skills
        ├── Certifications
        ├── Ratings
        ├── Earnings
        ├── Settlements
        ├── Availability
        ├── Documents
        ├── Settings
        ├── Language
        └── Support
```

---

# 10. AUTHENTICATION

Create Flutter screens matching the existing login UI:

## Worker Login

Fields:

* Worker ID
* Password

Also:

* Language selector
* Forgot password
* Login
* support/help

Preserve the existing navy header and cooperative branding.

## Forgot Password

Flow:

Worker ID

→ OTP

→ New Password

→ Password Confirmation

→ Success

## Account Locked

Show reason and support action.

## Session Expired

Show clear re-login action.

---

# 11. MULTILINGUAL SUPPORT — CORE REQUIREMENT

This is one of the most important requirements.

The application MUST fully support:

### English

`en`

### Hindi

`hi`

### Tamil

`ta`

### Malayalam

`ml`

The language selector already exists conceptually in the uploaded login UI and must be made into a real Flutter localization system.

---

# 12. COMPLETE LANGUAGE SWITCH

When the worker chooses:

**Tamil**

the entire application must become Tamil.

Not only Login.

Not only Home.

The complete Worker application must switch.

That means:

* bottom navigation
* headers
* buttons
* forms
* dialogs
* job statuses
* job details
* notifications
* quotation
* payment
* invoice
* profile
* courses
* schemes
* settings
* support
* error messages
* empty states
* loading states
* GPS messages
* OTP messages

Everything user-facing.

---

# 13. LANGUAGE EXAMPLE

English:

```text
Home
Customer
Institution
Courses
Schemes

Start Journey
Accept
Decline
Waiting for Customer
Job Confirmed
Verify OTP
Inspection
Quotation
Payment Pending
Payment Completed
Invoice Generated
Completed
```

Tamil:

```text
முகப்பு
வாடிக்கையாளர்
நிறுவனம்
பயிற்சிகள்
திட்டங்கள்

பயணத்தை தொடங்கு
ஏற்கவும்
நிராகரிக்கவும்
வாடிக்கையாளர் தேர்வுக்காக காத்திருக்கிறது
வேலை உறுதி செய்யப்பட்டது
OTP சரிபார்க்கவும்
ஆய்வு
மேற்கோள்
பணம் செலுத்துதல் நிலுவையில்
பணம் செலுத்தப்பட்டது
விலைப்பட்டியல் உருவாக்கப்பட்டது
நிறைவு
```

Hindi:

```text
होम
ग्राहक
संस्थान
पाठ्यक्रम
योजनाएँ

यात्रा शुरू करें
स्वीकार करें
अस्वीकार करें
ग्राहक के चयन की प्रतीक्षा
काम की पुष्टि हुई
OTP सत्यापित करें
निरीक्षण
कोटेशन
भुगतान लंबित
भुगतान पूर्ण
इनवॉइस तैयार
पूर्ण
```

Malayalam:

```text
ഹോം
ഉപഭോക്താവ്
സ്ഥാപനം
കോഴ്‌സുകൾ
പദ്ധതികൾ

യാത്ര ആരംഭിക്കുക
സ്വീകരിക്കുക
നിരസിക്കുക
ഉപഭോക്താവിന്റെ തിരഞ്ഞെടുപ്പിനായി കാത്തിരിക്കുന്നു
ജോലി സ്ഥിരീകരിച്ചു
OTP പരിശോധിക്കുക
പരിശോധന
ക്വട്ടേഷൻ
പേയ്മെന്റ് കാത്തിരിക്കുന്നു
പേയ്മെന്റ് പൂർത്തിയായി
ഇൻവോയ്സ് സൃഷ്ടിച്ചു
പൂർത്തിയായി
```

Use natural worker-friendly terminology in each language.

Do not use poor literal machine translation.

---

# 14. FLUTTER LOCALIZATION ARCHITECTURE

Use proper Flutter localization.

Preferred architecture:

```text
lib/
  l10n/
    app_en.arb
    app_hi.arb
    app_ta.arb
    app_ml.arb
```

Use Flutter's localization infrastructure:

* `flutter_localizations`
* generated localization classes
* ARB resources
* locale-aware formatting

Every visible string must come from localization resources.

Never scatter hard-coded English strings throughout widgets.

Example:

```dart
AppLocalizations.of(context)!.startJourney
```

not:

```dart
Text("Start Journey")
```

---

# 15. LANGUAGE PERSISTENCE

When the worker selects Tamil:

save:

`ta`

When the application is reopened:

restore Tamil.

Do not require:

* restart
* logout
* reinstall

The selected language persists.

Store the preference locally and synchronize with the worker profile if backend integration exists.

---

# 16. BUSINESS LOGIC MUST NOT BE TRANSLATED

Internal status codes remain language-independent.

Example:

```text
JOB_CONFIRMED
PAYMENT_PENDING
PAYMENT_COMPLETED
QUOTATION_REJECTED
```

Only presentation is translated.

IDs remain unchanged:

* Worker ID
* Job ID
* Invoice number
* Transaction ID
* UTR
* OTP

Names and addresses must not be translated automatically.

---

# 17. CUSTOMER JOB WORKFLOW

Implement this exact workflow:

```text
Customer creates requirement
        ↓
Eligible workers receive request
        ↓
Worker views request
        ↓
Worker checks schedule
        ↓
Worker Accepts / Declines
        ↓
Worker becomes a candidate
        ↓
Customer receives worker choice
        ↓
Customer selects worker
        ↓
Worker is notified
        ↓
JOB CONFIRMED
        ↓
1-hour reminder
        ↓
On Time / Delay / Cancel
        ↓
START JOURNEY
        ↓
GPS tracking
        ↓
ARRIVAL
        ↓
OTP verification
        ↓
Determine job type
```

---

# 18. NEW JOB REQUEST UI

Create a dedicated screen/state:

**NEW SERVICE REQUEST**

Display:

* Job ID
* customer
* service
* reported problem
* customer photos
* requested date
* requested time
* estimated duration
* distance
* location
* onsite required
* onsite fee
* schedule compatibility

Buttons:

**DECLINE**

**ACCEPT**

---

# 19. SCHEDULE VALIDATION

Before worker acceptance, validate:

* existing jobs
* working hours
* overlapping appointments
* estimated travel time
* service zone
* qualification
* certification
* active/inactive status

If impossible:

show:

**CANNOT ACCEPT THIS REQUEST**

Explain why.

---

# 20. CUSTOMER CHOICE SCREEN

After worker accepts:

**WAITING FOR CUSTOMER SELECTION**

Show:

* worker candidate status
* customer selection pending
* expiration time
* job details

When chosen:

**CUSTOMER SELECTED YOU ✓**

Then:

**JOB CONFIRMED**

---

# 21. CONFIRMED JOB SCREEN

Display:

* customer
* service
* job ID
* date
* time
* address
* location
* map
* distance
* onsite requirement
* onsite fee
* platform fee
* notes

Actions:

* Start Journey
* Reschedule
* Cancel
* Contact Customer

---

# 22. REMINDER UI

One hour before job:

**JOB STARTS IN 1 HOUR**

Actions:

* On Time
* Delay
* Cancel

---

# 23. DELAY FLOW

Create:

**REPORT DELAY**

Options:

* +15 minutes
* +30 minutes
* +45 minutes
* custom

Reasons:

* traffic
* previous job delay
* vehicle issue
* weather
* emergency
* other

Allow:

**NOTIFY CUSTOMER**

---

# 24. CANCELLATION FLOW

Create:

**CANCEL JOB**

Reasons:

* schedule conflict
* emergency
* vehicle problem
* customer unavailable
* unsafe location
* incorrect job details
* other

Show possible consequences.

Then:

**JOB CANCELLED**

Show:

* cancelled by
* reason
* time
* penalty/fee
* customer notified

---

# 25. START JOURNEY

Before leaving:

**START JOURNEY**

Show:

* destination
* distance
* ETA
* GPS status
* location permission status

Once started:

**EN ROUTE**

GPS tracking begins.

---

# 26. GPS TRACKING

Create live navigation UI matching the existing project.

Show:

* map
* worker position
* customer location
* route
* distance
* ETA
* elapsed journey time
* GPS status

Actions:

* call
* message
* SOS

Support GPS failure and weak signal states.

---

# 27. ARRIVAL UI

When worker reaches customer:

**ARRIVED AT LOCATION**

Verify:

* geofence
* GPS
* arrival time

Then:

**VERIFY CUSTOMER OTP**

---

# 28. OTP UI

States:

* enter OTP
* incorrect OTP
* expired OTP
* resend
* OTP verified
* customer not responding

After verification:

**ARRIVAL VERIFIED**

Then:

**INSPECTION READY**

---

# 29. CUSTOMER NOT RESPONDING

Create:

**CUSTOMER NOT RESPONDING**

Actions:

* Call
* Message
* Wait
* Report Customer Unavailable

Record arrival proof.

Show whether onsite fee eligibility applies.

---

# 30. ONSITE SERVICE FLOW

For onsite-required jobs:

```text
OTP Verified
      ↓
Inspection
      ↓
Problem Diagnosis
      ↓
Worker Creates Quotation
      ↓
Quotation Sent
      ↓
Customer Accepts / Rejects
```

---

# 31. INSPECTION UI

Show:

* reported issue
* customer images
* worker findings
* notes
* camera
* photos
* diagnosis
* recommended solution
* estimated labour
* material requirements

Maintain existing UI style.

---

# 32. DIAGNOSIS UI

Worker can enter:

* issue
* root cause
* recommendation
* labour hours
* labour amount
* materials
* quantity
* unit price
* notes
* proof

---

# 33. QUOTATION BUILDER

Create:

**SERVICE QUOTATION**

Sections:

Labour

Materials

Service subtotal

Platform fee

Onsite fee where applicable

Customer total

Platform-controlled charges must be calculated by the system.

Worker-controlled service/material charges must be separate.

---

# 34. QUOTATION PREVIEW

Show:

* quotation ID
* Job ID
* worker
* customer
* service
* labour
* materials
* onsite fee
* platform fee
* total
* notes
* validity

Button:

**SEND QUOTATION**

---

# 35. QUOTATION SENT

State:

**WAITING FOR CUSTOMER**

Actions:

* view
* contact
* edit where allowed

---

# 36. QUOTATION ACCEPTED

State:

**QUOTATION APPROVED ✓**

Show approved amount.

Action:

**START SERVICE**

---

# 37. QUOTATION REJECTED

State:

**QUOTATION NOT APPROVED**

Show:

* rejection reason
* service quotation
* onsite fee
* platform fee
* amount payable
* next action

If business rule says no service proceeds:

close the job after applicable visit charges.

---

# 38. NO-ONSITE WORKFLOW

For services that do not require onsite inspection:

```text
JOB CONFIRMED
      ↓
DIRECT SERVICE
      ↓
MATERIALS / PROOF
      ↓
SERVICE CHARGE
      ↓
PLATFORM FEE
      ↓
PAYMENT
      ↓
INVOICE
      ↓
COMPLETED
```

Do not show unnecessary OTP/inspection/quotation screens for direct-service jobs.

---

# 39. SERVICE EXECUTION UI

Show:

* job
* customer
* service
* start time
* task checklist
* work instructions
* notes
* materials

Action:

**SERVICE COMPLETED**

---

# 40. MATERIAL PROOF UI

Allow:

* material item
* quantity
* unit price
* amount
* receipt image
* material proof
* before photo
* after photo

---

# 41. SERVICE COMPLETION

Show final financial summary:

* labour/service
* materials
* platform fee
* onsite fee
* discounts if supported
* final amount

Action:

**REQUEST PAYMENT**

---

# 42. PAYMENT UI

Support all states:

## Pending

Waiting for payment.

## Processing

Transaction in progress.

## Successful

Display:

* amount
* transaction ID
* payment mode

## Failed

Display:

* failure reason
* retry
* alternate payment method
* support

## Partial Payment

Display:

* received
* remaining
* settlement status

---

# 43. INVOICE UI

Generate invoice based on final transaction data.

Show:

* invoice number
* Job ID
* customer
* worker
* service
* labour/service
* materials
* platform fee
* onsite fee
* applicable taxes
* total
* transaction ID
* payment status
* date

Actions:

* view
* share
* download/print

---

# 44. JOB COMPLETION UI

State:

**JOB COMPLETED ✓**

Show:

* completion time
* final amount
* payment status
* invoice number

Then allow customer rating.

---

# 45. RATING UI

Show:

* star rating
* customer feedback
* worker performance

After rating:

**THANK YOU**

Update profile metrics.

---

# 46. JOB HISTORY

Create dedicated screen:

Filters:

* All
* Completed
* Cancelled
* Rejected
* In Progress

Each item:

* Job ID
* customer
* service
* date
* amount
* status

Tap → Job Details.

---

# 47. COMPLETED JOB DETAILS

Show historical record:

* request
* acceptance
* customer selection
* confirmation
* journey
* arrival
* OTP
* inspection
* quotation
* service
* materials
* payment
* invoice
* rating

Historical financial information becomes read-only.

---

# 48. EARNINGS UI

Create dedicated Earnings screen.

Show:

* today
* weekly
* monthly
* financial year

Breakdown:

* service earnings
* onsite earnings
* reimbursements
* bonuses
* deductions
* pending earnings
* settled earnings

---

# 49. SETTLEMENT UI

Create:

## Pending Settlement

* amount
* included jobs
* expected settlement
* settlement method
* status

## Settlement History

* settlement ID
* date
* amount
* status

---

# 50. NOTIFICATIONS

Create:

* job request notifications
* customer selected
* confirmation
* reminder
* delay
* quotation
* payment
* invoice
* course
* scheme
* system

Actionable notifications must deep-link to the relevant screen.

Notifications must use the worker's selected language.

---

# 51. CUSTOMER WORKSPACE

Preserve and extend the existing Customer workspace.

Support:

* requests
* current jobs
* upcoming jobs
* accepted jobs
* completed jobs
* cancellation
* reschedule
* contact
* history

---

# 52. INSTITUTION WORKSPACE

Preserve existing Institution screens and visual style.

Support:

* institution dashboard
* request details
* assignment
* team
* scheduling
* tracking
* arrival
* verification
* service
* completion
* history

---

# 53. COURSES

Create:

Available Courses

→ Course Details

→ Enrollment

→ Training Progress

→ Completion

→ Certificate

Preserve existing course UI.

---

# 54. SCHEMES

Create:

Available Schemes

→ Scheme Details

→ Eligibility

→ Application

→ Verification

→ Approval/Rejection

Preserve existing scheme UI.

---

# 55. WORKER PROFILE

Preserve the uploaded profile design.

Show:

* worker identity
* worker ID
* role
* verification
* rating
* cooperative tier
* completed
* cancelled
* earnings
* skills
* certifications
* performance
* training
* settlement

Add access to:

* availability
* documents
* payment details
* settings
* language
* support

---

# 56. WORKER AVAILABILITY

Create dedicated screen:

States:

**ACTIVE**

**INACTIVE**

**BUSY**

**REQUESTS PAUSED**

Allow:

* active/inactive toggle
* working hours
* service availability

Make the state visible from Home.

---

# 57. SCHEDULE

Create Worker Schedule.

Show:

* calendar
* upcoming jobs
* completed jobs
* blocked times
* working hours

Use schedule data during new-request acceptance.

---

# 58. RESCHEDULE

Create:

Current appointment

→ Worker selects new time

→ Reason

→ Customer approval

States:

* requested
* waiting
* approved
* rejected

---

# 59. EMPTY STATES

Create theme-consistent empty screens for:

* no requests
* no upcoming jobs
* no active job
* no completed jobs
* no notifications
* no courses
* no schemes
* no earnings
* no settlements

Use concise copy.

---

# 60. ERROR STATES

Create complete visual states for:

* server unavailable
* network unavailable
* API failure
* timeout
* invalid OTP
* expired OTP
* payment failure
* upload failure
* GPS unavailable
* permission denied
* geofence failure
* session expired

Every error must explain:

**what happened + what the worker can do next**

---

# 61. LOCATION PERMISSION

Create a branded permission-explanation UI before the Android permission request.

Explain that location is required for:

* journey tracking
* arrival verification
* customer safety
* service verification

---

# 62. CAMERA / MEDIA PERMISSION

Explain that camera/photo access is required for:

* inspection
* material proof
* before/after evidence
* service documentation

---

# 63. NOTIFICATION PERMISSION

Explain that notification permission is needed for:

* new jobs
* customer selection
* reminders
* quotation results
* payment updates

---

# 64. SOS / EMERGENCY

Create operational SOS screen.

Show:

* emergency assistance
* call emergency services
* cooperative support
* share live location

Preserve the application's navy/white/cobalt style.

---

# 65. SUPPORT

Create:

* Help Center
* FAQ
* Contact Support
* Payment Issue
* Job Dispute
* Technical Issue
* Customer Issue
* Unsafe Location

---

# 66. SECURITY SETTINGS

Create:

* change password
* biometric option if supported
* session/device management
* logout
* account lock information

---

# 67. FINANCIAL RULES

Keep these concepts separate in all UI:

**Service/Labour Charge**

**Material Cost**

**Onsite Fee**

**Platform Fee**

**Customer Total**

**Worker Earnings**

**Settlement Amount**

Do not combine them into ambiguous amounts.

---

# 68. DATA CONSISTENCY

All screens must consume the same job model.

Example demo record:

```text
Job ID:
C-4821

Customer:
Priya Sharma

Service:
Plumbing Repair

Address:
Flat 402, Shivani Apartments,
Sector 22, Dwarka

Schedule:
2:00 PM – 3:30 PM

Onsite Fee:
₹150

Platform Fee:
System calculated
```

Do not randomly change:

* job IDs
* customer names
* addresses
* schedules
* prices
* statuses

between screens.

The same job must remain the same throughout its lifecycle.

---

# 69. JOB STATUS MODEL

Use one canonical state machine.

```text
NEW_REQUEST
↓
WORKER_ACCEPTED
↓
WAITING_FOR_CUSTOMER
↓
CUSTOMER_SELECTED
↓
CONFIRMED
↓
REMINDER
↓
EN_ROUTE
↓
ARRIVED
↓
OTP_VERIFIED
↓
INSPECTION
↓
QUOTATION_DRAFT
↓
QUOTATION_SENT
↓
QUOTATION_ACCEPTED
↓
SERVICE_IN_PROGRESS
↓
PAYMENT_PENDING
↓
PAYMENT_PROCESSING
↓
PAYMENT_COMPLETED
↓
INVOICE_GENERATED
↓
COMPLETED
```

Alternative branches:

```text
QUOTATION_REJECTED
→ VISIT_FEE_SETTLEMENT
→ CLOSED
```

```text
CANCELLED
```

```text
CUSTOMER_UNAVAILABLE
```

```text
PAYMENT_FAILED
```

```text
DISPUTED
```

No screen should invent its own status terminology.

---

# 70. FLUTTER ARCHITECTURE

Use a maintainable structure such as:

```text
lib/
├── app/
│   ├── app.dart
│   ├── router.dart
│   └── theme/
│
├── core/
│   ├── constants/
│   ├── localization/
│   ├── services/
│   ├── utils/
│   └── widgets/
│
├── features/
│   ├── auth/
│   ├── home/
│   ├── customer/
│   ├── institution/
│   ├── courses/
│   ├── schemes/
│   ├── jobs/
│   ├── navigation/
│   ├── inspection/
│   ├── quotation/
│   ├── payment/
│   ├── invoice/
│   ├── earnings/
│   ├── settlements/
│   ├── profile/
│   ├── notifications/
│   ├── support/
│   └── settings/
│
└── l10n/
    ├── app_en.arb
    ├── app_hi.arb
    ├── app_ta.arb
    └── app_ml.arb
```

Use reusable components rather than duplicating UI code.

---

# 71. STATE MANAGEMENT

Use a proper state-management solution suitable for production.

The exact package can be selected by the implementation team, but state must be centralized for:

* authentication
* selected language
* availability
* worker profile
* jobs
* job state
* notifications
* earnings
* settlements

Do not make business logic live inside individual UI widgets.

---

# 72. NAVIGATION

Use a proper routing system.

Deep-link capable destinations:

* job
* notification
* quotation
* invoice
* settlement
* course
* scheme

Back navigation must work correctly.

Protect authenticated screens.

---

# 73. RESPONSIVE MOBILE UI

Primary target:

Android phones.

Support:

* small phones
* standard 390px-ish layouts
* larger Android devices

Avoid hard-coded widths that cause clipping.

Support:

* SafeArea
* keyboard
* scrolling
* dynamic multilingual text length

Tamil/Malayalam/Hindi can require more vertical space than English.

Cards and buttons must grow dynamically rather than clipping text.

---

# 74. ANDROID INTEGRATION

Prepare the application for:

* GPS
* location permission
* camera
* notifications
* background-safe journey tracking architecture
* secure storage
* Android lifecycle events

Do not implement unsafe continuous background location behavior without the appropriate Android permission/service architecture.

---

# 75. OFFLINE / NETWORK AWARENESS

The app should clearly indicate:

* offline
* syncing
* reconnecting
* failed action

For field workers, important completed actions must not silently disappear when connectivity is poor.

Where appropriate, queue safe local actions and sync them later.

---

# 76. ACCESSIBILITY

Maintain:

* sufficient contrast
* readable labels
* minimum 44–48px touch targets
* semantic labels
* icon + text for important actions
* screen-reader compatibility
* dynamic text wrapping

Never rely only on color to communicate status.

---

# 77. LOADING STATES

Create skeleton/loading states consistent with existing cards.

Avoid generic full-screen circular loaders for every action.

Use:

* skeleton cards
* progress indicators
* disabled button states
* upload progress
* transaction progress

---

# 78. CONFIRMATION UI

Create reusable confirmation dialogs/bottom sheets for:

* accept
* decline
* cancel
* start journey
* submit quotation
* start service
* complete service
* request payment
* logout
* deactivate availability

Use the existing white-card/cobalt/n심avy style.

---

# 79. EXACT VISUAL MATCH REQUIREMENT

When implementing the Flutter version:

Compare each Flutter screen against the uploaded reference UI.

Match as closely as possible:

* layout
* spacing
* padding
* typography
* colors
* card positions
* header height
* button size
* icon placement
* status chips
* bottom navigation
* shadows
* borders
* visual hierarchy

Do not simplify the existing UI into generic Flutter widgets.

Use custom widgets where necessary to reproduce the design accurately.

---

# 80. DO NOT DO THESE THINGS

Do NOT:

* redesign the UI
* switch to a different theme
* introduce dark mode
* introduce neon colors
* introduce gradients everywhere
* use excessive illustrations
* use cartoon icons
* use oversized cards
* use excessive rounded corners
* use random fonts
* use random icon styles
* use hard-coded English text
* create inconsistent sample data
* remove existing Customer/Institution functionality
* omit missing exception states
* make worker acceptance equal final confirmation
* make platform fees manually editable
* show unnecessary onsite steps for non-onsite jobs

---

# 81. REQUIRED COMPLETENESS CHECK

Before considering the application complete, verify that the following all exist:

### Authentication

Login
Forgot password
OTP
Locked account
Session expired

### Home

Dashboard
Availability
New request
Empty state
Upcoming jobs
Active job
Notifications

### Customer

Request
Job details
Accept
Decline
Waiting for customer
Customer selected
Confirmed
Journey
Arrival
OTP
Inspection
Quotation
Service
Payment
Invoice
Completion
Rating
History

### Institution

Dashboard
Request
Assignment
Team
Tracking
Arrival
Service
Completion
History

### Courses

Available
Details
Enrollment
Progress
Completion
Certificate

### Schemes

Available
Details
Eligibility
Application
Status
Approved
Rejected

### Profile

Profile
Skills
Certifications
Performance
Earnings
Settlements
Availability
Documents
Settings
Language
Support

### Exceptions

Delay
Cancel
Reschedule
Customer unavailable
GPS unavailable
Permission denied
Network error
Payment failed
Quotation rejected
Upload failed
Dispute
SOS

---

# 82. MULTILINGUAL FINAL ACCEPTANCE TEST

The application is NOT complete unless this works:

## Test 1

Login in English.

Navigate through the complete Worker workflow.

## Test 2

Change language to Hindi.

Every screen becomes Hindi.

## Test 3

Change language to Tamil.

Every screen becomes Tamil.

## Test 4

Change language to Malayalam.

Every screen becomes Malayalam.

## Test 5

Close the app.

Reopen it.

The selected language remains active.

## Test 6

Generate a new-job notification.

Notification appears in the selected language.

## Test 7

Trigger:

* validation error
* payment error
* OTP error
* GPS error
* cancellation
* quotation rejection

All appear in the selected language.

## Test 8

Navigate through every bottom-navigation tab.

All tabs remain localized.

---

# 83. FINAL PRODUCT PRINCIPLE

The result must feel like:

**THE SAME EXISTING WORKER APP — COMPLETED, NOT REDESIGNED.**

The uploaded Worker UI is the visual source of truth.

Add every missing operational screen and state while preserving its existing appearance.

The final application must be:

**Flutter + Dart + Android**

with:

**English + Hindi + Tamil + Malayalam**

and language switching must be:

**complete + immediate + persistent + production-ready.**

The most important requirement is:

> **When the worker selects Tamil, the entire application must operate in Tamil. When the worker selects Hindi, the entire application must operate in Hindi. When the worker selects Malayalam, the entire application must operate in Malayalam. English must remain fully supported.**

Do not leave any user-facing English text untranslated in localized modes.

The existing visual identity, layout language, colors, spacing, cards, navigation, and component style must remain consistent across all four languages.
