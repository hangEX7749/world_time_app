import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  Map data = {};

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

  data = ModalRoute.of(context)?.settings.arguments as Map? ?? {};
  String bgImage = (data['isDayTime'] as bool?) ?? false 
    ? 'https://images.pexels.com/photos/296234/pexels-photo-296234.jpeg?cs=srgb&dl=pexels-goumbik-296234.jpg&fm=jpg'
    : 'https://media.istockphoto.com/id/809971888/photo/night-sky-landscape.jpg?b=1&s=612x612&w=0&k=20&c=gOgzD_8unm6l-V2n20qXxqfJ46euyOanN-TiJGYeJ4A=';

  Color bgColor = (data['isDayTime'] as bool?) ?? false 
    ? Colors.black
    : Colors.white;

  return Scaffold(
    //appBar: AppBar(),
    backgroundColor: bgColor,
    body: SafeArea(
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(bgImage),
            fit: BoxFit.cover,
          ),
        ),
        
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0, 120.0, 0, 0),
          child: Column(
            children: <Widget>[
              TextButton.icon(
                onPressed: () {
                  Navigator.pushNamed(context, '/location');
                },
                icon: Icon(
                  Icons.edit_location,
                  color: bgColor,
                ),
                label: Text(
                  'Edit Location',
                  style: TextStyle(
                    color: bgColor,
                  ),
                )
              ),
              const SizedBox(height: 20.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    data['location'] ?? 'Unknown location',
                    style: TextStyle(
                      fontSize: 28.0,
                      letterSpacing: 2.0,
                      color: bgColor,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20.0),
              Text(
                data['time'] ?? 'Unknown time',
                style: TextStyle(
                  fontSize: 66.0,
                  color: bgColor,
                )
              ),
            ],
          ),
          ),
      ),
    ),
  );
  }
}