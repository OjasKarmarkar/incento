import 'package:get/get.dart';
import 'package:incento_demo/Const/colors.dart';
import 'package:incento_demo/Controller/data_controller.dart';
import 'package:incento_demo/Screens/Mainscreen/home_screen.dart';
import 'package:incento_demo/Utils/wrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> with TickerProviderStateMixin {
  final List<Widget> _listTabs = [
    const HomeScreen(),
    Text("Hello"),
    Text("Hello"),
  ];
  int _currentTab = 0;
  late TabController _tabController;
  late AnimationController _animationController;
  late Animation<Offset> _animation;
  DataController dc = Get.put(DataController());

  Widget _bottomNavigationBar() {
    return BottomNavigationBar(
        elevation: 4,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        backgroundColor: Colors.white,
        currentIndex: _currentTab,
        onTap: (index) {
          setState(() {
            _currentTab = index;
            _tabController.animateTo(_currentTab);
            _animationController.reverse();
          });
        },
        type: BottomNavigationBarType.fixed,
        iconSize: 25.0,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            label: 'Home',
            activeIcon: Icon(
              FeatherIcons.home,
              color: accentColor,
            ),
            icon: Icon(
              FeatherIcons.home,
              color: Colors.grey,
            ),
          ),
          BottomNavigationBarItem(
            label: 'Profile',
            activeIcon: Icon(
              Icons.person_outline_rounded,
              color: accentColor,
            ),
            icon: Icon(
              Icons.person_outline_rounded,
              color: Colors.grey,
            ),
          ),
        ]);
  }

  @override
  void initState() {
    _tabController = TabController(vsync: this, length: _listTabs.length);
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
    _animation = Tween<Offset>(
            begin: const Offset(0.0, 0.0), end: const Offset(0.0, -1.0))
        .animate(CurvedAnimation(
            curve: Curves.easeOut, parent: _animationController));
    _animationController.reverse();
    dc.getAllProducts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return themeWrapper(
      child: Scaffold(
          floatingActionButton: FloatingActionButton(
            backgroundColor: accentColor,
            onPressed: () {},
            child: const Icon(FeatherIcons.heart),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          body: _listTabs[_currentTab],
          bottomNavigationBar: Container(
              decoration: const BoxDecoration(
                boxShadow: [
                  BoxShadow(color: Colors.grey, spreadRadius: 0, blurRadius: 2),
                ],
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(15),
                  topLeft: Radius.circular(15),
                ),
              ),
              child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15),
                  ),
                  child: _bottomNavigationBar()))),
    );
  }
}
