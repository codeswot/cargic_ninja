import 'dart:convert';
import 'package:http/http.dart' as http;

//class that handles http request
class RequestHelper {
  static Future<dynamic> getRequest(String url) async {
    try {
      //try get the request from passed (url) of method param
      http.Response response = await http.get(url);
      if (response.statusCode == 200) {
        String data = response.body;
        //decode (data) var gotten from response
        var decodedData = jsonDecode(data);
        //return decodedData
        return decodedData;
      } else {
        //return failed
        return 'failed';
      }
    } catch (e) {
      //catch err
      return 'failed $e';
    }
  }
}
