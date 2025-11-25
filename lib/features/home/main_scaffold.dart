import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:smart_door_app/features/control/control_page.dart';
import 'package:smart_door_app/features/history/history_page.dart';
import 'package:smart_door_app/features/profile/profile_page.dart';
import 'package:smart_door_app/features/schedule/schedule_page.dart';

class MainScaffold extends StatefulWidget {
  const MainScaffold({super.key});
  @override
  State<MainScaffold> createState() => _MainScaffoldState();
}

class _MainScaffoldState extends State<MainScaffold> {
  int _selectedIndex = 0;
  final List<Widget> _pages = <Widget>[
    const ControlPage(),
    const SchedulePage(),
    const HistoryPage(),
    const ProfilePage(), // Thêm màn hình Profile
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
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(PhosphorIcons.house()),
            // Sửa lỗi: Dùng icon gốc cho activeIcon
            activeIcon: Icon(PhosphorIcons.house()),
            label: 'Điều khiển',
          ),
          BottomNavigationBarItem(
            icon: Icon(PhosphorIcons.timer()),
            // Sửa lỗi: Dùng icon gốc cho activeIcon
            activeIcon: Icon(PhosphorIcons.timer()),
            label: 'Hẹn giờ',
          ),
          BottomNavigationBarItem(
            icon: Icon(PhosphorIcons.clockCounterClockwise()),
            // Sửa lỗi: Dùng icon gốc cho activeIcon
            activeIcon: Icon(PhosphorIcons.clockCounterClockwise()),
            label: 'Lịch sử',
          ),
          BottomNavigationBarItem(
            icon: Icon(PhosphorIcons.userCircle()),
            // Sửa lỗi: Dùng icon gốc cho activeIcon
            activeIcon: Icon(PhosphorIcons.userCircle()),
            label: 'Tài khoản',
          ),
        ],
      ),
    );
  }
}

