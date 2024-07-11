import 'package:flutter/material.dart';
import 'package:what_to_eat/admin_dialog.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  List<Map<String, String>> familyMembers = [
    {"name": "John", "favoriteFood": "Pizza"},
    {"name": "Emily", "favoriteFood": "Salad"},
    {"name": "Mike", "favoriteFood": "Burger"},
  ];

  Map<String, Map<String, String>> weeklyMenu = {
    "Monday": {"lunch": "Pizza", "dinner": "Steak"},
    "Tuesday": {"lunch": "Burger", "dinner": "Fish"},
    "Wednesday": {"lunch": "Salad", "dinner": "Chicken"},
    "Thursday": {"lunch": "Pasta", "dinner": "Shrimp"},
    "Friday": {"lunch": "Sandwich", "dinner": "Rice"},
    "Saturday": {"lunch": "Soup", "dinner": "Tacos"},
    "Sunday": {"lunch": "Sushi", "dinner": "Curry"},
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile Screen"),
      ),
      body: ListView.builder(
        itemCount: familyMembers.length,
        itemBuilder: (context, index) {
          final member = familyMembers[index];
          return ListTile(
            title: Text(member['name'] ?? ''),
            subtitle: Text('Favorite Food: ${member['favoriteFood'] ?? ''}'),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAdminDialog(context);
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  void _showAdminDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AdminDialog(
          weeklyMenu: weeklyMenu,
          familyMembers: familyMembers,
          onMenuUpdate: (String day, String newLunch, String newDinner) {
            setState(() {
              weeklyMenu[day]!['lunch'] = newLunch;
              weeklyMenu[day]!['dinner'] = newDinner;
            });
            // Update the weekly menu in your storage or state management as needed
          },
          onFamilyUpdate: (List<Map<String, String>> updatedFamilyMembers) {
            setState(() {
              familyMembers = updatedFamilyMembers;
            });
            // Update the family members in your storage or state management as needed
          },
        );
      },
    );
  }
}
