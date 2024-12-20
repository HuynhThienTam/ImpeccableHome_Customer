import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:impeccablehome_customer/components/custom_back_button.dart';
import 'package:impeccablehome_customer/components/avatar_widget.dart';
import 'package:impeccablehome_customer/components/custom_button.dart';
import 'package:impeccablehome_customer/components/custom_text_input.dart';
import 'package:impeccablehome_customer/components/photo_selector_dialog.dart';
import 'package:impeccablehome_customer/model/user_model.dart';
import 'package:impeccablehome_customer/resources/user_services.dart';
import 'package:impeccablehome_customer/utils/color_themes.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool isLoading = true; // State to track loading
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final UserService userService = UserService();
  UserModel? user;
  String? profilePicUrl;
  final ImagePicker _picker = ImagePicker(); // Create an instance of I
  @override
  void initState() {
    super.initState();

    // Set the initial value of the TextEditingController
    _fetchUser();
  }

  final currentuser = FirebaseAuth.instance.currentUser;
  // Function to fetch user data from Firestore
  // Future<UserModel?> fetchUserDetails(String userId) async {
  //   try {
  //     final userDoc = await FirebaseFirestore.instance
  //         .collection('users') // Firestore collection name
  //         .doc(userId) // Document ID
  //         .get();

  //     if (userDoc.exists) {
  //       return UserModel.fromMap(userDoc.data()!);
  //     } else {
  //       debugPrint('User not found in Firestore');
  //       return null;
  //     }
  //   } catch (e) {
  //     debugPrint('Error fetching user: $e');
  //     return null;
  //   }
  // }
  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    super.dispose();
  }
  Future<void> _fetchUser() async {
    try {
      final fetchedUser = await userService.fetchUserDetails(currentuser!.uid);

      if (fetchedUser != null) {
        setState(() {
          user = fetchedUser;
          profilePicUrl = fetchedUser.profilePic;
          nameController.text = fetchedUser.name ?? '';
          emailController.text = fetchedUser.email ?? '';
          phoneController.text = fetchedUser.phoneNumber ?? '';
        });
      }
    } catch (e) {
      // Handle errors (optional)
      print('Error fetching helper: $e');
    } finally {
      setState(() {
        isLoading = false; // Stop loading once data is fetched
      });
    }
  }

  Future<void> _pickImage(ImageSource source) async {
    try {
      final XFile? pickedFile = await _picker.pickImage(
        source: source,
        maxWidth: 600, // Resize the image if needed
        imageQuality: 80, // Reduce quality for optimization
      );

      if (pickedFile != null) {
        await userService.uploadPhoto(currentuser!.uid, pickedFile.path);
        _fetchUser(); // Refresh the UI after upload
      }
    } catch (e) {
      print("Error picking image: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(), // Show loading indicator
            )
          : SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: screenWidth * (21 / 25),
                      child: Stack(
                        children: [
                          // Background image
                          Image.asset("assets/images/home_header.png",
                              fit: BoxFit.cover),

                          // Column for the title and back button
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: screenWidth * (1 / 13)),
                            child: Column(
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(
                                      top: screenWidth * (1 / 6)),
                                  child: Row(
                                    children: [
                                      CustomBackButton(color: Colors.white),
                                      SizedBox(width: screenWidth * (3 / 13)),
                                      Text(
                                        "Your profile",
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.white),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),

                          // Avatar widget positioned correctly
                          Positioned(
                            top: screenWidth *
                                13 /
                                32, // Adjust the position as needed
                            left: screenWidth / 2 -
                                (screenWidth * 2 / 5) /
                                    2, // Center avatar horizontally
                            child: AvatarWidget(
                              imageUrl: (profilePicUrl != null && profilePicUrl!="")
                                  ? profilePicUrl!
                                  : "https://picsum.photos/205",
                              size: screenWidth * 2 / 5,
                              onPressed: () async {
                                final selectedValue = await showDialog<String>(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return PhotoSelectorDialog(
                                      onPickImage: (source) async {
                                        // Handle image picking here, e.g., call your _pickImage method
                                        await _pickImage(source);
                                      },
                                    );
                                  },
                                );

                                if (selectedValue != null) {
                                  setState(() {});
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal:
                            MediaQuery.of(context).size.width * (1 / 10),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 20,
                          ),
                          CustomTextInput(
                            hintText: "Enter new name here",
                            prefixImage: Image.asset(
                              "assets/icons/small_person_icon.png",
                              fit: BoxFit.contain,
                            ),
                            title: "Your mame",
                            controller: nameController,
                          ),
                          SizedBox(
                            height: 25,
                          ),
                          CustomTextInput(
                            hintText: "Enter your current phone number",
                            prefixImage: Image.asset(
                              "assets/icons/small_phone_icon.png",
                              fit: BoxFit.contain,
                            ),
                            title: "Phone number",
                            controller: phoneController,
                          ),
                          SizedBox(
                            height: 25,
                          ),
                          CustomTextInput(
                            hintText: "Enter your email",
                            prefixImage: Image.asset(
                              "assets/icons/email_icon.png",
                              fit: BoxFit.contain,
                            ),
                            title: "Email",
                            controller: emailController,
                          ),
                          SizedBox(
                            height: 45,
                          ),
                          CustomButton(
                            title: "Change password",
                            onTap: () {},
                            textColor: Colors.white,
                            backgroundColor: orangeColor,
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          CustomButton(
                            title: "Save",
                            onTap: () {},
                            textColor: Colors.white,
                            backgroundColor: oceanBlueColor,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
