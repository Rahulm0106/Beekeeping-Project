
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:beekeeping_app/assets/app_layout.dart';
 
class LineCharts extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    
    const tempTextStyle =
    TextStyle(fontSize: 18, color: Colors.yellow, fontWeight: FontWeight.bold);
 
    
     return Scaffold(
      backgroundColor: Colors.grey.shade900,
      resizeToAvoidBottomPadding: true,
      appBar: appBarBuilder('Graph'),
      bottomNavigationBar: BottomNav(),
      // body: !isloggedin
      //     ? Center(child: CircularProgressIndicator())
          body: Center(
            child: SingleChildScrollView(
                child: Container(
                  
                  padding: EdgeInsets.only(
                      top: 0.0, right: 20.0, left: 15.0, bottom: 0.0),
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height : 20,
                      ),
                      Container(
          alignment: Alignment.center,
            // height: auto,
            // width: 350,
            child: Center(
              child: Row(
                // children: [Center(
                // child: Column(
      // mainAxisSize: MainAxisSize.min,
      // mainAxisAlignment: MainAxisAlignment.center,
      // crossAxisAlignment: CrossAxisAlignment.center,
      children: [
         Container(
           margin: const EdgeInsets.all(8),
           child: Icon(Icons.alarm, color: Colors.black,size: 30, )),
        Container(
                
                child: Text(
                  "If temperature is less than 35°C:",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
        ),
        Container(
                margin: const EdgeInsets.all(8),
                child: Text(
                  "Put wet gummy bags",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
        ),
      ],
    ),
              
            ),
            
            
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(40.0),
                bottomRight: Radius.circular(40.0),
               topLeft: Radius.circular(40.0),
                bottomLeft: Radius.circular(40.0)),
              color: Colors.yellow.shade700,

            ),
            
            // child: Text(" Current Temperature ",style: TextStyle(color: Colors.yellow.shade700, fontSize: 20,fontWeight: FontWeight.bold),textAlign: TextAlign.center,)

        ),
                      SizedBox(height: 20,),
                      SizedBox(
            height : 400,
            width: 350,
            
        child: LineChart(
            
        LineChartData(
            backgroundColor: Colors.white,
            lineTouchData: LineTouchData(enabled: false),
            lineBarsData: [
              
              LineChartBarData(
                // colors: [
                //   Colors.yellow.shade700,
                // ],
                
                spots: [
                  FlSpot(0, 32),
                  FlSpot(10, 35),
                  // FlSpot(2, 3),
                  // FlSpot(3, 3),
                  // FlSpot(4, 5),
                  // FlSpot(4, 4)
                ],
                isCurved: false,
                barWidth: 2,
                // colors: [
                //   Colors.yellow.shade700,
                // ],
                // belowBarData: BarAreaData(
                //   show: true,
                //   colors: [Colors.lightGreen.withOpacity(0.4)],
                //   cutOffY: cutOffYValue,
                //   applyCutOffY: true,
                // ),
                // aboveBarData: BarAreaData(
                //   show: true,
                //   colors: [Colors.red.withOpacity(0.6)],
                //   cutOffY: cutOffYValue,
                //   applyCutOffY: true,
                // ),
                dotData: FlDotData(
                  
                  show: false,
                ),
              ),
            ],
            minY: 25,
            minX: 0,
            
            titlesData: FlTitlesData(
              bottomTitles: SideTitles(
                  showTitles: true,
                  reservedSize: 6,
                  textStyle: tempTextStyle,
                  // getTitles: (value) {
                  //   switch (value.toInt()) {
                  //     case 0:
                  //       return '2015';
                  //     case 1:
                  //       return '2016';
                  //     case 2:
                  //       return '2017';
                  //     case 3:
                  //       return '2018';
                  //     case 4:
                  //       return '2019';
                  //     default:
                  //       return '';
                  //   }
                  // }
                  ),
              leftTitles: SideTitles(
                showTitles: true,
                 textStyle: tempTextStyle,

                // getTitles: (value) {
                //   return '\$ ${value + 0}';
                // },
              ),
            ),
            axisTitleData: FlAxisTitleData(
              
                // leftTitle: AxisTitle(showTitle: true, titleText: 'Value', margin: 10),
                bottomTitle: AxisTitle(
                    showTitle: true,
                    margin: 25,
                    titleText: 'Temperature',
                    
                    textStyle: tempTextStyle,
                    textAlign: TextAlign.center)),
            // gridData: FlGridData(
            //   show: false,
            //   checkToShowHorizontalLine: (double value) {
            //     return value == 1 || value == 2 || value == 3 || value == 4;
            //   },
            // ),
        ),
        )),
        SizedBox(
            height:20
        ),
        Container(
          alignment: Alignment.center,
            // height: auto,
            // width: 350,
            child: Center(
              child: Row(
                // children: [Center(
                // child: Column(
      // mainAxisSize: MainAxisSize.min,
      // mainAxisAlignment: MainAxisAlignment.center,
      // crossAxisAlignment: CrossAxisAlignment.center,
      children: [
         Container(
           margin: const EdgeInsets.all(8),
           child: Icon(Icons.wb_sunny, color: Colors.black,size: 30, )),
        Container(
                
                child: Text(
                  "Current Temperature:",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
        ),
        Container(
                margin: const EdgeInsets.all(8),
                child: Text(
                  "35 °C",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
        ),
      ],
    ),
              
            ),
            
            
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(40.0),
                bottomRight: Radius.circular(40.0),
               topLeft: Radius.circular(40.0),
                bottomLeft: Radius.circular(40.0)),
              color: Colors.yellow.shade700,

            ),
            
            // child: Text(" Current Temperature ",style: TextStyle(color: Colors.yellow.shade700, fontSize: 20,fontWeight: FontWeight.bold),textAlign: TextAlign.center,)

        ),
        SizedBox(
                        height : 20,
                      ),
        
       Container(
          alignment: Alignment.center,
            // height: auto,
            // width: 350,
            child: Center(
              child: Row(
                // children: [Center(
                // child: Column(
      // mainAxisSize: MainAxisSize.min,
      // mainAxisAlignment: MainAxisAlignment.center,
      // crossAxisAlignment: CrossAxisAlignment.center,
      children: [
         Container(
           margin: const EdgeInsets.all(8),
           child: Icon(Icons.wb_sunny, color: Colors.black,size: 30, )),
        Container(
                
                child: Text(
                  "Current Humidity:",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
        ),
        Container(
                margin: const EdgeInsets.all(8),
                child: Text(
                  "60 %",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
        ),
      ],
    ),
              
            ),
            
            
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(40.0),
                bottomRight: Radius.circular(40.0),
               topLeft: Radius.circular(40.0),
                bottomLeft: Radius.circular(40.0)),
              color: Colors.yellow.shade700,

            ),
            
            // child: Text(" Current Temperature ",style: TextStyle(color: Colors.yellow.shade700, fontSize: 20,fontWeight: FontWeight.bold),textAlign: TextAlign.center,)

        ),
        SizedBox(
                        height : 20,
                      ),
        Container(
          alignment: Alignment.center,
            // height: auto,
            // width: 350,
            child: Center(
              child: Row(
                // children: [Center(
                // child: Column(
      // mainAxisSize: MainAxisSize.min,
      // mainAxisAlignment: MainAxisAlignment.center,
      // crossAxisAlignment: CrossAxisAlignment.center,
      children: [
         Container(
           margin: const EdgeInsets.all(8),
           child: Icon(Icons.wb_sunny, color: Colors.black,size: 30, )),
        Container(
                
                child: Text(
                  "Weight of box:",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
        ),
        Container(
                margin: const EdgeInsets.all(8),
                child: Text(
                  "15 kg",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
        ),
      ],
    ),
              
            ),
            
            
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(40.0),
                bottomRight: Radius.circular(40.0),
               topLeft: Radius.circular(40.0),
                bottomLeft: Radius.circular(40.0)),
              color: Colors.yellow.shade700,

            ),
            
            // child: Text(" Current Temperature ",style: TextStyle(color: Colors.yellow.shade700, fontSize: 20,fontWeight: FontWeight.bold),textAlign: TextAlign.center,)

        ),
        SizedBox(
                        height : 20,
                      ),

        
       
                     
                    ],
                  ),
                ),
              ),
          ),
    );
        
      
    
  }
}
