import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:wildrun/widgets/main_menu.dart';
import '/game/wildrun.dart';

class InfoMenu extends StatefulWidget {
  static const id = 'InfoMenu';

  final WildRun game;
  const InfoMenu(this.game, {super.key});

  @override
  State<InfoMenu> createState() => _InfoMenuState();
}

class _InfoMenuState extends State<InfoMenu> {
  late ScrollController _scrollController;
  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<String> texts = [
      "Fifty years ago, deep within the lush Wilderness settings, an imminent threat suddenly appeared on the earth. Numerous polluting beings in the form of smog and sludge were spreading and beginning to invade entire countries. These noxious monsters were the result of human negligence and indifference towards nature. They endangered the delicate balance of the ecosystem and threatened the lives of billions of living beings.",
      "In the midst of this chaos, a hero was born – he is called Eco-Hero. Eco-Hero is a unique creature born from the force of nature and the environmental consciousness of some humans. He travels through ravaged lands to restore the harmony of nature and defeat the forces of pollution.",
      "To accomplish his mission, the wisdom of the earth endowed him with extraordinary agility and fierce determination. He has the ability to leap over the tallest obstacles.",
      "This entity also bestowed upon him two magical powers. One is the ability to release spheres of purity, a natural energy to dissipate pollution and restore the vitality of the earth. The other is the power to communicate with animals and imbibe their abilities. Along his journey, birds, wolves, and squirrels offer him their assistance, granting him the ability to fly and providing him with seeds of new life.",
      "With these newfound abilities, our hero will push back pollution, plant trees, gather fruits, and recycle waste. He stands as a beacon of hope in this chaotic world, inviting us to join him in this ultimate battle for a greener and cleaner world.",
      "Credits",
      "Protagonist sprites by Penzilla: https://penzilla.itch.io/hooded-protagonist",
      "Tileset by Jesse Munguia: https://jesse-m.itch.io",
      "Animal sprite by Kacper Woźniak: https://itch.io/profile/thkaspar",
      "Enemies and fruits sprite by Pixel Frog: https://pixelfrog-assets.itch.io",
    ];

    return Center(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            color: Colors.black.withAlpha(100),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  Row(
                    children: [
                      const Expanded(
                        child: Text(
                          "Info",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          widget.game.overlays.remove(InfoMenu.id);
                          widget.game.overlays.add(MainMenu.id);
                          if (widget.game.actorInitialized) {
                            widget.game.reset();
                          }
                        },
                        icon: const Icon(Icons.cancel_outlined),
                      )
                    ],
                  ),
                  Text(
                    "WildRun story",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: MediaQuery.of(context).size.height * 0.045,
                      fontFamily: "Oswald",
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Expanded(
                    child: ListView.separated(
                      separatorBuilder: (BuildContext context, int index) =>
                          const SizedBox(
                        height: 20,
                      ),
                      itemCount: texts.length,
                      itemBuilder: (context, index) {
                        return ContentText(
                          text: texts[index],
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ContentText extends StatelessWidget {
  final String text;
  const ContentText({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Text(
        text,
        style: TextStyle(
          color: Colors.white,
          fontSize: MediaQuery.of(context).size.height * 0.042,
          fontFamily: "Oswald-regular",
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
