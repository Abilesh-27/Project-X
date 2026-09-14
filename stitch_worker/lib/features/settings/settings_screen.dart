import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:stitch_worker/l10n/generated/app_localizations.dart';
import '../../app/theme/app_colors.dart';
import '../../app/router.dart';
import '../../core/services/locale_service.dart';

/// App Settings Screen.
/// Provides immediate, persistent language switching and device preference controls.
class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _pushNotifications = true;
  bool _smsAlerts = true;
  bool _locationPermission = true;
  bool _cameraPermission = true;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final localeProvider = context.watch<LocaleProvider>();
    final currentCode = localeProvider.locale.languageCode;

    return Scaffold(
      backgroundColor: AppColors.surface,
      appBar: AppBar(
        backgroundColor: AppColors.navy,
        foregroundColor: Colors.white,
        title: Text(
          l10n.settingsTitle,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            // ─── Language Section ─────────────────────────────────────
            Text(
              l10n.selectLanguage.toUpperCase(),
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
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppColors.border),
              ),
              child: Material(
                color: Colors.transparent,
                child: Column(
                  children: [
                    _buildLanguageItem(
                      title: 'English',
                      nativeTitle: 'English (India)',
                      code: 'en',
                      currentCode: currentCode,
                      onTap: () => localeProvider.setLocale(AppLocales.english),
                    ),
                    const Divider(height: 1, color: AppColors.divider),
                    _buildLanguageItem(
                      title: 'Hindi',
                      nativeTitle: 'हिन्दी',
                      code: 'hi',
                      currentCode: currentCode,
                      onTap: () => localeProvider.setLocale(AppLocales.hindi),
                    ),
                    const Divider(height: 1, color: AppColors.divider),
                    _buildLanguageItem(
                      title: 'Tamil',
                      nativeTitle: 'தமிழ்',
                      code: 'ta',
                      currentCode: currentCode,
                      onTap: () => localeProvider.setLocale(AppLocales.tamil),
                    ),
                    const Divider(height: 1, color: AppColors.divider),
                    _buildLanguageItem(
                      title: 'Malayalam',
                      nativeTitle: 'മലയാളം',
                      code: 'ml',
                      currentCode: currentCode,
                      onTap: () => localeProvider.setLocale(AppLocales.malayalam),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              l10n.langPersistInfo,
              style: const TextStyle(fontSize: 10, color: AppColors.textMuted),
            ),
            const SizedBox(height: 20),

            // ─── Notification Preferences ────────────────────────────
            Text(
              l10n.appPreferences.toUpperCase(),
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
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppColors.border),
              ),
              child: Material(
                color: Colors.transparent,
                child: Column(
                  children: [
                    SwitchListTile(
                      title: Text(
                        l10n.pushNotifications,
                        style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
                      ),
                      subtitle: const Text(
                        'Receive real-time customer and job updates',
                        style: TextStyle(fontSize: 10.5, color: AppColors.textMuted),
                      ),
                      value: _pushNotifications,
                      activeTrackColor: AppColors.cobalt,
                      onChanged: (val) => setState(() => _pushNotifications = val),
                    ),
                    const Divider(height: 1, color: AppColors.divider),
                    SwitchListTile(
                      title: Text(
                        l10n.smsAlerts,
                        style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
                      ),
                      subtitle: const Text(
                        'SMS broadcast for critical OTPs and settlements',
                        style: TextStyle(fontSize: 10.5, color: AppColors.textMuted),
                      ),
                      value: _smsAlerts,
                      activeTrackColor: AppColors.cobalt,
                      onChanged: (val) => setState(() => _smsAlerts = val),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),

            // ─── Hardware Permissions ────────────────────────────────
            Text(
              'PERMISSIONS',
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
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppColors.border),
              ),
              child: Material(
                color: Colors.transparent,
                child: Column(
                  children: [
                    SwitchListTile(
                      title: Text(
                        l10n.locationServices,
                        style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
                      ),
                      subtitle: const Text(
                        'GPS required for journey tracking and on-site arrival',
                        style: TextStyle(fontSize: 10.5, color: AppColors.textMuted),
                      ),
                      value: _locationPermission,
                      activeTrackColor: AppColors.emerald,
                      onChanged: (val) => setState(() => _locationPermission = val),
                    ),
                    const Divider(height: 1, color: AppColors.divider),
                    SwitchListTile(
                      title: Text(
                        l10n.cameraPermission,
                        style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
                      ),
                      subtitle: const Text(
                        'Used to upload before/after photos and material bills',
                        style: TextStyle(fontSize: 10.5, color: AppColors.textMuted),
                      ),
                      value: _cameraPermission,
                      activeTrackColor: AppColors.emerald,
                      onChanged: (val) => setState(() => _cameraPermission = val),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),

            // ─── Support & Hotline ───────────────────────────────────
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: AppColors.cobaltLight,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: AppColors.cobalt.withValues(alpha: 0.2)),
              ),
              child: Row(
                children: [
                  const Icon(Icons.support_agent, color: AppColors.cobalt, size: 24),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          l10n.cooperativeHelpline,
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: AppColors.cobalt,
                          ),
                        ),
                        const SizedBox(height: 2),
                        const Text(
                          '1800-425-9988 (Toll Free • 24/7 Field Support)',
                          style: TextStyle(fontSize: 10, color: AppColors.textSecondary),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // ─── Logout CTA ──────────────────────────────────────────
            OutlinedButton.icon(
              onPressed: () => _showLogoutDialog(context, l10n),
              icon: const Icon(Icons.logout, size: 18, color: AppColors.roseDark),
              label: Text(
                l10n.logout,
                style: const TextStyle(color: AppColors.roseDark, fontWeight: FontWeight.bold),
              ),
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 14),
                side: BorderSide(color: AppColors.rose.withValues(alpha: 0.4)),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
            const SizedBox(height: 14),
            Center(
              child: Text(
                l10n.footerText,
                style: const TextStyle(fontSize: 9.5, color: AppColors.textSlate, letterSpacing: 0.5),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLanguageItem({
    required String title,
    required String nativeTitle,
    required String code,
    required String currentCode,
    required VoidCallback onTap,
  }) {
    final isSelected = currentCode == code;
    return ListTile(
      dense: true,
      onTap: onTap,
      title: Text(
        nativeTitle,
        style: TextStyle(
          fontSize: 14,
          fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
          color: isSelected ? AppColors.cobalt : AppColors.textPrimary,
        ),
      ),
      subtitle: Text(
        title,
        style: const TextStyle(fontSize: 10, color: AppColors.textMuted),
      ),
      trailing: isSelected
          ? const Icon(Icons.check_circle, color: AppColors.cobalt, size: 20)
          : const Icon(Icons.circle_outlined, color: AppColors.border, size: 20),
    );
  }

  void _showLogoutDialog(BuildContext context, AppLocalizations l10n) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text(l10n.logout, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        content: Text(l10n.logoutConfirm, style: const TextStyle(fontSize: 13)),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text(l10n.dismiss, style: const TextStyle(color: AppColors.textMuted)),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(ctx);
              context.go(Routes.login);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.rose,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            ),
            child: Text(l10n.logout),
          ),
        ],
      ),
    );
  }
}
