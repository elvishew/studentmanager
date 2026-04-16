import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:student_manager/providers/scheduled_class_provider.dart';
import 'schedule_page.dart';
import 'student_list_page.dart';
import 'statistics_page.dart';
import 'profile_page.dart';

/// 底部导航 4 Tab 容器
class MainShellPage extends ConsumerStatefulWidget {
  const MainShellPage({super.key});

  @override
  ConsumerState<MainShellPage> createState() => _MainShellPageState();
}

class _MainShellPageState extends ConsumerState<MainShellPage> {
  int _currentIndex = 0;

  static const List<Widget> _pages = [
    SchedulePage(),
    StudentListPage(),
    StatisticsPage(),
    ProfilePage(),
  ];

  void _onTabSelected(int index) {
    setState(() {
      _currentIndex = index;
    });
    // 切到课表 tab 时通知刷新
    if (index == 0) {
      ref.read(scheduleTabResumeProvider.notifier).resume();
    }
  }

  @override
  Widget build(BuildContext context) {
    final isIOS = Theme.of(context).platform == TargetPlatform.iOS;

    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _pages,
      ),
      bottomNavigationBar: isIOS
          ? CupertinoTabBar(
              currentIndex: _currentIndex,
              onTap: _onTabSelected,
              items: const [
                BottomNavigationBarItem(
                  icon: Padding(
                    padding: EdgeInsets.only(top: 4),
                    child: Icon(CupertinoIcons.calendar, size: 22),
                  ),
                  label: '课表',
                ),
                BottomNavigationBarItem(
                  icon: Padding(
                    padding: EdgeInsets.only(top: 4),
                    child: Icon(CupertinoIcons.person_2, size: 22),
                  ),
                  label: '学员',
                ),
                BottomNavigationBarItem(
                  icon: Padding(
                    padding: EdgeInsets.only(top: 4),
                    child: Icon(CupertinoIcons.chart_bar, size: 22),
                  ),
                  label: '统计',
                ),
                BottomNavigationBarItem(
                  icon: Padding(
                    padding: EdgeInsets.only(top: 4),
                    child: Icon(CupertinoIcons.person, size: 22),
                  ),
                  label: '我的',
                ),
              ],
            )
          : NavigationBar(
              selectedIndex: _currentIndex,
              onDestinationSelected: _onTabSelected,
              destinations: const [
                NavigationDestination(
                  icon: Icon(Icons.calendar_today_outlined),
                  selectedIcon: Icon(Icons.calendar_today),
                  label: '课表',
                ),
                NavigationDestination(
                  icon: Icon(Icons.people_outline),
                  selectedIcon: Icon(Icons.people),
                  label: '学员',
                ),
                NavigationDestination(
                  icon: Icon(Icons.bar_chart_outlined),
                  selectedIcon: Icon(Icons.bar_chart),
                  label: '统计',
                ),
                NavigationDestination(
                  icon: Icon(Icons.person_outline),
                  selectedIcon: Icon(Icons.person),
                  label: '我的',
                ),
              ],
            ),
    );
  }
}
