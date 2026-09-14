import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:stitch_worker/l10n/generated/app_localizations.dart';
import '../../app/theme/app_colors.dart';
import '../../core/widgets/shared_widgets.dart';

/// Models an individual earning transaction item.
class EarningItem {
  final String id;
  final String title;
  final String date;
  final String category;
  final double amount;
  final bool isCredit;
  final String status;

  const EarningItem({
    required this.id,
    required this.title,
    required this.date,
    required this.category,
    required this.amount,
    this.isCredit = true,
    this.status = 'Settled',
  });
}

/// Models a settlement payout record.
class SettlementRecord {
  final String settlementId;
  final String date;
  final double amount;
  final String bankAccount;
  final String status;
  final int jobCount;
  final String referenceUtr;

  const SettlementRecord({
    required this.settlementId,
    required this.date,
    required this.amount,
    required this.bankAccount,
    required this.status,
    required this.jobCount,
    required this.referenceUtr,
  });
}

/// Complete Worker Earnings & Settlement Dashboard.
/// Adheres strictly to Stitch visual reference and brand colors.
class EarningsDashboardScreen extends StatefulWidget {
  const EarningsDashboardScreen({super.key});

  @override
  State<EarningsDashboardScreen> createState() => _EarningsDashboardScreenState();
}

class _EarningsDashboardScreenState extends State<EarningsDashboardScreen> {
  int _selectedTab = 0; // 0: Overview, 1: Settlements
  String _timeframe = 'FY'; // Today, Week, Month, FY

  final List<EarningItem> _transactions = const [
    EarningItem(
      id: 'TXN-4821',
      title: 'Plumbing Repair • Job #C-4821',
      date: 'Today, 03:45 PM',
      category: 'Labour & Service',
      amount: 350.0,
      status: 'Pending Escrow',
    ),
    EarningItem(
      id: 'TXN-4820',
      title: 'Material Reimbursement (PVC P-Trap)',
      date: 'Today, 03:45 PM',
      category: 'Reimbursement',
      amount: 300.0,
      status: 'Pending Escrow',
    ),
    EarningItem(
      id: 'TXN-4819',
      title: 'Electrical Distribution Board Overhaul',
      date: 'Yesterday, 05:15 PM',
      category: 'Labour & Service',
      amount: 850.0,
      status: 'Settled',
    ),
    EarningItem(
      id: 'TXN-4815',
      title: 'On-site Inspection Fee • Job #C-4815',
      date: '22 Oct, 11:30 AM',
      category: 'Onsite Fee',
      amount: 150.0,
      status: 'Settled',
    ),
    EarningItem(
      id: 'TXN-4809',
      title: 'Festival Field Bonus (Cooperative)',
      date: '20 Oct, 09:00 AM',
      category: 'Bonus',
      amount: 500.0,
      status: 'Settled',
    ),
    EarningItem(
      id: 'TXN-4802',
      title: 'Cooperative Welfare & TDS Deduction',
      date: '18 Oct, 10:00 AM',
      category: 'Deduction',
      amount: 120.0,
      isCredit: false,
      status: 'Settled',
    ),
  ];

