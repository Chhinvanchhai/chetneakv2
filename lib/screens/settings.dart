import 'package:flutter/material.dart';
import 'widget/h2.dart';
import 'widget/language.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                H2(title: 'general'),
                SizedBox(
                  height: 5,
                ),
                Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.withOpacity(0.6)),
                      borderRadius: BorderRadius.circular(12)),
                  child: Column(
                    children: [
                      ChangeLanguage(),
                      Container(
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: Colors.grey.withOpacity(0.6),
                              width: 1,
                            ),
                          ),
                        ),
                        child: ListTile(
                          dense: true,
                          visualDensity: VisualDensity(vertical: 0),
                          title: Text('Lanugea'),
                          trailing: Icon(Icons.chevron_right),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: Colors.grey.withOpacity(0.6),
                              width: 1,
                            ),
                          ),
                        ),
                        child: ListTile(
                          dense: true,
                          visualDensity: VisualDensity(vertical: 0),
                          title: Text('Lanugea'),
                          trailing: Icon(Icons.chevron_right),
                        ),
                      ),
                      Container(
                        child: ListTile(
                          dense: true,
                          visualDensity: VisualDensity(vertical: 0),
                          title: Text('Lanugea'),
                          trailing: Icon(Icons.chevron_right),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                H2(title: 'privacy'),
                SizedBox(
                  height: 5,
                ),
                Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.withOpacity(0.6)),
                      borderRadius: BorderRadius.circular(12)),
                  child: Column(
                    children: [
                      ChangeLanguage(),
                      Container(
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: Colors.grey.withOpacity(0.6),
                              width: 1,
                            ),
                          ),
                        ),
                        child: ListTile(
                          dense: true,
                          visualDensity: VisualDensity(vertical: 0),
                          title: Text('Lanugea'),
                          trailing: Icon(Icons.chevron_right),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: Colors.grey.withOpacity(0.6),
                              width: 1,
                            ),
                          ),
                        ),
                        child: ListTile(
                          dense: true,
                          visualDensity: VisualDensity(vertical: 0),
                          title: Text('Lanugea'),
                          trailing: Icon(Icons.chevron_right),
                        ),
                      ),
                      Container(
                        child: ListTile(
                          dense: true,
                          visualDensity: VisualDensity(vertical: 0),
                          title: Text('Lanugea'),
                          trailing: Icon(Icons.chevron_right),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
