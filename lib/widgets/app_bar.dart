import 'package:flutter/material.dart';
import 'package:picguard/theme/colors.dart';

///
class PGAppBar extends AppBar {
  ///
  PGAppBar({
    super.key,
    super.actions,
    this.titleName,
    this.titleWidget,
  }) : super(
          title: titleName == null
              ? titleWidget
              : Text(
                  titleName,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
          centerTitle: true,
          elevation: 0,
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(0.5),
            child: Container(
              color: borderColor,
              height: 1,
            ),
          ),
        );

  final String? titleName;
  final Widget? titleWidget;
}
