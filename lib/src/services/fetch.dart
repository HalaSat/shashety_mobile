import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart';

// import '../../data/post_mock.dart';

Future<dynamic> fetch(String urlPrefix, String suffix) async {
  // return postMock;
  Response response;
  try {
    response = await get('$urlPrefix$suffix').timeout(Duration(seconds: 15));
  } catch (e) {
    return Future.error(
      '$e at $urlPrefix$suffix',
    );
  }
  if (response.statusCode == 200)
    return jsonDecode(response.body);
  else
    return Future.error(
      '${response.statusCode} at $suffix',
    );
}
