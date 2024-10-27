import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:impeccablehome_customer/utils/color_themes.dart';

class LoginHeaderWidget extends StatelessWidget {
  final Image iconImage; 
  final String title;
  final TextSpan briefDescription;
  const LoginHeaderWidget({
    super.key,
    required this.iconImage,
    required this.title,
    required this.briefDescription,
    });
  
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          Image.asset("assets/images/login_header.png"),
          Column(
            children: [
              Padding(
                  padding: EdgeInsets.only(
                    top: 90,
                    left: MediaQuery.of(context).size.width * (1 / 17),
                  ),
                  child: Row(
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.width * (5 / 11),
                        width: MediaQuery.of(context).size.width *
                            (5 / 11), // Same as height for a perfect circle
                        decoration: BoxDecoration(
                          color: Colors.white, // Background color
                          shape: BoxShape.circle, // Makes the container round
                        ),
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 12),
                            child: iconImage,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          left: MediaQuery.of(context).size.width * (1 / 14),
                        ),
                        child: Text(
                          title,
                          style: TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.w500,
                              color: Colors.white),
                        ),
                      ),
                    ],
                  )),
              Padding(
                  padding: const EdgeInsets.only(top: 30),
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: briefDescription
                  )),
            ],
          ),
        ],
      ),
    );
  }
}