  final List<SettlementRecord> _settlements = const [
    SettlementRecord(
      settlementId: 'STL-2024-1024',
      date: '24 Oct 2024',
      amount: 14250.0,
      bankAccount: 'State Bank of India •••• 4821',
      status: 'Processing',
      jobCount: 12,
      referenceUtr: 'UTR-984210982341',
    ),
    SettlementRecord(
      settlementId: 'STL-2024-1017',
      date: '17 Oct 2024',
      amount: 16800.0,
      bankAccount: 'State Bank of India •••• 4821',
      status: 'Settled',
      jobCount: 15,
      referenceUtr: 'UTR-873910249102',
    ),
    SettlementRecord(
      settlementId: 'STL-2024-1010',
      date: '10 Oct 2024',
      amount: 17150.0,
      bankAccount: 'State Bank of India •••• 4821',
      status: 'Settled',
      jobCount: 16,
      referenceUtr: 'UTR-762910839128',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Scaffold(
      backgroundColor: AppColors.surface,
      body: Column(
        children: [
          _buildHeader(l10n),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 32),
              children: [
                _buildSegmentedTab(l10n),
                const SizedBox(height: 16),
                if (_selectedTab == 0) ...[
                  _buildTimeframeFilter(l10n),
                  const SizedBox(height: 14),
                  _buildEarningsSummaryCard(l10n),
                  const SizedBox(height: 14),
                  _buildPayoutSplitCard(l10n),
                  const SizedBox(height: 18),
                  _buildTransactionsSection(l10n),
                ] else ...[
                  _buildPendingEscrowCard(l10n),
                  const SizedBox(height: 14),
                  _buildSettlementsList(l10n),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(AppLocalizations l10n) {
    return Container(
      color: AppColors.navy,
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
          child: Row(
            children: [
              GestureDetector(
                onTap: () => context.pop(),
                child: Container(
                  width: 38,
                  height: 38,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white.withValues(alpha: 0.1),
                  ),
                  child: const Icon(Icons.arrow_back, color: Colors.white, size: 20),
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      l10n.earningsTitle,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w800,
                        letterSpacing: -0.3,
                      ),
                    ),
                    Text(
                      'WKR-2847 • Ramesh Kumar',
                      style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.7),
                        fontSize: 11,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.emerald.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppColors.emerald.withValues(alpha: 0.4)),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.verified, size: 12, color: AppColors.emerald),
                    const SizedBox(width: 4),
                    Text(
                      l10n.verified,
                      style: const TextStyle(
                        color: AppColors.emerald,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSegmentedTab(AppLocalizations l10n) {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: AppColors.cardWhite,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () => setState(() => _selectedTab = 0),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 9),
                decoration: BoxDecoration(
                  color: _selectedTab == 0 ? AppColors.navy : Colors.transparent,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: Text(
                    l10n.earningsStat,
                    style: TextStyle(
                      color: _selectedTab == 0 ? Colors.white : AppColors.textSecondary,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () => setState(() => _selectedTab = 1),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 9),
                decoration: BoxDecoration(
                  color: _selectedTab == 1 ? AppColors.navy : Colors.transparent,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: Text(
                    l10n.settlementHistory,
                    style: TextStyle(
                      color: _selectedTab == 1 ? Colors.white : AppColors.textSecondary,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTimeframeFilter(AppLocalizations l10n) {
    final filters = [
      {'key': 'Today', 'label': l10n.todayEarnings},
      {'key': 'Week', 'label': l10n.weekEarnings},
      {'key': 'Month', 'label': l10n.monthEarnings},
      {'key': 'FY', 'label': l10n.fyEarnings},
    ];

    return Row(
      children: filters.map((f) {
        final isSelected = _timeframe == f['key'];
        return Expanded(
          child: GestureDetector(
            onTap: () => setState(() => _timeframe = f['key']!),
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 2),
              padding: const EdgeInsets.symmetric(vertical: 7),
              decoration: BoxDecoration(
                color: isSelected ? AppColors.cobalt : AppColors.cardWhite,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: isSelected ? AppColors.cobalt : AppColors.border,
                ),
              ),
              child: Center(
                child: Text(
                  f['label']!,
                  style: TextStyle(
                    color: isSelected ? Colors.white : AppColors.textSecondary,
                    fontSize: 11,
                    fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                  ),
                ),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildEarningsSummaryCard(AppLocalizations l10n) {
    return Container(
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF0F223D), Color(0xFF1A365D)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: AppColors.navy.withValues(alpha: 0.2),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${l10n.earningsStat.toUpperCase()} • $_timeframe',
                style: TextStyle(
                  color: Colors.blue.shade200,
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.8,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Text(
                  '100% Guaranteed',
                  style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          const Text(
            '₹48,200.00',
            style: TextStyle(
              color: Colors.white,
              fontSize: 32,
              fontWeight: FontWeight.w900,
              letterSpacing: -0.5,
            ),
          ),
          const SizedBox(height: 16),
          const Divider(color: Colors.white12, height: 1),
          const SizedBox(height: 14),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      l10n.settledEarnings,
                      style: const TextStyle(color: Colors.white60, fontSize: 11),
                    ),
                    const SizedBox(height: 2),
                    const Text(
                      '₹47,150.00',
                      style: TextStyle(
                        color: AppColors.emerald,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              Container(width: 1, height: 28, color: Colors.white12),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      l10n.pendingEarnings,
                      style: const TextStyle(color: Colors.white60, fontSize: 11),
                    ),
                    const SizedBox(height: 2),
                    const Text(
                      '₹1,050.00',
                      style: TextStyle(
                        color: AppColors.amber,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPayoutSplitCard(AppLocalizations l10n) {
    return AppCard(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                l10n.billingBreakdown,
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
              const Icon(Icons.pie_chart_outline, size: 16, color: AppColors.cobalt),
            ],
          ),
          const SizedBox(height: 14),
          _buildBreakdownRow(l10n.serviceEarnings, '₹32,400.00', AppColors.cobalt),
          const SizedBox(height: 10),
          _buildBreakdownRow(l10n.onsiteEarnings, '₹8,250.00', AppColors.emeraldDark),
          const SizedBox(height: 10),
          _buildBreakdownRow(l10n.materialReimbursements, '₹6,300.00', Colors.purple.shade700),
          const SizedBox(height: 10),
          _buildBreakdownRow(l10n.bonuses, '+ ₹1,500.00', AppColors.amberDark),
          const SizedBox(height: 10),
          _buildBreakdownRow(l10n.deductions, '- ₹250.00', AppColors.roseDark),
        ],
      ),
    );
  }

  Widget _buildBreakdownRow(String label, String value, Color accentColor) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Container(
              width: 8,
              height: 8,
              decoration: BoxDecoration(color: accentColor, shape: BoxShape.circle),
            ),
            const SizedBox(width: 8),
            Text(
              label,
              style: const TextStyle(fontSize: 12, color: AppColors.textSecondary, fontWeight: FontWeight.w500),
            ),
          ],
        ),
        Text(
          value,
          style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: accentColor),
        ),
      ],
    );
  }

  Widget _buildTransactionsSection(AppLocalizations l10n) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              l10n.transactions,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
            ),
            Text(
              '${_transactions.length} Total',
              style: const TextStyle(fontSize: 11, color: AppColors.textMuted),
            ),
          ],
        ),
        const SizedBox(height: 10),
        ..._transactions.map((tx) => _buildTransactionCard(tx)),
      ],
    );
  }

  Widget _buildTransactionCard(EarningItem tx) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.cardWhite,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.border.withValues(alpha: 0.8)),
      ),
      child: Row(
        children: [
          Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(
              color: tx.isCredit
                  ? AppColors.emerald.withValues(alpha: 0.1)
                  : AppColors.rose.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(
              tx.isCredit ? Icons.arrow_downward : Icons.arrow_upward,
              color: tx.isCredit ? AppColors.emeraldDark : AppColors.roseDark,
              size: 18,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  tx.title,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 2),
                Text(
                  '${tx.category} • ${tx.date}',
                  style: const TextStyle(fontSize: 10, color: AppColors.textMuted),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '${tx.isCredit ? '+' : '-'} ₹${tx.amount.toStringAsFixed(0)}',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: tx.isCredit ? AppColors.emeraldDark : AppColors.roseDark,
                ),
              ),
              const SizedBox(height: 2),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 1.5),
                decoration: BoxDecoration(
                  color: tx.status.contains('Pending')
                      ? AppColors.amber.withValues(alpha: 0.15)
                      : AppColors.emerald.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  tx.status,
                  style: TextStyle(
                    fontSize: 9,
                    fontWeight: FontWeight.bold,
                    color: tx.status.contains('Pending')
                        ? AppColors.amberDark
                        : AppColors.emeraldDark,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPendingEscrowCard(AppLocalizations l10n) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.cardWhite,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.amber.withValues(alpha: 0.4)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: AppColors.amber.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(Icons.shield_outlined, color: AppColors.amberDark, size: 18),
              ),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    l10n.inEscrow,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const Text(
                    'Direct payout cycle every Thursday',
                    style: TextStyle(fontSize: 10, color: AppColors.textMuted),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                '₹1,050.00',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w900,
                  color: AppColors.amberDark,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  color: AppColors.cobaltLight,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: AppColors.cobalt.withValues(alpha: 0.2)),
                ),
                child: const Text(
                  'Next: 31 Oct',
                  style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: AppColors.cobalt),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSettlementsList(AppLocalizations l10n) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l10n.settlementHistory,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: 10),
        ..._settlements.map((s) => _buildSettlementCard(s, l10n)),
      ],
    );
  }

  Widget _buildSettlementCard(SettlementRecord s, AppLocalizations l10n) {
    final isSettled = s.status == 'Settled';
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.cardWhite,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                s.settlementId,
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w800,
                  color: AppColors.navy,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: isSettled
                      ? AppColors.emerald.withValues(alpha: 0.15)
                      : AppColors.amber.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: isSettled
                        ? AppColors.emerald.withValues(alpha: 0.3)
                        : AppColors.amber.withValues(alpha: 0.3),
                  ),
                ),
                child: Text(
                  s.status,
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: isSettled ? AppColors.emeraldDark : AppColors.amberDark,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                s.date,
                style: const TextStyle(fontSize: 11, color: AppColors.textMuted),
              ),
              Text(
                '₹${s.amount.toStringAsFixed(0)}',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w900,
                  color: AppColors.textPrimary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          const Divider(height: 1, color: AppColors.divider),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(Icons.account_balance, size: 13, color: AppColors.cobalt),
                  const SizedBox(width: 5),
                  Text(
                    s.bankAccount,
                    style: const TextStyle(fontSize: 10, color: AppColors.textSecondary),
                  ),
                ],
              ),
              Text(
                '${s.jobCount} Jobs',
                style: const TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  color: AppColors.cobalt,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
