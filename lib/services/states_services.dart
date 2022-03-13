import 'dart:convert';

import 'package:covid_19_app/model/World_states_model.dart';
import 'package:covid_19_app/services/utilities/app_url.dart';
import 'package:http/http.dart' as http;

class StatesService {
  Future<WorldStatesModel> fecthWorldStatesRecord()async{

    final response = await http.get(Uri.parse(AppUrl.worldstatesApi));

    if(response.statusCode==200){
      var data = jsonDecode(response.body);
      return WorldStatesModel.fromJson(data);

    }else{
      throw Exception('error');
    }

  }


  Future<List<dynamic>> countriesApi()async{
    var data;
     final response=await http.get(Uri.parse(AppUrl.countriesList));

     if(response.statusCode==200){
       data= jsonDecode(response.body);
       return data;
     }else{
       throw Exception("error");
     }
  }


}
