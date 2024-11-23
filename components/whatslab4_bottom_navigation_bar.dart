import 'package:flutter/material.dart';
import 'package:whatslab4everyone_1/pages/home_page.dart';

class Whatslab4BottomNavigationBar extends StatefulWidget {
  const Whatslab4BottomNavigationBar({super.key});

  @override
  State<Whatslab4BottomNavigationBar> createState() => _Whatslab4BottomNavigationBarState();
}

class _Whatslab4BottomNavigationBarState extends State<Whatslab4BottomNavigationBar> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    bool isYes = false;
    return BottomNavigationBar(
      elevation: 5.0,

        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex,
        onTap: (index) async {
          if (index == 1) {
            isYes = await showAlertDialog("Go to login page?", isYes: isYes);
          }
          else {
            isYes = true;
          }

          if (isYes) {
            setState(() {
              _currentIndex = index;
            });
            String _route = _getRoute(index);
            if (!_route.isEmpty) {
              Navigator.of(context).popUntil((route) {
                if (route.settings.name == null) {
                  return false;
                }
                return route.settings.name == '/homepage';
              });
              Navigator.pushNamed(context, _getRoute(index));
            }
            print(_route);
          }
          isYes = false;
        },
        items: [
          BottomNavigationBarItem(
            icon: const Icon(Icons.home, color: Colors.green),
            label: "Home",
            backgroundColor: Theme.of(context).colorScheme.surface,
            tooltip: "Home route",
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.login, color: Colors.green),
            label: "Login",
            backgroundColor: Theme.of(context).colorScheme.surface,
            tooltip: "Login route",
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.contacts, color: Colors.green),
            label: "Contacts",
            backgroundColor: Theme.of(context).colorScheme.surface,
            tooltip: "Contact route",
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.person, color: Colors.green),
            label: "Profile",
            backgroundColor: Theme.of(context).colorScheme.surface,
            tooltip: "Profile route",
          ),
        ],
        selectedItemColor: Colors.black,
    );
  }

  String _getRoute(int index) {
    switch (index) {
      case 0:
        return '/homepage';
      case 1:
        return '/loginpage';
      case 2:
        return '/contacts';
      case 3:
        return '/profile';
      default:
        return '';
    }
  }

  Future<bool> showAlertDialog(String title, {bool isYes = false, String content = 'If you continue you will be logged out of your account. Are you sure?'}) async {
    bool? result = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(content),
          actions: <Widget>[
            TextButton(
              child: Text('No'),
              onPressed: () {
                Navigator.of(context).pop(false); // false döndür
              },
            ),
            TextButton(
              child: Text('Yes'),
              onPressed: () {
                Navigator.of(context).pop(true); // true döndür
              },
            ),
          ],
        );
      },
    );
    return result ?? false; // Eğer result null ise false döndür
  }



}
