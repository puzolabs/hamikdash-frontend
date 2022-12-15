
import 'package:flutter/material.dart';
import 'package:hamikdash_sheli/korban.dart';
import 'package:hamikdash_sheli/pages/korban_case_page.dart';

class NewVisitPage extends StatelessWidget {
  const NewVisitPage({super.key});

  Widget _buildList() {
    KorbanCasesFactory kcf = KorbanCasesFactory();
    var cases = kcf.create();

    return ListView.builder(
      padding: const EdgeInsets.all(8),
      itemCount: cases.length,
      itemBuilder: (BuildContext context, int index) {
        return _buildListItem(context, cases[index]);
      }
    );
  }

  Widget _buildListItem(BuildContext context, KorbanCase korbanCase) {
    return Card(
      child: ListTile(
        leading: const FlutterLogo(),
        title: Text(
          korbanCase.title,
          style: Theme.of(context).textTheme.headline4,
        ),
        onTap: () { _goToKorbanDetailsPage(context, korbanCase); }
      )
    );
  }

  void _goToKorbanDetailsPage(BuildContext context, KorbanCase korbanCase)
  {
      Navigator.of(context).push(
          MaterialPageRoute<void>(
              builder: (BuildContext context) {
                  return KorbanCasePage(korbanCase: korbanCase);
              }
          )
      );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Directionality(
          textDirection: TextDirection.rtl,
          child:Text("המקדש שלי"),
        )
      ),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "לצורך תיאום ביקור במקדש, אנא ביחרו את סיבת הגעתכם",
                style: Theme.of(context).textTheme.headline3,
                textAlign: TextAlign.center,
              ),
              Expanded(
                child: _buildList(),
              ),
            ]
          ),
        ),
      )
    );
  }
}
