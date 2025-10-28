import 'package:flutter/material.dart';
import 'package:hamikdash_sheli/app_persistence.dart';
import 'package:hamikdash_sheli/app_state.dart';
import 'package:hamikdash_sheli/calApi/cal_api_manager.dart';
import 'package:hamikdash_sheli/dataTypes/visit.dart';
import 'package:hamikdash_sheli/utills/single_snackbar_manager.dart';
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
  bool _duringCancellationProcess = false;
  final CalApiManager _calApiManager = CalApiManager();
  final RoundedLoadingButtonController _btnController = RoundedLoadingButtonController();
  final SingleSnackbarManager _snackbarManager = SingleSnackbarManager('אנא המתינו לסיום תהליך הביטול', 'הבנתי');

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
    // repaint to prevent going to previous page until canceling is done (otherwise we get an exception + we can't remove the visit from the UI list)
    setState(() { _duringCancellationProcess = true;});

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
    setState(() { _duringCancellationProcess = false;}); // repaint to hide the 'update' button + allow to go to previous page
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
      body: PopScope(
        //prvent going back during cancellation process since
        //we won't be able to update the visits list UI widget ( = delete the visit from the list) after the cancallatin is done
        canPop: !_duringCancellationProcess,
        onPopInvoked: (didPop) {
          if(!didPop){
            _snackbarManager.showToast(context);
          }
        },
        child: Directionality(
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
                const SizedBox(height: 20),
                Visibility(
                  visible: appState.currentVisit!.status == Status.pending,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 20.0, left: 20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("מעוניינים לבטל את הביקור? ליחצו כאן"),
                        //user can't press the button while spinner is showing
                        RoundedLoadingButton(
                          width: 100,
                          controller: _btnController,
                          onPressed: _cancel,
                          child: const Text('ביטול',
                            style: TextStyle(color: Colors.white)
                          ),
                        )
                      ]
                    ),
                  ),
                ),
                Visibility(
                  visible: appState.currentVisit!.status == Status.canceled,
                  child: const Padding(
                    padding: EdgeInsets.only(right: 20.0, left: 20.0),
                    child: Text("הביקור בוטל בהצלחה",
                      style: TextStyle(fontSize: 28)),
                  ),
                ),
                Visibility(
                  visible: appState.currentVisit!.status == Status.pending,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 20.0, left: 20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("מעוניינים לעדכן את הביקור? ליחצו כאן"),
                        ElevatedButton(
                          onPressed: () async {
                            await _goToDateSelectionPage();
                            setState(() { }); // update date\time labels with updated info
                          },
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.all(20),
                          ),
                          child: const Text("עדכון")
                        )
                      ],
                    ),
                  ),
                ),
              ]
            ),
          ),
        ),
      )
    );
  }
}
