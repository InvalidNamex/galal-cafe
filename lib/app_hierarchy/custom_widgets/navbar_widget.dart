import 'package:flutter/material.dart';
import 'package:galal/app_hierarchy/controllers/home_controller.dart';
import 'package:get/get.dart';

import '../../constants.dart';

class SideNavBar extends GetView<HomeController> {
  const SideNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => controller.categoryList.isNotEmpty
          ? ListView.builder(
              itemBuilder: (context, index) {
                return CustomNavbarButton(
                  index: index,
                  buttonName: controller.categoryList[index].categoryName ?? '',
                  onTap: () {
                    controller.chosen(index);
                  },
                );
              },
              itemCount: controller.categoryList.length,
            )
          : const SizedBox(),
    );
  }
}

class CustomNavbarButton extends GetView<HomeController> {
  final String buttonName;
  final int index;
  final Function onTap;
  const CustomNavbarButton({
    required this.index,
    required this.buttonName,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: index == 0 ? CustomShapeClipper() : null,
      child: Container(
        alignment: Alignment.center,
        height: 90,
        color: accentColor, // background color of the shape
        child: Transform.rotate(
          angle: -1.5708, // -90 degrees in radians
          child: Text(
            buttonName,
            maxLines: 1,
            style: const TextStyle(
                fontSize: 12, color: darkColor, fontWeight: FontWeight.w600),
          ),
        ),
      ),
    );
  }
}

class CustomShapeClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.moveTo(0, 0);
    path.lineTo(size.width - 30, 0); // move to the point where the curve starts
    path.quadraticBezierTo(size.width, 0, size.width, 30); // draw the curve
    path.lineTo(size.width, size.height); // straight line down the right side
    path.lineTo(0, size.height); // straight line along the bottom
    path.close(); // close the path

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}
