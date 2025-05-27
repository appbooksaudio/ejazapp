import 'package:ejazapp/helpers/routes.dart';
import 'package:ejazapp/providers/locale_provider.dart';
import 'package:ejazapp/providers/theme_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class CreateGroupScreen extends StatefulWidget {
  @override
  _CreateGroupScreenState createState() => _CreateGroupScreenState();
}

class _CreateGroupScreenState extends State<CreateGroupScreen> {
  final TextEditingController groupNameController = TextEditingController();
  final TextEditingController searchController = TextEditingController();
  final Set<types.User> selectedMembers = {};
  List<types.User> allUsers = [];
  List<types.User> filteredUsers = [];

  @override
  void initState() {
    super.initState();
    allUsers = Get.arguments;
    filteredUsers = allUsers;
    searchController.addListener(_filterUsers);
  }

  void _filterUsers() {
    final query = searchController.text.toLowerCase();
    setState(() {
      filteredUsers = allUsers.where((user) {
        final name = user.firstName?.toLowerCase() ?? '';
        return name.contains(query);
      }).toList();
    });
  }

  Future<void> createGroup(String groupName, List<types.User> members) async {
    List<String> memberIds = members.map((user) => user.id).toList();

    await FirebaseFirestore.instance.collection('groups').add({
      'name': groupName,
      'createdAt': FieldValue.serverTimestamp(),
      'members': memberIds,
    });

    Get.toNamed(Routes.groupchat, arguments: memberIds);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final themeProv = Provider.of<ThemeProvider>(context);
    final localProvider = Provider.of<LocaleProvider>(context, listen: false);
    final String lang = localProvider.localelang?.languageCode ?? "en";

    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          color: themeProv.isDarkTheme! ? Colors.white : Colors.black,
          onPressed: () => Get.back<dynamic>(),
        ),
        // backgroundColor: theme.colorScheme.primary,
        title: Text(
          lang == "ar" ? 'إنشاء مجموعة' : 'Create Group Chat',
          style: TextStyle(
              color: themeProv.isDarkTheme! ? Colors.white : Colors.black),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _sectionTitle(lang == "ar" ? 'اسم المجموعة' : 'Group Name'),
            _spacer(8),
            _textField(
              controller: groupNameController,
              hintText: lang == "ar" ? 'أدخل اسم المجموعة' : 'Enter Group Name',
            ),
            _spacer(16),
            _sectionTitle(lang == "ar" ? 'ابحث عن الأعضاء' : 'Search Members'),
            _spacer(8),
            _textField(
              controller: searchController,
              hintText: lang == "ar" ? 'ابحث بالاسم' : 'Search by name',
              prefixIcon: Icon(Icons.search),
            ),
            _spacer(16),
            _sectionTitle(lang == "ar" ? 'اختر الأعضاء' : 'Select Members'),
            _spacer(8),
            Expanded(
              child: filteredUsers.isEmpty
                  ? Center(
                      child: Text(
                          lang == "ar" ? 'لا يوجد أعضاء' : 'No members found'))
                  : ListView.builder(
                      itemCount: filteredUsers.length,
                      itemBuilder: (context, index) {
                        final user = filteredUsers[index];
                        final themeProv = Provider.of<ThemeProvider>(context);
                        return Card(
                          color: theme.cardColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          elevation: 2,
                          child: CheckboxListTile(
                            title: Text(
                              user.firstName ?? '',
                              style: TextStyle(
                                fontSize: 16,
                                color: themeProv.isDarkTheme!
                                    ? Colors.white
                                    : Colors.black,
                              ),
                            ),
                            value: selectedMembers.contains(user),
                            checkColor: Colors.white, // Checkmark color
                            side: BorderSide(
                              color: const Color.fromARGB(
                                  255, 244, 245, 246), // <-- Border color here
                              width: 2,
                            ),
                            onChanged: (selected) {
                              setState(() {
                                if (selected == true) {
                                  selectedMembers.add(user);
                                } else {
                                  selectedMembers.remove(user);
                                }
                              });
                            },
                            activeColor: theme.colorScheme.primary,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                          ),
                        );
                      },
                    ),
            ),
            _spacer(16),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: GestureDetector(
                onTap: () {
                  if (groupNameController.text.isNotEmpty &&
                      selectedMembers.isNotEmpty) {
                    createGroup(
                        groupNameController.text, selectedMembers.toList());
                    Navigator.pop(context);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        behavior: SnackBarBehavior.floating,
                        backgroundColor: Colors.blue.shade600,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 6,
                        margin: EdgeInsets.all(16),
                        content: Row(
                          children: [
                            Icon(Icons.warning_amber_rounded,
                                color: Colors.white),
                            SizedBox(width: 12),
                            Expanded(
                              child: Text(
                                lang == "ar"
                                    ? "يرجى ملء اسم المجموعة واختيار الأعضاء"
                                    : "Please enter a group name and select members",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 15,
                                ),
                              ),
                            ),
                          ],
                        ),
                        duration: Duration(seconds: 3),
                      ),
                    );
                  }
                },
                child: Container(
                  width: double.infinity,
                  height: 50,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Color(0xFF0088CE), Color(0xFF0088CE)],
                    ),
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 5,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Center(
                      child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        lang == "ar" ? 'إنشاء المجموعة' : 'Create Group',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  )),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _sectionTitle(String text) {
    return Text(
      text,
      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
    );
  }

  Widget _textField({
    required TextEditingController controller,
    String? hintText,
    Icon? prefixIcon,
    Color textColor = Colors.black,
    Color hintColor = Colors.grey,
  }) {
    return TextField(
      controller: controller,
      style: TextStyle(
        color: textColor, // <-- Text color
      ),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(
          color: hintColor, // <-- Hint text color
        ),
        prefixIcon: prefixIcon,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        filled: true,
        fillColor: Colors.grey[200],
      ),
    );
  }

  SizedBox _spacer(double height) => SizedBox(height: height);
}
