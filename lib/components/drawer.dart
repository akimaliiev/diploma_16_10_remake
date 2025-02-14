import 'package:diploma_16_10/components/my_list_tile.dart';
import 'package:flutter/material.dart';
class MyDrawer extends StatelessWidget {
  final void Function()? onProfileTap;
  final void Function()? onLogoutTap;
  const MyDrawer({super.key, required this.onProfileTap, required this.onLogoutTap});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.grey[900],
      child: Column(children: [
        DrawerHeader(
          child: Icon(
            Icons.person,
            color: Colors.white,
            size: 64,
          ),
        ),
        MyListTile(
          icon: Icons.home, 
          text: 'H O M E',
          onTap: ()=> Navigator.pop(context),
        ),
        MyListTile(
          icon: Icons.person, 
          text: 'P R O F I L E',
          onTap: onProfileTap,
        ),
        MyListTile(
          icon: Icons.logout, 
          text: 'L O G O U T',
          onTap: onLogoutTap,
        ),
      ]),
    );
  }
}