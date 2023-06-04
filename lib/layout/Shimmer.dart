import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

Widget home_list_shimmer(context){

  return Shimmer(
    gradient:  LinearGradient(
      colors: Theme.of(context).brightness == Brightness.light?[
        const Color(0xFFEBEBF4),
        const Color(0xFFF4F4F4),
        const Color(0xFFEBEBF4),
      ]:[
      const Color(0xFF212121),
      const Color(0xFF1E1E25),
      const Color(0xFF1F1F21),],
      stops: const [
        0.2,
        0.3,
        0.4,
      ],
      begin: const Alignment(-1.0, -0.3),
      end: const Alignment(1.0, 0.3),
      tileMode: TileMode.clamp,
    ),
     period: const Duration(milliseconds: 2000),
    // baseColor:Theme.of(context).backgroundColor==Colors.white? Colors.grey[300]!:Colors.grey[700]!,
    // highlightColor:Theme.of(context).backgroundColor==Colors.white? Colors.black.withOpacity(0.05): Colors.white.withOpacity(0.05),
    child: Padding(
      padding: const EdgeInsets.all(0.0),
      child: Column(
        children: [
          Container(width: 60,height: 80,color: Theme.of(context).backgroundColor,),
          const SizedBox(height: 10,),
          // Expanded(child: Container(height: 50,width: double.infinity,color: Colors.white)),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
               // Container(width: MediaQuery.of(context).size.width/6,height: 20,color: Theme.of(context).backgroundColor,),
                const SizedBox(height: 5,),
                Container(width:  MediaQuery.of(context).size.width/4,height: 17,color: Theme.of(context).backgroundColor,),

              ],
            ),
          ),
        ],
      ),
    ),
  );
}