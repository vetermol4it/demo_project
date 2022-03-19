import 'package:demo_project/presentation/pages/home_page/pages/profile_page/profile_page.dart';
import 'package:demo_project/presentation/pages/home_page/pages/search_page/search_page.dart';
import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';

import 'package:demo_project/presentation/constants/routes.dart';

class HomePage extends StatefulWidget {
  final int index;

  HomePage({required String tab, Key? key})
      : index = indexFrom(tab),
        super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();

  static int indexFrom(String tab) {
    switch (tab) {
      case 'search': return 0;
      case 'profile': return 1;
      default: return 0;
    }
  }
}

class _HomePageState extends State<HomePage> {
  late int _selectedIndex;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.index;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _selectedIndex = widget.index;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
        backgroundColor: Colors.white,
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.redAccent,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
            switch (index) {
              case 0:
                context.goNamed(searchRoute);
                break;
              case 1:
                context.goNamed(profileRoute);
                break;
            }
          });
        },
      ),
      body: IndexedStack(
        index: _selectedIndex,
        children: const [SearchPage(), ProfilePage(),],
      ),
    );
  }
}
