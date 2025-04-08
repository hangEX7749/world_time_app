import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Map data = {
    // 'time': 'Unknown time',
    // 'location': 'Unknown location',
    // 'isDayTime': false, // Default value
    // 'flag': '',
  };

  @override
  Widget build(BuildContext context) {
    // Safely get route arguments with defaults
    data = data.isNotEmpty ? data : (ModalRoute.of(context)?.settings.arguments as Map<dynamic, dynamic>? ?? {});

    // Safely get daytime status with fallback
    final isDayTime = data['isDayTime'] as bool? ?? false;
    
    String bgImage = isDayTime ? 'day.png' : 'night.png';
    Color bgColor = isDayTime ? Colors.blue : Colors.indigo[900]!;
    Color textColor = isDayTime ? Colors.black : Colors.white;

    return Scaffold(
      appBar: AppBar(
        title: const Text('World Time App'),
        centerTitle: true,
        backgroundColor: Colors.blue[900],
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      backgroundColor: bgColor,
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/$bgImage'),
              fit: BoxFit.cover,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0, 120.0, 0, 0),
            child: Column(
              children: <Widget>[
                TextButton.icon(
                  onPressed: () async {
                    final result = await Navigator.pushNamed(context, '/location');
                    if (result is Map) {
                      setState(() {
                        data = {
                          'time': result['time'] ?? data['time'],
                          'location': result['location'] ?? data['location'],
                          'isDayTime': result['isDayTime'] as bool? ?? data['isDayTime'],
                          'flag': result['flag'] ?? data['flag'],
                        };

                        //print(data);
                      });
                    }
                  },
                  icon: Icon(Icons.edit_location, color: textColor),
                  label: Text(
                    'Edit Location',
                    style: TextStyle(color: textColor),
                  ),
                ),
                const SizedBox(height: 20.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      data['location'] as String? ?? 'Unknown location',
                      style: TextStyle(
                        fontSize: 28.0,
                        letterSpacing: 2.0,
                        color: textColor,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20.0),
                Text(
                  data['time'] as String? ?? 'Unknown time',
                  style: TextStyle(
                    fontSize: 66.0,
                    color: textColor,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}