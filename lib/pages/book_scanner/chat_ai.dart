import 'dart:io';
import 'dart:typed_data';

import 'package:camera/camera.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:ejazapp/core/services/services.dart';
import 'package:ejazapp/helpers/colors.dart';
import 'package:ejazapp/helpers/constants.dart';
import 'package:ejazapp/helpers/routes.dart';
import 'package:ejazapp/pages/book_scanner/camerapreview.dart';
import 'package:ejazapp/providers/locale_provider.dart';
import 'package:ejazapp/providers/theme_provider.dart';
import 'package:ejazapp/widgets/empty_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:get/get.dart';

import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class GeminiChat extends StatefulWidget {
  const GeminiChat({super.key});

  @override
  State<GeminiChat> createState() => GeminiChatState();
}

class GeminiChatState extends State<GeminiChat> {
  // final model = GenerativeModel(
  //     model: 'gemini-1.5-flash-latest',
  //     apiKey: 'AIzaSyA4NZiRhArE_1oOa2ACEWQeEUJGZ94okWo',
  // );

  String lang = "";
  late List<CameraDescription> cameras = [];
  bool camera = false;
  bool isIpadR = false;
  XFile? image;
  bool stateView = false;
  final Gemini gemini = Gemini.instance;
  bool loading = false;

  List<ChatMessage> _messageList = [];

  final ChatUser _currentUser =
      ChatUser(id: '1', firstName: 'Abhishek', lastName: 'Verma');

