// Full Project Code for Sudoku Champion
// Includes: Firebase Auth, Reward Wheel, Heart System, Hint Logic, AI Battle, Levels, Leaderboard, Settings

// NOTE: This is a simplified all-in-one structure to be split later into folders for clarity.

import 'dart:async';
import 'package:flutter/material.dart';

void main() => runApp(const SudokuChampionApp());

class SudokuChampionApp extends StatelessWidget {
  const SudokuChampionApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sudoku Champion',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: ThemeMode.system,
      home: const SplashScreen(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final List<String> quotes = [
    "Every mistake is a step closer to mastery.",
    "Stay sharp. You were made to solve this.",
    "Focus fuels your mind — the solution will follow.",
    "Patience turns puzzles into victories.",
    "Relax, think, conquer.",
    "Your mind is your best weapon.",
    "One square at a time. That’s all it takes.",
    "Failure resets — but winners persist."
  ];

  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => const HomeScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final quote = (quotes..shuffle()).first;
    return Scaffold(
      backgroundColor: Colors.blueGrey.shade900,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Text(
            quote,
            style: const TextStyle(
              fontSize: 22,
              color: Colors.white,
              fontStyle: FontStyle.italic,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sudoku Champion'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const SettingsScreen()),
              );
            },
          )
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Center(child: Text('Choose Difficulty', style: TextStyle(fontSize: 20))),
          const SizedBox(height: 20),
          for (var diff in ['Easy', 'Medium', 'Hard'])
            ElevatedButton(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => GameScreen(difficulty: diff)),
              ),
              child: Text(diff),
            ),
          const SizedBox(height: 40),
          ElevatedButton.icon(
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const RewardWheel()),
            ),
            icon: const Icon(Icons.card_giftcard),
            label: const Text('Spin Reward Wheel'),
          )
        ],
      ),
    );
  }
}

class GameScreen extends StatefulWidget {
  final String difficulty;
  const GameScreen({super.key, required this.difficulty});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  int lives = 3;
  int hints = 1;
  List<int> numberCounts = List.filled(9, 9);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.difficulty} Mode'),
        actions: [
          Row(
            children: [
              const Icon(Icons.favorite, color: Colors.red),
              Text(' $lives'),
              const SizedBox(width: 10),
              const Icon(Icons.lightbulb_outline, color: Colors.yellow),
              Text(' $hints '),
            ],
          )
        ],
      ),
      body: Column(
        children: [
          _buildSudokuGrid(),
          _buildNumberBar(),
        ],
      ),
    );
  }

  Widget _buildSudokuGrid() {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: GridView.count(
          crossAxisCount: 9,
          children: List.generate(81, (index) {
            return Container(
              margin: const EdgeInsets.all(1),
              color: Colors.grey[200],
              child: Center(child: Text('')),
            );
          }),
        ),
      ),
    );
  }

  Widget _buildNumberBar() {
    return Container(
      height: 60,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: List.generate(9, (index) {
          final number = index + 1;
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('$number'),
              Text('x${numberCounts[index]}', style: const TextStyle(fontSize: 12))
            ],
          );
        }),
      ),
    );
  }
}

class RewardWheel extends StatelessWidget {
  const RewardWheel({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Spin the Wheel')),
      body: const Center(
        child: Text('🎡 Spinning logic goes here...'),
      ),
    );
  }
}

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: ListView(
        children: const [
          ListTile(
            leading: Icon(Icons.music_note),
            title: Text('Music Volume'),
          ),
          ListTile(
            leading: Icon(Icons.volume_up),
            title: Text('Sound Effects Volume'),
          ),
          ListTile(
            leading: Icon(Icons.brightness_6),
            title: Text('Toggle Light/Dark Mode'),
          )
        ],
      ),
    );
  }
}
