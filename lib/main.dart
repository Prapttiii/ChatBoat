import 'package:chatboat/authentication_repository.dart';
import 'package:chatboat/chat_screen.dart';
import 'package:chatboat/constant_theme.dart';
import 'package:chatboat/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:chatboat/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  Get.put(AuthenticationRepository());
  //.then((value) => Get.put(AuthenticationRepository()));
  runApp(const ProviderScope(child: App()));
}

class App extends ConsumerWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final activeTheme = ref.watch(activeThemeProvider);
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: lightTheme,
      darkTheme: darkTheme,
      defaultTransition: Transition.leftToRightWithFade,
      transitionDuration: const Duration(milliseconds: 500),
      themeMode: activeTheme == Themes.dark ? ThemeMode.dark : ThemeMode.light,
      home: ChatScreen(),
    );
  }
}
