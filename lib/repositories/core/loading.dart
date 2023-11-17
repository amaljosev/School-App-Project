import 'package:flutter/material.dart';
import 'package:schoolapp/repositories/core/colors.dart';
import 'package:schoolapp/repositories/utils/shimmer_widget.dart';

class LoadingWidget {
  Widget classDataLoadingShimmer() => Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
          decoration: BoxDecoration(
              color: appbarColor,
              borderRadius: const BorderRadius.all(Radius.circular(8))),
          height: 200,
          width: double.infinity,
          child: ShimmerWidget.rectangular(
            isRound: false,
              height: 200,
              baseColor: appbarColor,
              highlightColor: Colors.purple.shade50)));
  Widget studentCircleShimmer() => Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        height: 120,
        width: double.infinity,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: 4,
          itemBuilder: (context, index) => Padding(
            padding: const EdgeInsets.all(8.0),
            child: CircleAvatar(
              radius: 40,
              child: ShimmerWidget.circular(
                isRound: true,
                  height: 40,
                  width: 40, 
                  baseColor: appbarColor,
                  highlightColor: Colors.purple.shade50),
            ),
          ),
        ),
      ));
}
