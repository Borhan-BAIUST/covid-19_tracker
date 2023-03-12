import 'dart:async';

import 'package:covid19_tracker/view/world_states_screen.dart';
import 'package:flutter/material.dart';
import 'dart:math'as math;
class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin {
  //its a controllr for animation
  late final AnimationController _animationController =AnimationController(
    //time for animation
    duration:const Duration(seconds: 10) ,
      vsync:this)..repeat();
  @override
  void dispose() {
    // TODO: implement dispose
    _animationController.dispose();
    super.dispose();
  }
  void initState() {
    // TODO: implement initState
    super.initState();
    
    Timer(Duration(seconds: 5),
        ()=>Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context)=>WorldStatesScreen()))
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center  ,
        children: [
          AnimatedBuilder(
              animation: _animationController,
              child: Container(
                height: 200,
                width: 200,
                child:Center(
                  child: Image(
                    fit: BoxFit.cover,
                    image: AssetImage("assets/coronavirus.webp",
                    ),
                  ),
                ) ,
              ),
              builder: (BuildContext context,Widget?child){
                return Transform.rotate(
                    angle: _animationController.value*2.0*math.pi,
                child: child,);
              }),
          SizedBox(
            height:MediaQuery.of(context).size.height*.08,),
          Align(
            alignment: Alignment.center,
            child: Text("Covid-19\nTracker App",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 25

            ),
            ),
          )
        ],
      ),
    );
  }
}
