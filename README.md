# hamikdash-frontend

I set the minSdkVersion to 21 (instead of 19)  in C:\runtimes\flutter\packages\flutter_tools\gradle\src\main\groovy\flutter.groovy, in order to avoid https://developer.android.com/build/multidex during compilation and debugging integratin tests:

rest of the sdks are:
compileSdkVersion = 34
targetSdkVersion = 33

explanation is here https://developer.android.com/guide/topics/manifest/uses-sdk-element

--
when I developed a state for a statefullWidget and I coded a member below the ctor - it caused a compilation error.
but if I moved that member declaration line above the ctor - it showed no red curly error...

--
works beautifully (SummeryPage, DetailsPage):
Center that wraps (ListView or Column) that wraps
Center that wraps Column that wraps
ListView (shrinkWrap: true,  physics: const ClampingScrollPhysics()) that each item is
  a Column

--
works beautifully (VisitsPage, NewVisitPage, DateSelectionPage):
Center that wraps Column that wraps
Expanded that wraps
ListView without setting special properties

--
works beautifully (SingleOptionKorbanCase):
Center that wraps Column that wraps
ListView (shrinkWrap: true,  physics: const ClampingScrollPhysics()) that each item is
  a Column

--
works beautifully (MultiOptionsKorbanCase):
Center that wraps Column that wraps
Expanded that wraps
ListView without setting special properties that each item is
  a Column that wraps
  ListView (shrinkWrap: true,  physics: const ClampingScrollPhysics()) that each item is
    a Column

--
works beautifully (NewVisitPage):
Container(
  height: 215,
  **width: double.infinity,**
  child: ListView.builder(
    padding: const EdgeInsets.only(top: 0, bottom: 0, right: 16, left: 16),
    itemCount: korbanCases.length,
    scrollDirection: Axis.horizontal,
    itemBuilder: (BuildContext context, int index) {
      return SizedBox(
        **width: 200**,
        child:Card()
      )
    },
  )
)

--
on the top level page where you see the yellow strip - wrap the widget that cause it with Expanded widget

