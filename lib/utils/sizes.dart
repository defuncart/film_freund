import 'package:flutter/material.dart';

@visibleForTesting
const singlePageBreakpoint = 440.0;

bool isSinglePage(BuildContext context) => MediaQuery.of(context).size.width < singlePageBreakpoint;
