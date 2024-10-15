
import 'package:flutter/material.dart';
import 'package:hamikdash_sheli/app_state.dart';
import 'package:hamikdash_sheli/korban.dart';
import 'package:hamikdash_sheli/utills/list_enhancements.dart';
import 'package:intl/intl.dart' show DateFormat;
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart' show CalendarCarousel;
import 'package:flutter_calendar_carousel/classes/event.dart';

import '../calApi/cal_api_manager.dart';
import '../calApi/data_types/day_availability.dart';
import 'summery_page.dart';
import '../utills/screen_dimension.dart';

enum DateSelectionMode {
  create,
  reschedule,
}

class DateSelectionPage extends StatefulWidget {
  const DateSelectionPage({
    super.key,
    required this.mode
  });

  final DateSelectionMode mode;

  @override
  State<DateSelectionPage> createState() => _DateSelectionPageState();
}

class _DateSelectionPageState extends State<DateSelectionPage> {
  final CalApiManager _calApiManager = CalApiManager();
  late Future<List<DayAvailability>> _futureListOfDayAvailability;
  DateTime _currentDate = DateTime.now();
  final TextStyle _defaultWeekDay = const TextStyle(fontSize: 14.0, color: Colors.deepOrange); // according to this page: https://pub.dev/packages/flutter_calendar_carousel

  @override
  void initState() {
    super.initState();
    _futureListOfDayAvailability = _calApiManager.getMonthAvailability(DateTime.now());
  }

  void _goToSummeryPage(BuildContext context)
  {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (BuildContext context) {
            return SummeryPage();
        }
      )
    );
  }

  Widget _buildCalendar() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16.0),
      child: CalendarCarousel<Event>(
        onDayPressed: (DateTime date, List<Event> events) {
          setState(() => _currentDate = date);
        },
        onCalendarChanged:(DateTime page) {
          _futureListOfDayAvailability = _calApiManager.getMonthAvailability(page);
        },
        weekendTextStyle: const TextStyle(   //compensate that sunday displayed in red. even the default implementation (red color) overrides customDayBuilder
          color: Colors.black,
        ),
        todayButtonColor: Colors.blue,
        customWeekDayBuilder: (weekday, weekdayName) {
          switch (weekday) {
            case 0: return Text('ראשון', style: _defaultWeekDay);
            case 1: return Text('שני', style: _defaultWeekDay);
            case 2: return Text('שלישי', style: _defaultWeekDay);
            case 3: return Text('רביעי', style: _defaultWeekDay);
            case 4: return Text('חמישי', style: _defaultWeekDay);
            case 5: return Text('שישי', style: _defaultWeekDay);
            case 6: return Text('שבת', style: _defaultWeekDay);
          }
          return Container();
        },
        customDayBuilder: (
          bool isSelectable,
          int index,
          bool isSelectedDay,
          bool isToday,
          bool isPrevMonthDay,
          TextStyle textStyle,
          bool isNextMonthDay,
          bool isThisMonthDay,
          DateTime day,
        ) {
            if ((day.isBefore(DateTime.now()) && !isToday) ||
                day.weekday == 6) {                //saturday
              return Center(
                child: Text(day.day.toString(),
                  style: textStyle.apply(color: Colors.grey),
                ),
              );
            } else {
              return null;
            }
        },
        weekFormat: false,
        markedDatesMap: null,
        height: 420.0,
        selectedDateTime: _currentDate,
        daysHaveCircularBorder: null, // null for not rendering any border, true for circular border, false for rectangular border
      ),
    );
  }

  Widget _buildDayAvailabilityPanel(DayAvailability dayAvailability) {
    return ListView.builder(
      padding: const EdgeInsets.all(8),
      itemCount: dayAvailability.timeSlots.length,
      itemBuilder: (BuildContext context, int index) {
        return _buildListItem(context, dayAvailability.timeSlots[index]);
      }
    );
  }

  Widget _buildListItem(BuildContext context, DateTime timeSlot) {
    return Card(
      child: ListTile(
        title: Align(
          alignment: Alignment.center,
          child: Text(
            DateFormat('HH:mm').format(timeSlot),
            style: Theme.of(context).textTheme.headline4,
          )
        ),
        onTap: () {
          _timeSlotTapped(timeSlot);
        }
      )
    );
  }

  void _timeSlotTapped(DateTime timeSlot) {
    currentVisit!.dateTime = timeSlot;
    if(widget.mode == DateSelectionMode.create) {
      _calApiManager.create("minha", timeSlot);
      _goToSummeryPage(context);
    } else { // reschedule
      _calApiManager.create("minha", timeSlot, rescheduleUid: currentVisit!.uid);
      _showToast(context);
      Navigator.pop(context);
    }
  }

  void _showToast(BuildContext context) {
    final scaffold = ScaffoldMessenger.of(context);

    scaffold.showSnackBar(
      SnackBar(
        content: const Text('מועד הביקור עודכן בהצלחה'),
        action: SnackBarAction(label: 'הבנתי', onPressed: scaffold.hideCurrentSnackBar),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Directionality(
          textDirection: TextDirection.rtl,
          child:Text("המקדש שלי"),
        ),
      ),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                "מתי יהיה לכם נח להגיע?",
                style: Theme.of(context).textTheme.headline3,
                textAlign: TextAlign.center,
              ),
              _buildCalendar(),
              FutureBuilder<List<DayAvailability>>(
                future: _futureListOfDayAvailability,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    var selectedDayAvailability = snapshot.data!.findFirst((da) => da.day == _currentDate);
                    return selectedDayAvailability == null
                    ? Container()
                    : Expanded(
                        child: _buildDayAvailabilityPanel(selectedDayAvailability)
                      );
                  } else if (snapshot.hasError) {
                    return Text('${snapshot.error}');
                  }

                  // By default, show a loading spinner.
                  return const CircularProgressIndicator();
                },
              )
            ]
          ),
        ),
      )
    );
  }
}
