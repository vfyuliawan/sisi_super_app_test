// ignore_for_file: unused_element

import 'package:flutter/material.dart';

class Constans {
  static final theme = _Theme();
  static final routeMenu = RouteMenu();
  static var primaryColor = const Color(0xff296e48);
  static var secondaryColor = const Color(0xff3A8891);
  static var thirdColor = const Color(0xffEBD9B4);
  static var fourthColor = const Color(0xffFBF9F1);
  static var fivethColor = const Color(0xffd2c1b9);
  static var sixth = const Color(0xffe3b480);
  // static var seventh = Color(0xff265073);
  static var seventh = const Color(0xff3A8891);
  static var eight = const Color.fromARGB(255, 239, 239, 239);
  static var nine = const Color.fromARGB(255, 240, 240, 240);
  static var ten = const Color.fromARGB(255, 248, 240, 232);
  static var eleven = const Color.fromARGB(138, 100, 86, 255);

  static var textColor = const Color(0xff3C3633);
  static var textColor2 = const Color.fromARGB(255, 88, 75, 70);
  static var alertColor = const Color.fromARGB(255, 252, 239, 214);
  static var redEssence = const Color.fromARGB(255, 117, 7, 7);
  static var bluePremium = const Color(0xff101f32);
  static var luxuryGreen = const Color(0xff758673);
  static var luxuryCream = const Color(0xffEBD9B4);
  static var luxuryPink = const Color(0xffDBC4CA);

  static var baseUrlDev = 'localhost:3000/?a=';
  // static var baseUrlDev = 'localhost:3000/?a=';
  static var version = "V.0.0.1";
  static var baseUrlDeploy =
      'https://your-wedding-day-git-main-vfyuliawans-projects.vercel.app/?a=';

  static List<String> listDebitCard = [
    "ImageBca",
    "ImageBri",
    "ImageOvo",
  ];
  static List<String> listTheme = [
    "RedEssence",
    "BluePremium",
    "LuxuryCream",
    "LuxuryGreen",
    "LuxuryPink",
    "GreenFloral",
    "DarkGreenFloral",
    "BlueFloral",
    "BluePastel",
    "BlueAnimatedFloral",
    "CoklatAnimatedFloral",
    "JavaStyle1"
    // "BlackPasta"
    // "BlackPasta"
    // "BlackPasta"
  ];

  static List<String> listThemeSong = [
    "Payung-Teduh-Akad",
    "Komang-Raim-Laode",
    "Pamungkas-To-The-Bone",
    "Merry-Your-Daughter",
    "Thousand-Years",
  ];

  static var uidLogin = "uidLogin";
  static var bearerToken = "bearerToken";
  static var displayName = "displayName";
  static var unauthorize = "Unauthorize";
}

class _Theme {
  final String redEssence = "RedEssence";
  final String bluePremium = "BluePremium";
  final String luxuryCream = "LuxuryCream";
  final String luxuryGreen = "LuxuryGreen";
  final String luxuryPink = "LuxuryPink";
}

class RouteMenu {
  final String createPreset = "createPreset";
  final String createUndangan = "createUndangan";
  final String listcontact = "listcontact";
  final String listUser = "listUser";
  final String listRsvp = "listRsvp";
  final String listMessage = "listMessage";
}
