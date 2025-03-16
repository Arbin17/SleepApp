import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

void main() {
  runApp(SleepSoundApp());
}

class SleepSoundApp extends StatefulWidget {
  @override
  _SleepSoundAppState createState() => _SleepSoundAppState();
}

class _SleepSoundAppState extends State<SleepSoundApp> {
  final Map<String, AudioPlayer> _players = {};
  final Map<String, double> _volumes = {
    'Rain': 0.5,
    'Wind': 0.5,
    'Forest': 0.5,
    'Meditation': 0.6,
  };
  final Map<String, String> _soundFiles = {
    'Rain': 'rain.mp3',
    'Wind': 'wind.mp3',
    'Forest': 'forest.mp3',
    'Meditation': 'meditation.mp3',
  };
  final Map<String, bool> _isPlaying = {
    'Rain': false,
    'Wind': false,
    'Forest': false,
    'Meditation': false,
  };

  // Icons for each sound type
  final Map<String, IconData> _soundIcons = {
    'Rain': Icons.water_drop,
    'Wind': Icons.air,
    'Forest': Icons.forest,
    'Meditaion': Icons.mediation,
  };

  @override
  void initState() {
    super.initState();
    for (var sound in _soundFiles.keys) {
      _players[sound] = AudioPlayer();
      _players[sound]!.setVolume(_volumes[sound]!);
      _players[sound]!.setReleaseMode(ReleaseMode.loop);
    }
  }

  void _togglePlay(String sound) async {
    if (_isPlaying[sound]!) {
      await _players[sound]!.stop();
      setState(() {
        _isPlaying[sound] = false;
      });
    } else {
      await _players[sound]!.play(AssetSource(_soundFiles[sound]!));
      setState(() {
        _isPlaying[sound] = true;
      });
    }
  }

  void _setVolume(String sound, double volume) {
    setState(() {
      _volumes[sound] = volume;
      _players[sound]?.setVolume(volume);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Color(0xFF3A4256),
        scaffoldBackgroundColor: Color(0xFF121421),
        cardColor: Color(0xFF1D2030),
        brightness: Brightness.dark,
        colorScheme: ColorScheme.dark(
          primary: Color(0xFF8E97FD),
          secondary: Color(0xFF6CB28E),
        ),
        sliderTheme: SliderThemeData(
          activeTrackColor: Color(0xFF8E97FD),
          thumbColor: Color(0xFF8E97FD),
          inactiveTrackColor: Color(0xFF3A4256),
        ),
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text(
            'Sleep Sound Mixer',
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
          ),
          elevation: 0,
          backgroundColor: Color(0xFF121421),
        ),
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color(0xFF121421), Color(0xFF1D2030)],
            ),
          ),
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Mix Sounds',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Combine different sounds for the perfect sleep environment',
                  style: TextStyle(fontSize: 14, color: Colors.white70),
                ),
                SizedBox(height: 24),
                Expanded(
                  child: ListView(
                    children:
                        _soundFiles.keys.map((sound) {
                          return Container(
                            margin: EdgeInsets.only(bottom: 16.0),
                            decoration: BoxDecoration(
                              color: Color(0xFF1D2030),
                              borderRadius: BorderRadius.circular(16),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black12,
                                  blurRadius: 5,
                                  offset: Offset(0, 2),
                                ),
                              ],
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        padding: EdgeInsets.all(12),
                                        decoration: BoxDecoration(
                                          color:
                                              _isPlaying[sound]!
                                                  ? Theme.of(context)
                                                      .colorScheme
                                                      .primary
                                                      .withOpacity(0.2)
                                                  : Color(0xFF2D3142),
                                          borderRadius: BorderRadius.circular(
                                            12,
                                          ),
                                        ),
                                        child: Icon(
                                          _soundIcons[sound] ??
                                              Icons.music_note,
                                          color:
                                              _isPlaying[sound]!
                                                  ? Theme.of(
                                                    context,
                                                  ).colorScheme.primary
                                                  : Colors.white70,
                                          size: 28,
                                        ),
                                      ),
                                      SizedBox(width: 16),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              sound,
                                              style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.w600,
                                                color: Colors.white,
                                              ),
                                            ),
                                            SizedBox(height: 4),
                                            Text(
                                              _isPlaying[sound]!
                                                  ? 'Playing'
                                                  : 'Paused',
                                              style: TextStyle(
                                                fontSize: 14,
                                                color: Colors.white54,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      // Play/Pause button instead of switch
                                      ElevatedButton(
                                        onPressed: () => _togglePlay(sound),
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor:
                                              _isPlaying[sound]!
                                                  ? Colors.red.withOpacity(0.8)
                                                  : Theme.of(
                                                    context,
                                                  ).colorScheme.primary,
                                          shape: CircleBorder(),
                                          padding: EdgeInsets.all(12),
                                          elevation: 4,
                                        ),
                                        child: Icon(
                                          _isPlaying[sound]!
                                              ? Icons.pause
                                              : Icons.play_arrow,
                                          color: Colors.white,
                                          size: 24,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 16),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.volume_down,
                                        color: Colors.white54,
                                        size: 20,
                                      ),
                                      SizedBox(width: 8),
                                      Expanded(
                                        child: SliderTheme(
                                          data: SliderTheme.of(
                                            context,
                                          ).copyWith(
                                            trackHeight: 4.0,
                                            thumbShape: RoundSliderThumbShape(
                                              enabledThumbRadius: 8.0,
                                            ),
                                            overlayShape:
                                                RoundSliderOverlayShape(
                                                  overlayRadius: 16.0,
                                                ),
                                          ),
                                          child: Slider(
                                            value: _volumes[sound]!,
                                            min: 0,
                                            max: 1,
                                            onChanged:
                                                (value) =>
                                                    _setVolume(sound, value),
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: 8),
                                      Icon(
                                        Icons.volume_up,
                                        color: Colors.white54,
                                        size: 20,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        }).toList(),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    for (var player in _players.values) {
      player.dispose();
    }
    super.dispose();
  }
}
