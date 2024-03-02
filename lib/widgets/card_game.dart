import 'package:flutter/material.dart';

class CardGame extends StatelessWidget {
  final Map cardData;
  const CardGame({super.key, required this.cardData});
  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    return SizedBox(
      width: screenSize.height * .7 * 2 / 3,
      height: screenSize.height * .8,
      child: Card(
        elevation: 12,
        child: ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          child: Column(
            children: [
              Image.asset(
                cardData["asset"],
                fit: BoxFit.fitWidth,
              ),
              const SizedBox(
                height: 4,
              ),
              Text(
                cardData['name'],
                style: TextStyle(fontSize: screenSize.width * 0.03),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(4),
                  child: Text(
                    cardData['name'],
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
