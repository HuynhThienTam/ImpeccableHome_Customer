import 'package:flutter/material.dart';
import 'package:impeccablehome_customer/utils/color_themes.dart';
import 'package:intl/intl.dart';

class HelperInfoWidget extends StatelessWidget {
  final String avatarPath;
  final String workerName;
  final String gender;
  final String dateOfBirth;
  final String location;

  const HelperInfoWidget({
    Key? key,
    required this.avatarPath,
    required this.workerName,
    required this.gender,
    required this.dateOfBirth,
    required this.location,
  }) : super(key: key);

  int _calculateAge(String dob) {
    final birthDate = DateFormat('yyyy-MM-dd').parse(dob);
    final today = DateTime.now();
    int age = today.year - birthDate.year;
    if (today.month < birthDate.month ||
        (today.month == birthDate.month && today.day < birthDate.day)) {
      age--;
    }
    return age;
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final avatarSize = screenWidth * 2 / 5;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            // Rounded Container
            Container(
              height: avatarSize,
              padding: EdgeInsets.only(
                  left: avatarSize / 2,
                  top: avatarSize / 10,
                  bottom: avatarSize / 10),
              child: Container(
                width: screenWidth * 7 / 11,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: lightGrayColor, 
                    width: 2.0, // Border width
                  ),
                  borderRadius: BorderRadius.circular(26.0), // Rounded corners
                ),
                child: Padding(
                  padding: EdgeInsets.only(left: ((avatarSize / 2) + 16)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        workerName,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: 8),
                      Row(
                        children: [
                          Image.asset(
                            gender.toLowerCase() == 'male'
                                ? 'assets/icons/male_icon.png'
                                : 'assets/icons/female_icon.png',
                            height: 16,
                            width: 16,
                          ),
                          SizedBox(width: 8),
                          Text(
                            '${_calculateAge(dateOfBirth)} years old',
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                color: silverGrayColor),
                          ),
                        ],
                      ),
                      SizedBox(height: 8),
                      Row(
                        children: [
                          Image.asset(
                            'assets/icons/small_location_icon.png',
                            height: 16,
                            width: 16,
                          ),
                          SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              location,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                color: silverGrayColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // Rounded Avatar
            Positioned(
              left: 0,
              child: CircleAvatar(
                radius: avatarSize / 2,
                backgroundImage: NetworkImage(avatarPath),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
