
import 'package:flutter/material.dart';
import 'package:hamikdash_sheli/korban.dart';
import 'package:hamikdash_sheli/widgets/visit_widget.dart';

class DetailsPage extends StatefulWidget {
  DetailsPage({
    super.key,
    required this.visit,
  });

  Visit visit;

  @override
  State<DetailsPage> createState() => _MyDetailsPageState();
}

class _MyDetailsPageState extends State<DetailsPage> {

  @override
  void initState() {
    super.initState();
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
              VisitWidget(visit: widget.visit),
              Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  margin: const EdgeInsets.only(left: 20),
                  child: ElevatedButton(
                    onPressed: () {
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.all(20),
                    ),
                    child: const Text("ביטול")
                  ),
                ),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  margin: const EdgeInsets.only(left: 20),
                  child: ElevatedButton(
                    onPressed: () {
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.all(20),
                    ),
                    child: const Text("עדכון")
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
