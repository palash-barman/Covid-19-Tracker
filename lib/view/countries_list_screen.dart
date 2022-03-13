import 'package:covid_19_app/services/states_services.dart';
import 'package:covid_19_app/view/detialsscreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CountrieListScreen extends StatefulWidget {
  const CountrieListScreen({Key? key}) : super(key: key);

  @override
  _CountrieListScreenState createState() => _CountrieListScreenState();
}

class _CountrieListScreenState extends State<CountrieListScreen> {
  TextEditingController _searchcontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    StatesService statesService = StatesService();
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color(0xff3261bf),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          image: DecorationImage(
            image:AssetImage('assets/images/countryscreen.jpg'),
            fit: BoxFit.cover
          )
        ),
        child: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextFormField(
                  onChanged: (value){
                    setState(() {

                    });
                  },
                  controller: _searchcontroller,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.search),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                      hintText: " Search with country name ",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50),
                      )),
                ),
              ),
              Expanded(
                  child: FutureBuilder(
                      future: statesService.countriesApi(),
                      builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
                        if (!snapshot.hasData) {
                          return ListView.builder(
                              itemCount: 10,
                              itemBuilder: (context, index) {
                            return Shimmer.fromColors(
                              baseColor: Colors.grey.shade700,
                              highlightColor: Colors.grey.shade100,
                              child: Column(
                                children: [
                                  ListTile(
                                    leading: Container(
                                      height: 50,
                                      width: 50,
                                      color: Colors.white,
                                    ),
                                    title: Container(
                                      height: 8.0,
                                      width: 100,
                                      color: Colors.white,
                                    ),
                                    subtitle: Container(
                                      width: double.infinity,
                                      height: 8.0,
                                      color: Colors.white,
                                    ),
                                  )
                                ],
                              ),
                            );
                          });
                        } else {
                          return ListView.builder(
                              itemCount: snapshot.data!.length,
                              itemBuilder: (context, index) {
                                String name = snapshot.data![index]["country"];

                                if(_searchcontroller.text.isEmpty){
                                  return Column(
                                    children: [
                                      InkWell(
                                        onTap: (){
                                          Navigator.push(context, MaterialPageRoute(builder: (context)=>DetialsScreen(
                                            active:snapshot.data![index]["active"],
                                            totalDeaths: snapshot.data![index]["deaths"],
                                            name:snapshot.data![index]["country"],
                                            critical:snapshot.data![index]["critical"] ,
                                            image:snapshot.data![index]["countryInfo"]["flag"],
                                            todayRecovered:snapshot.data![index]["todayRecovered"],
                                            totalCases:snapshot.data![index]["cases"] ,
                                            totalRecovered:snapshot.data![index]["recovered"] ,
                                            test:snapshot.data![index]["tests"],

                                          )));
                                  },
                                        child: ListTile(
                                          title: Text(
                                            snapshot.data![index]["country"],
                                            style: TextStyle(
                                                fontSize: 20,
                                                color: Colors.redAccent,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          leading: Image(
                                              height: 50,
                                              width: 50,
                                              image: NetworkImage(
                                                  snapshot.data![index]["countryInfo"]
                                                  ["flag"])),
                                          subtitle: Text(snapshot.data![index]
                                          ["cases"]
                                              .toString()),
                                        ),
                                      )
                                    ],
                                  );
                                }
                                else if(name.toLowerCase().contains(_searchcontroller.text.toLowerCase())){
                                  return Column(
                                    children: [
                                      InkWell(
                                        onTap: (){
                                          Navigator.push(context, MaterialPageRoute(builder: (context)=>DetialsScreen(
                                            active:snapshot.data![index]["active"],
                                            totalDeaths: snapshot.data![index]["deaths"],
                                            name:snapshot.data![index]["country"],
                                            critical:snapshot.data![index]["critical"] ,
                                            image:snapshot.data![index]["countryInfo"]["flag"],
                                            todayRecovered:snapshot.data![index]["todayRecovered"],
                                            totalCases:snapshot.data![index]["cases"] ,
                                            totalRecovered:snapshot.data![index]["recovered"] ,
                                            test:snapshot.data![index]["tests"],

                                          )));
                                        },
                                        child: ListTile(
                                          title: Text(
                                            snapshot.data![index]["country"],
                                            style: TextStyle(
                                                fontSize: 20,
                                                color: Colors.redAccent,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          leading: Image(
                                              height: 50,
                                              width: 50,
                                              image: NetworkImage(
                                                  snapshot.data![index]["countryInfo"]
                                                  ["flag"])),
                                          subtitle: Text(snapshot.data![index]
                                          ["cases"]
                                              .toString()),
                                        ),
                                      )
                                    ],
                                  );
                                }
                                else{
                                  return Container();
                                }

                              });
                        }
                      })),
            ],
          ),
        ),
      ),
    );
  }
}
