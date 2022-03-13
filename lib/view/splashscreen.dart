import 'dart:async';

import 'package:covid_19_app/view/world_states_screen.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin {

  late final AnimationController _animationController= AnimationController(
        duration: const Duration(seconds: 10),
      vsync: this)..repeat();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _animationController.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(const Duration(seconds: 7),
        ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=>WorldStatesScreen()))
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            image: DecorationImage(
              image:AssetImage('assets/images/splashscreen.jpg'),
              fit: BoxFit.cover
            ),

        ),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              AnimatedBuilder(
                child: Container(
                  height: 300,
                  width: 300,
                  child: const Center(

                    child: Image(
                        fit: BoxFit.cover,
                        image: AssetImage('assets/images/splash.png')),
                  ),
                ),
                animation: _animationController,
                builder:(BuildContext context, Widget? child){
                  return Transform.rotate(
                      angle:_animationController.value*2.0 * math.pi,
                      child: child,
                  );

                }
                ),
              SizedBox(height: MediaQuery.of(context).size.height*.08,),
              const Align(
                alignment: Alignment.center,
                child: Text("Covid-19 \n Tracker App" ,
                  textAlign:TextAlign.center,
                  style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                    color: Colors.yellowAccent,
                ),),
              )
            ],
          ),
        ),
      ),
    );
  }
}
