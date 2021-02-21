import 'dart:math';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:impromptu_generator2/screens/speechScreens/chooseTopicScreen.dart';
import 'package:impromptu_generator2/userSettings.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CustomTopicsScreen extends StatefulWidget {
  @override
  _CustomTopicsScreenState createState() => _CustomTopicsScreenState();
}

class _CustomTopicsScreenState extends State<CustomTopicsScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final textController = TextEditingController();

  void dispose() {
    textController.dispose();
    super.dispose();
  }

  void modalPopUpTopic(
      context, String title, String buttonText, Function press) {
    Size size = MediaQuery.of(context).size;
    showModalBottomSheet(
      context: context,
      builder: (BuildContext bc) {
        return Container(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 10.0,
              vertical: 10,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Text(
                      title,
                      style: TextStyle(fontSize: size.width * 0.05),
                    ),
                    Spacer(),
                    IconButton(
                      icon: Icon(Icons.close),
                      onPressed: () {
                        Navigator.of(context).pop();
                        textController.clear();
                      },
                    ),
                  ],
                ),
                Divider(
                  height: 10,
                  indent: 10,
                  endIndent: 10,
                  color: Colors.black87,
                  thickness: 0.5,
                ),
                SizedBox(
                  height: size.height * 0.10,
                ),
                Padding(
                  padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom,
                  ),
                  child: TextField(
                    controller: textController,
                    keyboardType: TextInputType.text,
                    textAlign: TextAlign.center,
                    textCapitalization: TextCapitalization.sentences,
                    maxLength: 200,
                    maxLengthEnforced: true,
                    decoration: InputDecoration(
                      hintText: "Enter a topic",
                      labelStyle: GoogleFonts.poppins(
                        color: Colors.black,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(28),
                        borderSide: BorderSide(color: Colors.black),
                        gapPadding: 10,
                      ),
                      errorStyle: GoogleFonts.poppins(
                        color: Colors.red,
                      ),
                      errorBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                        color: Colors.red,
                      )),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(28),
                        borderSide: BorderSide(
                          color: Colors.black,
                        ),
                        gapPadding: 10,
                      ),
                      focusedErrorBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.red,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: size.height * 0.05,
                ),
                GestureDetector(
                  onTap: press,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.blue[100],
                      borderRadius: BorderRadius.circular(28),
                      border: Border.all(
                        color: Colors.black,
                        width: 0.7,
                      ),
                    ),
                    width: size.width * 0.6,
                    height: size.height * 0.07,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          buttonText,
                          textAlign: TextAlign.center,
                          style: GoogleFonts.poppins(
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: size.height * 0.05,
                ),
              ],
            ),
          ),
        );
      },
      isScrollControlled: true,
      isDismissible: true,
      enableDrag: true,
      elevation: 15,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(MediaQuery.of(context).size.height * 0.02),
            topRight:
                Radius.circular(MediaQuery.of(context).size.height * 0.02)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.cyan[50],
      appBar: AppBar(
        elevation: 0,
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
        actions: [
          IconButton(
            padding: EdgeInsets.only(right: 20),
            icon: Icon(
              Icons.add_box_outlined,
              color: Colors.black,
            ),
            splashColor: Colors.transparent,
            onPressed: () {
              modalPopUpTopic(context, "Enter Custom Topics", "Add Topic",
                  () async {
                if (textController.text.isEmpty) {
                } else {
                  setState(() {
                    customTopics.add(textController.text);
                  });
                  SharedPreferences prefs =
                      await SharedPreferences.getInstance();
                  prefs.setStringList('customTopics', customTopics);
                  Navigator.of(context).pop();
                  textController.clear();
                }
              });
            },
          ),
        ],
        backgroundColor: Colors.cyan[50],
      ),
      body: Column(
        children: [
          Text(
            "Custom Topics",
            style: TextStyle(fontSize: size.width * 0.07),
          ),
          Text(
            "Swipe left or right to delete topics",
            style: TextStyle(fontSize: size.width * 0.03),
          ),
          Divider(
            height: 20,
            indent: 50,
            endIndent: 50,
            color: Colors.black87,
            thickness: 0.5,
          ),
          Expanded(
            child: ListView.builder(
              itemCount: customTopics.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                final topic = customTopics[index];
                return Dismissible(
                  key: UniqueKey(),
                  child: GestureDetector(
                    onTap: () {
                      modalPopUpTopic(context, "Edit Topic", "Save changes",
                          () async {
                        if (textController.text.isEmpty ||
                            textController.text == null) {
                        } else {
                          setState(() {
                            customTopics.remove(customTopics[index]);
                            customTopics.insert(index, textController.text);
                          });
                          SharedPreferences prefs =
                              await SharedPreferences.getInstance();
                          prefs.setStringList('customTopics', customTopics);
                          Navigator.of(context).pop();
                          textController.clear();
                        }
                      });
                      textController.text = topic;
                    },
                    child: Column(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Flexible(
                              child: AutoSizeText(
                                topic,
                                maxFontSize: size.width * 0.8,
                                textAlign: TextAlign.center,
                                minFontSize: 17,
                              ),
                            ),
                          ],
                        ),
                        Divider(
                          height: 20,
                          indent: 10,
                          endIndent: 10,
                          color: Colors.black87,
                          thickness: 0.5,
                        ),
                      ],
                    ),
                  ),
                  onDismissed: (direction) async {
                    setState(() {
                      customTopics.removeAt(index);
                    });
                    HapticFeedback.mediumImpact();
                    Scaffold.of(context).showSnackBar(SnackBar(
                        duration: Duration(milliseconds: 800),
                        content: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Flexible(
                                child: AutoSizeText("$topic has been removed")),
                          ],
                        )));
                    SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    prefs.setStringList('customTopics', customTopics);
                  },
                  background: Container(
                      color: Colors.red[300],
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Icon(Icons.remove),
                          Icon(Icons.remove),
                        ],
                      )),
                  // child: ListTile(title: Text('$topic')),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: Builder(builder: (BuildContext context) {
        return FloatingActionButton.extended(
          label: Text("Custom Topic Generator"),
          elevation: 5,
          splashColor: Colors.blue,
          highlightElevation: 7,
          backgroundColor: Colors.blue,
          onPressed: () async {
            if (customTopics.length < 3) {
              Scaffold.of(context).showSnackBar(SnackBar(
                  duration: Duration(milliseconds: 1100),
                  content: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Flexible(
                        child: Text(
                          "Please enter more than 3 topics",
                          style: TextStyle(
                            color: Colors.red,
                          ),
                        ),
                      ),
                    ],
                  )));
            } else {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                var random = Random();
                return ChooseTopic(
                  topic1: customTopics[random.nextInt(customTopics.length)],
                  topic2: customTopics[random.nextInt(customTopics.length)],
                  topic3: customTopics[random.nextInt(customTopics.length)],
                  fontSize: 0.06,
                  maxLines: 10,
                );
              }));
            }
          },
        );
      }),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
