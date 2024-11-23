import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:page_transition/page_transition.dart';
import 'package:whatslab4everyone_1/components/whatslab4_bottom_navigation_bar.dart';
import 'package:hive/hive.dart';
import 'package:whatslab4everyone_1/models/direct_message_model.dart';
import 'package:whatslab4everyone_1/models/user_model.dart';
import 'package:whatslab4everyone_1/pages/Settings/account_page.dart';
import 'package:whatslab4everyone_1/pages/Settings/change_chat_background_page.dart';
import 'package:whatslab4everyone_1/pages/Settings/favorites_page.dart';
import 'package:whatslab4everyone_1/pages/Settings/notifications_page.dart';
import 'package:whatslab4everyone_1/pages/Settings/privacy_page.dart';
import 'package:whatslab4everyone_1/pages/Settings/settings_page.dart';
import 'package:whatslab4everyone_1/pages/auth/login_page.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatslab4everyone_1/pages/auth/signup_page.dart';
import 'package:whatslab4everyone_1/pages/contacts_page.dart';
import 'package:whatslab4everyone_1/pages/home_page.dart';
import 'package:whatslab4everyone_1/pages/profile/profile_page.dart';
import 'package:whatslab4everyone_1/providers/responsive_info_provider.dart';
import 'package:whatslab4everyone_1/providers/user_authentication_check.dart';
import 'package:whatslab4everyone_1/responsive/responsive_manager.dart';
import 'package:whatslab4everyone_1/services/shared_preference_service/shared_preference_manager.dart';
import 'package:whatslab4everyone_1/themes/dark_theme.dart';
import 'package:whatslab4everyone_1/themes/light_theme.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(UserAdapter());
  Hive.registerAdapter(DirectMessageAdapter());

  await Hive.openBox<User>('currentUserBox');
  await Hive.openBox<DirectMessage>('direct_messages');
  await Hive.openBox<String>('selected_image_box');

  SharedPreferenceManager sharedPreferenceManager = SharedPreferenceManager();
  await sharedPreferenceManager.initialize();

  runApp(const ProviderScope(
    child: MyApp(),
  ));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    final isUserAuthenticated = ref.watch(userAuthenticationCheckProviderProvider);
    final responsiveInfo = ref.read(responsiveInfoProviderProvider.notifier);

    Size deviceSize = MediaQuery.of(context).size;
    ResponsiveManager responsiveManager = ResponsiveManager(
        width: deviceSize.width,
        height: deviceSize.height);

    responsiveInfo.setIsPhone(responsiveManager.isPhone());
    responsiveInfo.setDeviceType(responsiveManager.deviceType);

    return MaterialApp(
      onGenerateRoute: (RouteSettings settings) {
        WidgetBuilder builder;
        switch (settings.name) {
          case '/homepage':
            builder = (context) => const HomePage();
            break;
          case '/loginpage':
            builder = (context) => LoginPage();
            break;
          case '/signup_page':
            builder = (context) => SignupPage();
            break;
          case '/contacts':
            builder = (context) => const ContactsPage();
            break;
          case '/profile':
            builder = (context) => const ProfilePage();
            break;
          case '/change_chat_background_page':
            builder = (context) => const ChangeChatBackgroundPage();
            break;
          case '/settings':
            builder = (context) => const SettingsPage();
            break;
          case '/notifications':
            builder = (context) => const NotificationsPage();
            break;
          case '/favorites':
            builder = (context) => const FavoritesPage();
            break;
          case '/privacy':
            builder = (context) => const PrivacyPage();
            break;
          case '/account':
            builder = (context) => const AccountPage();
            break;
          default:
            builder = (context) => const HomePage();
        }

        return PageTransition(
          type: PageTransitionType.rightToLeft,
          child: builder(context),
          settings: settings,
        );
      },

      debugShowCheckedModeBanner: false,
      theme: lightMode,
      darkTheme: darkMode,
      home: Scaffold(
        backgroundColor: Colors.green,
        bottomNavigationBar: isUserAuthenticated ? const Whatslab4BottomNavigationBar() : null,
        body: isUserAuthenticated ? Container() : LoginPage()
      ),
    );
  }
}



/*
      routes: {
        '/homepage' : (context) => const HomePage(),
        '/loginpage': (context) => LoginPage(),
        '/signup_page': (context) => SignupPage(),
        '/contacts': (context) => const ContactsPage(),
        '/profile': (context) => const ProfilePage(),
        '/change_chat_background_page': (context) => const ChangeChatBackgroundPage(),
        '/settings': (context) => const SettingsPage(),
        '/notifications': (context) => const NotificationsPage(),
        '/favorites': (context) => const FavoritesPage(),
        '/privacy': (context) => const PrivacyPage(),
        '/account': (context) => const AccountPage(),
      },
*/