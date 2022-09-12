import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hisham_qr/translations/locale_keys.g.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:flutter/rendering.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/services.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:hisham_qr/sizes.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:screenshot/screenshot.dart';

class QrGenScreen extends StatefulWidget {
  const QrGenScreen({Key? key}) : super(key: key);

  @override
  _QrGenScreenState createState() => _QrGenScreenState();
}

class _QrGenScreenState extends State<QrGenScreen> {
  TextEditingController c1 = TextEditingController();
  TextEditingController c2 = TextEditingController();
  TextEditingController c3 = TextEditingController();
  TextEditingController c4 = TextEditingController();
  TextEditingController c5 = TextEditingController();
  TextEditingController c6 = TextEditingController();

  bool fabisvisible = true;
  bool isclicked = false;
  String? text1;
  String? text2;
  String? text3;
  String? text4;
  String? text5;
  String? text6;
  String? result;
  final controller = ScreenshotController();

  @override
  Widget build(BuildContext context) {
    return Screenshot(
      controller: controller,
      child: Scaffold(
        floatingActionButton: fabisvisible ? buildFAB(context) : null,
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        body: NotificationListener<UserScrollNotification>(
          onNotification: (notification) {
            if (notification.direction == ScrollDirection.forward) {
              if (!fabisvisible)
                setState(() {
                  fabisvisible = true;
                });
            } else if (notification.direction == ScrollDirection.reverse) {
              if (fabisvisible)
                setState(() {
                  fabisvisible = false;
                });
            }
            return true;
          },
          child: GestureDetector(
            onTap: () {
              FocusScopeNode currentFocus = FocusScope.of(context);

              if (!currentFocus.hasPrimaryFocus) {
                currentFocus.unfocus();
              }
            },
            child: SingleChildScrollView(
                child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  buildQR(),
                  SizedBox(
                    height: sh * 0.05,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      buildtext(
                        context: context,
                        title: LocaleKeys.type_text.tr(),
                        type: TextInputType.multiline,
                        controller: c1,
                        number: false,
                      ),
                      buildtext(
                        context: context,
                        title: LocaleKeys.model_text.tr(),
                        type: TextInputType.number,
                        controller: c2,
                      ),
                      buildtext(
                          context: context,
                          title: LocaleKeys.colors_text.tr(),
                          type: TextInputType.multiline,
                          controller: c3,
                          number: false),
                      buildtext(
                          context: context,
                          title: LocaleKeys.size_text.tr(),
                          type: TextInputType.multiline,
                          controller: c4,
                          number: false),
                      buildtext(
                        context: context,
                        title: LocaleKeys.code_text.tr(),
                        type: TextInputType.number,
                        controller: c5,
                      ),
                      buildtext(
                        context: context,
                        title: LocaleKeys.price_text.tr(),
                        type: TextInputType.number,
                        controller: c6,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: sh * 0.1,
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        c1.clear();
                        c2.clear();
                        c3.clear();
                        c4.clear();
                        c5.clear();
                        c6.clear();
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(30)),
                      width: sw * 0.6,
                      height: sh * 0.1,
                      child: Icon(
                        Icons.delete,
                        size: 30,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'أزياء الفاتنة \n سوريا \n 0944600103',
                          style: TextStyle(fontSize: sh * 0.03),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            )),
          ),
        ),
      ),
    );
  }

  Widget buildQR() {
    return Container(
      width: 180,
      height: 210 ,
      color: Colors.white,
      child: Column(
        children: [
          QrImage(
            data: result.toString(),
            backgroundColor: Colors.white,
            size: 180,
           gapless: true,
          ),
          isclicked
              ? Text(
                  c2.text,
                  style: TextStyle(color: Colors.black, fontSize: 20),
                )
              : Container(),
        ],
      ),
    );
  }

  Widget buildFAB(BuildContext context) {
    var lang = Localizations.localeOf(context).languageCode;

    return SpeedDial(
        switchLabelPosition: lang == 'ar' ? true : false,
        icon: Icons.menu,
        activeChild: Icon(
          Icons.arrow_back,
          size: 30,
        ),
        spacing: 10,
        children: [
          SpeedDialChild(
            label: LocaleKeys.create_text.tr(),
            backgroundColor: Colors.lightGreen,
            onTap: () async {
              text1 = c1.text;
              text2 = c2.text;
              text3 = c3.text;
              text4 = c4.text;
              text5 = c5.text;
              text6 = c6.text;
              result =
                  '${LocaleKeys.type_text.tr()}: ${text1} \n${LocaleKeys.model_text.tr()}: ${text2} \n${LocaleKeys.colors_text.tr()}: ${text3} \n${LocaleKeys.size_text.tr()}: ${text4} \n${LocaleKeys.code_text.tr()}: ${text5} \n${LocaleKeys.price_text.tr()}: ${text6} \n \n أزياء الفاتنة \n سوريا \n 0944600103 ';

              setState(() {});
              Platform.isAndroid
                  ? Fluttertoast.showToast(
                      msg: '${LocaleKeys.created_text.tr()}')
                  : null;
              if (Platform.isWindows) {
                setState(() {
                  isclicked = true;
                });
              }
            },
            child: Icon(Icons.qr_code, color: Colors.white),
          ),
          SpeedDialChild(
            label: '${LocaleKeys.save_text.tr()}',
            backgroundColor: Colors.teal,
            onTap: () async {
              if (Platform.isWindows) {
                final image = await controller.captureFromWidget(buildQR());
                saveImagedesk(image.toList());
                print('saved !');
              } else if (Platform.isAndroid) {
                final image = await controller.captureFromWidget(buildQR());
                saveimage(image);
                Fluttertoast.showToast(msg: '${LocaleKeys.saved_text.tr()}');
                print('saved !');
              }
            },
            child: Icon(Icons.camera_alt, color: Colors.white),
          ),
          SpeedDialChild(
            label: '${LocaleKeys.change_text.tr()}',
            backgroundColor: Colors.teal,
            onTap: () async {
              setState(() {
                lang == 'ar'
                    ? context.setLocale(Locale('en'))
                    : context.setLocale(Locale('ar'));
              });
            },
            child: Icon(Icons.language, color: Colors.white),
          ),
        ]);
  }

  Widget buildtext({
    context,
    title,
    controller,
    type,
    bool number = true,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              '${title} :',
              style: TextStyle(fontSize: sh * 0.02),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Container(
              width: Platform.isWindows ? sh * 0.7 : sh * 0.4,
              child: TextFormField(
                controller: controller,
                inputFormatters: number
                    ? <TextInputFormatter>[
                        FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                      ]
                    : null,
                style: TextStyle(fontSize: sh * 0.03),
                keyboardType: type,
                decoration: InputDecoration(

                    // suffixIcon: IconButton(
                    //   icon: Icon(
                    //     Icons.check,
                    //     size: 30,
                    //     color: Theme.of(context).colorScheme.secondary,
                    //   ),

                    // ),
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                    border: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Theme.of(context).colorScheme.secondary),
                        borderRadius: BorderRadius.circular(10))),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<String> getPicturesPath() async {
    final directory = await getApplicationDocumentsDirectory();
    final path = directory.path;
    final file = File(path);
    var pathList = file.path.split('\\');
    pathList[pathList.length - 1] = 'Desktop';
    var picturePath = pathList.join('\\');
    print(picturePath);
    return picturePath;
  }

  void saveImagedesk(imageData) async {
    try {
      final time = DateTime.now()
          .toIso8601String()
          .replaceAll('.', ' - ')
          .replaceAll(':', ' - ');
      var picturesPath = await getPicturesPath();
      var thetaImage =
          await File(join(picturesPath, 'QR', '${c2.text.toString()}.png'))
              .create(recursive: true);
      await thetaImage.writeAsBytes(imageData);
    } catch (e) {
      print(e.toString());
    }
  }

  Future<String> saveimage(Uint8List byte) async {
    await [Permission.storage].request();

    final result =
        await ImageGallerySaver.saveImage(byte, name: '${c1.text.toString()}');
    Fluttertoast.showToast(msg: '${LocaleKeys.created_text.tr()}');
    return result['filepath'];
  }
}
