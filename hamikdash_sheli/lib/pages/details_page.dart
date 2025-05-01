import 'package:flutter/material.dart';
import 'package:hamikdash_sheli/app_persistence.dart';
import 'package:hamikdash_sheli/app_state.dart';
import 'package:hamikdash_sheli/calApi/cal_api_manager.dart';
import 'package:hamikdash_sheli/dataTypes/visit.dart';
import 'package:hamikdash_sheli/widgets/visit_widget.dart';

import 'package:hamikdash_sheli/calApi/date_selection_page.dart';

class DetailsPage extends StatefulWidget {
  DetailsPage({
    super.key,
  });

  @override
  State<DetailsPage> createState() => _MyDetailsPageState();
}

class _MyDetailsPageState extends State<DetailsPage> {
  final CalApiManager _calApiManager = CalApiManager();
  late Future? _futureCancelMeeting; // nullable since I have nothing to set it to in initState()

  @override
  void initState() {
    super.initState();
    _futureCancelMeeting = null;
  }

  Future<void> _goToDateSelectionPage() async {
    await Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (BuildContext context) {
            return const DateSelectionPage(mode: DateSelectionMode.reschedule);
        }
      )
    );
  }

  Future _cancel(BuildContext context) async {
    await _calApiManager.cancel(appState.currentVisit!.uid);
    await appPersistence.currentVisitsRepository!.delete(appState.currentVisit!.uid);    
  }

  void _showErrorToast(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('ביטול הביקור נכשל'),
      ),
    );
  }

  void _returnToPreviousPage(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) =>
      Navigator.pop(context, true)
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
          child: ListView(
            children: [
              Icon(
                //use https://fonts.google.com/icons to search for icons and open the Android tab to see the icon name
                Icons.verified, //Icons.check_circle_rounded,
                color: Colors.greenAccent.shade700,
                size: 60.0,
              ),
              Text(
                "פרטי הביקור",
                style: Theme.of(context).textTheme.headline3,
                textAlign: TextAlign.center,
              ),
              VisitWidget(visit: appState.currentVisit!),
              Visibility(
                visible: appState.currentVisit!.status != Status.done,
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    margin: const EdgeInsets.only(left: 20),
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {  // repaint
                          _futureCancelMeeting = _cancel(context);
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.all(20),
                      ),
                      child: const Text("ביטול")
                    ),
                  ),
                ),
              ),
              if(_futureCancelMeeting != null)
                FutureBuilder(
                  future: _futureCancelMeeting,
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      _futureCancelMeeting = null;
                      _showErrorToast(context);
                      return Container(); //dummy
                    } else if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator();
                    }
      
                    appState.visitList.removeWhere((v) => v.uid == appState.currentVisit!.uid);
                    appState.currentVisit = null;
                    _returnToPreviousPage(context);
                    
                    return Container(); // dummy
                  },
                ),
              Visibility(
                visible: appState.currentVisit!.status != Status.done,
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    margin: const EdgeInsets.only(left: 20),
                    child: ElevatedButton(
                      onPressed: () async {
                        await _goToDateSelectionPage();
                        setState(() { }); // update date\time labels with updated info
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.all(20),
                      ),
                      child: const Text("עדכון")
                    ),
                  ),
                ),
              ),
            ]
          ),
        ),
      )
    );
  }
}
