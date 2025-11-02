
import 'package:flutter/material.dart';
import 'package:hamikdash_sheli/app_state.dart';
import 'package:hamikdash_sheli/utills/list_enhancements.dart';
import 'package:intl/intl.dart' show DateFormat;
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart' show CalendarCarousel;
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:hamikdash_sheli/calApi/cal_api_manager.dart';
import 'package:hamikdash_sheli/calApi/data_types/day_availability.dart';
import 'package:hamikdash_sheli/pages/summery_page.dart';
import 'package:hamikdash_sheli/utills/screen_dimension.dart';
import 'package:hamikdash_sheli/app_persistence.dart';

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
  late Future? _futureCreateMeeting; // nullable since I have nothing to set it to in initState()
  DateTime _currentDate = DateTime.now();
  DateTime _dateToFindAvailabilitiesFor = DateTime.now();
  bool _monthChanged = false;
  final TextStyle _defaultWeekDay = const TextStyle(fontSize: 14.0, color: Colors.deepOrange); // according to this page: https://pub.dev/packages/flutter_calendar_carousel

  @override
  void initState() {
    super.initState();
    _dateToFindAvailabilitiesFor = DateTime.now();
    _futureListOfDayAvailability = _calApiManager.getMonthAvailability(appState.currentVisit!.caseCode, appState.currentVisit!.optionCode, _dateToFindAvailabilitiesFor);
    _futureCreateMeeting = null;
  }

  bool _areDateTimesEqual(DateTime first, DateTime second) {
    return
      first.year == second.year &&
      first.month == second.month &&
      first.day == second.day;
  }

  void _goToSummeryPage(BuildContext context)
  {
    WidgetsBinding.instance.addPostFrameCallback((_) =>
      Navigator.of(context).push(
        MaterialPageRoute<void>(
          builder: (BuildContext context) {
              return SummeryPage();
          }
        )
      )
    );
  }

  void _returnToPreviousPage(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) =>
      Navigator.pop(context)
    );
  }

  Widget _buildCalendar() {
    final calendarWidth = MediaQuery.of(context).size.width;

    // Allocate part of available height to make room for headers, week titles, etc.
    // Adjust this factor if needed for perfect fit.
    final calendarHeight = MediaQuery.of(context).size.height * 0.55;

    //on a Pixel C tablet landscape (the height is 1800 pixels), 3.5 aspect ratio displays the 6 week lines perfectly
    //4 lines for 4 weeks + 1 line of the 1st day that is in saturday + 1 line for the 30th day that is in sunday
    //like in November 2025.
    //on a Pixel C tablet portrait (the height is 2560 pixels), 2.5 is the perfect value.
    //on Pixel 6 smartphone portrait (the height is 2400 pixels), 1 is the perfect value.
    //on Pixel 6 smartphone landscape (the height is 1080 pixels), 5 is the perfect value.
    final childAspectRatio = (calendarWidth * 6) / (calendarHeight * 7); // 7 days per row, 6 week rows always

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16.0),
      child: CalendarCarousel<Event>(
        onDayPressed: (DateTime date, List<Event> events) {
          setState(() => _currentDate = date);
        },
        onCalendarChanged:(DateTime page) {
          print("onCalendarChanged start. month selected ${page.day}.${page.month}.${page.year}");
          setState(() { // repaint
            _monthChanged = true;
            _dateToFindAvailabilitiesFor = page;
            _futureListOfDayAvailability = _calApiManager.getMonthAvailability(appState.currentVisit!.caseCode, appState.currentVisit!.optionCode, _dateToFindAvailabilitiesFor);
            print("onCalendarChanged. setting month to ${page.day}.${page.month}.${page.year}");
          });
          print("onCalendarChanged end. month selected ${page.day}.${page.month}.${page.year}");
        },
        weekendTextStyle: const TextStyle(   //compensate that sunday displayed in red. even the default implementation (red color) overrides customDayBuilder
          color: Colors.black,
        ),
        todayButtonColor: Colors.blue,
        locale: "he",
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
        height: calendarHeight, // 420.0,
        childAspectRatio: childAspectRatio,
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
    appState.currentVisit!.dateTime = timeSlot;
    if(widget.mode == DateSelectionMode.create) {
      _futureCreateMeeting = _createVisit();
    } else { // reschedule
      _futureCreateMeeting = _updateVisit();
    }

    setState(() {}); // repaint
  }

  Future _createVisit() async {
    await _calApiManager.create(appState.currentVisit!.caseCode, appState.currentVisit!.optionCode, appState.currentVisit!.dateTime!);
    appState.visitList.add(appState.currentVisit!);
    await appPersistence.currentVisitsRepository!.insert(appState.currentVisit!);
  }

  Future _updateVisit() async {
    await _calApiManager.create(appState.currentVisit!.caseCode, appState.currentVisit!.optionCode, appState.currentVisit!.dateTime!, rescheduleUid: appState.currentVisit!.uid);
    await appPersistence.currentVisitsRepository!.update(appState.currentVisit!);
  }

  void _showToast(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {      
      final scaffold = ScaffoldMessenger.of(context);

      scaffold.showSnackBar(
        SnackBar(
          content: const Text('מועד הביקור עודכן בהצלחה'),
          action: SnackBarAction(label: 'הבנתי', onPressed: scaffold.hideCurrentSnackBar),
        ),
      );
    });
  }

  Widget _showNoAvailableTimeSlotsPanel(BuildContext context) {
    return const Column(
      children: [
        Text("אין זמנים פנויים היום"),
        Text("נסה יום אחר"),
      ],
    );
  }

  Widget _showErrorPanel(BuildContext context, String textLabel, String textButton) {
    return Column(
      children: [
        Text(textLabel),
        ElevatedButton(
          onPressed: () {
            setState(() { // repaint
              _futureListOfDayAvailability = _calApiManager.getMonthAvailability(appState.currentVisit!.caseCode, appState.currentVisit!.optionCode, _dateToFindAvailabilitiesFor);
            });
          },
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.all(20),
          ),
          child: Text(textButton)
        ),
      ],
    );
  }

  Widget _handleMonthChanged(AsyncSnapshot<List<DayAvailability>> snapshot) {
    _monthChanged = false;
    DayAvailability? selectedDayAvailability = snapshot.data!.firstOrNull;

    if(selectedDayAvailability == null) {
      print("at build() for month selected. no available days for month starting at ${_dateToFindAvailabilitiesFor.day}.${_dateToFindAvailabilitiesFor.month}.${_dateToFindAvailabilitiesFor.year}");
    } else {
      print("at build() for month selected. about to select date ${selectedDayAvailability.day.day}.${selectedDayAvailability.day.month}.${selectedDayAvailability.day.year} for month starting at ${_dateToFindAvailabilitiesFor.day}.${_dateToFindAvailabilitiesFor.month}.${_dateToFindAvailabilitiesFor.year}");
      WidgetsBinding.instance.addPostFrameCallback((_) {
        setState(() {
          _currentDate = selectedDayAvailability.day;
          print("at build() for month selected. date selected ${selectedDayAvailability.day.day}.${selectedDayAvailability.day.month}.${selectedDayAvailability.day.year} for month starting at ${_dateToFindAvailabilitiesFor.day}.${_dateToFindAvailabilitiesFor.month}.${_dateToFindAvailabilitiesFor.year}");
        });
      });
    }

    print("build() end.");
    return Container(); // dummy. usefull when user browsed to old month. otherwise the spinner is shown endlessly
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
              if(_futureCreateMeeting == null)
                FutureBuilder<List<DayAvailability>>(
                  // its very important to set the key since otherwise pressing a lot of times fastly on the 'next\prev month'
                  // would cause _futureListOfDayAvailability to represent a certain month
                  // while _dateToFindAvailabilitiesFor a different month
                  key: ValueKey(_futureListOfDayAvailability),
                  future: _futureListOfDayAvailability,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      print("build() start.");
                      if(_monthChanged) { // user pressed on the next\prev month buttons
                        return _handleMonthChanged(snapshot);
                      } else { // user pressed on a day
                        print("at build() for day selected. about to find time slots for ${_currentDate.day}.${_currentDate.month}.${_currentDate.year} for month starting at ${_dateToFindAvailabilitiesFor.day}.${_dateToFindAvailabilitiesFor.month}.${_dateToFindAvailabilitiesFor.year}");
                        DayAvailability? selectedDayAvailability = snapshot.data!.findFirst((da) => _areDateTimesEqual(da.day, _currentDate));

                        print("build() end.");
                        return selectedDayAvailability == null
                        ? _showNoAvailableTimeSlotsPanel(context)
                        : Expanded(
                            child: _buildDayAvailabilityPanel(selectedDayAvailability)
                          );
                      }
                    } else if (snapshot.hasError) {
                      return _showErrorPanel(context, "קרתה תקלה בקבלת נתונים מהשרת", "נסה שנית");
                    }

                    // By default, show a loading spinner.
                    return const CircularProgressIndicator();
                  },
                )
              else
                FutureBuilder(
                  future: _futureCreateMeeting,
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      _futureCreateMeeting = null;
                      return _showErrorPanel(context, "רצועת הזמן שנבחרה כבר לא זמינה יותר", "רענן");
                    } else if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator();
                    }

                    if(widget.mode == DateSelectionMode.create) {
                      _goToSummeryPage(context);
                    } else { // reschedule
                      _showToast(context);
                      _returnToPreviousPage(context);
                    }

                    return Container(); // dummy
                  },
                )
            ]
          ),
        ),
      )
    );
  }
}
