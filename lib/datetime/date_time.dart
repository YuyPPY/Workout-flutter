// return  todays date as yyymmdd
String todayDateYYYYMMDD() {
// today
  var dateTimeObject = DateTime.now();

  // year in the foemat yyyy
  String year = dateTimeObject.year.toString();

  //month in the format mm

  String month = dateTimeObject.month.toString();
  if (month.length == 1) {
    month = '0$month';
  }

//day in the format dd
  String day = dateTimeObject.day.toString();
  if (day.length == 1) {
    day = '0$day';
  }
  String yyyymmdd = year + month + day;
  return yyyymmdd;
  // DateTime now = DateTime.now();
  // return now.year.toString() + now.month.toString() + now.day.toString();
}
// covert string yyyymmdd to  DateTime odject

DateTime createDdateTimeObject(String yyyymmdd) {
  int yyyy = int.parse(yyyymmdd.substring(0, 4));
  int mm = int.parse(yyyymmdd.substring(4, 6));
  int dd = int.parse(yyyymmdd.substring(6, 8));
  DateTime dateTimeObject = DateTime(yyyy, mm, dd);
  return dateTimeObject;
}

// convert Date  Odject To String yyyymmdd

String convertDateTimeToYYYYMMDD(DateTime dateTime) {
  // year in the foemat yyyy
  String year = dateTime.year.toString();

  //month in the format mm

  String month = dateTime.month.toString();
  if (month.length == 1) {
    month = '0$month';
  }

//day in the format dd
  String day = dateTime.day.toString();
  if (day.length == 1) {
    day = '0$day';
  }

  String yyyymmdd = year + month + day;
  return yyyymmdd;
}
