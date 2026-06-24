import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

SizedBox verticalSpace(double height) => SizedBox(height: height.h);

SizedBox horizontalSpace(double width) => SizedBox(width: width.w);

Size screenSize(BuildContext context) => MediaQuery.sizeOf(context);

double width(BuildContext context) => screenSize(context).width;

double height(BuildContext context) => screenSize(context).height;
