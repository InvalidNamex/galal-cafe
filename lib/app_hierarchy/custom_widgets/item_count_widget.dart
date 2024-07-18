import 'package:flutter/material.dart';
import 'package:galal/constants.dart';
import 'package:get/get.dart';

Widget itemCountWidget(RxInt count) {
  return SizedBox(
    width: 120,
    height: 40,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        InkWell(
          onTap: () {
            count.value += 1;
          },
          child: Container(
            height: 50,
            width: 40,
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(30),
                    bottomRight: Radius.circular(30)),
                color: accentColor),
            child: const Icon(
              Icons.add,
              color: darkColor,
            ),
          ),
        ),
        Container(
          height: 50,
          width: 40,
          alignment: Alignment.center,
          color: accentColor,
          child: Obx(() => Text(
                count.toString(),
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              )),
        ),
        InkWell(
          onTap: () {
            if (count.value > 1) {
              count.value -= 1;
            }
          },
          child: Container(
            height: 50,
            width: 40,
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    bottomLeft: Radius.circular(30)),
                color: accentColor),
            child: const Icon(
              Icons.remove,
              color: darkColor,
            ),
          ),
        ),
      ],
    ),
  );
}
