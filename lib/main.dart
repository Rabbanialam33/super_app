import 'package:flutter/material.dart';
import 'package:super_app/features/customer/home/home_page.dart';
import 'package:super_app/features/customer/orders/orders_page.dart';
import 'package:super_app/features/customer/services/services_page.dart';
import 'package:super_app/features/customer/profile/profile_page.dart';

void main() {
  runApp(const SuperApp());
}

class SuperApp extends StatelessWidget {
  const SuperApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Super App',
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: const CustomerNavigation(),
    );
  }
}

class CustomerNavigation extends StatefulWidget {
  const CustomerNavigation({super.key});

  @override
  State<CustomerNavigation> createState() => _CustomerNavigationState();
}

class _CustomerNavigationState extends State<CustomerNavigation> {
  int _currentIndex = 0;

  final List<Widget> _pages = const [
    HomePage(),
    OrdersPage(),
    ServicesPage(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _pages,
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _currentIndex,
        onDestinationSelected: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.receipt_long_outlined),
            selectedIcon: Icon(Icons.receipt_long),
            label: 'Orders',
          ),
          NavigationDestination(
            icon: Icon(Icons.grid_view_outlined),
            selectedIcon: Icon(Icons.grid_view),
            label: 'Services',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline),
            selectedIcon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}