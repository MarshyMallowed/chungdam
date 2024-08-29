import 'package:flutter/material.dart';
import 'menu_items.dart';

class BranchProvider extends ChangeNotifier {
  String _selectedBranch = 'MALATE'; // Default branch
  String get selectedBranch => _selectedBranch;

  // Menu items for each branch
  final Map<String, List<MenuItem>> _branchMenus = {
    'MALATE': [
      MenuItem(name: 'MYEONGPHUM (MALATE)', imagePath: 'assets/others/myeongphum.png', index: 1),
      MenuItem(name: 'WAGYU (MALATE)', imagePath: 'assets/others/wagyu.jpg', index: 2),
      MenuItem(name: 'USA PRIME (MALATE)', imagePath: 'assets/others/usaprime.jpg', index: 3),
      MenuItem(name: 'SAMGYEOPSAL (MALATE)', imagePath: 'assets/others/samgyupsal.jpg', index: 4),
      MenuItem(name: 'SINGLE MENU (MALATE)', imagePath: 'assets/others/singlemenu.jpg', index: 5),
      MenuItem(name: 'STEW (MALATE)', imagePath: 'assets/others/stew.jpg', index: 6),
      MenuItem(name: 'SPECIAL MENU: MEAT (MALATE)', imagePath: 'assets/others/meat.jpg', index: 7),
      MenuItem(name: 'SPECIAL MENU: CRAB (MALATE)', imagePath: 'assets/others/crab.png', index: 8),
      MenuItem(name: 'SPECIAL MENU: SASHIMI (MALATE)', imagePath: 'assets/others/sashimi.png', index: 9),
      MenuItem(name: 'ORIGIN FROM KOREA (MALATE)', imagePath: 'assets/others/originfromkorea.jpg', index: 10),
      MenuItem(name: 'BEVERAGES (MALATE)', imagePath: 'assets/others/beverage.png', index: 11),

      // Add more items for MALATE
    ],
    'PARQAL': [
      MenuItem(name: 'MYEONGPHUM (PARQAL)', imagePath: 'assets/others/myeongphum.png', index: 1),
      MenuItem(name: 'WAGYU (PARQAL)', imagePath: 'assets/others/wagyu.jpg', index: 2),
      MenuItem(name: 'USA PRIME (PARQAL)', imagePath: 'assets/others/usaprime.jpg', index: 3),
      MenuItem(name: 'SAMGYEOPSAL (PARQAL)', imagePath: 'assets/others/samgyupsal.jpg', index: 4),
      MenuItem(name: 'SINGLE MENU (PARQAL)', imagePath: 'assets/others/singlemenu.jpg', index: 5),
      MenuItem(name: 'STEW (PARQAL)', imagePath: 'assets/others/stew.jpg', index: 6),
      MenuItem(name: 'SPECIAL MENU: MEAT (PARQAL)', imagePath: 'assets/others/meat.jpg', index: 7),
      MenuItem(name: 'SPECIAL MENU: CRAB (PARQAL)', imagePath: 'assets/others/crab.png', index: 8),
      MenuItem(name: 'SPECIAL MENU: SASHIMI (PARQAL)', imagePath: 'assets/others/sashimi.png', index: 9),
      MenuItem(name: 'ORIGIN FROM KOREA (PARQAL)', imagePath: 'assets/others/originfromkorea.jpg', index: 10),
      MenuItem(name: 'BEVERAGES (PARQAL)', imagePath: 'assets/others/beverage.png', index: 11)

      // Add more items for BGC
    ],
    'BGC': [
      MenuItem(name: 'MYEONGPHUM (BGC)', imagePath: 'assets/others/myeongphum.png', index: 1),
      MenuItem(name: 'WAGYU (BGC)', imagePath: 'assets/others/wagyu.jpg', index: 2),
      MenuItem(name: 'USA PRIME (BGC)', imagePath: 'assets/others/usaprime.jpg', index: 3),
      MenuItem(name: 'SAMGYEOPSAL (BGC)', imagePath: 'assets/others/samgyupsal.jpg', index: 4),
      MenuItem(name: 'SINGLE MENU (BGC)', imagePath: 'assets/others/singlemenu.jpg', index: 5),
      MenuItem(name: 'STEW (BGC)', imagePath: 'assets/others/stew.jpg', index: 6),
      MenuItem(name: 'SPECIAL MENU: MEAT (BGC)', imagePath: 'assets/others/meat.jpg', index: 7),
      MenuItem(name: 'SPECIAL MENU: CRAB (BGC)', imagePath: 'assets/others/crab.png', index: 8),
      MenuItem(name: 'SPECIAL MENU: SASHIMI (BGC)', imagePath: 'assets/others/sashimi.png', index: 9),
      MenuItem(name: 'ORIGIN FROM KOREA (BGC)', imagePath: 'assets/others/originfromkorea.jpg', index: 10),
      MenuItem(name: 'BEVERAGES (BGC)', imagePath: 'assets/others/beverage.png', index: 11),
      MenuItem(name: 'KOREAN ICE CREAM (BGC)', imagePath: 'assets/others/icecream.png', index: 12), // Add more items specific to BGC
      // Add more items for PARQAL
    ],
  };

  List<MenuItem> get menuItems => _branchMenus[_selectedBranch] ?? [];

  void setBranch(String branch) {
    _selectedBranch = branch;
    notifyListeners();
  }
}
