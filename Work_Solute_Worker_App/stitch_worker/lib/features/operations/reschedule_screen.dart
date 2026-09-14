import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:stitch_worker/l10n/generated/app_localizations.dart';
import '../../app/theme/app_colors.dart';
import '../../core/models/job_model.dart';
import '../../core/widgets/shared_widgets.dart';

enum RescheduleStatus { initial, requested, approved }

/// Reschedule Appointment Screen.
/// Manages date/time selection, reason input, and customer approval states.
class RescheduleScreen extends StatefulWidget {
  final Job job;
  const RescheduleScreen({super.key, required this.job});

  @override
  State<RescheduleScreen> createState() => _RescheduleScreenState();
}

class _RescheduleScreenState extends State<RescheduleScreen> {
  int _selectedSlot = 1; // 0: Morning, 1: Afternoon, 2: Evening
  int _selectedDay = 1; // 0: Today, 1: Tomorrow, 2: 26 Oct
  RescheduleStatus _status = RescheduleStatus.initial;
  final TextEditingController _reasonController = TextEditingController(
    text: 'Client requested postponement due to unexpected meeting.',
  );

  @override
  void dispose() {
    _reasonController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Scaffold(
      backgroundColor: AppColors.surface,
      appBar: AppBar(
        backgroundColor: AppColors.navy,
        foregroundColor: Colors.white,
        title: Text(
          l10n.rescheduleTitle,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
      ),
      body: SafeArea(
        child: _status != RescheduleStatus.initial
            ? _buildStatusView(l10n)
            : ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  // Current appointment card
                  AppCard(
                    padding: const EdgeInsets.all(14),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          l10n.currentAppointment.toUpperCase(),
                          style: const TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 0.8,
                            color: AppColors.textMuted,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Row(
                          children: [
                            const Icon(Icons.event, size: 16, color: AppColors.cobalt),
                            const SizedBox(width: 8),
                            Text(
                              'Today, 02:00 PM – 03:30 PM',
                              style: const TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                                color: AppColors.textPrimary,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Job #${widget.job.jobId} • ${widget.job.customerName}',
                          style: const TextStyle(fontSize: 11, color: AppColors.textSecondary),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 18),

                  // Select new date
                  Text(
                    l10n.selectNewSlot.toUpperCase(),
                    style: const TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.8,
                      color: AppColors.textSecondary,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      _buildDayChip(0, 'Today (Late)'),
                      const SizedBox(width: 8),
                      _buildDayChip(1, 'Tomorrow, 25 Oct'),
                      const SizedBox(width: 8),
                      _buildDayChip(2, 'Sat, 26 Oct'),
                    ],
                  ),
                  const SizedBox(height: 14),

                  // Time slots
                  _buildSlotCard(0, 'Morning Slot', '09:00 AM – 11:00 AM', Icons.wb_sunny_outlined),
                  const SizedBox(height: 8),
                  _buildSlotCard(1, 'Afternoon Slot', '02:00 PM – 04:00 PM', Icons.wb_twilight_outlined),
                  const SizedBox(height: 8),
                  _buildSlotCard(2, 'Evening Slot', '05:30 PM – 07:30 PM', Icons.nights_stay_outlined),
                  const SizedBox(height: 18),

                  // Reason for Reschedule
                  Text(
                    l10n.rescheduleReason.toUpperCase(),
                    style: const TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.8,
                      color: AppColors.textSecondary,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    decoration: BoxDecoration(
                      color: AppColors.cardWhite,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: AppColors.border),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    child: TextField(
                      controller: _reasonController,
                      maxLines: 3,
                      style: const TextStyle(fontSize: 13, color: AppColors.textPrimary),
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Add notes for customer regarding reschedule...',
                        hintStyle: TextStyle(fontSize: 12, color: AppColors.textMuted),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Submit CTA
                  AppButton(
                    label: l10n.requestCustomerApproval,
                    icon: Icons.send_rounded,
                    onPressed: () {
                      setState(() => _status = RescheduleStatus.requested);
                    },
                  ),
                ],
              ),
      ),
    );
  }

  Widget _buildDayChip(int index, String label) {
    final isSelected = _selectedDay == index;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => _selectedDay = index),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color: isSelected ? AppColors.cobalt : AppColors.cardWhite,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: isSelected ? AppColors.cobalt : AppColors.border,
            ),
          ),
          child: Center(
            child: Text(
              label,
              style: TextStyle(
                fontSize: 10,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.w600,
                color: isSelected ? Colors.white : AppColors.textSecondary,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSlotCard(int index, String title, String time, IconData icon) {
    final isSelected = _selectedSlot == index;
    return GestureDetector(
      onTap: () => setState(() => _selectedSlot = index),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.cobaltLight : AppColors.cardWhite,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? AppColors.cobalt : AppColors.border,
            width: isSelected ? 1.5 : 1,
          ),
        ),
        child: Row(
          children: [
            Icon(icon, color: isSelected ? AppColors.cobalt : AppColors.textSlate, size: 20),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: isSelected ? AppColors.cobalt : AppColors.textPrimary,
                    ),
                  ),
                  Text(time, style: const TextStyle(fontSize: 11, color: AppColors.textMuted)),
                ],
              ),
            ),
            Icon(
              isSelected ? Icons.radio_button_checked : Icons.radio_button_unchecked,
              color: isSelected ? AppColors.cobalt : AppColors.textSlate,
              size: 18,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusView(AppLocalizations l10n) {
    final isApproved = _status == RescheduleStatus.approved;

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 64,
              height: 64,
              decoration: BoxDecoration(
                color: isApproved ? AppColors.emeraldLight : AppColors.cobaltLight,
                shape: BoxShape.circle,
              ),
              child: Icon(
                isApproved ? Icons.check_circle : Icons.hourglass_top_rounded,
                size: 36,
                color: isApproved ? AppColors.emeraldDark : AppColors.cobalt,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              isApproved
                  ? '${l10n.rescheduleStatusApproved}!'
                  : l10n.rescheduleStatusWaiting,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              isApproved
                  ? 'New appointment set for Tomorrow, 02:00 PM.'
                  : l10n.rescheduleSuccess,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 12, color: AppColors.textMuted),
            ),
            const SizedBox(height: 24),
            if (!isApproved) ...[
              AppButton(
                label: 'Simulate Customer Approval (Demo)',
                variant: AppButtonVariant.outline,
                onPressed: () {
                  setState(() => _status = RescheduleStatus.approved);
                },
              ),
              const SizedBox(height: 10),
            ],
            AppButton(
              label: l10n.close,
              onPressed: () => context.pop(),
            ),
          ],
        ),
      ),
    );
  }
}
