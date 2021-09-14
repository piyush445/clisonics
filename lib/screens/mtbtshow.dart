import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:musopathy/models/mtbt.dart';
import 'package:musopathy/widgets/custom_drawer.dart';

class Mtbtshow extends StatelessWidget {
  final List<Mtbt> data = [
    Mtbt(
        "Clisonics offers specially evolved evidence-based Health and Wellness solutions through its Tonation Breathing Techniques (TBT) or other programs for a variety of health conditions. There are also specialized Mind Engineering and Management (MEM) Courses for Individual and Organizational Wellbeing.",
        Colors.white),
    Mtbt(
        "Tonation Breathing Techniques (TBT): A unique combination of diverse non-strenuous specialized breathing techniques with the unique addition of Tonation which is anchored on published studies in leading journals",
        Colors.white),
    Mtbt(
        "Uniqueness \n\nOptimal benefits:  Many programs focus on Breathing techniques, music therapy, mindfulness, meditation, biofeedback etc. By uniquely introducing Tonatio to most breathing techniques, the TBT program gives exponential benefits to patients as well as healthy participants.\n\n Simplified: TBT includes only the easiest techniques and simplifications of even seemingly challenging ones from other programs to not tax even the severely weakened. Variations: Several variations have been introduced to provide higher benefits by engaging more of the respiratory pathways.\n\n Minimalistic approach: TBT emphasises on the most essential techniques to ensure that even 2-3 minutes .\nFocus: The TBT twin mantra of Mindfulness and Restfulness is life enhancing and - at times, life saving. \n ",
        Colors.white),
    // Mtbt(, c),
    // Mtbt(text, c),
    // Mtbt(),
    // Mtbt(, c)
  ];
  final GlobalKey<ScaffoldState> key1 = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    return Scaffold(
      key: key1,
      drawer: CustomDrawer(),
      appBar: AppBar(
        iconTheme: IconThemeData(color: Color.fromRGBO(40, 115, 161, 1.0)),
        backgroundColor: Colors.white,
        title: Text(
          'C L I S O N I C S',
          style: TextStyle(
            fontFamily: 'Ubuntu',
            fontSize: 20,
            color: Color.fromRGBO(40, 115, 161, 1.0),
            fontWeight: FontWeight.normal,
          ),
        ),
        elevation: 4,
      ),
      body: ListView.builder(
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              elevation: 1.0,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5)),
              child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Text(data[index].text,
                      textAlign: TextAlign.justify,
                      style: TextStyle(fontSize: 17))),
              color: data[index].c,
            ),
          );
        },
        itemCount: data.length,
      ),
    );
  }
}
