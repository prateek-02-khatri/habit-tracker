import 'package:flutter/material.dart';

class CustomAppHead extends StatelessWidget {
  const CustomAppHead({
    super.key,
    required this.title,
    required this.subtitle
  });

  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: ClipRRect(

        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(25),
          bottomRight: Radius.circular(25),
        ),

        child: Stack(
          children: [
            Align(
                alignment: Alignment.topCenter,
                child: SizedBox(
                  height: MediaQuery.of(context).size.height * 0.3,
                  child: Image.asset(
                    'assets/images/head.png',
                    fit: BoxFit.cover,
                  ),
                )
            ),

            Positioned(
              left: 25,
              bottom: 25,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.white
                    ),
                  ),

                  const SizedBox(height: 5),

                  Text(
                    subtitle,
                    style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: Colors.white
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
