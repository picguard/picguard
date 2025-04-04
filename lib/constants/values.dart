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
  PGFont(
    fontFamily: 'Roboto',
    name: 'Roboto',
    path: 'fonts/Roboto-Regular.ttf',
    boldPath: 'fonts/Roboto-Bold.ttf',
  ),
  PGFont(
    fontFamily: 'OpenSans',
    name: 'Open Sans',
    path: 'fonts/OpenSans-Regular.ttf',
    boldPath: 'fonts/OpenSans-Bold.ttf',
  ),
  PGFont(
    fontFamily: 'Lato',
    name: 'Lato',
    path: 'fonts/Lato-Regular.ttf',
    boldPath: 'fonts/Lato-Bold.ttf',
  ),
  PGFont(
    fontFamily: 'Montserrat',
    name: 'Montserrat',
    path: 'fonts/Montserrat-Regular.ttf',
    boldPath: 'fonts/Montserrat-Bold.ttf',
  ),
  PGFont(
    fontFamily: 'Merriweather',
    name: 'Merriweather',
    path: 'fonts/Merriweather-Regular.ttf',
    boldPath: 'fonts/Merriweather-Bold.ttf',
  ),
  PGFont(
    fontFamily: 'MerriweatherSans',
    name: 'Merriweather Sans',
    path: 'fonts/MerriweatherSans-Regular.ttf',
    boldPath: 'fonts/MerriweatherSans-Bold.ttf',
  ),
  PGFont(
    fontFamily: 'PlayfairDisplay',
    name: 'Playfair Display',
    path: 'fonts/PlayfairDisplay-Regular.ttf',
    boldPath: 'fonts/PlayfairDisplay-Bold.ttf',
  ),
  PGFont(
    fontFamily: 'PlayfairDisplaySC',
    name: 'Playfair Display SC',
    path: 'fonts/PlayfairDisplaySC-Regular.ttf',
    boldPath: 'fonts/PlayfairDisplaySC-Bold.ttf',
  ),
  PGFont(
    fontFamily: 'Poppins',
    name: 'Poppins',
    path: 'fonts/Poppins-Regular.ttf',
    boldPath: 'fonts/Poppins-Bold.ttf',
  ),
  PGFont(
    fontFamily: 'SourceSans3',
    name: 'Source Sans 3',
    path: 'fonts/SourceSans3-Regular.ttf',
    boldPath: 'fonts/SourceSans3-Bold.ttf',
  ),
];

const websiteBaseUrl = 'https://www.picguard.app';
