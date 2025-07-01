import 'package:petbuddy_frontend_flutter/common/utils/fn_get_leap_year.dart';

bool fnValidateBirthFormat(String birth) {
    bool result = false;
    int year = int.parse(birth.substring(0, 4));
    int month = int.parse(birth.substring(5, 7));
    int day = int.parse(birth.substring(8, 10));

    List<int> maxDays = [0, 31, !fnGetLeapYear(year) ? 28 : 29, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];

    if(month <= 0 || month > 12 || day <= 0 || day > maxDays[month]) {
      result = false;
    } else {
      result = true;
    }

    return result;
  }