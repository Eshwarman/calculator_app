import 'dart:ui';

import 'package:flutter/material.dart';
class HourlyForecast extends StatelessWidget {
  final String label;
  final String Value;
  final IconData icon;
  const HourlyForecast({super.key,
  required this.Value,
    required this.label,
    required this.icon
  });

  @override
  Widget build(BuildContext context) {
    
    return Card(elevation: 10,
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
                          children: [Text(label,style: const TextStyle(color: Colors.white70,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          overflow: TextOverflow.ellipsis),
                          ),
                          const SizedBox(height: 10,),
                          Icon(icon,size: 34,),
                          const SizedBox(height: 1,),
                          Text(Value,style: const TextStyle(overflow: TextOverflow.ellipsis),)
                          ],
                          
                        ),
                      ),
                    ),
                  ),);
  }
}
class Additional_info extends StatelessWidget {
  final String label;
  final IconData icon;
  final String value;

  const Additional_info({
    super.key,
    required this.label,
    required this.icon,
    required this.value

  });

  @override
  Widget build(BuildContext context) {
    return  Column(
      children: [
        // icon
        Icon(icon,size: 34,),
        // text
        SizedBox(width: 10),
        Text(label,style:TextStyle(fontSize: 20,),),
        // text
        SizedBox(width: 5),
        Text(value)
      ],
    );
  }
}