import 'package:daliy_music/bottom_navigation.dart';
import 'package:daliy_music/playlist/viewModel/playlist.dart';
import 'package:daliy_music/routes/routes.dart';
import 'package:daliy_music/youtube_list/view_models/card.dart';
import 'package:daliy_music/youtube_list/view_models/youtubeProvider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // KakaoSdk.init(nativeAppKey: Constants.kakaoAppKey);
  // await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => YoutubeProvider()),
        ChangeNotifierProvider(create: (context) => CardProvider()),
        ChangeNotifierProvider(create: (context) => PlayListProvider()),
      ],
      child: MaterialApp(
        builder: (context, child) => MediaQuery(
          data: MediaQuery.of(context).copyWith(
            textScaleFactor: 1.0,
          ),
          child: child!,
        ),
        initialRoute: '/',
        routes: customRoutes,
        title: 'Flutter Demo',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(
              seedColor: Colors.white,
              brightness: Brightness.light,
              primary: const Color(0xff00C853),
              secondary: const Color(0xffA5D6A7),
              background: const Color.fromARGB(255, 249, 249, 249)),
          textTheme: GoogleFonts.nanumGothicTextTheme(),
        ),
      ),
    );
  }
}

class HomeProvider extends StatelessWidget {
  const HomeProvider({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const BottomNavigationPage();
  }
}
