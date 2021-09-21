import 'package:flutter/material.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
            flex: 9,
            child: Container(
              color: Colors.pink,
            )),
        const Expanded(child: _HomeNavBar()),
      ],
    );
  }
}

class _HomeNavBar extends StatefulWidget {
  const _HomeNavBar({
    Key? key,
  }) : super(key: key);

  @override
  _HomeNavBarState createState() => _HomeNavBarState();
}

class _HomeNavBarState extends State<_HomeNavBar> {
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: (tappedIndex) {
        setState(() {
          currentIndex = tappedIndex;
        });
      },
      items: const [
        BottomNavigationBarItem(
            icon: Icon(
              Icons.group,
            ),
            label: 'Users'),
        BottomNavigationBarItem(
            icon: Icon(
              Icons.chat,
            ),
            label: 'Chat'),
        BottomNavigationBarItem(
            icon: Icon(
              Icons.settings,
            ),
            label: 'Profile'),
      ],
    );
  }
}
