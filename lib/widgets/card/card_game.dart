import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:wildrun/game/managers/card_manager.dart';

class CardGame extends StatelessWidget {
  final CardInfo cardData;
  const CardGame({super.key, required this.cardData});
  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    return SizedBox(
      width: screenSize.height * .7 * 3 / 2,
      height: screenSize.height * .7,
      child: Card(
        elevation: 12,
        child: ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          child: Column(
            children: [
              SizedBox(
                height: screenSize.height * .5,
                child: Image.asset(
                  cardData.urlImage,
                  fit: BoxFit.fitWidth,
                ),
              ),
              const SizedBox(
                height: 4,
              ),
              Text(
                cardData.name,
                style: TextStyle(fontSize: screenSize.height * 0.05),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(4),
                  child: Text(
                    cardData.desc,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
