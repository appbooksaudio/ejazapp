import 'package:ejazapp/helpers/routes.dart';
import 'package:ejazapp/providers/locale_provider.dart';
import 'package:ejazapp/providers/theme_provider.dart';
import 'package:firebase_auth/firebase_auth.dart' ;
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class CreateGroupScreen extends StatefulWidget {
  CreateGroupScreen();

  @override
  _CreateGroupScreenState createState() => _CreateGroupScreenState();
}

class _CreateGroupScreenState extends State<CreateGroupScreen> {
  TextEditingController groupNameController = TextEditingController();
  List<types.User> selectedMembers = [];
  List<types.User> allUserIds = [];

  @override
  void initState() {
    allUserIds = Get.arguments;
    super.initState();
  }

 Future<void> createGroup(String groupName, List<types.User> members) async {
  // Extract UIDs from the chat users
  List<String> memberIds = members.map((user) => user.id).toList(); 

  await FirebaseFirestore.instance.collection('groups').add({
    'name': groupName,
    'createdAt': FieldValue.serverTimestamp(),
    'members': memberIds, // Store only UIDs, not User objects
  });
  Get.toNamed(Routes.groupchat,arguments: memberIds);
}


  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final themeProv = Provider.of<ThemeProvider>(context);
    final localprovider = Provider.of<LocaleProvider>(context, listen: false);
    String lang = localprovider.localelang!.languageCode;
    return Scaffold(
      appBar: AppBar(
          centerTitle: false,
          backgroundColor: theme.colorScheme.surface,
          foregroundColor: themeProv.isDarkTheme! ? Colors.blue : Colors.blue,
          title: Text(
            lang == "ar" ? 'إنشاء مجموعة' : 'Create Group Chat',
            style: TextStyle(color: Colors.white),
          )),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              lang == "ar" ? 'اسم المجموعة' : 'Group Name',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            TextField(
              controller: groupNameController,
              decoration: InputDecoration(
                hintText:
                    lang == "ar" ? 'أدخل اسم المجموعة' : 'Enter Group Name',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                filled: true,
                fillColor: Colors.grey[200],
              ),
            ),
            SizedBox(height: 16),
            Text(
              lang == "ar" ? 'اختر الأعضاء' : 'Select Members',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Expanded(
              child: ListView.builder(
                itemCount: allUserIds.length,
                itemBuilder: (context, index) {
                  final user = allUserIds[index];
                  return Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    elevation: 2,
                    child: CheckboxListTile(
                      title: Text(user.firstName!,
                          style: TextStyle(fontSize: 16, color: Colors.white)),
                      value: selectedMembers.contains(user),
                      onChanged: (bool? selected) {
                        setState(() {
                          if (selected == true) {
                            selectedMembers.add(user);
                          } else {
                            selectedMembers.remove(user);
                          }
                        });
                      },
                      activeColor: Colors.blue,
                      checkColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                if (groupNameController.text.isNotEmpty &&
                    selectedMembers.isNotEmpty) {
                  createGroup(groupNameController.text, selectedMembers);
                  Navigator.pop(context);
                }
              },
              child: Text(
                lang == "ar" ? 'إنشاء المجموعة' : 'Create Group',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
