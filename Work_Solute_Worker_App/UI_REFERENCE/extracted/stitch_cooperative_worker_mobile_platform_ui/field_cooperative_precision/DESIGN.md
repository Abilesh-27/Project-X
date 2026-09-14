---
name: Field Cooperative Precision
colors:
  surface: '#f8f9ff'
  surface-dim: '#cbdbf5'
  surface-bright: '#f8f9ff'
  surface-container-lowest: '#ffffff'
  surface-container-low: '#eff4ff'
  surface-container: '#e5eeff'
  surface-container-high: '#dce9ff'
  surface-container-highest: '#d3e4fe'
  on-surface: '#0b1c30'
  on-surface-variant: '#434654'
  inverse-surface: '#213145'
  inverse-on-surface: '#eaf1ff'
  outline: '#737686'
  outline-variant: '#c3c5d7'
  surface-tint: '#1353d8'
  primary: '#003fb1'
  on-primary: '#ffffff'
  primary-container: '#1a56db'
  on-primary-container: '#d4dcff'
  inverse-primary: '#b5c4ff'
  secondary: '#565e74'
  on-secondary: '#ffffff'
  secondary-container: '#dae2fd'
  on-secondary-container: '#5c647a'
  tertiary: '#005439'
  on-tertiary: '#ffffff'
  tertiary-container: '#006f4d'
  on-tertiary-container: '#7ff2be'
  error: '#ba1a1a'
  on-error: '#ffffff'
  error-container: '#ffdad6'
  on-error-container: '#93000a'
  primary-fixed: '#dbe1ff'
  primary-fixed-dim: '#b5c4ff'
  on-primary-fixed: '#00174d'
  on-primary-fixed-variant: '#003dab'
  secondary-fixed: '#dae2fd'
  secondary-fixed-dim: '#bec6e0'
  on-secondary-fixed: '#131b2e'
  on-secondary-fixed-variant: '#3f465c'
  tertiary-fixed: '#85f8c4'
  tertiary-fixed-dim: '#68dba9'
  on-tertiary-fixed: '#002114'
  on-tertiary-fixed-variant: '#005137'
  background: '#f8f9ff'
  on-background: '#0b1c30'
  surface-variant: '#d3e4fe'
typography:
  headline-lg:
    fontFamily: Inter
    fontSize: 28px
    fontWeight: '700'
    lineHeight: 34px
    letterSpacing: -0.02em
  headline-md:
    fontFamily: Inter
    fontSize: 22px
    fontWeight: '700'
    lineHeight: 28px
    letterSpacing: -0.015em
  headline-sm:
    fontFamily: Inter
    fontSize: 18px
    fontWeight: '600'
    lineHeight: 24px
    letterSpacing: -0.01em
  title-md:
    fontFamily: Inter
    fontSize: 16px
    fontWeight: '600'
    lineHeight: 22px
    letterSpacing: -0.005em
  body-lg:
    fontFamily: Inter
    fontSize: 15px
    fontWeight: '400'
    lineHeight: 22px
  body-md:
    fontFamily: Inter
    fontSize: 13px
    fontWeight: '400'
    lineHeight: 18px
  body-sm:
    fontFamily: Inter
    fontSize: 12px
    fontWeight: '400'
    lineHeight: 16px
  label-lg:
    fontFamily: Inter
    fontSize: 13px
    fontWeight: '600'
    lineHeight: 16px
    letterSpacing: 0.01em
  label-md:
    fontFamily: Inter
    fontSize: 11px
    fontWeight: '600'
    lineHeight: 14px
    letterSpacing: 0.03em
  label-sm:
    fontFamily: Inter
    fontSize: 10px
    fontWeight: '700'
    lineHeight: 12px
    letterSpacing: 0.05em
  metric-display:
    fontFamily: Inter
    fontSize: 20px
    fontWeight: '700'
    lineHeight: 24px
    letterSpacing: -0.02em
rounded:
  sm: 0.25rem
  DEFAULT: 0.5rem
  md: 0.75rem
  lg: 1rem
  xl: 1.5rem
  full: 9999px
spacing:
  space-xxs: 0.25rem
  space-xs: 0.5rem
  space-sm: 0.75rem
  space-md: 1rem
  space-lg: 1.25rem
  space-xl: 1.5rem
  space-2xl: 2rem
  space-3xl: 2.5rem
  margin-screen: 1rem
  gutter-grid: 0.75rem
