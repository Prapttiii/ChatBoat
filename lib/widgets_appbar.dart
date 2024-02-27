import 'package:chatboat/authentication_repository.dart';
import 'package:chatboat/providers.dart';
import 'package:chatboat/theme_switcher.dart';
import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MyAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        'ChatBoat',
        style: TextStyle(
          color: Theme.of(context).colorScheme.onPrimary,
        ),
      ),
      actions: [
        Row(
          children: [
            Container(
                child: IconButton(
                    icon: const Image(image: AssetImage('assets/icon.png')),
                    onPressed: () {
                      AuthenticationRepository.instance.logout();
                    })),
            Consumer(
              builder: (context, ref, child) => Icon(
                ref.watch(activeThemeProvider) == Themes.dark
                    ? Icons.dark_mode
                    : Icons.light_mode,
              ),
            ),
            const SizedBox(width: 8),
            const ThemeSwitch(),
          ],
        )
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(60);
}
