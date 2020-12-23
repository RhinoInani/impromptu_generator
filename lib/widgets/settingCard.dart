import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SettingsCard extends StatelessWidget {
  final String text;
  final Icon icon;
  final Function pressIcon;
  const SettingsCard({Key key, this.text, this.icon, this.pressIcon}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: pressIcon,
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.035),
            height: MediaQuery.of(context).size.height * 0.135,
            child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      text,
                      style: GoogleFonts.poppins(
                        fontSize: MediaQuery.of(context).size.width * 0.055,
                      ),
                    ),
                    IconButton(
                      onPressed:pressIcon,
                      icon: icon,
                      iconSize: MediaQuery.of(context).size.height * 0.03,
                      color: Colors.black,
                    ),
                  ],
                ),
              ],
            ),
          ),
          Divider(
            height: 5,
            color: Colors.black,
            thickness: 0.5,
          ),

        ],
      ),
    );
  }
}
