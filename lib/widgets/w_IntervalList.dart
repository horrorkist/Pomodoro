import 'package:flutter/material.dart';

class IntervalList extends StatelessWidget {
  const IntervalList({
    super.key,
    required this.keys,
    required this.selectedTimeIndex,
    required this.times,
    required this.onTap,
  });

  final List<GlobalKey<State<StatefulWidget>>> keys;
  final int selectedTimeIndex;
  final List<int> times;
  final Function(int) onTap;

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (bounds) {
        return LinearGradient(
          colors: [
            Colors.white.withOpacity(0.2),
            Colors.white,
            Colors.white,
            Colors.white.withOpacity(0.2)
          ],
          // begin: Alignment.centerLeft,
          // end: Alignment.centerRight,
          stops: const [0, 0.3, 0.7, 1.0],
          tileMode: TileMode.mirror,
        ).createShader(bounds);
      },
      child: SizedBox(
        height: ((MediaQuery.of(context).size.width - 60) / 5) * 0.8,
        child: ListView.separated(
          padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width / 2 -
                ((MediaQuery.of(context).size.width - 60) / 5 / 2),
          ),
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return GestureDetector(
              key: keys[index],
              onTap: () => onTap(index),
              child: Container(
                width: (MediaQuery.of(context).size.width - 60) / 5,
                height: ((MediaQuery.of(context).size.width - 60) / 5) * 0.8,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: selectedTimeIndex == index
                      ? Colors.white
                      : Colors.transparent,
                  border: selectedTimeIndex != index
                      ? Border.all(
                          color: const Color.fromRGBO(255, 255, 255, 0.8),
                          width: 2,
                        )
                      : null,
                ),
                child: Center(
                  child: Text(
                    '${times[index]}',
                    style: TextStyle(
                      color: selectedTimeIndex == index
                          ? Colors.red
                          : const Color.fromRGBO(255, 255, 255, 0.8),
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            );
          },
          separatorBuilder: (context, index) {
            return const SizedBox(
              width: 10,
            );
          },
          itemCount: times.length,
        ),
      ),
    );
  }
}
