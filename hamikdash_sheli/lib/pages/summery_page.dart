


import 'package:flutter/material.dart';
import 'package:hamikdash_sheli/korban.dart';
import 'package:hamikdash_sheli/pages/visits_page.dart';
import 'package:hamikdash_sheli/widgets/visit_widget.dart';

class SummeryPage extends StatelessWidget {
  SummeryPage({
    super.key,
  });

  bool _isSnackbarActive = false;
  
  void _showToast(BuildContext context) {
    if(_isSnackbarActive) {
      return;
    }

    _isSnackbarActive = true;

    final scaffold = ScaffoldMessenger.of(context);

    scaffold
      .showSnackBar(
        SnackBar(
          content: const Text('נא ליחצו על כפתור אישור'),
          action: SnackBarAction(label: 'הבנתי', onPressed: scaffold.hideCurrentSnackBar),
        ),
      )
      .closed
        .then((SnackBarClosedReason reason) {
        _isSnackbarActive = false ;
      });
  }

  void _goToVisitsPage(BuildContext context)
  {
    //I am using the technique below since calling:
    //Navigator.of(context).popUntil((route) => route.settings.name == "/visits" /*route.isFirst*/);
    //would display for a split second the cal.com page which is not elegant

    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute<void>(
        builder: (BuildContext context) {
            return const VisitsPage();
        }
      ),
      (Route<dynamic> route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false, // hide the 'back' arrow
        title: const Directionality(
          textDirection: TextDirection.rtl,
          child:Text("המקדש שלי"),
        ),
      ),
      body: PopScope(
        canPop: false,
        onPopInvoked: (didPop) {
          _showToast(context);
        },
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "הביקור הוזמן בהצלחה!",
                  style: Theme.of(context).textTheme.headline3,
                  textAlign: TextAlign.center,
                ),
                VisitWidget(visit: currentVisit!),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    margin: const EdgeInsets.only(left: 20),
                    child: ElevatedButton(
                      onPressed: () {
                        visitList.add(currentVisit!);
                        _goToVisitsPage(context);
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.all(20),
                      ),
                      child: const Text("אישור")
                    ),
                  ),
                ),
              ]
            ),
          ),
        )
      ),
    );
  }
}
