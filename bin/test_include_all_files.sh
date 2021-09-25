#!/bin/sh

# Taken from https://github.com/flutter/flutter/issues/27997

file=test/coverage_helper_test.dart
printf "// Helper file to make coverage work for all dart files\n" > $file
printf "// **************************************************************************\n" >> $file
printf "// Because of this: https://github.com/flutter/flutter/issues/27997#issue-410722816\n" >> $file
printf "// DO NOT EDIT THIS FILE USE: sh scripts/import_files_coverage.sh YOUR_PACKAGE_NAME\n" >> $file
printf "// **************************************************************************\n" >> $file
printf "\n" >> $file
printf "// ignore_for_file: unused_import\n" >> $file
find lib -type f \( -iname "*.dart" ! -iname "*.g.dart" ! -iname "*.*.dart" ! -iname "generated_plugin_registrant.dart" \) | cut -c4- | awk -v package="$1" '{printf "import '\''package:%s%s'\'';\n", package, $1}' >> $file
printf "\nvoid main(){}" >> $file
