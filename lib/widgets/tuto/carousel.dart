import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import '../../game/wildrun.dart';
import '../../models/tuto_data.dart';

class Carousel extends StatefulWidget {
  static const id = 'Carousel';
  final WildRun game;
  const Carousel(this.game, {super.key});

  @override
  State<Carousel> createState() => _CarouselState();
}

class _CarouselState extends State<Carousel> {
  int _current = 0;
  List<Widget> generateItem() {
    return tutos
        .map(
          (data) => ClipRRect(
            child: Image.asset(
              data.urlImage,
              fit: BoxFit.contain,
            ),
          ),
        )
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Stack(
        children: [
          CarouselSlider(
            items: generateItem(),
            options: CarouselOptions(
                enlargeCenterPage: true,
                aspectRatio: 18 / 8,
                onPageChanged: (index, other) {
                  setState(() {
                    _current = index;
                  });
                }),
          ),
          AspectRatio(
            aspectRatio: 18 / 8,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    tutos[_current].name,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: MediaQuery.of(context).size.height * 0.035),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
