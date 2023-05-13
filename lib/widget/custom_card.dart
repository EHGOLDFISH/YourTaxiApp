import 'package:flutter/material.dart';
import 'package:maps_launcher/maps_launcher.dart';

import '../theme/colors.dart';

class CustomDisplayCard extends StatelessWidget {
  CustomDisplayCard(  {
    required String this.title,
    required String this.subtitle,
    required IconData this.icon,
    this.onClicked,
    this.color});

  String title;
  String subtitle;
  IconData icon = Icons.dangerous;
  Color? color = Colors.black;
  final VoidCallback? onClicked;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Column(children: [
      Row(
        children: [
          Expanded(
            child: Container(
              margin: EdgeInsets.only(
                top: 10,
                left: 25,
                right: 25,
              ),
              decoration: BoxDecoration(
                  color: white,
                  borderRadius: BorderRadius.circular(25),
                  boxShadow: [
                    BoxShadow(
                      color: grey.withOpacity(0.03),
                      spreadRadius: 10,
                      blurRadius: 3,
                      // changes position of shadow
                    ),
                  ]),
              child: Padding(
                padding: const EdgeInsets.only(
                    top: 10, bottom: 10, right: 20, left: 20),
                child: Row(
                  children: [
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: arrowbgColor,
                        borderRadius: BorderRadius.circular(15),
                        // shape: BoxShape.circle
                      ),
                      child: Center(child: Icon(icon,color: color,)),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Expanded(
                      child: Container(
                        width: (size.width - 90) * 0.7,
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                title,
                                style: TextStyle(
                                    fontSize: 14,
                                    color: black.withOpacity(0.5),
                                    fontWeight: FontWeight.w400),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              if(title != 'Drop Off' && title != 'Pick Up')
                                Text(
                                  subtitle!,
                                  style:
                                  TextStyle(
                                      fontSize: 12,
                                      color: black,
                                      fontWeight: FontWeight.w400),
                                )
                              else
                                Text(
                                  subtitle!,
                                  style:
                                  TextStyle(
                                      fontSize: 18,
                                      color: black,
                                      fontWeight: FontWeight.bold),
                                )
                              ,
                            ]),
                      ),
                    ),
                    if(title == 'Drop Off' || title == 'Pick Up')
                      Expanded(
                        child: Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              _buildButtonColumn(
                                  Colors.black, Icons.near_me, 'ROUTE', subtitle)
                            ],
                          ),
                        ),
                      )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    ]);
  }

  Widget dispatchSection(String locationType, String address) {
    return Container(
      padding: const EdgeInsets.all(32),
      color: Colors.white60,
      child: Row(
        children: [
          Expanded(
            /*1*/
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /*2*/
                Text(
                  locationType,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  address,
                  style: TextStyle(
                    fontSize: 26,
                  ),
                ),
              ],
            ),
          ),
          _buildButtonColumn(color!, Icons.near_me, 'ROUTE', address)
        ],
      ),
    );
  }

  InkWell _buildButtonColumn(
      Color color, IconData icon, String label, String address) {
    return InkWell(
      onTap: () {
        MapsLauncher.launchQuery('${address}, St Thomas, ON Canada');
      },
      child: Ink(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: color),
            Container(
              margin: const EdgeInsets.only(top: 8),
              child: Text(
                label,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: color,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}