  final ChatUser _geminiUser = ChatUser(
    id: '2',
    firstName: 'Ejaz',
    lastName: 'AI',
  );

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    CheckIpad();
    openChat();
    initCamera();
    //check gemini model info
  }

  initCamera() async {
    cameras = await availableCameras();
  }

  openChat() {
    camera = mybox!.get('camera') != null ? mybox!.get('camera') : false;
    image =
        mybox!.get('imagepath') != null ? XFile(mybox!.get('imagepath')) : null;
    lang = mybox!.get("langcamera") != null ? mybox!.get("langcamera") : "en";

    if (camera == true) {
      mybox!.put("camera", false);
      mybox!.put("imagepath", null);
      mybox!.put("langcamera", "en");
      sendImageMessage(true, image);
    }
  }

  CheckIpad() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    IosDeviceInfo info = await deviceInfo.iosInfo;
    if (info.name.toLowerCase().contains("ipad")) {
      setState(() {
        isIpadR = true;
      });
      return true;
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeProv = Provider.of<ThemeProvider>(context);
    final localprovider = Provider.of<LocaleProvider>(context, listen: true);
    lang = localprovider.locale!.languageCode;
    final theme = Theme.of(context);

    return Scaffold(
      appBar: stateView != false
          ? AppBar(
              actions: [
                IconButton(
                    onPressed: () {
                      sendImageMessage(false, null);
                    },
                    icon: Icon(
                      Icons.image,
                      color: themeProv.isDarkTheme!
                          ? Colors.white
                          : ColorDark.background,
                    )),
                IconButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                            builder: (context) => TakePictureScreen(
                                  camera: cameras,
                                  lang: lang,
                                )),
                      );
                    },
                    icon: Icon(
                      Icons.camera_alt,
                      color: themeProv.isDarkTheme!
                          ? Colors.white
                          : ColorDark.background,
                    ))
              ],
              backgroundColor:
                  themeProv.isDarkTheme! ? ColorDark.background : Colors.white,
              elevation: 0,
              title: Padding(
                padding: const EdgeInsets.only(top: 0.0),
                child: Text(
                  AppLocalizations.of(context)!.chatai_ejaz, //"Ejaz Chat AI",
                  style: theme.textTheme.headlineLarge!
                      .copyWith(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              centerTitle: false,
              automaticallyImplyLeading: true,
              foregroundColor:
                  themeProv.isDarkTheme! ? Colors.blue : ColorDark.background,
            )
          : AppBar(
              backgroundColor: theme.colorScheme.surface,
              foregroundColor:
                  themeProv.isDarkTheme! ? Colors.blue : Colors.blue,
              leading: IconButton(
                  onPressed: () {
                    Get.offAllNamed(Routes.profile);
                  },
                  icon: const Icon(Icons.arrow_back)),
            ),
      body: stateView == false
          ? Center(
              child: EmptyWidget(
                image: Const.ejazai,
                title: AppLocalizations.of(context)!.chatai_by_photo,
                subtitle: AppLocalizations.of(context)!.add_photo,
                thirdLabelButton: AppLocalizations.of(context)!.select_photo,
                secondaryOnTap: () {
                  final name = mybox!.get('name');
                  if (name == 'Guest') {
                    Get.showSnackbar(GetSnackBar(
                      title: 'Ejaz',
                      message: AppLocalizations.of(context)!.messagetoguestuser,
                      duration: const Duration(seconds: 5),
                      titleText: Column(
                        children: [],
                      ),
                      snackPosition: SnackPosition.TOP,
                      backgroundColor: Colors.red,
                      icon: const Icon(Icons.mood_bad),
                    ));
                    return;
                  }
                  sendImageMessage(false, null);
                },
              ),
            )
          : Stack(
              fit: StackFit.loose,
              children: [
                DashChat(
                    readOnly: true,
                    messageOptions: MessageOptions(
                        currentUserContainerColor:
                            // Color.fromARGB(255, 68, 68, 68),
                            Colors.transparent,
                        currentUserTextColor: Colors.transparent),
                    //  Color.fromARGB(255, 255, 255, 255)),
                    messageListOptions: MessageListOptions(
                      onLoadEarlier: () async {
                        await Future.delayed(const Duration(seconds: 3));
                      },
                    ),
                    currentUser: _currentUser,
                    onSend: _sendMessage,
                    messages: _messageList),
                if (loading)
                  Center(
                    child: Lottie.asset(
                      "assets/loadingai.json",
                      width: 200,
                      height: 200,
                      fit: BoxFit.contain,
                    ),
                  ),
              ],
            ),
    );
  }

  void _sendMessage(ChatMessage m) {
    setState(() {
      _messageList.insert(0, m);
      loading = true;
    });

    try {
      String question = m.text;
      List<Uint8List>? image;
      if (m.medias?.isNotEmpty ?? false) {
        image = [
          File(m.medias!.first.url).readAsBytesSync(),
        ];
      }
      // listner will be fired when ever event happenes on this stream
      // gemini.textAndImage(images: image!,text: question);
      gemini
          .streamGenerateContent(question,
              images: image,
              generationConfig: GenerationConfig(
                maxOutputTokens: 2000,
                temperature: 0.9,
                topP: 0.1,
                topK: 16,
              ))
          .listen((event) {
        print(event.content);
        ChatMessage? lastMessage = _messageList.firstOrNull;
        if (lastMessage != null && lastMessage.user == _geminiUser) {
          lastMessage = _messageList.removeAt(0);
          String response = event.content?.parts?.fold(
                  "",
                  (previousValue, currentValue) =>
                      "$previousValue ${currentValue.text}") ??
              "";

          lastMessage.text += response;
          setState(() {
            _messageList = [lastMessage!, ..._messageList];
            loading = false;
          });
        } else {
          String response = event.content?.parts?.fold(
                  "",
                  (previousValue, currentValue) =>
                      "$previousValue ${currentValue.text}") ??
              "";

          ChatMessage message = ChatMessage(
              user: _geminiUser, createdAt: DateTime.now(), text: response);

          setState(() {
            _messageList = [message, ..._messageList];
          });
        }
      });
    } catch (e) {
      print(e);
    }
  }

  void sendImageMessage(bool cameravalue, XFile? image) async {
    XFile? file;
    if (cameravalue != true) {
      setState(() {
        stateView = true;
      });
      ImagePicker imagePicker = ImagePicker();
      file = await imagePicker.pickImage(
        source: ImageSource.gallery,
      );
    } else {
      setState(() {
        stateView = true;
      });
      file = image;
    }

    if (file != null) {
      ChatMessage chatMessage = ChatMessage(
          user: _currentUser,
          createdAt: DateTime.now(),
          text: lang == "ar"
              ? "أعطيني موجز مطول ومفصل عن هذا الكتاب باللغة العربية؟"
              : "Can you give me a long and detailed summary of this book?",
          medias: [
            ChatMedia(
              url: file.path,
              fileName: "",
              type: MediaType.image,
            )
          ]);
      _sendMessage(chatMessage);
    }
  }
}
