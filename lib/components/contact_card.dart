import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:impeccablehome_customer/model/helper_model.dart';
import 'package:impeccablehome_customer/model/user_model.dart';
import 'package:impeccablehome_customer/resources/helper_service.dart';
import 'package:impeccablehome_customer/utils/color_themes.dart';

class ContactCard extends StatefulWidget {
  final String helperId;
  final String lastMessage;
  final int unreadCount;
  final VoidCallback onTap;

  ContactCard({
    required this.helperId,
    required this.lastMessage,
    required this.unreadCount,
    required this.onTap,
    Key? key,
  }) : super(key: key);

  @override
  State<ContactCard> createState() => _ContactCardState();
}

class _ContactCardState extends State<ContactCard> {
  HelperModel? helper;

  String formatLastActive(String? lastLogOutAt) {
    if (lastLogOutAt == null || lastLogOutAt.isEmpty) {
      return "Unavailable"; // Fallback for null or empty value
    }

    try {
      // Parse the String into a DateTime object
      final lastActive = DateTime.parse(lastLogOutAt);

      // Calculate the difference between now and the parsed DateTime
      final duration = DateTime.now().difference(lastActive);

      // Format based on the duration
      if (duration.inMinutes < 60) {
        return '${duration.inMinutes} min';
      } else if (duration.inHours < 24) {
        return '${duration.inHours} hours';
      } else if (duration.inDays < 7) {
        return '${duration.inDays} days';
      } else {
        // Return formatted date as DD-MM-YYYY
        return '${lastActive.day.toString().padLeft(2, '0')}-'
            '${lastActive.month.toString().padLeft(2, '0')}-'
            '${lastActive.year}';
      }
    } catch (e) {
      print("Invalid date format: $lastLogOutAt");
      return "Invalid date"; // Fallback for invalid format
    }
  }

  final currentuser = FirebaseAuth.instance.currentUser;
  final HelperService helperService = HelperService();
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchHelper();
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
    } finally {
      setState(() {
        isLoading = false; // Stop loading once data is fetched
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        height: screenWidth * 2 / 9,
        padding: const EdgeInsets.symmetric(vertical: 2.0),
        child: Column(
          children: [
            isLoading
                ? CircularProgressIndicator()
                : Row(
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Stack(
                            clipBehavior: Clip
                                .none, // To allow the dot to appear outside the bounds
                            children: [
                              CircleAvatar(
                                backgroundImage: NetworkImage(
                                  helper!
                                      .profilePic, // Replace with HelperModel().profilePic
                                ),
                                radius: screenWidth / 11,
                              ),
                              Positioned(
                                top:
                                    2, // Adjust this to fine-tune the position of the dot
                                left: 2, // Adjust this as well
                                child: Container(
                                  width: 14, // Diameter of the dot
                                  height: 14,
                                  decoration: BoxDecoration(
                                    color: helper!.status == 'onl'
                                        ? oceanBlueColor
                                        : silverGrayColor,
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: Colors
                                          .white, // Optional border for better visibility
                                      width: 2,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(helper!.firstName + " " + helper!.lastName,
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            SizedBox(height: 4),
                            Text(widget.lastMessage,
                                style: TextStyle(color: silverGrayColor)),
                          ],
                        ),
                      ),
                      SizedBox(width: 16),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                              helper!.lastLogOutAt == ""
                                  ? "Online"
                                  : formatLastActive(helper!.lastLogOutAt),
                              style: TextStyle(
                                  fontSize: 12, color: charcoalGrayColor)),
                          SizedBox(height: 4),
                          if (widget.unreadCount > 0)
                            CircleAvatar(
                              radius: 10,
                              backgroundColor: Colors.red,
                              child: Text(
                                widget.unreadCount.toString(),
                                style: TextStyle(
                                    color: Colors.white, fontSize: 12),
                              ),
                            ),
                        ],
                      ),
                    ],
                  ),
            Expanded(child: Container()),
            Divider(
              color: silverGrayColor, // Line color
              thickness: 1, // Line thickness
              height: 1, // Space the divider takes vertically
            )
          ],
        ),
      ),
    );
  }
}