---

## Brand & Style

This design system delivers an institutional, high-reliability mobile utility built specifically for cooperative field service workers, technicians, and municipal service agents. The visual language bridges trusted civic enterprise utility with modern consumer clarity. 

The emotional tone balances institutional security, operational clarity, and professional dignity. Field workers operating under variable ambient lighting and fast-paced real-world conditions require immediate legibility, unambiguous hierarchy, and clear state communication. 

The aesthetic is Modern Corporate Utility: crisp pure-white structural containers floating above subtle cool-slate canvas layers, punctuated by deep authoritative cobalt accents, rich navy typography, and muted status indicators. Every element serves an operational purpose, avoiding decorative clutter while maintaining high tactile quality through refined micro-radii, structured 1px framing, and subtle elevation tiers.

## Colors

The palette is engineered around high contrast, functional separation, and low visual fatigue for sustained daily field usage.

- **Primary Canvas (`#F4F7FA`)**: A calm, cool-tinted neutral surface that eliminates eye strain from raw white backdrops and provides clear boundaries for white card modules.
- **Surface Pure (`#FFFFFF`)**: Reserved exclusively for cards, action sheets, headers, and interactive containers.
- **Primary Brand Blue (`#1A56DB`) & Deep Cobalt (`#1E40AF`)**: The primary vehicle for interaction, active workspace indicators, and high-priority primary buttons.
- **Executive Navy (`#0F172A`) & Slate Dark (`#1E293B`)**: Applied across headings, job titles, and essential numerical counters to ensure maximum legibility against white and light-gray surfaces.
- **Muted Slate (`#64748B`)**: Used for secondary text, metadata timestamps, breadcrumbs, and inactive icon states.
- **Status & Operational Semantics**:
  - *Success / Active / Verified*: Emerald green (`#059669`) paired with a soft mint container tint (`#ECFDF5`).
  - *Warning / Urgent / Pending*: Controlled warm amber (`#D97706` / `#EA580C`) paired with warm amber tint (`#FFFBEB`). Harsh fluorescent reds are deliberately omitted in favor of clear, non-alarming operational urgency.
  - *Borders & Separators (`#E2E8F0`)*: Hairline definitions (1px) preserving structural crispness without visual noise.

## Typography

Typography relies on **Inter** configured with tight negative tracking on display and headline tiers, and generous x-height legibility across dense data clusters.

- **Scale & Contrast**: Numbers indicating key metrics (e.g., pending requests, upcoming jobs, active assignments) use heavy weights (`700`) paired with uppercase metadata labels (`label-sm` at 10px with `0.05em` letter spacing) to allow instantaneous scanning on small screens.
- **Section & Workspace Identifiers**: Titles use `title-md` or `headline-sm` with Navy `#0F172A` tone to root structural sections solidly within the card hierarchy.
- **Metadata and Timestamps**: Rendered in `body-sm` (`#64748B`), balancing legibility with clear secondary visual priority.

## Layout & Spacing

The layout is built upon an 8-point spatial grid system (with a 4px sub-grid for compact pills, badges, and inline icon offsets).

- **Screen Margins**: A constant `16px` (`space-md`) horizontal safe gutter is enforced on mobile screens, expanding to `24px` on tablet viewports.
- **Card Padding**: Inner card containers utilize `16px` padding uniformly, reducing to `12px` (`space-sm`) for nested sub-cards or status rows.
- **Vertical Rhythm**:
  - `8px` between related text elements (title and metadata).
  - `12px` to `16px` between content blocks within a module card.
  - `16px` gap separating independent card modules (e.g., between the "Customer" and "Institution" workspaces).
  - `24px` between global page sections.
- **Touch Ergonomics**: All interactive elements maintain a minimum target height of `44px` to `48px`. Secondary inline actions within cards adhere strictly to `36px`–`40px` touch envelopes.

## Elevation & Depth

This design system avoids heavy shadows, utilizing a combination of low-contrast hairline borders, soft ambient drop shadows, and subtle tonal layering to express physical structure.

