import 'dart:convert';
import 'package:http/http.dart';
// ignore_for_file: avoid_print
class WorldTime {
  late String location;
  late String time;
  late String flag;
  late String url;

  WorldTime({required this.location, required this.flag, required this.url});

  Future<void> getTime() async {
    try {
      //make the request
      Response response =
          await get(Uri.parse("https://www.timeapi.io/api/time/current/zone?timeZone=$url"));

      //await get(Uri.parse("http://worldtimeapi.org/api/timezone/$url"));
      Map data = jsonDecode(response.body);

      print(data);



      // Parse the datetime (assumes it's in UTC if no timezone is specified)
      DateTime parsedTime = DateTime.parse(data['dateTime']!);

      // Apply the UTC offset (e.g., +2 hours for CEST)
      const utcOffset = Duration(hours: 6); // From dstActive: true
      final adjustedTime = parsedTime.add(utcOffset);

      //set the time properly
      time = adjustedTime.toString();
    } catch (e) {
      print('caught error: $e');
      time = 'Could not get time data';
    }
  }
}
