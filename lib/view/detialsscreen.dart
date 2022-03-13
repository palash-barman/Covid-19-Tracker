import 'package:covid_19_app/view/world_states_screen.dart';
import 'package:flutter/material.dart';

class DetialsScreen extends StatefulWidget {
  String name;
  String image;
  int totalCases , totalDeaths, totalRecovered , active , critical, todayRecovered , test;

   DetialsScreen({Key? key,
   required this.name,
     required this.image,
     required this.totalCases,
     required this.totalDeaths,
     required this.totalRecovered,
     required this.active,
     required this.critical,
     required this.todayRecovered,
     required this.test,
   }) : super(key: key);

  @override
  _DetialsScreenState createState() => _DetialsScreenState();
}

class _DetialsScreenState extends State<DetialsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.name),
        centerTitle: true,
        backgroundColor: Color(0xfff1621f),
      ),
 body: Container(
   height: MediaQuery.of(context).size.height,
   width: MediaQuery.of(context).size.width,
   decoration: BoxDecoration(
       image: DecorationImage(
         image:AssetImage('assets/images/ffg.jpg'),
           fit: BoxFit.cover
       )
   ),
   child: Column(
     // mainAxisAlignment: MainAxisAlignment.center,
     crossAxisAlignment: CrossAxisAlignment.center,
     children: [
       Container(
         margin: EdgeInsets.only(top: 200),
         child: Stack(
           alignment: Alignment.topCenter,
           children: [
             Padding(
               padding: EdgeInsets.only(top:MediaQuery.of(context).size.height * .067),
               child: Card(
                 color: Color(0xfff16161),
                 margin: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                 child: Column(
                   children: [
                     SizedBox(height: MediaQuery.of(context).size.height* .06,),
                     ReusableRow( title:'Cases',value:widget.totalCases.toString(),),
                     ReusableRow(title: "Deaths", value:widget.totalDeaths.toString()),
                     ReusableRow(title: "Recovered", value:widget.totalRecovered.toString()),
                     ReusableRow(title: "ToDay Recoverd", value:widget.todayRecovered.toString()),
                     ReusableRow(title: "Active ", value:widget.active.toString()),
                     ReusableRow(title: "Critecal ", value: widget.critical.toString()),
                     ReusableRow(title: "Test", value: widget.test.toString()),

                   ],
                 ),
               ),
             ),
             Positioned(
               child: Container(
                 height: 120,
                 width: 120,
                 child: CircleAvatar(
                   radius: 50,
                   backgroundImage: NetworkImage(widget.image),
                 ),
               ),
             )

           ],
         ),
       )


     ],
   ),
 ),


    );
  }
}
