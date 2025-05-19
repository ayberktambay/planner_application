  import 'package:flutter/material.dart';
import 'package:planner/view/menu/list.dart';
  import 'package:planner/view/menu/profile.dart';
  class HomeView extends StatefulWidget {
    const HomeView({super.key});

    @override
    State<HomeView> createState() => _HomeViewState();
  }

  class _HomeViewState extends State<HomeView> {
    List<NavItems> navItems = [
      NavItems(0, "List", Icon(Icons.list_outlined), Icon(Icons.list), PlanListView()), // Assuming HomeView is meant to be displayed
      NavItems(1, "Profile", Icon(Icons.person_outline), Icon(Icons.person), ProfileView()),
    ];
    int currentIndex = 0; // Initialize to the first item

    @override
    Widget build(BuildContext context) {
      return Scaffold(
        body: navItems[currentIndex].path,
        bottomNavigationBar: BottomNavigationBar(
          items: navItems.map((e) => BottomNavigationBarItem(
            icon: e.disabledIcon!,
            activeIcon: e.activeIcon,
            label: e.name,
          )).toList(),
          currentIndex: currentIndex,
        onTap: (value) {
              setState(() {
              currentIndex = value;
            });
        
          },
        ),
      );
    }
  }

  class NavItems{
    int index;
    String? name;
    Icon? disabledIcon;
    Icon? activeIcon;
    Widget path;
    NavItems(this.index,this.name,this.disabledIcon,this.activeIcon,this.path);
  }