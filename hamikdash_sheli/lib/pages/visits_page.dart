import 'package:flutter/material.dart';
import 'package:hamikdash_sheli/app_state.dart';
import 'package:hamikdash_sheli/dataTypes/visit.dart';
import 'package:hamikdash_sheli/pages/details_page.dart';
import 'package:hamikdash_sheli/pages/history_page.dart';
import 'package:hamikdash_sheli/pages/new_visit.dart';
import 'package:hamikdash_sheli/services/visit_data_retriever.dart';


class VisitsPage extends StatefulWidget {
  const VisitsPage({
    super.key,
  });

  @override
  State<VisitsPage> createState() => _MyVisitsPageState();
}

class _MyVisitsPageState extends State<VisitsPage> {
  
  @override
  void initState() {
    super.initState();
  }

  Widget _buildPanel() {
    return ListView.builder(
      padding: const EdgeInsets.all(8),
      itemCount: appState.visitList.length,
      itemBuilder: (BuildContext context, int index) {
        return _buildListItem(context, appState.visitList[index]);
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
      MaterialPageRoute(
        builder: (BuildContext context) {
            return DetailsPage();
        }
      )
    );

    if(appState.currentVisit!.status == Status.canceled) {
      appState.currentVisit = null;
      setState(() { }); //repaint to remove the canceled visit from the list
    }
  }

  Future<void> _goToNewVisitPage(BuildContext context) async
  {
    await Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (BuildContext context) {
            return const NewVisitPage();
        }
      )
    );
  }

  Future<void> _goToHistoryPage(BuildContext context) async
  {
    await Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (BuildContext context) {
            return const HistoryPage();
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
      drawer: Drawer(
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(color: Colors.blue),
              child: Text('תפריט'),
            ),
            ListTile(
              title: const Text('ביקורים קודמים'),
              onTap: () {
                Navigator.pop(context); // close the drawer
                _goToHistoryPage(context);
              },
            ),
          ],
        ),
      ),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                "הביקורים הבאים",
                style: Theme.of(context).textTheme.headline3,
                textAlign: TextAlign.center,
              ),
              (appState.visitList.isEmpty)
              ? const Text("רשימת הביקורים ריקה :(", style: TextStyle(color: Colors.grey))
              : Expanded(
                child:_buildPanel(),
              )
            ]
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async { 
          appState.currentVisit = Visit();
          await _goToNewVisitPage(context);
          //force rebuild this widget after poping from summery page
          setState(()
          {
          });
        },
        tooltip: 'Add',
        child: const Icon(Icons.add),
      ),
    );
  }
}
