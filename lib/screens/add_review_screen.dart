import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:impeccablehome_customer/components/custom_back_button.dart';
import 'package:impeccablehome_customer/components/custom_button.dart';
import 'package:impeccablehome_customer/components/dash_border_painter.dart';
import 'package:impeccablehome_customer/components/ratings_widget.dart';
import 'package:impeccablehome_customer/model/helper_model.dart';
import 'package:impeccablehome_customer/model/review_model.dart';
import 'package:impeccablehome_customer/model/user_model.dart';
import 'package:impeccablehome_customer/resources/helper_service.dart';
import 'package:impeccablehome_customer/resources/review_services.dart';
import 'package:impeccablehome_customer/resources/user_services.dart';
import 'package:impeccablehome_customer/screens/report_screen.dart';
import 'package:impeccablehome_customer/utils/color_themes.dart';
import 'package:impeccablehome_customer/utils/mock.dart';

class AddReviewScreen extends StatefulWidget {
  final String userId;
  final String helperId;
  const AddReviewScreen(
      {super.key, required this.helperId, required this.userId});

  @override
  State<AddReviewScreen> createState() => _AddReviewScreenState();
}

class _AddReviewScreenState extends State<AddReviewScreen> {
  ValueNotifier<int> ratingsController = ValueNotifier<int>(5);
  TextEditingController reviewContentController = TextEditingController();
  final List<File> _selectedImages = [];
  final ImagePicker _picker = ImagePicker();

  void _pickImage(ImageSource source) async {
    if (_selectedImages.length >= 3) return; // Maximum of 3 images
    final XFile? pickedFile = await _picker.pickImage(source: source);

    if (pickedFile != null) {
      setState(() {
        _selectedImages.add(File(pickedFile.path));
      });
    }
  }

  void _showImagePickerOptions() {
    showModalBottomSheet(
      context: context,
      builder: (_) => SafeArea(
        child: Wrap(
          children: [
            ListTile(
              leading: Icon(Icons.camera_alt),
              title: Text("Take a Photo"),
              onTap: () {
                Navigator.pop(context);
                _pickImage(ImageSource.camera);
              },
            ),
            ListTile(
              leading: Icon(Icons.photo),
              title: Text("Get from Storage"),
              onTap: () {
                Navigator.pop(context);
                _pickImage(ImageSource.gallery);
              },
            ),
          ],
        ),
      ),
    );
  }

  void _removeImage(int index) {
    setState(() {
      _selectedImages.removeAt(index);
    });
  }

