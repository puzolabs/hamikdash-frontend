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

    return ListView.separated(
      padding: const EdgeInsets.only(top: 20, bottom: 20),
      separatorBuilder: (BuildContext context, int index) => const SizedBox(height: 30),
      itemCount: sections.length,
      itemBuilder: (BuildContext context, int index) {
        return _buildLine(context, sections[index].name, sections[index].list);
      }
    );
  }

  Widget _buildLine(BuildContext context, String title, List<KorbanCase> korbanCases) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 0, bottom: 10, right: 16, left: 16),
          child: Text(
            title,
            style: const TextStyle(fontSize: 20)
          ),
        ),
        Container(
          height: 310,
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
    return Padding(
      padding: const EdgeInsets.only(left: 10),
      child: SizedBox( // force same height to all cards, even those who have no details
        width: 200,
        height: 310,
        child: Card (
          elevation: 8.0, // Good shadow
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0), // Rounded corners
          ),
          child: InkWell( // Makes the card tappable with a splash
            onTap: () {
              appState.currentVisit!.caseCode = korbanCase.code;
              _goToKorbanCasePage(context, korbanCase);
            },
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12.0), // smaller than the card border radius, giving a nice visual hierarchy
                        image: DecorationImage(
                          image: AssetImage(korbanCase.image),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12.0),
                  Text(
                    korbanCase.title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),                  
                  ),
                  const SizedBox(height: 4.0),
                  Visibility(
                    visible: korbanCase.details !=  "",
                    child: Text(
                      korbanCase.details, 
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[600]
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _goToKorbanCasePage(BuildContext context, KorbanCase korbanCase)
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
