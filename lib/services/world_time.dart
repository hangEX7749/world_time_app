import 'dart:convert';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
// ignore_for_file: avoid_print
class WorldTime {
  late String location;
  late String time;
  late String flag;
  late String url;
  bool isDayTime = false; // true or false if daytime or not

  WorldTime({required this.location, required this.flag, required this.url});

  Future<void> getTime() async {
    try {
      //make the request
      Response response =
          await get(Uri.parse("https://timeapi.io/api/time/current/zone?timeZone=$url"));

      // print("Status Code: ${response.statusCode}");
      // print("Response: ${response.body}");

      //await get(Uri.parse("http://worldtimeapi.org/api/timezone/$url"));
      Map data = jsonDecode(response.body);

      // Parse the datetime (assumes it's in UTC if no timezone is specified)
      DateTime parsedTime = DateTime.parse(data['dateTime']!);

      // Apply the UTC offset (e.g., +2 hours for CEST)
      const utcOffset = Duration(hours: 0); // From dstActive: true
      final adjustedTime = parsedTime.add(utcOffset);

      //set the time properly
      //time = adjustedTime.toString();
      isDayTime = adjustedTime.hour > 6 && adjustedTime.hour < 20 ? true : false; // true or false if daytime or not
      time = DateFormat.jm().format(adjustedTime); // Format to 12-hour time
      
    } catch (e) {
      print('caught error: $e');
      time = 'Could not get time data';
    }
  }
}
