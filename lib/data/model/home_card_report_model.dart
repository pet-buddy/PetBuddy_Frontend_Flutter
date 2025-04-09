import 'package:flutter/painting.dart';

class HomeCardReportModel {
  final String title;
  final String content;
  final VoidCallback? onPressed;

  HomeCardReportModel({
    required this.title,
    required this.content,
    this.onPressed
  });
} 