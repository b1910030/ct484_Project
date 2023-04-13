import 'package:flutter/material.dart';
import 'package:flutter_application_1/ui/admin/app_drawer.dart';
import '../shared/app_drawer.dart';
import '../screens.dart';

class AdminScreen extends StatelessWidget {
  static const routeName = '/admin';
  // const AdminScreen ({super.key});

  final List<MenuOption> options = [
    MenuOption(
      title: 'Users',
      icon: Icons.people,
      routeName: '/admin/user',
    ),
    MenuOption(
      title: 'Products',
      icon: Icons.bookmark_add,
      routeName: '/user-products',
    ),
    MenuOption(
      title: 'Orders',
      icon: Icons.delivery_dining,
      routeName: '/admin/order',
    ),
  ];



  @override
  Widget build(BuildContext context) {
    print('manager admin');
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Manager'),
      ),
      drawer: const AdminDrawer(),
      body: GridView.count(
        crossAxisCount: 3,
        children: options.map((option) {
          return InkWell(
            onTap: () {
              Navigator.of(context).pushNamed(option.routeName);
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(option.icon),
                SizedBox(height: 8),
                Text(option.title),
              ],
            ),
          );
        }).toList(),
      ),

    );
    
  }
}

class MenuOption {
  final String title;
  final IconData icon;
  final String routeName;

  MenuOption({
    required this.title,
    required this.icon,
    required this.routeName,
  });
}