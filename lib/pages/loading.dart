import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:world_clock/services/world_time.dart';

class Loading extends StatefulWidget {
  const Loading({super.key});

  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  String time = 'Loading...';

  void setupWorldTime() async {
    WorldTime obj = WorldTime(
        location: 'Berlin', flag: 'germany.png', url: 'Europe/Berlin');
    await obj.getTime().then((e) => {
          Navigator.pushReplacementNamed(context, '/home', arguments: {
            'location': obj.location,
            'flag': obj.flag,
            'time': obj.time,
            'isDayTime': obj.isDayTime,
          }),
        });
  }

  @override
  void initState() {
    super.initState();
    setupWorldTime();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color.fromARGB(255, 16, 83, 138),
      body: Center(
        child: SpinKitRotatingCircle(
          color: Colors.white,
          size: 50.0,
        ),
      ),
    );
  }
}
