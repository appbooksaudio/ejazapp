import 'package:camera/camera.dart';
import 'package:ejazapp/controllers/chat/chat_controllers.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:signalr_netcore/hub_connection.dart';
import '../../providers/theme_provider.dart';
import '../rectangularButton.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MessageSendingSection extends StatefulWidget {
  const MessageSendingSection({
    super.key,
  });

  @override
  State<MessageSendingSection> createState() => _MessageSendingSectionState();
}

class _MessageSendingSectionState extends State<MessageSendingSection> {
  late ChatController chatController;
late HubConnection hubConnection;
late TextEditingController messageController;
  @override
  void initState() {
    super.initState();
    chatController = Get.put(ChatController());
    hubConnection=chatController.hubConnection;
    messageController=TextEditingController();
  }

  _imagePicker()async{
    final ImagePicker picker = ImagePicker();
   await picker.pickImage(source: ImageSource.camera);
  }

  _filePicker()async{
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if(result!=null){

    }
  }
  _messageSending()async{
    print('tappped');
    // hubConnection.invoke('SendMessage',args: ['group name','user','message']);
   chatController.sampleList.add(messageController.text);
   chatController.update();

   messageController.clear();
  }

  @override
  Widget build(BuildContext context) {
    final themeProv = Provider.of<ThemeProvider>(context);
    final theme = Theme.of(context);

    final Color grey = Color(0xffA8A8A8);
    final Color buttonBackGround = (themeProv.isDarkTheme ?? false)
        ? Color(0xFF1F2937)
        : Color(0xffF6F5F5);

    final TextStyle f13Font =
        TextStyle(fontSize: 13, fontWeight: FontWeight.w400, color: grey);

    final locale= AppLocalizations.of(context)!;

    return Container(
            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            height: 88,
            width: double.infinity,
            decoration: BoxDecoration(
                color: theme.cardColor,
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(12),
                ),
                boxShadow: [
                  BoxShadow(
                      color: (themeProv.isDarkTheme ?? false
                              ? Colors.white
                              : Colors.black)
                          .withAlpha(10),
                      blurRadius: 32,
                      spreadRadius: 0,
                      offset: Offset(0, -8))
                ]
            ),
            child: Row(
              children: [
                SquareButton(
                  action: _filePicker,
                  child: Icon(
                    Feather.paperclip,
                    size: 16,
                  ),
                  size: 40,
                  backGroundColor: buttonBackGround,
                ),
                const SizedBox(
                  width: 8,
                ),
                Expanded(
                  child: Container(
                    height: 44,
                    width: 225,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Color(0xffE3E3E3))),
                    child: TextFormField(
                      controller: messageController,
                      style: theme.textTheme.titleLarge,
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 15, vertical: 12),
                          suffixIcon: GestureDetector(
                            onTap: _messageSending,
                            child: Icon(
                              CupertinoIcons.paperplane_fill,
                              size: 20,
                              color: Color(0xff0F99D6),
                            ),
                          ),
                          hintText: '',
                          hintStyle: f13Font,
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          disabledBorder: InputBorder.none),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                GestureDetector(
                    onTap:_imagePicker,
                    child: Icon(
                      CupertinoIcons.camera_fill,
                      size: 20,
                    )),
                const SizedBox(
                  width: 10,
                ),
                GestureDetector(
                    onTap: () {},
                    child: Icon(
                      CupertinoIcons.mic_fill,
                      size: 20,
                    ))
              ],
            ),
          );
  }
}
