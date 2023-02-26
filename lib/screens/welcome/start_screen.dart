import 'package:flutter/material.dart';
import 'package:get/get.dart';
class Started extends StatefulWidget {
  const Started({Key? key}) : super(key: key);

  @override
  State<Started> createState() => _StartedState();
}

class _StartedState extends State<Started> {
  List imageList = [
    'welcome-one.png',
    'welcome-two.png',
    'welcome-three.png'
  ];
  List listText = [
    'mountain'.tr,
    'sea'.tr,
    'history'.tr
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView.builder(
          itemCount: imageList.length,
          scrollDirection: Axis.vertical,
          itemBuilder: (context, index) {
            print('assets/images/${imageList[index]}');
            return Container(
              height: double.maxFinite,
              width: double.maxFinite,
              decoration: BoxDecoration(
               image: DecorationImage(
                 image: AssetImage(
                   'assets/images/${imageList[index]}'
                 ),
                 fit: BoxFit.fill
               )
              ),
              child: Container(
                padding: EdgeInsets.fromLTRB(18, 150, 18, 18),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Trips', style: TextStyle(fontWeight: FontWeight.w900, fontSize: 40),),
                        Text(listText[index], style: TextStyle(fontWeight: FontWeight.w500, fontSize: 30),),
                        Container(
                          margin: EdgeInsets.symmetric(vertical: 20),
                          width: 250,
                          child: Text('Free your life by desire what you want for you life', style: TextStyle(fontWeight: FontWeight.w400, fontSize: 18),) ,
                        ),
                        SizedBox(height: 20,),
                        InkWell(
                          onTap: () => Get.toNamed('/login'),
                          child: Container(
                            width: 50,
                            height: 30,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10)
                            ),
                            child: Image.asset('assets/images/button-one.png'),
                          ),
                        )

                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: List.generate(3, (dotIndex) => Container(
                      width: 10,
                      margin: EdgeInsets.only(top: 2),
                      height: index == dotIndex ? 30  :  15,
                      decoration: BoxDecoration(
                        color: index == dotIndex ?   Colors.green :  Colors.grey,
                        borderRadius: BorderRadius.circular(6)
                      ),
                    )),)
                  ],
                ),
              ),
            );
          }),
    );
  }
}
