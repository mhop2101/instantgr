import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instantgramclonexyz/state/auth/providers/is_logged_in_provider.dart';
import 'package:instantgramclonexyz/state/providers/is_loading_provider.dart';
import 'package:instantgramclonexyz/views/components/loading/loading_screen.dart';
import 'package:instantgramclonexyz/views/login/login_view.dart';
import 'package:instantgramclonexyz/views/main/main_view.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    const ProviderScope(
      child: App(),
    ),
  );
}

class App extends StatelessWidget {
  const App({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.blue,
        indicatorColor: Colors.blueGrey,
      ),
      theme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.blue,
      ),
      themeMode: ThemeMode.dark,
      debugShowCheckedModeBanner: false,
      home: Consumer(builder: (context, ref, child) {
        // display loading screen
        ref.listen<bool>(isLoadingProvider, (previous, next) {
          if (next) {
            LoadingScreen.instance().show(context: context, text: 'Loading...');
          } else {
            LoadingScreen.instance().hide();
          }
        });
        final isLoggedIn = ref.watch(isLoggedInProvider);
        return isLoggedIn ? const MainView() : const LoginView();
      }),
    );
  }
}