  bool isUploading = false;
  final ReviewService _reviewService = ReviewService();
  Future<void> _uploadReview() async {
    if (isUploading) return;

    final reviewContent = reviewContentController.text.trim();
    final ratings = ratingsController.value;

    setState(() {
      isUploading = true;
    });

    try {
      // Upload images and get their URLs
      List<String> imageUrls = [];
      for (File image in _selectedImages) {
        String fileName = DateTime.now().millisecondsSinceEpoch.toString();
        Reference ref =
            FirebaseStorage.instance.ref().child('review_images/$fileName');
        await ref.putFile(image);
        String imageUrl = await ref.getDownloadURL();
        imageUrls.add(imageUrl);
      }

      // Upload review to Firestore
      await _reviewService.uploadReview(ReviewModel(
          userId: widget.userId,
          helperId: widget.helperId,
          ratings: ratings.toDouble(),
          reviewContent: reviewContent,
          reviewPics: imageUrls));

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Review uploaded successfully!')),
      );
      Navigator.pop(context); // Go back to the previous screen
    } catch (e) {
      print('Error uploading review: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to upload review')),
      );
    } finally {
      setState(() {
        isUploading = false;
      });
    }
  }

  bool isLoading = true; // State to track loading
  final UserService userService = UserService();
  UserModel? user;
  final HelperService helperService = HelperService();
  HelperModel? helper;
  @override
  void initState() {
    super.initState();
    _fetchUser(); // Fetch user details when the widget is initialized
    _fetchHelper();
    setState(() {
      isLoading = false; // Stop loading once data is fetched
    });
  }

  Future<void> _fetchUser() async {
    try {
      final fetchedUser = await userService.fetchUserDetails(widget.userId);

      if (fetchedUser != null) {
        setState(() {
          user = fetchedUser;
        });
      }
    } catch (e) {
      // Handle errors (optional)
      print('Error fetching user: $e');
    } finally {}
  }

  Future<void> _fetchHelper() async {
    try {
      final fetchedHelper =
          await helperService.fetchHelperDetails(widget.helperId);

      if (fetchedHelper != null) {
        setState(() {
          helper = fetchedHelper;
        });
      }
    } catch (e) {
      // Handle errors (optional)
      print('Error fetching helper: $e');
    } finally {}
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final avatarSize = screenWidth / 2;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.only(
                  top: screenWidth * (1 / 6),
                  left: screenWidth * (1 / 13),
                ),
                child: Row(
                  children: [
                    CustomBackButton(color: Colors.blue),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * (2 / 7),
                    ),
                    Text(
                      "Profile",
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Colors.black),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 25,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: screenWidth / 8),
                child: Text(
                  isLoading
                      ? ""
                      : "What is your thought on ${helper!.firstName} ${helper!.lastName}'s service?",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(
                height: 25,
              ),
              CircleAvatar(
                radius: avatarSize / 3,
                backgroundImage: NetworkImage(isLoading
                    ? "https://media.istockphoto.com/id/1337144146/vector/default-avatar-profile-icon-vector.jpg?s=612x612&w=0&k=20&c=BIbFwuv7FxTWvh5S3vB6bkT0Qv8Vn8N5Ffseq84ClGI="
                    : helper!.profilePic),
              ),
              SizedBox(
                height: 25,
              ),
              RatingsWidget(controller: ratingsController),
              SizedBox(
                height: 25,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: screenWidth / 14),
                child: TextField(
                  controller: reviewContentController,
                  maxLines: null, // Allows the input to have many lines
                  style: TextStyle(fontSize: 18.0),
                  decoration: InputDecoration(
                    hintText: "Leave your comment here",
                    hintStyle: TextStyle(color: Colors.grey),
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius:
                          BorderRadius.circular(18.0), // Rounded border
                      borderSide: BorderSide(
                        color:
                            silverGrayColor, // Replace with your custom color
                        width: 1.0,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(18.0),
                      borderSide: BorderSide(
                        color: silverGrayColor,
                        width: 1.0,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16.0),
                      borderSide: BorderSide(
                        color: orangeColor,
                        width: 1.0,
                      ),
                    ),
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 16.0,
                      vertical: 12.0,
                    ), // Adjusts inner padding
                  ),
                  keyboardType: TextInputType.multiline,
                  textInputAction: TextInputAction.newline,
                  minLines: 5, // Ensures height of 145px approx
                ),
              ),
              SizedBox(
                height: 25,
              ),
              Text(
                "Upload some pictures?",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              SizedBox(
                height: 15,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Wrap(
                    spacing: 16.0,
                    runSpacing: 8.0,
                    children: [
                      ..._selectedImages.asMap().entries.map((entry) {
                        final index = entry.key;
                        final image = entry.value;

                        return Stack(
                          children: [
                            Container(
                              width: 110,
                              height: 110,
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(top: 10, right: 10),
                                child: Container(
                                  width: 100,
                                  height: 100,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: FileImage(image),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              top: 0,
                              right: 0,
                              child: GestureDetector(
                                onTap: () => _removeImage(index),
                                child: CircleAvatar(
                                  radius: 12,
                                  backgroundColor: Colors.grey.withOpacity(0.6),
                                  child: Icon(
                                    Icons.close,
                                    color: Colors.black,
                                    size: 18,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        );
                      }).toList(),
                      if (_selectedImages.length < 3)
                        GestureDetector(
                          onTap: _showImagePickerOptions,
                          child: Container(
                            width: 110,
                            height: 110,
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(top: 10.0, right: 10),
                              child: Container(
                                width: 100,
                                height: 100,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                child: CustomPaint(
                                  painter: DashedBorderPainter(
                                    color: lightGrayColor,
                                    dashWidth: 6.0,
                                    dashGap: 5.0,
                                  ),
                                  child: Center(
                                    child: Text(
                                      '+',
                                      style: TextStyle(
                                        fontSize: 66,
                                        fontWeight: FontWeight
                                            .w300, // Adjust weight for thickness
                                        color: silverGrayColor,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                "Selected Images (${_selectedImages.length}/3):",
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
              ),
              SizedBox(
                height: 15,
              ),
              RichText(
                text: TextSpan(
                  text: "Have a problem with our service? ",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: Colors.black,
                    height: 1.5,
                  ),
                  children: [
                    TextSpan(
                      text: "Let us know",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: skyBlueColor,
                        decoration: TextDecoration.underline,
                        height: 1.5,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ReportScreen(),
                            ),
                          );
                        },
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 35,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: screenWidth / 8),
                child: CustomButton(
                  title: "Send your review",
                  onTap: _uploadReview,
                  textColor: Colors.white,
                  backgroundColor: oceanBlueColor,
                ),
              ),
              SizedBox(
                height: 50,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
