
import 'package:flutter/material.dart';
import 'package:hamikdash_sheli/korban.dart';
import 'package:hamikdash_sheli/pages/details_page.dart';
import 'package:hamikdash_sheli/pages/new_visit.dart';


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
      itemCount: visitList.length,
      itemBuilder: (BuildContext context, int index) {
        return _buildListItem(context, visitList[index]);
      }
    );
  }

  Widget _buildListItem(BuildContext context, Visit visit) {
    return Card(
      child: ListTile(
        leading: const FlutterLogo(),
        title: Text(
          visit.title,
          style: Theme.of(context).textTheme.headline4,
        ),
        onTap: () {
          _goToDetailsPage(context, visit);
        }
      )
    );
  }

  Future<void> _goToDetailsPage(BuildContext context, Visit visit) async
  {
    await Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (BuildContext context) {
            return DetailsPage(visit: visit);
        }
      )
    );
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
                "ברוכים הבאים",
                style: Theme.of(context).textTheme.headline3,
                textAlign: TextAlign.center,
              ),
              (visitList.isEmpty)
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
          currentVisit = Visit();
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
