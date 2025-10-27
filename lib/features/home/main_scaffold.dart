import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:smart_door_app/features/control/control_page.dart';
import 'package:smart_door_app/features/history/history_page.dart';
import 'package:smart_door_app/features/profile/profile_page.dart';
import 'package:smart_door_app/features/schedule/schedule_page.dart';

class MainScaffold extends StatefulWidget {
  // ... (Copy class MainScaffold) ...
  const MainScaffold({super.key});
  @override
  State<MainScaffold> createState() => _MainScaffoldState();
}

class _MainScaffoldState extends State<MainScaffold> {
  // ... (Copy class _MainScaffoldState) ...
  int _selectedIndex = 0;
  static const List<Widget> _pages = <Widget>[
    ControlPage(),
    SchedulePage(),
    HistoryPage(),
    ProfilePage(), // Thêm màn hình Profile
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: _pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(PhosphorIcons.house),
            activeIcon: Icon(PhosphorIcons.houseFill),
            label: 'Điều khiển',
          ),
          BottomNavigationBarItem(
            icon: Icon(PhosphorIcons.timer),
            activeIcon: Icon(PhosphorIcons.timerFill),
            label: 'Hẹn giờ',
          ),
          BottomNavigationBarItem(
            icon: Icon(PhosphorIcons.clockCounterClockwise),
            activeIcon: Icon(PhosphorIcons.clockCounterClockwiseFill),
            label: 'Lịch sử',
          ),
          BottomNavigationBarItem(
            icon: Icon(PhosphorIcons.userCircle),
            activeIcon: Icon(PhosphorIcons.userCircleFill),
            label: 'Tài khoản',
          ),
        ],
      ),
    );
  }
}
