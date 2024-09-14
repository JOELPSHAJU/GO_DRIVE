import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:godrive/core/constants.dart';
import 'package:godrive/view/screens/admin_side/add_inventory/add_inventory.dart';
import 'package:godrive/view/screens/admin_side/add_rental_rules/add_rental_rules.dart';
import 'package:godrive/view/screens/admin_side/advertisement/advertisement_screen.dart';
import 'package:godrive/view/screens/admin_side/delete_inventory/delete_inventory.dart';
import 'package:godrive/view/screens/admin_side/popular_inventory/popular_inventory_screen.dart';
import 'package:godrive/view/screens/admin_side/update_inventory/update_inventory_screen.dart';
import 'package:godrive/view/screens/admin_side/view_inventory/view_inventory.dart';
import 'package:godrive/view/screens/booking_requests/booking_request.dart';

class AdminDrawer extends StatelessWidget {
  const AdminDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            accountName: const Text(
              'GO DRIVE',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            accountEmail: const Text(
              'admin@gmail.com',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            currentAccountPicture: CircleAvatar(
              radius: 55,
              backgroundColor: Colors.black,
              child: ClipOval(
                child: Image.asset(
                  logoandroid,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(admindrawerimg),
                fit: BoxFit.cover,
              ),
            ),
          ),
          ListTile(
            title: const Text(
              'HOME',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          const Divider(),
          ListTile(
            title: const Text(
              'ADD INVENTORY',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            onTap: () {
              Navigator.push(
                  context, CupertinoPageRoute(builder: (c) => AddInventory()));
            },
          ),
          const Divider(),
          ListTile(
            title: const Text(
              'UPDATE INVENTORY',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            onTap: () {
              Navigator.push(context,
                  CupertinoPageRoute(builder: (c) => const UpdateInventory()));
            },
          ),
          const Divider(),
          ListTile(
            title: const Text(
              'DELETE INVENTORY',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            onTap: () {
              Navigator.push(context,
                  CupertinoPageRoute(builder: (c) => const DeleteInventory()));
            },
          ),
          const Divider(),
          ListTile(
            title: const Text(
              'VIEW INVENTORY',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            onTap: () {
              Navigator.push(context,
                  CupertinoPageRoute(builder: (c) => const ViewInventory()));
            },
          ),
          const Divider(),
          ListTile(
            title: const Text(
              'VIEW POPULAR INVENTORIES',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            onTap: () {
              Navigator.push(
                  context,
                  CupertinoPageRoute(
                      builder: (c) => const PopularInventoryScreen()));
            },
          ),
          const Divider(),
          ListTile(
            title: const Text(
              'ADD RENTAL RULES',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            onTap: () {
              Navigator.push(
                  context,
                  CupertinoPageRoute(
                      builder: (c) => const AddRentalRulesScreen()));
            },
          ),
          const Divider(),
          ListTile(
            title: const Text(
              'ADD ADVERTISEMENT',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            onTap: () {
              Navigator.push(context,
                  CupertinoPageRoute(builder: (c) => const AddAdvertisement()));
            },
          ),
          const Divider(),
          ListTile(
            title: const Text(
              'VIEW BOOKING REQUEST',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            onTap: () {
              Navigator.push(context,
                  CupertinoPageRoute(builder: (c) => const BookingRequest()));
            },
          ),
        ],
      ),
    );
  }
}
