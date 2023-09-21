import 'package:shared_preferences/shared_preferences.dart';

Future<void> saveInstallationTime() async {
  final prefs = await SharedPreferences.getInstance();
  final currentTime = DateTime.now();
  await prefs.setInt('installationTimeInSeconds', currentTime.millisecondsSinceEpoch);
}

Future<DateTime> getInstallationTime() async {
  final prefs = await SharedPreferences.getInstance();
  final installationTimeMilliseconds = prefs.getInt('installationTimeInSeconds') ?? 0;
  return DateTime.fromMillisecondsSinceEpoch(installationTimeMilliseconds);
}

Future<Duration> calculateTimeSinceInstallation() async {
  final installationTime = await getInstallationTime();

  final currentTime = DateTime.now();
  final timeSinceInstallation = currentTime.difference(installationTime);

  return timeSinceInstallation;
}

