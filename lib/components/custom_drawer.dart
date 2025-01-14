import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:impeccablehome_customer/model/user_model.dart';
import 'package:impeccablehome_customer/resources/authentication_method.dart';
import 'package:impeccablehome_customer/resources/user_services.dart';
import 'package:impeccablehome_customer/screens/profile_screen.dart';
import 'package:impeccablehome_customer/utils/color_themes.dart';
import 'package:provider/provider.dart';

class CustomDrawer extends StatefulWidget {
  final String userName;
  final String profilePic;
  const CustomDrawer({
    required this.profilePic,
    required this.userName,
    Key? key,
  }) : super(key: key);

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Drawer(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(22),
          bottomLeft: Radius.circular(22),
        ),
      ),
      child:  Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Drawer Header
          Container(
            decoration: BoxDecoration(
              color: oceanBlueColor,
              borderRadius: BorderRadius.circular(22),
            ),
            child: Padding(
              padding: EdgeInsets.only(
                  top: screenWidth / 7,
                  left: screenWidth / 11,
                  bottom: screenWidth / 15),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 35,
                    backgroundImage: NetworkImage(widget.profilePic),
                  ),
                  SizedBox(width: 12),
                  Text(
                    widget.userName,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Drawer Options
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                _drawerOption(
                  context,
                  prefixIcon: Image.asset(
                    "assets/icons/small_person_icon.png",
                    width: 24,
                    height: 24,
                  ),
                  title: "Profile",
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProfileScreen(),
                      ),
                    );
                  },
                ),
                _drawerOption(
                  context,
                  prefixIcon: Image.asset(
                    "assets/icons/promotion_icon.png",
                    width: 24,
                    height: 24,
                  ),
                  title: "Promotion",
                  onTap: () {},
                ),
                _drawerOption(
                  context,
                  prefixIcon: Image.asset(
                    "assets/icons/setting_icon.png",
                    width: 24,
                    height: 24,
                  ),
                  title: "Setting",
                  onTap: () {},
                ),
                _drawerOption(
                  context,
                  prefixIcon: Image.asset(
                    "assets/icons/support_icon.png",
                    width: 24,
                    height: 24,
                  ),
                  title: "Support",
                  onTap: () {},
                ),
                _drawerOption(
                  context,
                  prefixIcon: Image.asset(
                    "assets/icons/policy_icon.png",
                    width: 24,
                    height: 24,
                  ),
                  title: "Policy",
                  onTap: () {},
                ),
                _drawerOption(
                  context,
                  prefixIcon: Image.asset(
                    "assets/icons/logout_icon.png",
                    width: 24,
                    height: 24,
                  ),
                  title: "Log out",
                  onTap: () {
                    signOut();
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _drawerOption(BuildContext context,
      {required Widget prefixIcon,
      required String title,
      required VoidCallback onTap}) {
    return Padding(
      padding: const EdgeInsets.only(
          top: 12.0, left: 40, right: 14), // Add vertical padding
      child: Column(
        children: [
          ListTile(
            leading: prefixIcon,
            title: Text(
              title,
              style: TextStyle(fontSize: 16),
            ),
            onTap: onTap,
          ),
          SizedBox(
            height: 10,
          ),
          Divider(
            color: lightGrayColor, // Divider color
            thickness: 1, // Divider thickness
            height: 1, // Adjust the spacing around the divider
          ),
        ],
      ),
    );
  }
  void signOut() {
    final authMethods =
        Provider.of<AuthenticationMethods>(context, listen: false);
      authMethods.userSignOut();
    }
  
}
