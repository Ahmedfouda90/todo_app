import 'package:flutter/material.dart';
class BottomBar extends StatelessWidget {
   BottomBar({Key? key,required this.onTap,@required this.currentIndex=0}) : super(key: key);
  int currentIndex;
  void Function(int)? onTap;
  @override
  Widget build(BuildContext context) {

    return  BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: /*(index) {
        setState(() {
          currentIndex = index;
        });
      },*/onTap,
      type: BottomNavigationBarType.fixed,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.menu), label: 'tasks'),
        BottomNavigationBarItem(
            icon: Icon(Icons.check_circle_outline), label: 'done'),
        BottomNavigationBarItem(
            icon: Icon(Icons.archive_outlined), label: 'archive'),
      ],
    );
  }

}
