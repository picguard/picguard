// Copyright 2023 Insco. All rights reserved.
// This source code is licensed under the GNU General Public License v3.0.
// See the LICENSE file in the project root for full license information.

// Project imports:
import 'package:picguard/constants/get.dart';
import 'package:picguard/models/models.dart';

const spacing = 8.0;
const runSpacing = 4.0;
const paddingSize = 10.0;
const minOpacity = 0.3; // 最小不透明度
const maxOpacity = 1.0; // 最大不透明度

double initialGap = isMobile ? 200.0 : 60.0;

/// fontFamilies
const fontFamilies = <PGFont>[
  PGFont(fontFamily: 'Roboto', name: 'Roboto'),
  PGFont(fontFamily: 'OpenSans', name: 'Open Sans'),
  PGFont(fontFamily: 'Lato', name: 'Lato'),
  PGFont(fontFamily: 'Montserrat', name: 'Montserrat'),
  PGFont(fontFamily: 'Merriweather', name: 'Merriweather'),
  PGFont(fontFamily: 'MerriweatherSans', name: 'Merriweather Sans'),
  PGFont(fontFamily: 'PlayfairDisplay', name: 'Playfair Display'),
  PGFont(fontFamily: 'PlayfairDisplaySC', name: 'Playfair Display SC'),
  PGFont(fontFamily: 'Poppins', name: 'Poppins'),
  PGFont(fontFamily: 'SourceSans3', name: 'Source Sans 3'),
];

const websiteBaseUrl = 'https://www.picguard.app';

const githubBaseUrl = 'https://github.com/PicGuard/picguard';
