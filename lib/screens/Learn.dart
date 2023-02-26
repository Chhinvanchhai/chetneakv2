import 'package:flutter/material.dart';

class LearnScreen extends StatefulWidget {
  const LearnScreen({Key? key}) : super(key: key);

  @override
  State<LearnScreen> createState() => _LearnScreenState();
}

class _LearnScreenState extends State<LearnScreen> {
  List myList = ['Mountaint', "Sea", "History", "Museasme"];
  void selectCard() {}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Container(
                  height: 200, child: Image.asset("assets/images/user.png")),
              Text("The best of learning is to pratice"),
              SizedBox(
                height: 20,
              ),
              Material(
                elevation: 2,
                borderRadius: BorderRadius.circular(30),
                child: Container(
                  padding: EdgeInsets.all(4),
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(30)),
                  child: Row(
                    children: [
                      Expanded(
                        child: SizedBox(
                          height: 20,
                          child: TextFormField(
                            decoration: InputDecoration(
                                hintText: "Find Place",
                                enabledBorder: InputBorder.none,
                                contentPadding:
                                    EdgeInsets.symmetric(vertical: 30),
                                prefixIcon: Icon(Icons.search_off_outlined),
                                focusedBorder: InputBorder.none),
                          ),
                        ),
                      ),
                      const CircleAvatar(
                        radius: 12,
                        backgroundColor: Colors.redAccent,
                        child: Icon(Icons.place_outlined),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text("Category"),
              Container(
                height: 60,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: myList.map((e) => cardPlace(e)).toList(),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget cardPlace(name) {
    return Container(
      margin: EdgeInsets.all(4),
      child: Material(
        elevation: 4,
        borderRadius: BorderRadius.circular(30),
        child: Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
          ),
          child: Row(
            children: [
              CircleAvatar(
                child: Image.asset("assets/images/user.png"),
                radius: 24,
              ),
              Text(name)
            ],
          ),
        ),
      ),
    );
  }
}
