
import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:plant_app/constants.dart';
import 'package:plant_app/ui/screen/cart_page.dart';
import 'package:plant_app/ui/screen/favorite_page.dart';
import 'package:plant_app/ui/screen/home_page.dart';
import 'package:plant_app/ui/screen/profile_page.dart';
import 'package:plant_app/ui/screen/scan_page.dart';

import '../model/plants.dart';

class RootPage extends StatefulWidget {
  const RootPage({super.key});

  @override
  State<RootPage> createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  List<Plant> favorites = [];
  List<Plant> myCart = [];
  int _bottomNavIndex = 0;
  // List screen
  List<Widget> _widgetOptions() {
    return [
      const HomePage(),
      FavoritePage(favoritePlants: favorites),
      CartPage(addedToCartPlants: myCart,),
      const ProfilePage(),
    ];
  }

  // List icon for screen
  List<IconData> icons = [
    Icons.home,
    Icons.favorite,
    Icons.shopping_cart,
    Icons.person,
  ];

  // List of titles screen
  List<String> titles = const [
    'Home',
    'Favorite',
    'Cart',
    'Profile'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              titles[_bottomNavIndex],
              style: TextStyle(
                color: Constants.blackColor,
                fontWeight: FontWeight.w500,
                fontSize: 24
              ),
            ),
            Icon(Icons.notifications, color: Constants.blackColor, size: 30.0,)
          ],
        ),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0.0,
      ),
      body: IndexedStack(
        index: _bottomNavIndex,
        children: _widgetOptions(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, PageTransition(child: const ScanPage(), type: PageTransitionType.bottomToTop));
        },
        backgroundColor: Constants.primaryColor,
        shape: const CircleBorder(),
        child: Image.asset('assets/images/code-scan-two.png', height: 30.0),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: AnimatedBottomNavigationBar(
        splashColor: Constants.primaryColor,
        activeColor: Constants.primaryColor,
        inactiveColor: Colors.black.withOpacity(0.5),
        icons: icons,
        activeIndex: _bottomNavIndex,
        gapLocation: GapLocation.center,
        notchSmoothness: NotchSmoothness.softEdge,
        onTap: (index) {
          setState(() {
            _bottomNavIndex = index;
            final List<Plant> favoritePlants = Plant.getFavoritedPlants();
            final List<Plant> addToCardPlants = Plant.addedToCartPlants();
            favorites = favoritePlants;
            myCart = addToCardPlants.toSet().toList();
          });
        }
      ),
    );
  }
}
