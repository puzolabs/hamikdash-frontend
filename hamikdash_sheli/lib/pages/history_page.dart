import 'package:flutter/material.dart';
import 'package:hamikdash_sheli/app_state.dart';
import 'package:hamikdash_sheli/dataTypes/visit.dart';
import 'package:hamikdash_sheli/pages/details_page.dart';
import 'package:hamikdash_sheli/services/visit_data_retriever.dart';


class HistoryPage extends StatefulWidget {
  const HistoryPage({
    super.key,
  });

  @override
  State<HistoryPage> createState() => _MyHistoryPageState();
}

class _MyHistoryPageState extends State<HistoryPage> {
  
  @override
  void initState() {
    super.initState();
  }

  Widget _buildPanel() {
    return ListView.builder(
      padding: const EdgeInsets.all(8),
      itemCount: appState.completedList.length,
      itemBuilder: (BuildContext context, int index) {
        return _buildListItem(context, appState.completedList[index]);
      }
    );
  }

  Widget _buildListItem(BuildContext context, Visit visit) {
    VisitDataRetriever vdr = VisitDataRetriever(visit:visit);

    return Card(
      child: ListTile(
        leading: Image.asset(
          vdr.getImage(),
          width: 24,
          height: 24,
          fit: BoxFit.cover,
        ),
        title: Text(
          vdr.getTitle(),
          style: Theme.of(context).textTheme.headline4,
        ),
        onTap: () {
          appState.currentVisit = visit;
          _goToDetailsPage(context);
        }
      )
    );
  }

  Future<void> _goToDetailsPage(BuildContext context) async
  {
    await Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (BuildContext context) {
          return DetailsPage();
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
        ),
      ),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                "ביקורים שהסתיימו",
                style: Theme.of(context).textTheme.headline3,
                textAlign: TextAlign.center,
              ),
              (appState.completedList.isEmpty)
              ? const Text("אין ביקורים להצגה", style: TextStyle(color: Colors.grey))
              : Expanded(
                child:_buildPanel(),
              )
            ]
          ),
        ),
      ),
    );
  }
}
