import 'package:chungdam/screens/menu/beverage.dart';
import 'package:chungdam/screens/menu/hanwooset.dart';
import 'package:chungdam/screens/menu/koreanicecream.dart';
import 'package:chungdam/screens/menu/originfromkorea.dart';
import 'package:chungdam/screens/menu/specialmenumeat.dart';
import 'package:chungdam/screens/menu/specialmenucrab.dart';
import 'package:chungdam/screens/menu/specialmenusashimi.dart';
import 'package:chungdam/screens/menu/stew.dart';
import 'package:chungdam/screens/menu/wagyuset.dart';
import 'package:chungdam/screens/menu/usaprime.dart';
import 'package:chungdam/screens/menu/samgyeopsal.dart';
import 'package:chungdam/screens/menu/chungdammeal.dart';
import 'package:flutter/material.dart';

class MenuItem {
  final String name;
  final String imagePath;
  final int index;

  MenuItem({required this.name, required this.imagePath, required this.index});

  Widget getPage() {
    // Return the corresponding page for each menu item
    switch (name) {
      case 'MYEONGPHUM (PARQAL)':
        return MyeongphumPage(index);
      case 'WAGYU (PARQAL)':
        return WagyuSetPage(index);
      case 'USA PRIME (PARQAL)':
        return UsaPrimePage(index);
      case 'SAMGYEOPSAL (PARQAL)':
        return SamgyeopsalPage(index);
      case 'SINGLE MENU (PARQAL)':
        return MealPage(index);
      case 'STEW (PARQAL)':
        return StewPage(index);
      case 'SPECIAL MENU: MEAT (PARQAL)':
        return SpecialMenuMeatPage(index);
      case 'SPECIAL MENU: CRAB (PARQAL)':
        return SpecialMenuCrabPage(index);
      case 'SPECIAL MENU: SASHIMI (PARQAL)':
        return SpecialMenuSashimiPage(index);
      case 'ORIGIN FROM KOREA (PARQAL)':
        return OriginFromKoreaPage(index);
      case 'BEVERAGES (PARQAL)':
        return BeveragesPage(index);
      case 'MYEONGPHUM (BGC)':
        return MyeongphumBGCPage(index);
      case 'WAGYU (BGC)':
        return WagyuSetBGCPage(index);
      case 'USA PRIME (BGC)':
        return UsaPrimeBGCPage(index);
      case 'SAMGYEOPSAL (BGC)':
        return SamgyeopsalBGCPage(index);
      case 'SINGLE MENU (BGC)':
        return MealBGCPage(index);
      case 'STEW (BGC)':
        return StewBGCPage(index);
      case 'SPECIAL MENU: MEAT (BGC)':
        return SpecialMenuMeatBGCPage(index);
      case 'SPECIAL MENU: CRAB (BGC)':
        return SpecialMenuCrabBGCPage(index);
      case 'SPECIAL MENU: SASHIMI (BGC)':
        return SpecialMenuSashimiPage(index);
      case 'ORIGIN FROM KOREA (BGC)':
        return OriginFromKoreaBGCPage(index);
      case 'BEVERAGES (BGC)':
        return BeveragesBGCPage(index);
      case 'KOREAN ICE CREAM (BGC)':
        return IceCreamBGCPage(index);
      case 'MYEONGPHUM (MALATE)':
        return MyeongphumMalatePage(index);
      case 'WAGYU (MALATE)':
        return WagyuSetMalatePage(index);
      case 'USA PRIME (MALATE)':
        return UsaPrimeMalatePage(index);
      case 'SAMGYEOPSAL (MALATE)':
        return SamgyeopsalMalatePage(index);
      case 'SINGLE MENU (MALATE)':
        return MealMalatePage(index);
      case 'STEW (MALATE)':
        return StewMalatePage(index);
      case 'SPECIAL MENU: MEAT (MALATE)':
        return SpecialMenuMeatMalatePage(index);
      case 'SPECIAL MENU: CRAB (MALATE)':
        return SpecialMenuCrabMalatePage(index);
      case 'SPECIAL MENU: SASHIMI (MALATE)':
        return SpecialMenuSashimiMalatePage(index);
      case 'ORIGIN FROM KOREA (MALATE)':
        return OriginFromKoreaMalatePage(index);
      case 'BEVERAGES (MALATE)':
        return BeveragesMalatePage(index);
      default:
        return Container(); // Default page if no match
    }
  }
}
