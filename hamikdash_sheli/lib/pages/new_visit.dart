import 'package:flutter/material.dart';
import 'package:hamikdash_sheli/app_config.dart';
import 'package:hamikdash_sheli/app_state.dart';
import 'package:hamikdash_sheli/dataTypes/korban_case.dart';
import 'package:hamikdash_sheli/pages/korban_case_page.dart';

class NewVisitPage extends StatelessWidget {
  const NewVisitPage({super.key});

  Widget _buildList() {
    var happy = appConfig.korbanCases.where((kc) => kc.section == Sections.happyEvent).toList();
    var nedarimUndavot = appConfig.korbanCases.where((kc) => kc.section == Sections.nedarimUndavot).toList();
    var nazir = appConfig.korbanCases.where((kc) => kc.section == Sections.nazir).toList();
    var caparatHataim = appConfig.korbanCases.where((kc) => kc.section == Sections.caparatHataim).toList();
    var caparatAvonot = appConfig.korbanCases.where((kc) => kc.section == Sections.caparatAvonot).toList();
    var sadEvent = appConfig.korbanCases.where((kc) => kc.section == Sections.sadEvent).toList();

    List sections = [
      (name: "אירועים משמחים", list: happy),
      (name: "נדרים ונדבות", list: nedarimUndavot),
      (name: "נזיר", list: nazir),
      (name: "כפרת חטאים", list: caparatHataim),
      (name: "כפרת עוונות", list: caparatAvonot),
      (name: "מכאן רק עולים!", list: sadEvent)];

    return ListView.builder(
      padding: const EdgeInsets.all(8),
      itemCount: sections.length,
      itemBuilder: (BuildContext context, int index) {
        return _buildLine(context, sections[index].name, sections[index].list);
      }
    );
  }

  Widget _buildLine(BuildContext context, String title, List<KorbanCase> korbanCases) {
    return Column(
      children: [
        Text(title, style: const TextStyle(fontSize: 10),),
        Container(
          height: 215,
          width: double.infinity,
          child: ListView.builder(
            padding: const EdgeInsets.only(top: 0, bottom: 0, right: 16, left: 16),
            itemCount: korbanCases.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (BuildContext context, int index) {
              return _buildListItem(context, korbanCases[index]);
            },
          )
        )
      ]
    );
  }
  
  Widget _buildListItem(BuildContext context, KorbanCase korbanCase) {
    return SizedBox(
      width: 200,
      child:Card(
        child: ListTile(
          leading: const FlutterLogo(),
          title: Text(
            korbanCase.title,
            style: Theme.of(context).textTheme.headline4,
          ),
          onTap: ()
          {
            appState.currentVisit!.title = korbanCase.title;
            _goToKorbanDetailsPage(context, korbanCase);
          }
        )
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
