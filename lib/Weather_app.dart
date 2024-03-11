import 'dart:convert';
import 'dart:ui';


import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
// import 'package:weather_app/secrets.dart';

import 'Widgets_items.dart';
import 'package:http/http.dart' as http;

class WeatherApp extends StatefulWidget {
  const WeatherApp({super.key});

  @override
  State<WeatherApp> createState() => _WeatherAppState();
}

class _WeatherAppState extends State<WeatherApp> {
  late Future<Map<String,dynamic>> weather;
 Future<Map<String,dynamic>> getCurrentWeather()async{
  try{
    
  String cityName="london";
 Uri uri = Uri.parse("https://api.openweathermap.org/data/2.5/forecast?q=$cityName,uk&APPID=1ab028d475b0dc8f5b877f786d9cee3e");
final res= await http.get(uri);
//  print(res);
 final data=jsonDecode(res.body);
 if(data['cod']!="200"){
  print('cod!=200');
  throw 'an unexpexted error';
 }
 return data;
  // temp=data['list'][0]['main']['temp'];
 
 }catch(e){
  print('catch');
  throw e.toString();
 }}
 @override
 void initState(){
  super.initState();
  
 }
 

  @override
  Widget build(BuildContext context) {
    print("object build");
    print("insta");
    print("do it");
    return  Scaffold(
      appBar: AppBar(
      title: const Text("Weather_App",style: TextStyle(
        color: Colors.white70,
        fontWeight: FontWeight.bold
      ),
      ),
      centerTitle: true,
      actions:  [IconButton(onPressed: (){setState(() {
        
      });}, icon:const Icon(Icons.refresh))],
      
      ),
      body:FutureBuilder(
        future:getCurrentWeather(),
        builder: (context, snapshot) {
          print(snapshot);
          if(snapshot.connectionState==ConnectionState.waiting){
            return  const Center(child:  CircularProgressIndicator.adaptive());
          }
          if(snapshot.hasError){
            return Text(snapshot.error.toString());
          }
          final data =snapshot.data!;
          final rep=data['list'][0];
          final currentTemp=rep['main']['temp'];
          final currentClouds=rep['weather'][0]['main'];
          final currentHumidity=data['list'][0]['main']['humidity'];
          final currentPressure=data['list'][1]['main']['pressure'];
          final currentWindSpeed=data['list'][0]['wind']['speed'];
          
          return Padding(
          
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            
            scrollDirection: Axis.vertical,
            child: Column(
              mainAxisAlignment:MainAxisAlignment.spaceAround,
              children: [
                // main card nnnnn font colmun 
                Container(
                  width: double.infinity,
                  
                  child:  Card(elevation: 50,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16)
                  ),
                    child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 10,sigmaY: 10),
                      child:  Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          children: [Text(" $currentTemp k ",style: const TextStyle(color: Colors.white70,
                          fontSize: 30,
                          fontWeight: FontWeight.bold),
                          ),
                         const  SizedBox(height: 16,),
                           Icon(currentClouds=='Clouds'||currentClouds=='Rain'?Icons.cloud:Icons.sunny,size: 64,),
                         const  SizedBox(height: 1,),
                           Text("$currentClouds")
                          ],
                          
                        ),
                      ),
                    ),
                  ),)
                ),
                const SizedBox(height: 16),
                
               const  Align(alignment:Alignment.centerLeft,child: Text("Weather Forecast",style: TextStyle(fontSize:20 ))),
                // report
                 const SizedBox(height: 8),
                // Container(alignment: Alignment.centerLeft,
                //   // child:   SingleChildScrollView(
                //   //   scrollDirection: Axis.horizontal,
                    
                //   //   child: Row(
                //   //     children: [
                //   //       for(int i=0;i<39;i++)
                //   //       HourlyForecast(label: data['list'][i+1]['dt'].toString(),
                //   //       Value: data['list'][i+1]['main']['temp'].toString(),
                //   //       icon: data['list'][i+1]['weather'][0]['main']=='Clouds'||data['list'][i+1]['weather'][0]['main']=='Rain'?Icons.cloud:Icons.sunny,),
                      
                      
              
                //   //     ],
                //   //   ),
                //   // ),
                // ),

                SizedBox(
                  height: 120,
                  child: ListView.builder(itemCount: 5,
                  scrollDirection: Axis.horizontal,
                  itemBuilder:(context ,Index){
                  final time=DateTime.parse((data['list'][Index+1]['dt_txt'].toString()));
                    return HourlyForecast(label: DateFormat.Hm().format(time),
                          Value: data['list'][Index+1]['main']['temp'].toString(),
                          icon: data['list'][Index+1]['weather'][0]['main']=='Clouds'||data['list'][Index+1]['weather'][0]['main']=='Rain'?Icons.cloud:Icons.sunny,);
                  } ,
                  ),
                ),
                
               const    SizedBox(height: 16,),
                // additional information
              const Align(alignment:Alignment.centerLeft,child: Text("Additional Information",style: TextStyle(fontSize: 20,),)),
              const  SizedBox(height: 8,),
             Padding(
               padding:  EdgeInsets.all(10.0),
               child:   Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Additional_info(icon: Icons.water_drop,label: "Humidity",value: currentHumidity.toString(),),
              
                     SizedBox(width: 20,),
                    Additional_info(icon: Icons.air_rounded,label: "wind speed",value: currentWindSpeed.toString(),),
                    SizedBox(width: 20,),
                    Additional_info(icon: Icons.ramen_dining,label: "Pressure",value: currentPressure.toString(),),
                  ],
                ),
             )
              ],
            ),
          ),
        );
        },
      ) ,
    );
  }
}



