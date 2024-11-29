import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sisi_super_app/moduls/post-login/Absence/absence_page_screen.dart';
import 'package:sisi_super_app/moduls/post-login/Homepage/cubit/homepage_cubit.dart';
import 'package:sisi_super_app/moduls/post-login/Homepage/home_page_screen.dart';
import 'package:sisi_super_app/moduls/post-login/Notification/cubit/notification_cubit.dart';
import 'package:sisi_super_app/moduls/post-login/Notification/notification_screen.dart';

class MainMenuScreen extends StatefulWidget {
  final String id;
  const MainMenuScreen({super.key, required this.id});

  @override
  State<MainMenuScreen> createState() => _MainMenuScreenState();
}

class _MainMenuScreenState extends State<MainMenuScreen> {
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: selectedIndex == 0
          ? BlocProvider(
              create: (context) {
                final homePageCubit = HomepageCubit();
                homePageCubit.getDetailUser(widget.id);
                return homePageCubit;
              },
              child: HomePageScreen(idKey: widget.id),
            )
          : selectedIndex == 1
              ? AbsenceScreen()
              : BlocProvider(
                  create: (context) {
                    final notifCubit = NotificationCubit();
                    notifCubit.getDataNotif();
                    return notifCubit;
                  },
                  child: NotificationScreen(),
                ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart_outlined),
            label: 'Statistik Absensi',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications_active),
            label: 'Notifikasi',
          ),
        ],
        currentIndex: selectedIndex,
        selectedItemColor: Colors.blue,
        onTap: (int index) {
          setState(() {
            selectedIndex = index;
          });
        },
      ),
    );
  }
}