// body: Column(
//   crossAxisAlignment: CrossAxisAlignment.center,
//   children: [
//     Expanded(
//         child: Padding(
//           padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
//           child: GridView.builder(
//             itemCount: customTopics.length,
//               gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                 crossAxisCount: 1,
//                 childAspectRatio: 2.5,
//               ),
//               itemBuilder: (context, index){
//                 return CustomTopicCard(
//                   topic: customTopics[index],
//                   type: customTypes[index],
//                   press: (){},
//                 );
//               },
//           ),
//         ),
//     ),
//   ],
// ),

// body: Padding(
//   padding: EdgeInsets.symmetric(
//       horizontal: size.width * 0.05,
//     vertical: size.height * 0.15,
//   ),
//   child: SingleChildScrollView(
//     child: Column(
//       children: [
//         Container(
//           padding: EdgeInsets.only(left: 16, right: 16),
//           decoration: BoxDecoration(
//               border: Border.all(color: Colors.black),
//               borderRadius: BorderRadius.circular(30)),
//           child: Padding(
//             padding: EdgeInsets.symmetric(
//               horizontal: MediaQuery.of(context).size.width * 0.035,
//             ),
//             child: DropdownButton(
//               hint: Text(topics[1],
//                   style: GoogleFonts.poppins()),
//               dropdownColor: Colors.grey[100],
//               underline: Container(),
//               elevation: 5,
//               icon: Icon(Icons.arrow_drop_down),
//               iconSize:
//               MediaQuery.of(context).size.height * 0.04,
//               isExpanded: false,
//               value: dropDownValue,
//               style: TextStyle(
//                   color: Colors.black, fontSize: 17.0
//               ),
//               onChanged: (value) {
//                 setState(() {
//                   dropDownValue = value;
//                 });
//                 for(int i = 0; i < userTopicsAbstract.length; i++){
//                   print(userTopicsAbstract[i]);
//                 }
//                 HapticFeedback.lightImpact();
//               },
//               items: topics.map((value) {
//                 return DropdownMenuItem(
//                   value: value,
//                   child: Text(
//                     value,
//                     style: GoogleFonts.poppins(),
//                   ),
//                 );
//               }).toList(),
//             ),
//           ),
//         ),
//         SizedBox(
//           height: size.height * 0.15,
//         ),
//         TextFormField(
//           controller: textController,
//           keyboardType: TextInputType.text,
//           textAlign: TextAlign.center,
//           decoration: InputDecoration(
//             hintText: "Enter a topic",
//             labelStyle: GoogleFonts.poppins(
//               color: Colors.black,
//             ),
//             enabledBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(28),
//               borderSide: BorderSide(
//                   color: Colors.black
//               ),
//               gapPadding: 10,
//             ),
//             errorStyle: GoogleFonts.poppins(
//               color: Colors.red,
//             ),
//             errorBorder: UnderlineInputBorder(
//                 borderSide: BorderSide(
//                   color:  Colors.red,
//                 )
//             ),
//             focusedBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(28),
//               borderSide: BorderSide(
//                   color: Colors.black,
//               ),
//               gapPadding: 10,
//             ),
//             focusedErrorBorder: UnderlineInputBorder(
//               borderSide: BorderSide(
//                 color:  Colors.red,
//               ),
//             ),
//           ),
//         ),
//         SizedBox(
//           height: size.height * 0.05,
//         ),
//         GestureDetector(
//           onTap: (){
//             if(dropDownValue.toString()=="Abstract Topics"){
//               userTopicsAbstract.add(textController.text);
//             }
//             else if(dropDownValue.toString()=="Concrete Topics"){
//               userTopicsConcrete.add(textController.text);
//             }
//             else if(dropDownValue.toString()=="Quote Topics"){
//               userTopicsQuote.add(textController.text);
//             }
//           },
//           child: Container(
//             decoration: BoxDecoration(
//               color: Colors.cyan[100],
//               borderRadius: BorderRadius.circular(28),
//               border: Border.all(
//                 color: Colors.black,
//                 width: 0.7,
//               ),
//             ),
//             width: size.width* 0.6,
//             height: size.height * 0.07,
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Text(
//                     "Add Topic",
//                   textAlign: TextAlign.center,
//                   style: GoogleFonts.poppins(
//                     color: Colors.black,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ],
//     ),
//   ),
// ),
