import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:twister_app/databases/pref/theme.dart';
import 'package:twister_app/themes.dart';
import 'package:twister_app/themes_constants.dart';
import 'package:twister_app/ui_funcs.dart';

class ChangeThemeButton extends StatelessWidget {
  final Color? iconColor;
  const ChangeThemeButton({Key? key, this.iconColor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      child: ThemeSwitcher(
        builder: (BuildContext context) => GestureDetector(
          onTap: () {
            final bool toDark = !isDarkTheme(context);
            ThemeSwitcher.of(context).changeTheme(
              theme: getThemeData(
                context,
                toDark ? darkTheme : lightTheme,
              ),
              isReversed: false,
            );
            PrefTheme.save(toDark);
          },
          child: FaIcon(
            isDarkTheme(context)
                ? FontAwesomeIcons.solidMoon
                : FontAwesomeIcons.moon,
            color: iconColor ?? Theme.of(context).iconTheme.color,
            size: 32,
          ),
        ),
      ),
    );
  }
}
