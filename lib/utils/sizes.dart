import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

@visibleForTesting
const singlePageBreakpoint = 440.0;

bool isSinglePage(BuildContext context) => MediaQuery.of(context).size.width < singlePageBreakpoint;
