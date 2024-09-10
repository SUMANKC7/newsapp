import 'package:flutter/material.dart';

class Homescreen extends StatelessWidget {
  const Homescreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.asset(
              "assests/images/kabar.png",
              width: 99,
              height: 30,
            ),
            Material(
              elevation: 2,
              shape:RoundedRectangleBorder(borderRadius: BorderRadiusDirectional.circular(10)),
              child: IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.notifications_outlined,
                  size: 32,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}