#!/bin/sh

# create coverage helper
sh bin/test_include_all_files.sh film_freund

# generate lcov report
flutter test --coverage

# remove non-relevant files from lcov
lcov --remove coverage/lcov.info "lib/generated/*" "*.*.dart" -o coverage/lcov.info

# generate html report
genhtml coverage/lcov.info --output=coverage
