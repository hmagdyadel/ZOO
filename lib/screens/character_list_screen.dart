import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../providers/language.dart';
import '../models/character_widget.dart';
import '/style.dart';
import 'package:provider/provider.dart';

class CharacterListScreen extends StatefulWidget {
  @override
  _CharacterListScreenState createState() => _CharacterListScreenState();
}

class _CharacterListScreenState extends State<CharacterListScreen> {
  late PageController _pageController;
  int currentPage = 0;

  @override
  void initState() {
    _pageController = PageController(
      viewportFraction: 1.0,
      initialPage: currentPage,
      keepPage: false,
    );
    Provider.of<LanguageProvider>(context, listen: false).getLan();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var lan = Provider.of<LanguageProvider>(context, listen: true);
    return WillPopScope(
      onWillPop: () {
        SystemNavigator.pop();
        return new Future(() => true);
      },
      child: Directionality(
        textDirection: lan.isEn ? TextDirection.ltr : TextDirection.rtl,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            leading: TextButton(
              child: Container(
                width: 50,
                height: 30,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Colors.orangeAccent),
                child: Center(
                  child: Text(
                    lan.getTexts('language').toString(),
                    style: TextStyle(color: Colors.pink[800], fontSize: 10),
                  ),
                ),
              ),
              onPressed: () => _displayTextInputDialog(context),
            ),
          ),
          body: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                  child: RichText(
                    text: TextSpan(
                      text: lan.getTexts('app_title').toString(),
                      style: AppTheme.display1,
                    ),
                  ),
                ),
                Expanded(
                    child: PageView(
                  physics: ClampingScrollPhysics(),
                  controller: _pageController,
                  children: [
                    for (var i = 0; i < 40; i++)
                      CharacterWidget(
                        sentAnimal: selectedAnimal(i + 1, context),
                        pageController: _pageController,
                        currentPage: i,
                      )
                  ],
                ))
              ],
            ),
          ),
        ),
      ),
    );
  }

  List<String> selectedAnimal(int index, BuildContext context) {
    var lan = Provider.of<LanguageProvider>(context, listen: true);
    return lan.getTexts('animal-${currentPage + 1}') as List<String>;
  }

  Future<void> _displayTextInputDialog(BuildContext context) async {
    showDialog(
        context: context,
        builder: (ctx) {
          var lan = Provider.of<LanguageProvider>(ctx, listen: true);
          return Container(
            height: 200,
            width: MediaQuery.of(context).size.width,
            child: AlertDialog(
              backgroundColor: Color.fromRGBO(255, 254, 229, 1),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(32))),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text('🇪🇬'),
                  Text(
                    lan.getTexts('language2').toString(),
                    style: TextStyle(fontSize: 14),
                  ),
                  CupertinoSwitch(
                    value: Provider.of<LanguageProvider>(context, listen: true)
                        .isEn,
                    onChanged: (newValue) {
                      Provider.of<LanguageProvider>(context, listen: false)
                          .changeLan(newValue);
                      Navigator.of(context).pop();
                    },
                  ),
                  Text(
                    lan.getTexts('language3').toString(),
                    style: TextStyle(fontSize: 14),
                  ),
                  Text('🇺🇸'),
                ],
              ),
            ),
          );
        });
  }
}
