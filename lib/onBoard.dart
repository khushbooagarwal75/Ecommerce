import 'package:dots_indicator/dots_indicator.dart';
import 'package:ecommerce_app/login.dart';
import 'package:ecommerce_app/onboardScreens/Screen2.dart';
import 'package:ecommerce_app/onboardScreens/Screen3.dart';
import 'package:ecommerce_app/onboardScreens/screen1.dart';
import 'package:flutter/material.dart';

class Onboard extends StatefulWidget {
  Onboard({super.key});

  @override
  State<Onboard> createState() => _OnboardState();
}

class _OnboardState extends State<Onboard> {
  final PageController _controller = PageController();

  double _currentPageIndex = 0.0;

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      setState(() {
        _currentPageIndex = _controller.page ?? 0.0;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 0),
        child: Column(
          children: [
            Expanded(
              flex: 1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  RichText(
                      text: TextSpan(
                          children: [
                            TextSpan(text: (_currentPageIndex+1).toInt().toString(),
                                style:TextStyle(
                                    fontSize: 18,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold
                                ) ),
                            TextSpan(text: "/3",
                                style:TextStyle(
                                    fontSize: 18,
                                    color: Colors.grey,
                                    fontWeight: FontWeight.bold
                                ) ),
                          ]
                      )
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(
                          context, MaterialPageRoute(
                        builder: (context) {
                          return Login();
                        },));
                    },
                    child: const Text("Skip",style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.bold
                    ),),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 8,
              child: PageView(
                controller: _controller,
                children: const [
                  Screen1(),
                  Screen2(),
                  Screen3(),
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _currentPageIndex!=0?
                  TextButton(
                    onPressed: () {
                      if (_currentPageIndex > 0) {
                        _controller.previousPage(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                        );
                      }
                    },
                    child: const Text(
                      "Prev",
                      style: TextStyle(
                          color: Colors.grey,
                          fontSize: 18
                      ),),
                  ):SizedBox(),
                  DotsIndicator(
                    dotsCount: 3,
                    position: _currentPageIndex.toInt(),
                    decorator: DotsDecorator(
                      size: const Size.square(9.0),
                      activeSize: const Size(50.0, 10.0),
                      activeColor: Colors.black,
                      activeShape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                    ),
                  ),
                  _currentPageIndex!=2?
                  TextButton(
                    onPressed: () {
                      if (_currentPageIndex < 2) {
                        _controller.nextPage(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                        );
                      } else {
                        // Navigate to the next screen or perform an action
                      }
                    },
                    child: const Text("Next",style: TextStyle(
                        color: Colors.red,
                        fontSize: 18
                    ),),
                  ):
                  TextButton(
                    onPressed: () {
                      if (_currentPageIndex < 2) {
                        _controller.nextPage(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                        );
                      } else {
                        Navigator.pushReplacement(context, MaterialPageRoute(
                          builder: (context) {
                            return Login();
                          },
                        ));
                        // Navigate to the next screen or perform an action
                      }
                    },
                    child: const Text("Get Started",style: TextStyle(
                        color: Colors.red,
                        fontSize: 18
                    ),),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
