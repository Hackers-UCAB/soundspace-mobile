import 'package:dio/dio.dart';

import '../../../domain/services/location_checker.dart';

class LocationCheckerImpl implements ILocationChecker {
  @override
  Future<String> getCountry() async {
    try {
      final dio = Dio();
      final ip = await dio.get('https://api.ipify.org');
      final location = await dio.get('http://ip-api.com/json/${ip.data}');

      if (location.data != null && location.data.containsKey('country')) {
        return location.data['country'];
      } else {
        throw Exception('Country not found in location data');
      }
    } catch (e) {
      throw Exception('Error getting location: ${e.toString()}');
    }
  }
}
