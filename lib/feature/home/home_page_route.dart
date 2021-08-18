import 'package:flutter/material.dart';
import 'package:glucose_counter/feature/normal_list/view/normal_list_page_route.dart';
import 'package:glucose_counter/feature/daily_list/view/daily_list_page_route.dart';

class HomePageRoute extends StatefulWidget {
  @override
  _HomePageRouteState createState() => _HomePageRouteState();
}

class _HomePageRouteState extends State<HomePageRoute> {
  final _pageController = PageController();
  var _currentPage=0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        physics: NeverScrollableScrollPhysics(),
        children: [
          NormalListPageRoute(),
          DailyListPageRoute()
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index){
          _pageController.jumpToPage(index);
          setState(() {
            _currentPage=index;
          });
        },
        currentIndex: _currentPage,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.calendar_view_day),label: 'Glucose Values'),
          BottomNavigationBarItem(icon: Icon(Icons.calendar_today),label: 'Daily Values'),
        ],
      ),
    );
  }
}
