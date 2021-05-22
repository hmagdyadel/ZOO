import 'package:flutter/material.dart';
import '../providers/language.dart';

import '../screens/character_details_page.dart';
import 'package:provider/provider.dart';
import '../style.dart';

class CharacterWidget extends StatelessWidget {
  final PageController pageController;
  final int currentPage;
  final List<String> sentAnimal;

  const CharacterWidget({
    required this.pageController,
    required this.currentPage,
    required this.sentAnimal,
  });

  @override
  Widget build(BuildContext context) {
    var lan = Provider.of<LanguageProvider>(context, listen: true);
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    List<String> selectedAnimal =
        lan.getTexts('animal-${currentPage + 1}') as List<String>;
    int x = (currentPage + 1) % 2;
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          PageRouteBuilder(
              transitionDuration: const Duration(milliseconds: 450),
              pageBuilder: (context, _, __) => CharacterDetailPage(
                    character: selectedAnimal,
                    currentPage: currentPage + 1,
                  )),
        );
      },
      child: AnimatedBuilder(
        animation: pageController,
        builder: (context, child) {
          double value = 1;
          if (pageController.position.haveDimensions) {
            value = pageController.page! - currentPage;
            value = (1 - (value.abs() * 0.6)).clamp(0.0, 1.0);
          }
          return Stack(
            children: [
              Align(
                alignment: Alignment.bottomCenter,
                child: ClipPath(
                  clipper: CharacterCardBackgroundClipper(),
                  child: Hero(
                    tag: 'background-${selectedAnimal[0]}',
                    child: Container(
                      height: screenHeight * 0.6,
                      width: screenWidth * 0.9,
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                        colors: x == 1
                            ? [
                                Colors.orange.shade200,
                                Colors.deepOrange.shade400
                              ]
                            :[Colors.pink.shade200, Colors.redAccent.shade400],
                      )),
                    ),
                  ),
                ),
              ),
              Align(
                  alignment: Alignment(0, -0.5),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Hero(
                      tag: "image-${sentAnimal[1]}",
                      child: Image.asset(
                        selectedAnimal[1],
                        height: screenHeight * 0.45 * value,
                        width: MediaQuery.of(context).size.width*0.8,
                      ),
                    ),
                  )),
              Padding(
                padding:
                    const EdgeInsets.only(left: 48.0, right: 16, bottom: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Hero(
                        tag: lan
                            .getTexts("name-${selectedAnimal[0]}")
                            .toString(),
                        child: Material(
                          color: Colors.transparent,
                          child: Container(
                            child: Text(
                              selectedAnimal[0],
                              style: AppTheme.heading,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 80),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        lan.getTexts('read_more').toString(),
                        style: AppTheme.subHeading,
                      ),
                    ),
                  ],
                ),
              )
            ],
          );
        },
      ),
    );
  }
}

class CharacterCardBackgroundClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    double curveDistance = 40;
    path.moveTo(0, size.height * 0.4);

    path.lineTo(0, size.height - curveDistance);
    path.quadraticBezierTo(1, size.height - 1, 0 + curveDistance, size.height);

    path.lineTo(size.width - curveDistance, size.height);
    path.quadraticBezierTo(size.width + 1, size.height - 1, size.width,
        size.height - curveDistance);

    path.lineTo(size.width, 0 + curveDistance);
    path.quadraticBezierTo(size.width - 1, 0,
        0 + size.width - curveDistance - 5, 0 + curveDistance / 3);

    path.lineTo(curveDistance, size.height * 0.29);
    path.quadraticBezierTo(1, (size.height * 0.30) + 10, 0, size.height * 0.4);

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}
