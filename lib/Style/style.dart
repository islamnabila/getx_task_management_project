
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../widget/profilelisttile_style_screen.dart';

const colorGreen = Color.fromRGBO(33, 191, 115, 1);
const colorWhite = Color.fromRGBO(255, 255, 255, 1);


//Background Image
SvgPicture ScreenBackGround(context){
  return SvgPicture.asset("assets/images/background.svg",
    alignment: Alignment.center,
    height: MediaQuery.of(context).size.height,
    width: MediaQuery.of(context).size.width,
    fit: BoxFit.cover,
  );
}
//splash screen logo
SvgPicture ScreenLogo(context){
  return SvgPicture.asset("assets/images/logo.svg",
    alignment: Alignment.center,
    height: MediaQuery.of(context).size.height*0.08,
    width: MediaQuery.of(context).size.height*0.08,
    fit: BoxFit.cover,
  );
}

//Text Style large bold 1
Text boldTextStyle(text){
  return Text(text, style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),);
}
//Text Style grey small 2
Text GreyTextStyle(text){
  return Text(text, style: TextStyle(color: Colors.grey.shade600, fontSize: 15),);
}

//Text Style small bold 3
Text BoldSmallTextStyle(text){
  return Text(text, style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),);
}

//Text Form field Decoration
InputDecoration TextFormFieldWhite(hint){
  return InputDecoration(
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: Colors.green, width: 1
      )
    ),
    filled: true,
    fillColor: colorWhite,
    contentPadding: EdgeInsets.all(20),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: colorWhite, width: 1
      )
    ),
    border: OutlineInputBorder(),
    hintText: hint,
  );
}

//Elevatted button style

ButtonStyle ElevattedButtonStyle(){
  return ElevatedButton.styleFrom(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(6),
    ),
    backgroundColor: Colors.transparent,
    elevation: 1,
    padding: EdgeInsets.all(0),

  );
}

//Elevatted button child Icon style
Ink ButtonChildStyle(IconData button){
  return Ink(
    decoration: BoxDecoration(
      color: colorGreen,
      borderRadius: BorderRadius.circular(6)
    ),
    child: Container(
      height: 45,
      alignment: Alignment.center,
      child: Icon(button, size: 30,),
    ),
  );
}
//Elevatted button child Text style
Ink ButtonChildStyleText(text){
  return Ink(
    decoration: BoxDecoration(
        color: colorGreen,
        borderRadius: BorderRadius.circular(6)
    ),
    child: Container(
      height: 45,
      alignment: Alignment.center,
      child: Text(text, style: TextStyle(fontSize: 17),),
    ),
  );
}
//Text Button style grey
Text TextButtonChildStyleGrey(text){
  return Text(text, style: TextStyle(color: Colors.grey.shade600, fontSize: 15),);
}
//Text Button style green
Text TextButtonChildStyle(text){
  return Text(text, style: TextStyle(color: colorGreen, fontSize: 18),);
}


//Edit Profile Photo Style


//Snackbar message for signup page
void showSnackMessage(BuildContext context, String message, [bool isError =false]){
  ScaffoldMessenger.of(context).showSnackBar(
       SnackBar(
          content: Text(message),
       backgroundColor: isError? Colors.red : null));
}


ProfileListTileStyle ListTyleStyle(){
  return ProfileListTileStyle();
}
