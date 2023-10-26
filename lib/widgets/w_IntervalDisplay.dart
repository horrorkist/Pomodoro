import 'package:flutter/material.dart';

class IntervalDisplay extends StatelessWidget {
  const IntervalDisplay({
    super.key,
    required this.cardWidth,
    required bool isResting,
    required this.time,
  }) : _isResting = isResting;

  final double cardWidth;
  final bool _isResting;
  final int time;

  String getMinutes(int time) {
    return (time ~/ 60).toString().padLeft(2, '0');
  }

  String getSeconds(int time) {
    return (time % 60).toString().padLeft(2, '0');
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: cardWidth,
          height: cardWidth * 1.4,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Positioned(
                top: 0,
                child: Card(
                  color: const Color.fromRGBO(255, 255, 255, 0.6),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: SizedBox(
                    width: cardWidth * 0.90,
                    height: cardWidth * 0.90 * 1.2,
                  ),
                ),
              ),
              Positioned(
                top: 8,
                child: Card(
                  color: const Color.fromRGBO(255, 255, 255, 0.6),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: SizedBox(
                    width: cardWidth * 0.95,
                    height: cardWidth * 0.95 * 1.2,
                  ),
                ),
              ),
              Positioned(
                top: 16,
                child: Card(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: SizedBox(
                    width: cardWidth,
                    height: cardWidth * 1.2,
                    child: Center(
                      child: Text(
                        getMinutes(time),
                        style: TextStyle(
                          color: _isResting ? Colors.green : Colors.red,
                          fontSize: 64,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 15,
          ),
          child: Column(
            children: [
              Container(
                width: 10,
                height: 10,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color.fromRGBO(
                    255,
                    255,
                    255,
                    0.5,
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                width: 10,
                height: 10,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color.fromRGBO(
                    255,
                    255,
                    255,
                    0.5,
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          width: cardWidth,
          height: cardWidth * 1.4,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Positioned(
                top: 0,
                child: Card(
                  color: const Color.fromRGBO(255, 255, 255, 0.6),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: SizedBox(
                    width: cardWidth * 0.90,
                    height: cardWidth * 0.90 * 1.2,
                  ),
                ),
              ),
              Positioned(
                top: 8,
                child: Card(
                  color: const Color.fromRGBO(255, 255, 255, 0.6),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: SizedBox(
                    width: cardWidth * 0.95,
                    height: cardWidth * 0.95 * 1.2,
                  ),
                ),
              ),
              Positioned(
                top: 16,
                child: Card(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: SizedBox(
                    width: cardWidth,
                    height: cardWidth * 1.2,
                    child: Center(
                      child: Text(
                        getSeconds(time),
                        style: TextStyle(
                          color: _isResting ? Colors.green : Colors.red,
                          fontSize: 64,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
