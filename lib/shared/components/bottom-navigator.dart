import 'package:flutter/material.dart';

class BottomTabItem {
  final String title;
  final IconData icon;
  final Color color;
  final String route;

  BottomTabItem(
      {required this.title,
      required this.icon,
      required this.color,
      required this.route});
}

List<BottomTabItem> options = <BottomTabItem>[
  new BottomTabItem(
      title: "Portfólio", icon: Icons.folder, color: Colors.grey, route: '/'),
  new BottomTabItem(
      title: "Notícias", icon: Icons.info, color: Colors.grey, route: '/news'),
];

class BottomNavigator extends StatelessWidget {
  final String selected;

  BottomNavigator(this.selected);

  @override
  Widget build(BuildContext context) {
    void _onItemTapped(int index) {
      Navigator.pushReplacementNamed(context, options[index].route);
    }

    final int currentIndex =
        options.indexWhere((item) => item.route == selected);

    return BottomNavigationBar(
      items: options.map((option) {
        return BottomNavigationBarItem(
            icon: Icon(option.icon),
            label: option.title,
            backgroundColor: option.color);
      }).toList(),
      currentIndex: currentIndex > 0 ? currentIndex : 0,
      selectedItemColor: Colors.green[800],
      onTap: _onItemTapped,
    );
  }
}
