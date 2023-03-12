import 'dart:convert';

import 'package:covid19_tracker/Model/WorldModel.dart';
import 'package:covid19_tracker/Services/Utilis/app_url.dart';
import 'package:http/http.dart'as http;
class StatesServices{
  Future<WorldModel>fetchworldStatesRecords () async{
    final response = await http.get(Uri.parse(AppUrl.worldStatteUrl));
    if(response.statusCode == 200){
      var data = jsonDecode(response.body);
      return WorldModel.fromJson(data) ;
    }else{
      throw Exception("Error");
    }
  }

  Future<List<dynamic>>gethcountryRecordList () async{
    var data;
    final response = await http.get(Uri.parse(AppUrl.countryStatteUrl));
    if(response.statusCode == 200){
      data = jsonDecode(response.body);
      return data ;
    }else{
      throw Exception("Error");
    }
  }
}