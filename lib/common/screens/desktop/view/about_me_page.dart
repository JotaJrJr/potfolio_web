import 'package:flutter/material.dart';

import '../../../utils/icons_app.dart';

class AboutMePage extends StatelessWidget {
  final VoidCallback onTap;

  const AboutMePage({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    const Color backgroundColor = Color(0xFF211F26);

    return Material(
      child: Container(
        decoration: const BoxDecoration(
          color: backgroundColor,
        ),
        width: 350,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(1.0),
              child: Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(6.0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: GestureDetector(
                        onTap: () => onTap(),
                        child: const CircleAvatar(
                          radius: 6,
                          backgroundColor: Colors.red,
                        ),
                      ),
                    ),
                  ),
                  const Align(
                    alignment: Alignment.center,
                    child: Text(
                      "Sobre",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            const CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage(IconsApp.profilePicture),
            ),
            const SizedBox(height: 10),
            const Text(
              "João Antônio",
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Text(
              "Desenvolvedor Flutter",
              style: TextStyle(
                color: Colors.white,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 10),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Spacer(),
                  Column(
                    children: [
                      Text(
                        "Experiência: ",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                        ),
                      ),
                      Text(
                        "Habilidades: ",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "4 anos",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Flutter, Dart", style: TextStyle(color: Colors.white, fontSize: 14)),
                          Text("Firebase, Git, Restful", style: TextStyle(color: Colors.white, fontSize: 14)),
                          Text("UI/UX/Figma", style: TextStyle(color: Colors.white, fontSize: 14)),
                          Text("Clean Code", style: TextStyle(color: Colors.white, fontSize: 14)),
                          Text("JavaScript, NodeJS, MongoDB", style: TextStyle(color: Colors.white, fontSize: 14)),
                        ],
                      ),
                    ],
                  )
                  //
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
