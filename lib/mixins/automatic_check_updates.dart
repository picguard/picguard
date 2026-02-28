// Copyright 2023 Qiazo. All rights reserved.
// This source code is licensed under the GNU General Public License v3.0.
// See the LICENSE file in the project root for full license information.

import 'dart:async';

import 'package:app_updater/app_updater.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

import '../app/config.dart';
import '../events/events.dart';
import '../i18n/i18n.g.dart';
import '../logger/logger.dart';

@optionalTypeArgs
mixin AutomaticCheckUpdatesMixin<T extends StatefulWidget> on State<T> {
  // Create AppUpdater instance with all new features configured
  late final AppUpdater appUpdater;

  // Stream subscription for background updates
  StreamSubscription<UpdateInfo>? _updateSubscription;

  // Track if background checking is active
  bool _isBackgroundCheckingActive = false;

  late final AppLifecycleListener _listener;

  late final StreamSubscription<AppUpdatesEvent> _appUpdatesStreamSubscription;

  @override
  void initState() {
    super.initState();
    _appUpdatesStreamSubscription = eventBus.on<AppUpdatesEvent>().listen((
      event,
    ) async {
      if (isMobile || isDesktop) {
        await _checkForUpdates();
        // await _showDialogWithOptions();
      }
    });

    _listener = AppLifecycleListener(
      onShow: _toggleBackgroundChecking,
      onHide: _toggleBackgroundChecking,
    );

    WidgetsBinding.instance.addPostFrameCallback((timestamp) async {
      if (isMobile || isDesktop) {
        final t = Translations.of(context);
        appUpdater = AppUpdater.configure(
          // Mobile
          iosAppId: AppConfig.shared.iosAppId,
          androidPackageName: AppConfig.shared.androidPackageName,

          // Desktop
          macAppId: AppConfig.shared.macAppId,
          microsoftProductId: AppConfig.shared.microsoftProductId,
          snapName: AppConfig.shared.snapName,
          flathubAppId: AppConfig.shared.flathubAppId,

          // Update frequency control - only check once per day
          checkFrequency: const Duration(days: 1),

          // Force update if below this version
          minimumVersion: '1.0.0',

          strings: UpdateStrings(
            updateAvailableTitle: t.dialogs.updatesDialog.updateAvailableTitle,
            updateAvailableMessage:
                t.dialogs.updatesDialog.updateAvailableMessage,
            updateButton: t.dialogs.updatesDialog.updateButton,
            laterButton: t.dialogs.updatesDialog.laterButton,
            skipVersionButton: t.dialogs.updatesDialog.skipVersionButton,
            doNotAskAgainButton: t.dialogs.updatesDialog.doNotAskAgainButton,
            criticalUpdateTitle: t.dialogs.updatesDialog.criticalUpdateTitle,
            criticalUpdateMessage:
                t.dialogs.updatesDialog.criticalUpdateMessage,
            releaseNotesTitle: t.dialogs.updatesDialog.releaseNotesTitle,
            loadingText: t.dialogs.updatesDialog.loadingText,
            errorText: t.dialogs.updatesDialog.errorText,
            upToDateText: t.dialogs.updatesDialog.upToDateText,
          ),

          // Analytics callback
          onAnalyticsEvent: (event) {
            printDebugLog('Analytics Event: ${event.eventName}');
            printDebugLog('  Platform: ${event.platform}');
            printDebugLog('  Current Version: ${event.currentVersion}');
            if (event.latestVersion != null) {
              printDebugLog('  Latest Version: ${event.latestVersion}');
            }
            if (event.urgency != null) {
              printDebugLog('  Urgency: ${event.urgency}');
            }
          },
        );

        await _checkForUpdates();
        // await _showDialogWithOptions();
      }
    });
  }

  @override
  void dispose() {
    _appUpdatesStreamSubscription.cancel();
    _listener.dispose();
    _updateSubscription?.cancel();
    appUpdater.dispose();
    super.dispose();
  }

  Future<void> _checkForUpdates() async {
    // final t = Translations.of(context);
    final updateInfo = await appUpdater.checkAndShowUpdateDialog(
      context,
      isDismissible: false,
      showSkipVersion: true,
      showDoNotAskAgain: true,
      // onNoUpdate: () {
      //   if (mounted) {
      //     ScaffoldMessenger.of(
      //       context,
      //     ).showSnackBar(SnackBar(content: Text(t.homePage.appNoUpdates)));
      //   }
      // },
      onUpdate: () => appUpdater.openStore(),
      onCancel: () => printDebugLog('User cancelled update'),
    );

    printDebugLog('Current version: ${updateInfo.currentVersion}');
    printDebugLog('Latest version: ${updateInfo.latestVersion}');
    printDebugLog('Update available: ${updateInfo.updateAvailable}');
    printDebugLog('Release notes: ${updateInfo.releaseNotes}');
    printDebugLog('Urgency: ${updateInfo.urgency}');
  }

  void _showSnackBar(String message) {
    if (!mounted) return;
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  void _toggleBackgroundChecking() {
    final t = Translations.of(context);
    setState(() {
      if (_isBackgroundCheckingActive) {
        // Stop background checking
        appUpdater.stopBackgroundChecking();
        _updateSubscription?.cancel();
        _updateSubscription = null;
        _isBackgroundCheckingActive = false;
        _showSnackBar(t.homePage.backgroundCheckingStopped);
      } else {
        // Start background checking every 30 seconds (for demo purposes)
        appUpdater.startBackgroundChecking(const Duration(seconds: 30));

        // Listen for updates
        _updateSubscription = appUpdater.updateStream.listen((updateInfo) {
          if (updateInfo.updateAvailable && mounted) {
            _showSnackBar(
              t.homePage.backgroundCheckingAvailable(
                latestVersion: updateInfo.latestVersion!,
              ),
            );
          }
        });

        _isBackgroundCheckingActive = true;
        _showSnackBar(t.homePage.backgroundCheckingStarted(seconds: 30));
      }
    });
  }
}
