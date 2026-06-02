import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

SizedBox verticalSpace(double height) => SizedBox(
      height: height.h,
    );

SizedBox horizontalSpace(double width) => SizedBox(
      width: width.w,
    );
// ignore: strict_top_level_inference
double width(context) => MediaQuery.sizeOf(context).width;
// ignore: strict_top_level_inference
double height(context) => MediaQuery.sizeOf(context).height;
