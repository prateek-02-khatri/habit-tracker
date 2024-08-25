import 'package:flutter/material.dart';
import 'package:habit_tracker_app/view/profile/widgets/custom_list_tile.dart';
import 'package:habit_tracker_app/view_model/auth_provider.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AuthenticationProvider>(context);
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 15,),
              Center(
                child: CircleAvatar(
                  minRadius: 125,
                  maxRadius: 150,
                  backgroundColor: Colors.deepPurpleAccent.shade100,
                  child: const Icon(
                    Icons.person,
                    color: Colors.white,
                    size: 125,
                  ),
                ),
              ),

              const Padding(
                padding: EdgeInsets.only(top: 25, bottom: 10),
                child: Text(
                "Hey User!",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 22,
                  fontWeight: FontWeight.bold),
                ),
              ),

              const Text(
                "What a wonderful day!!",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w500
                ),
              ),

              const SizedBox(height: 20,),

              const CustomListTile(icon: Icons.person, title: 'My Account Info'),

              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: Divider(),
              ),

              const CustomListTile(icon: Icons.payment, title: 'My Subscription Info'),

              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: Divider(),
              ),

              const CustomListTile(icon: Icons.list, title: 'All of my habits'),

              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: Divider(),
              ),

              const CustomListTile(icon: Icons.info, title: 'About this App'),

              const SizedBox(height: 20,),

              TextButton(
                onPressed: () {
                  provider.logout(context);
                },
                child: const Text(
                  'Log Out',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.red,
                    fontWeight: FontWeight.bold
                  ),
                )
              ),

              const SizedBox(height: 20,),
            ],
          ),
        ),
      ),
    );
  }
}
