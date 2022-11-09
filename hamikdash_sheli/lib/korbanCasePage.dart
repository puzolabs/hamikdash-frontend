import 'package:flutter/material.dart';
import 'package:hamikdash_sheli/korbanotListPage.dart';
import 'package:hamikdash_sheli/korban.dart';

class KorbanCasePage extends StatefulWidget {
  const KorbanCasePage({super.key, required this.korbanCase});

  final KorbanCase korbanCase;

  @override
  State<KorbanCasePage> createState() => _KorbanCasePageState();
}

class _KorbanCasePageState extends State<KorbanCasePage> {
  
  // Widget _buildList(KorbanCase korbanCase) {
  //   return ListView.builder(
  //     padding: const EdgeInsets.all(8),
  //     itemCount: korbanCase.korbanot.length,
  //     itemBuilder: (BuildContext context, int index) {
  //       return _buildListItem(korbanCase.korbanot[index]);
  //     },
  //   );
  // }

  // Widget _buildListItem(Korban korban) {
  //   return ListTile(
  //       leading: FlutterLogo(),
  //       title: Text(
  //         korban.requirements,
  //         style: Theme.of(context).textTheme.headline4,
  //       ),
  //       subtitle: Text(
  //         korban.type,
  //         style: Theme.of(context).textTheme.headline6?.apply(color: Colors.grey),
  //       ),
  //     )
  //   ;
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Directionality(
          textDirection: TextDirection.rtl,
          child:Text("המקדש שלי"),
        ),
      ),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "עליכם להגיע למקדש עם הפריטים הבאים:",
                style: Theme.of(context).textTheme.headline3,
                textAlign: TextAlign.center,
              ),
              Expanded(
                // child: _buildList(widget.korban),
                child: KorbanotListPage(korbanot: widget.korbanCase.korbanot),
              ),
            ]
          ),
        ),
      )
    );
  }
}