- **Level 0 (Flat Canvas)**: `#F4F7FA` background canvas.
- **Level 1 (Module Card Surface)**: Crisp `#FFFFFF` container with a 1px border (`#E2E8F0`) and an ambient shadow: `box-shadow: 0 1px 3px rgba(15, 23, 42, 0.04), 0 4px 12px rgba(15, 23, 42, 0.03)`. This renders cards tactile and detached from the slate canvas without appearing lifted or floating excessively.
- **Level 2 (Active Overlays & Primary Modals)**: Used for status notification overlays, bottom navigation bars, and sticky action footers: `box-shadow: 0 4px 6px -1px rgba(15, 23, 42, 0.06), 0 10px 15px -3px rgba(15, 23, 42, 0.05)`.
- **Level 3 (Interactive Active Banner)**: Dark or tinted high-visibility cards (such as the "Active Day" availability card) utilize a saturated primary blue fill (`#1A56DB`) with an ambient primary-tinted shadow: `box-shadow: 0 4px 14px rgba(26, 86, 219, 0.25)`.

## Shapes

The shape geometry utilizes a standardized radius scale:
- **Card Containers**: `16px` (`rounded-xl`) outer radius for all primary workspace modules, creating a soft, approachable frame that avoids clinical sharpness.
- **Nested Sub-Containers & Inner Rows**: `10px` to `12px` (`rounded-lg`), ensuring proportional concentricity inside parent cards.
- **Buttons**: `12px` on primary operational buttons; `9999px` (full pill) on quick-toggle switches and category status badges.
- **Pills & Badges**: Fully rounded (`9999px`) for count badges, verified tags, and status chips (e.g., "In Progress", "En Route", "3 New").

## Components

### 1. Workspace Card Modules (Customer & Institution)
- **Structure**: High-contrast white card (`16px` radius, 1px border in `#E2E8F0`, Level 1 ambient shadow).
- **Header**: Icon container (`40x40px`, `10px` radius, subtle colored background `#EFF6FF` for Customer or `#F5F3FF` for Institution), paired with a bold Navy title, subtle descriptor, and a pill-shaped counter tag on the top right (`#FFFBEB` with amber text or `#FAF5FF` with purple text).
- **Metric Row**: A clean, 3-column partitioned stat strip with thin 1px vertical dividers (`#F1F5F9`). Metric numbers are displayed in distinct semantic colors (Amber for Requests, Primary Blue for Upcoming, Emerald Green for Accepted/Assigned).
- **Active Task Snippet**: An embedded nested card (`#F8FAFC` background, `10px` radius) with a pulsing status dot, role title, address metadata, and an inline status chip ("In Progress", "En Route").
- **Card Action**: Full-width primary blue button (`44px` height, `12px` radius) with an icon and clear uppercase or title-case callout.

### 2. Status & Availability Header Card
- **Style**: Saturated Primary Blue (`#1A56DB`) surface with soft ambient blue shadow.
- **Controls**: Integrated switch toggle featuring a pure white thumb and high-contrast track (`#2563EB` off / `#10B981` active).
- **Icon Accent**: Translucent white container (`rgba(255, 255, 255, 0.15)`) framing the shift indicator.

### 3. Buttons & Interactive Controls
- **Primary CTA**: Solid fill (`#1A56DB`), white text, `48px` minimum height, `12px` border radius, subtle pressed-state scale transform (`0.98`).
- **Secondary CTA**: White surface with 1px border (`#E2E8F0`), Navy text (`#0F172A`), active state background `#F8FAFC`.
- **Icon Buttons**: Circular or soft-square (`40x40px`), translucent background (`#F1F5F9`), slate icon (`#475569`).

### 4. Status Chips & Badges
- **Pill Badges**: `22px` height, uppercase or title-case text (`11px` weight `600`), horizontal padding of `10px`.
  - *Active / En Route*: Pale blue (`#EFF6FF`) with deep blue text (`#1D4ED8`).
  - *In Progress*: Pale emerald (`#ECFDF5`) with forest green text (`#047857`).
  - *Pending / Urgent*: Pale amber (`#FFFBEB`) with warm amber text (`#B45309`).

### 5. Bottom Navigation Bar
- **Dimensions & Backdrop**: Fixed height `68px` plus safe area inset, pure white background with `1px` top border (`#E2E8F0`), elevated with Level 2 shadow.
- **Items**: 5-tab distribution (`HOME`, `CUSTOMER`, `INSTITUTION`, `COURSES`, `SCHEMES`).
- **States**: 
  - *Active*: Deep primary blue icon and label (`#1A56DB`), accompanied by a subtle top indicator line or pill backplate.
  - *Inactive*: Muted slate icon and label (`#64748B`).
  - *Typography*: `label-sm` (`10px`), bold tracking (`0.04em`).