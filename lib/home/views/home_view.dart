import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yt_chat/contact/bloc/contact_bloc.dart';
import 'package:yt_chat/contact/data/providers/contact_firebase_provider.dart';
import 'package:yt_chat/contact/data/repositories/contact_repository.dart';
import 'package:yt_chat/contact/views/contact_view.dart';
import 'package:yt_chat/home/bloc/home_bloc.dart';
import 'package:yt_chat/settings/settings_view.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          flex: 9,
          child: BlocBuilder<HomeBloc, HomeState>(
            builder: (context, state) {
              if (state is HomeUserDisplay) {
                return BlocProvider(
                  create: (context) => ContactBloc(ContactRepository(
                    contactFirebaseProvider: ContactFirebaseProvider(
                        firestore: FirebaseFirestore.instance),
                  ))
                    ..add(ContactStreamRequested()),
                  child: const ContactView(),
                );
              } else if (state is HomeChatDisplay) {
                return const Text('Cht will be displayed here');
              } else if (state is HomeSettingsDisplay) {
                return const SettingsView();
              }
              return Text('Undfined state ${state.runtimeType}');
            },
          ),
        ),
        const Expanded(child: _HomeNavBar()),
      ],
    );
  }
}

enum HomeNavItem {
  user,
  chat,
  settings,
}

class _HomeNavBar extends StatefulWidget {
  const _HomeNavBar({
    Key? key,
  }) : super(key: key);

  @override
  _HomeNavBarState createState() => _HomeNavBarState();
}

class _HomeNavBarState extends State<_HomeNavBar> {
  int currentIndex = HomeNavItem.user.index;
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: (tappedIndex) {
        if (tappedIndex == HomeNavItem.user.index) {
          BlocProvider.of<HomeBloc>(context).add(HomeUserPressed());
        } else if (tappedIndex == HomeNavItem.chat.index) {
          BlocProvider.of<HomeBloc>(context).add(HomeChatPressed());
        } else if (tappedIndex == HomeNavItem.settings.index) {
          BlocProvider.of<HomeBloc>(context).add(HomeSettingsPressed());
        }
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
