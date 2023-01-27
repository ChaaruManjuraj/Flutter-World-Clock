import 'package:http/http.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

class WorldTime {
  String location = "";
  String time = "";
  String url = "";
  String flag = "";
  bool isDayTime = true;

  WorldTime(
      {required this.location,
      this.time = "",
      required this.url,
      required this.flag});

  Future<void> getTime() async {
    try {
      Uri urlLondon = Uri.parse('http://worldtimeapi.org/api/timezone/$url');
      Response response = await get(urlLondon);
      Map data = jsonDecode(response.body);

      // Get properties from data
      String datetime = data['utc_datetime'];
      String offset = data['utc_offset'].substring(1, 3);

      // Create a datetime object
      DateTime now = DateTime.parse(datetime);
      now = now.add(Duration(hours: int.parse(offset)));

      isDayTime = now.hour > 6 && now.hour < 19 ? true : false;

      time = DateFormat.jm().format(now);
    } catch (e) {
      // ignore: avoid_print
      print('Caught Error: $e');
      time = 'Could not get the data';
    }
  }
}
