import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('YT Chat'),
        ),
        body: const Center(child: Text('Home')),
        bottomNavigationBar: const HomeTabView());
  }
}

class HomeTabView extends StatefulWidget {
  const HomeTabView({Key? key}) : super(key: key);

  @override
  _HomeTabViewState createState() => _HomeTabViewState();
}

class _HomeTabViewState extends State<HomeTabView> {
  int tappedItem = 0;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: tappedItem,
      onTap: (newIndex) {
        setState(() => tappedItem = newIndex);
      },
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.chat),
          label: 'Chats',
        ),
        BottomNavigationBarItem(icon: Icon(Icons.people), label: 'Users'),
        BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Profile'),
      ],
    );
  }
}
