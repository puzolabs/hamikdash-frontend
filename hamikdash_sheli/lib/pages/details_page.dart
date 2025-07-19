import 'package:flutter/material.dart';
import 'package:hamikdash_sheli/app_persistence.dart';
import 'package:hamikdash_sheli/app_state.dart';
import 'package:hamikdash_sheli/calApi/cal_api_manager.dart';
import 'package:hamikdash_sheli/dataTypes/visit.dart';
import 'package:hamikdash_sheli/widgets/visit_widget.dart';
import 'package:hamikdash_sheli/calApi/date_selection_page.dart';
import 'package:rounded_loading_button_plus/rounded_loading_button.dart';

class DetailsPage extends StatefulWidget {
  DetailsPage({
    super.key,
  });

  @override
  State<DetailsPage> createState() => _MyDetailsPageState();
}

class _MyDetailsPageState extends State<DetailsPage> {
  final CalApiManager _calApiManager = CalApiManager();
  final RoundedLoadingButtonController _btnController = RoundedLoadingButtonController();

  @override
  void initState() {
    super.initState();
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

  void _cancel() async {
    try {
      await _calApiManager.cancel(appState.currentVisit!.uid);
    } catch(e) {
      //we dont care to leave wasted time slot on the server side
      //so continue below to remove it from local db
    }

    await appPersistence.currentVisitsRepository!.delete(appState.currentVisit!.id);

    appState.visitList.removeWhere((v) => v.uid == appState.currentVisit!.uid);
    appState.currentVisit!.status = Status.canceled;
    
    _btnController.success();
    setState(() {}); // repaint to hide the 'update' button
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
                visible: appState.currentVisit!.status == Status.pending || appState.currentVisit!.status == Status.canceled,
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    margin: const EdgeInsets.only(left: 20),
                    //user can't press the button while spinner is showing
                    child: RoundedLoadingButton(
                      controller: _btnController,
                      onPressed: _cancel,
                      child: const Text('ביטול',
                        style: TextStyle(color: Colors.white)
                      ),
                    )
                  ),
                ),
              ),
              Visibility(
                visible: appState.currentVisit!.status == Status.pending,
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
