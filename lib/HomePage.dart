import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:numberpicker/numberpicker.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin{

  TabController tabController;
  @override
  void initState(){
    super.initState();
    tabController = TabController(
      length: 2, 
      vsync: this);
  }
  bool started = true;
  bool stopped = true;
  int hr = 00;
  int min = 00;
  int sec = 00;
  var timetodisplay = "Set the Timer";
  bool checktimer = true;
  String timetodisplay1 ;
  
 void start(){
   setState((){
   started = false;
   stopped = false;
   });
    var timeestimated = ((hr*3600) + (min*60) +(sec));
    Timer.periodic(Duration(
      seconds: 1
    ), (Timer t){
      setState(() {
        if(timeestimated<1 || checktimer == false)
        {t.cancel();
        checktimer = true;
        timetodisplay = "Set the Timer ";
        started = true;
        stopped = true;
        }
        else
        {
        timeestimated = timeestimated-1;
        
  
  int h = 00, m= 00, s= 00;
  if(timeestimated <= 60){
    s= timeestimated;
    h = 00;
    m =00;
    timetodisplay1 = h.toString() + ":" + m.toString() + ":" +s.toString();
    print(timetodisplay);
  }
  else if(timeestimated > 60 && timeestimated <= 3600){
    s = timeestimated%60;
    m = timeestimated ~/60;
    h =00;
      timetodisplay1 = h.toString() + ":" + m.toString() + ":" +s.toString();
    print(timetodisplay);
  }
  else {
    h = timeestimated ~/3600;
    var timeformin = timeestimated %3600;
    s = timeformin%60;
    m = timeformin ~/60;
    timetodisplay1 = h.toString() + ":" + m.toString() + ":" +s.toString();
    print(timetodisplay);
    

  }
        
        }
   //timetodisplay = timeestimated.toString();
      });
      timetodisplay = timetodisplay1;
    });
  }
  void stop(){
    setState(() {
      started = true;
    stopped = true;
    checktimer = false;
    });
  }

  void restart(){
    Navigator.pushReplacement(context, MaterialPageRoute(
      builder: (context)=> HomePage(),
      )
      );
  }
  Widget timer() {
    return Container(
      child: Column(
        children: <Widget>[
          Expanded(
            flex: 6,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text("HH",
                    style: GoogleFonts.lato(
                      fontWeight: FontWeight.w900,
                      fontSize: 18.0  
                    ),),
                  
                NumberPicker.integer(
                  initialValue: hr,
                   minValue: 00, maxValue: 23, 
                   onChanged: (val1){
                     setState(() {
                       hr = val1;
                     },
                     );
                   },
                   ),
                   ],
                ),
                 Column(
                   mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text("MM",
                    style: GoogleFonts.lato(
                      fontWeight: FontWeight.w900,
                      fontSize: 18.0,  
                    ),),
                  
                NumberPicker.integer(
                  initialValue: min,
                   minValue: 00, maxValue: 60, 
                   onChanged: (val1){
                     setState(() {
                       min = val1;
                     },
                     );
                   },
                   ),
                   ],
                   
                ),
                 Column(
                   mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text("SS",
                    style: GoogleFonts.lato(
                      fontWeight: FontWeight.w900,  
                      fontSize: 18.0
                    ),),
                  
                NumberPicker.integer(
                  initialValue: sec,
                   minValue: 00, maxValue: 60, 
                   onChanged: (val1){
                     setState(() {
                       sec = val1;
                     },
                     );
                   },
                   ),
                   ],
                ),
              ],
            ),
            ),
            Expanded(
            flex: 1,
           child: Text(
             "$timetodisplay",
             style: GoogleFonts.lato(
               fontSize: 25.0,
               fontWeight: FontWeight.w900
             ),
           ),
            ),


            Expanded(
            flex: 4,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                        Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  RaisedButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                      
                    ),
                    color: Colors.green,
                    onPressed: started ? start : null,
                    child: Text('Start'),
                    ),
                    RaisedButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                      
                    ),
                    color: Colors.red,
                    onPressed: stopped ? null : stop,
                    child: Text('Stop'),
                    ),
                    
                    
                  
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
              
                    RaisedButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                      
                    ),
                    color: Hexcolor("#1287A5"),
                    onPressed:  restart,
                    child: Text('Restart'),
                    ),
              ],)
              ]
            )),
        ],
      )
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Welcome,',
       style: GoogleFonts.lato(
         fontSize: 35.0
       ),
      ),
      centerTitle: true,
      bottom: TabBar(
        tabs:<Widget>[
          Container(
            padding: EdgeInsets.only(bottom: 10.0),
            child: Text("Timer")
            ),
          Container(
            padding: EdgeInsets.only(bottom: 10.0),
            child: Text("Worldclock")
            )
        
        ],
        controller: tabController,
        unselectedLabelColor: Colors.white24,
        
        ),
      ),
     body: TabBarView(
       children: <Widget>[
         timer(),
         Text("WorldClock")
       ],
       controller: tabController,
       )
      
      
    );
  }
}