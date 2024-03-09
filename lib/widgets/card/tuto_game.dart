import 'package:flutter/material.dart';
import 'package:wildrun/models/tuto_data.dart';

class TutoGame extends StatelessWidget {
  final TutoInfo tutoInfo;
  const TutoGame({super.key, required this.tutoInfo});
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
                //height: screenSize.height * .5,
                child: Image.asset(
                  tutoInfo.urlImage,
                  fit: BoxFit.fitWidth,
                ),
              ),
              const SizedBox(
                height: 4,
              ),
              Text(
                tutoInfo.name,
                style: TextStyle(fontSize: screenSize.height * 0.045),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Text(
                    tutoInfo.desc,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: screenSize.height * 0.02),
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
