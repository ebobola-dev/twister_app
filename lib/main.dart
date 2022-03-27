import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:twister_app/bloc/add_player/add_player_bloc.dart';
import 'package:twister_app/bloc/added_players/added_players_bloc.dart';
import 'package:twister_app/bloc/fortune/fortune_bloc.dart';
import 'package:twister_app/bloc/game/game_bloc.dart';
import 'package:twister_app/databases/pref/theme.dart';
import 'package:twister_app/screens/create_players_screen/create_players_screen.dart';
import 'package:twister_app/screens/game_screen/game_screen.dart';
import 'package:twister_app/screens/splash_screen.dart';
import 'package:twister_app/screens/start_screen.dart';
import 'package:twister_app/themes.dart';
import 'package:twister_app/themes_constants.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final initTheme = await PrefTheme.read();
  runApp(MyApp(initDark: initTheme ?? true));
}

class MyApp extends StatelessWidget {
  final bool initDark;
  const MyApp({Key? key, required this.initDark}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AddPlayerBloc()),
        BlocProvider(create: (context) => AddedPlayersBloc()),
        BlocProvider(create: (context) => FortuneBloc()),
        BlocProvider(create: (context) => GameBloc())
      ],
      child: ThemeProvider(
        initTheme: getThemeData(context, initDark ? darkTheme : lightTheme),
        builder: (context, theme) => MaterialApp(
          title: 'Twister App',
          debugShowCheckedModeBanner: false,
          theme: theme,
          initialRoute: "/splash",
          routes: {
            "/splash": (context) => const SplashScreen(),
            "/start": (context) => const StartScreen(),
            "/create": (context) => CreatePlayersScreen(),
            "/game": (context) => const GameScreen(),
          },
        ),
      ),
    );
  }
}
