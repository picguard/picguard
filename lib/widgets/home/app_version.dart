// Copyright 2023 Insco. All rights reserved.
// This source code is licensed under the GNU General Public License v3.0.
// See the LICENSE file in the project root for full license information.

import 'package:flutter/material.dart';

import 'package:package_info_plus/package_info_plus.dart';

import 'package:picguard/app/config.dart';
import 'package:picguard/constants/env.dart';
import 'package:picguard/generated/colors.gen.dart';
import 'package:picguard/i18n/i18n.g.dart';

/// 版本号
class AppVersion extends StatelessWidget {
  const AppVersion({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<PackageInfo>(
      future: PackageInfo.fromPlatform(),
      builder: (BuildContext context, AsyncSnapshot<PackageInfo> snapshot) {
        if (snapshot.connectionState == .done && snapshot.hasData) {
          final t = Translations.of(context);
          final appName = t.appName(flavor: AppConfig.shared.flavor);
          final packageInfo = snapshot.data;
          final version = packageInfo?.version;
          return Text(
            '$appName $version${PgEnv.gitCommitShown ? "\n${PgEnv.gitCommitSha.substring(0, 8)}" : ""}',
            style: const TextStyle(
              color: PGColors.secondaryTextColor,
              fontSize: 12,
            ),
            textAlign: .center,
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
