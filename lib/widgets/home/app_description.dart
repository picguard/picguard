// Copyright 2023 Insco. All rights reserved.
// This source code is licensed under the GNU General Public License v3.0.
// See the LICENSE file in the project root for full license information.

import 'package:flutter/material.dart';

import 'package:picguard/generated/colors.gen.dart';
import 'package:picguard/i18n/i18n.g.dart';

/// 声明文本
class AppDescription extends StatelessWidget {
  const AppDescription({super.key});

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    return Text(
      t.homePage.description,
      style: const TextStyle(
        color: PGColors.errorTextColor,
        fontSize: 12,
        height: 1.5,
      ),
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
      textAlign: TextAlign.center,
    );
  }
}
