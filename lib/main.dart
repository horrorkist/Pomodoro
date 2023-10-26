import 'dart:async';

import 'package:flutter/material.dart';
import 'package:pomodoro/widgets/w_IntervalDisplay.dart';
import 'package:pomodoro/widgets/w_IntervalList.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a blue toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        textTheme: TextTheme(
          bodyLarge: const TextStyle(
            color: Colors.white,
            fontSize: 32,
            fontWeight: FontWeight.bold,
          ),
          displayLarge: const TextStyle(
            color: Colors.red,
            fontSize: 64,
            fontWeight: FontWeight.bold,
          ),
          displayMedium: const TextStyle(
            color: Colors.red,
            fontSize: 32,
            fontWeight: FontWeight.bold,
          ),
          labelMedium: TextStyle(
            color: Colors.white.withOpacity(0.5),
            fontSize: 32,
            fontWeight: FontWeight.bold,
          ),
          labelSmall: const TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        fontFamily: 'Roboto',
        useMaterial3: true,
      ),
      home: const Pomodoro(),
    );
  }
}

class Pomodoro extends StatefulWidget {
  const Pomodoro({super.key});

  @override
  State<Pomodoro> createState() => _PomodoroState();
}

class _PomodoroState extends State<Pomodoro> {
  final double cardWidth = 160;

  final List<int> times = [1, 10, 15, 20, 25, 30, 35, 40, 45, 50, 55, 60];

  int selectedTimeIndex = 5;

  bool _isPlaying = false;
  bool _isResting = false;

  final keys = List.generate(12, (index) => GlobalKey());

  onTap(int index) {
    if (_isPlaying) return;
    setState(() {
      _isResting = false;
      selectedTimeIndex = index;
      _time = times[selectedTimeIndex] * 5;
    });
    Scrollable.ensureVisible(
      keys[index].currentContext!,
      duration: const Duration(milliseconds: 500),
      alignment: 0.5,
    );
  }

  int _time = 0;
  final _maxRounds = 3;
  int _rounds = 0, _goals = 0;

  late Timer _timer;

  onPlay() {
    setState(() {
      _isPlaying = true;
      // tick timer
      _timer = Timer.periodic(const Duration(milliseconds: 100), (timer) {
        setState(() {
          _time--;

          if (_time == 0) {
            if (!_isResting) {
              _isResting = true;
              _time = 30;
              if (_rounds == _maxRounds) {
                _rounds = 0;
                _goals++;
              } else {
                _rounds++;
              }
            } else {
              _isResting = false;
              _time = times[selectedTimeIndex] * 5;
            }
          }
        });
      });
    });
  }

  onPause() {
    setState(() {
      _isPlaying = false;
      _timer.cancel();
    });
  }

  @override
  initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Scrollable.ensureVisible(
        keys[selectedTimeIndex].currentContext!,
        duration: const Duration(milliseconds: 500),
        alignment: 0.5,
      );
    });
    _time = times[selectedTimeIndex] * 5;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red,
      body: Column(
        children: [
          const SizedBox(
            height: 80,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 40,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'POMODORO',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                IconButton(
                  onPressed: () {
                    setState(() {
                      _isPlaying = false;
                      _isResting = false;
                      _time = times[selectedTimeIndex] * 5;
                      _rounds = 0;
                      _goals = 0;
                    });
                  },
                  icon: const Icon(
                    Icons.refresh_outlined,
                    size: 32,
                    color: Colors.white,
                  ),
                )
              ],
            ),
          ),
          const SizedBox(
            height: 100,
          ),
          IntervalDisplay(
            cardWidth: cardWidth,
            isResting: _isResting,
            time: _time,
          ),
          const SizedBox(
            height: 50,
          ),
          IntervalList(
            keys: keys,
            selectedTimeIndex: selectedTimeIndex,
            times: times,
            onTap: onTap,
          ),
          const SizedBox(
            height: 70,
          ),
          RawMaterialButton(
            onPressed: _isPlaying ? onPause : onPlay,
            fillColor: Colors.black.withOpacity(0.3),
            padding: const EdgeInsets.all(20),
            shape: const CircleBorder(),
            child: Icon(
              _isPlaying ? Icons.pause_outlined : Icons.play_arrow,
              size: 60,
              color: Colors.white,
            ),
          ),
          const SizedBox(
            height: 50,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: [
                  Text('$_rounds / 4',
                      style: Theme.of(context).textTheme.labelMedium),
                  const SizedBox(
                    height: 10,
                  ),
                  Text('ROUND', style: Theme.of(context).textTheme.labelSmall),
                ],
              ),
              Column(
                children: [
                  Text('$_goals / 12',
                      style: Theme.of(context).textTheme.labelMedium),
                  const SizedBox(
                    height: 10,
                  ),
                  Text('GOAL', style: Theme.of(context).textTheme.labelSmall)
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}
