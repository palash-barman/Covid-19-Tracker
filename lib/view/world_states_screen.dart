import 'dart:ui';

import 'package:covid_19_app/model/World_states_model.dart';
import 'package:covid_19_app/view/countries_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pie_chart/pie_chart.dart';

import '../services/states_services.dart';

class WorldStatesScreen extends StatefulWidget {

  const WorldStatesScreen({Key? key}) : super(key: key);

  @override
  _WorldStatesScreenState createState() => _WorldStatesScreenState();
}

class _WorldStatesScreenState extends State<WorldStatesScreen>  with TickerProviderStateMixin{
   late final AnimationController _controller = AnimationController(
       duration: const Duration(seconds: 5),
       vsync: this)..repeat();

   @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
   _controller.dispose();
  }

  final colorlist =<Color>[
    const Color(0xfffdb601),
   const Color(0xff083fea),
    const Color(0xffcb02f6)

  ];

  @override
  Widget build(BuildContext context) {
    StatesService statesService = StatesService();

    return Scaffold(

      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            image: DecorationImage(
              image:AssetImage('assets/images/worldscreen.jpg'),
                fit: BoxFit.cover
            )
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: [
                SizedBox(height: MediaQuery.of(context).size.height*.01,),
                 FutureBuilder(
                     future: statesService.fecthWorldStatesRecord(),
                     builder: (context, AsyncSnapshot<WorldStatesModel> snapshot){
                       if(!snapshot.hasData){
                         return Expanded(
                             flex: 1,
                             child: SpinKitCircle(
                               color: Colors.pink,
                               controller: _controller,
                               size: 50,
                             ),
                         );
                       }else{
                         return Column(
                           children: [
                             PieChart(
                               dataMap:{
                                 "Total ": double.parse(snapshot.data!.cases.toString()),
                                 "Recovered": double.parse(snapshot.data!.recovered.toString()),
                                 "Deaths": double.parse(snapshot.data!.deaths.toString()),
                               },
                               centerTextStyle: TextStyle(fontSize: 25,color: Colors.white),
                               chartValuesOptions: const ChartValuesOptions(
                                 showChartValuesInPercentage: true,
                               ),
                               colorList: colorlist,
                               chartType: ChartType.ring,
                               animationDuration: const Duration(milliseconds: 1200),
                               chartRadius: MediaQuery.of(context).size.width/3.2,
                               legendOptions: LegendOptions(
                                 legendPosition: LegendPosition.left,
                                 legendTextStyle: TextStyle(fontSize: 25,color:Colors.pink),
                               ),
                               chartLegendSpacing: 40,
                             ),
                             Padding(
                               padding:  EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height * .06),
                               child: Card(
                                 color:Color(0xff4858a7),
                                 child: Column(

                                   children: [
                                     ReusableRow(title:"Total ",value:snapshot.data!.cases.toString(), ),
                                     ReusableRow(title: "Recovered", value: snapshot.data!.recovered.toString()),
                                     ReusableRow(title: "Deaths", value:snapshot.data!.deaths.toString()),
                                     ReusableRow(title: "Active", value:snapshot.data!.active.toString()),
                                     ReusableRow(title: "Critical", value: snapshot.data!.critical.toString()),
                                     ReusableRow(title: "ToDay Total", value:snapshot.data!.todayCases.toString()),
                                     ReusableRow(title: "ToDay Deaths", value:snapshot.data!.todayDeaths.toString()),
                                     ReusableRow(title: "ToDay Recovered", value:snapshot.data!.todayRecovered.toString()),

                                   ],
                                 ),
                                 elevation: 0,
                               ),
                             ),
                             GestureDetector(
                               onTap:(){
                                 Navigator.push(context, MaterialPageRoute(builder: (context)=>CountrieListScreen()));
                               },
                               child: Container(
                                 height: 50,
                                 decoration: BoxDecoration(
                                   borderRadius: BorderRadius.circular(10),
                                   color: Color(0xff2afd06),
                                 ),
                                 child: Center(
                                   child: Text('Track Countries', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),),
                                 ),
                               ),
                             ),

                           ],
                         );
                       }
                 }),

              ],
            ),
          ),
        ),
      ),
    );
  }
}


class ReusableRow extends StatelessWidget {
  String title,value;

  ReusableRow({Key? key,

    required this.title,
    required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10,top: 5,right: 10,bottom: 5),
      child: Column(
       // crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
             mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(title,style: TextStyle(fontSize: 25,fontWeight:FontWeight.bold,color: Colors.yellowAccent),),
               //SizedBox(width: 120),
              Text(value,style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold,color: Colors.white),),


            ],
          ),
           SizedBox(height: 5,),
          Divider(),

        ],
      ),
    );
  }
}

