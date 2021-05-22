import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:assets_audio_player/assets_audio_player.dart';
import '../providers/language.dart';
import 'package:provider/provider.dart';
import '../style.dart';

class CharacterDetailPage extends StatefulWidget {
  final List<String> character;
  final int currentPage;

  const CharacterDetailPage({
    required this.character,
    required this.currentPage,
  });

  @override
  _CharacterDetailPageState createState() => _CharacterDetailPageState();
}

class _CharacterDetailPageState extends State<CharacterDetailPage> {
  @override
  Widget build(BuildContext context) {
    AssetsAudioPlayer assetAudioPlayer = AssetsAudioPlayer();
    int x = widget.currentPage % 2;
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarIconBrightness: Brightness.dark,
      statusBarColor: x == 1
          ? Colors.orange.shade200.withOpacity(0.8)
          : Colors.deepOrange.shade400.withOpacity(0.8),
    ));
    var lan = Provider.of<LanguageProvider>(context, listen: true);
    final screenHeight = MediaQuery.of(context).size.height;
    return WillPopScope(
      onWillPop: () {
        assetAudioPlayer.dispose();
        Navigator.of(context).pop();
        return new Future(() => true);
      },
      child: Directionality(
        textDirection: lan.isEn ? TextDirection.ltr : TextDirection.rtl,
        child: Scaffold(
          body: Stack(
            fit: StackFit.expand,
            children: [
              Hero(
                tag: 'background-${widget.character[0]}',
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                        colors: x == 1
                            ? [
                                Colors.orange.shade200,
                                Colors.deepOrange.shade400
                              ]
                            : [Colors.pink.shade200, Colors.redAccent.shade400],
                        begin: Alignment.topRight,
                        end: Alignment.bottomLeft),
                  ),
                ),
              ),
              SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 40),
                    Padding(
                      padding: const EdgeInsets.only(top: 8, left: 16),
                      child: IconButton(
                        icon: Icon(Icons.close),
                        iconSize: 40,
                        color: Colors.white.withOpacity(0.9),
                        onPressed: () {
                          assetAudioPlayer.dispose();
                          Navigator.pop(context);
                        },
                      ),
                    ),
                    Align(
                      alignment: Alignment.topRight,
                      child: Hero(
                        tag: 'image-${widget.character[1]}',
                        child: Image.asset(
                          widget.character[1],
                          height: screenHeight * 0.35,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 40, vertical: 8),
                      child: Hero(
                        tag: 'name-${widget.character[0]}',
                        child: Material(
                          color: Colors.transparent,
                          child: Container(
                            child: Text(
                              widget.character[0],
                              style: AppTheme.heading,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    createPadding(
                        lan.getTexts('weight').toString(), widget.character[2]),
                    SizedBox(height: 10),
                    createPadding(
                        lan.getTexts('height').toString(), widget.character[3]),
                    SizedBox(height: 10),
                    createPadding(
                        lan.getTexts('food').toString(), widget.character[4]),
                    SizedBox(height: 10),
                    createPadding(
                        lan.getTexts('live').toString(), widget.character[7]),
                    SizedBox(height: 10),
                    createPadding(
                        lan.getTexts('sound').toString(), widget.character[8]),
                    SizedBox(height: 10),
                    createPadding(lan.getTexts('classification').toString(),
                        widget.character[9]),
                    SizedBox(height: 30),
                    Center(
                      child: Text(
                        lan.getTexts('description').toString(),
                        style: AppTheme.heading,
                      ),
                    ),
                    SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(32, 0, 32, 16),
                      child: Text(
                        ' ${widget.character[6]}',
                        style: AppTheme.description,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
          floatingActionButton: widget.character[5].isEmpty
              ? Container()
              : FloatingActionButton(
                  onPressed: () async {
                    print(widget.character[5]);
                    assetAudioPlayer.open(Audio(widget.character[5]));
                    assetAudioPlayer.dispose();
                  },
                  child: Icon(Icons.volume_up),
                  backgroundColor: x == 1 ? Colors.pink : Colors.orange,
                ),
        ),
      ),
    );
  }

  Widget createPadding(String header, String desc) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Container(
              child: Text(
                header,
                style: AppTheme.heading1,
              ),
            ),
          ),
          Expanded(
              flex: 2,
              child: Container(
                child: Text(
                  desc,
                  style: AppTheme.subHeading,
                ),
              ))
        ],
      ),
    );
  }
}
