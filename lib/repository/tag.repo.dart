import 'package:hive_app/models/tag.model.dart';
import 'package:hive_app/data/remote/network/NetworkApiService.dart';
import 'package:hive_app/data/remote/network/ApiEndPoints.dart';
import 'package:hive_app/data/remote/network/BaseApiService.dart';

abstract class TagRepo {
  Future<TagModel?> getTagData();
}

class TagRepoImpl extends TagRepo {
  final BaseApiService _apiService = NetworkApiService();

  @override
  Future<TagModel?> getTagData() async {
    try {
      dynamic response =
          await _apiService.getResponse(ApiEndPoints().tagsEndPoint);
      print("Log: $response");
      final jsonData = TagModel.fromJson(response);
      return jsonData;
    } catch (e) {
      throw e;
    }
  }
}
