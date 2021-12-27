// import 'package:flutter/material.dart';
// import 'package:shop_app/modules/shop%20login/shop_login.dart';
// import 'package:shop_app/shared/components/components.dart';
// import 'package:shop_app/shared/network/local/cache_helper.dart';
// import 'package:smooth_page_indicator/smooth_page_indicator.dart';

// class BoardingModel {
//   final String title;
//   final String body;
//   final String image;

//   BoardingModel({required this.body, required this.title, required this.image});
// }

// class OnBoardingScreen extends StatelessWidget {
//   var boardController = PageController();
//   List<BoardingModel> boarding = [
//     BoardingModel(
//         body: 'On Board Body 1',
//         title: 'On Board Title 1',
//         image: 'assets/images/onboard_1.jpg'),
//     BoardingModel(
//         body: 'On Board Body 2',
//         title: 'On Board Title 2',
//         image: 'assets/images/onboard_1.jpg'),
//     BoardingModel(
//         body: 'On Board Body 3',
//         title: 'On Board Title 3',
//         image: 'assets/images/onboard_1.jpg'),
//   ];

//   bool isLast = false;

//   get context => null;

//   void submit() {
//     CacheHelper.saveData(
//       key: 'onBoarding',
//       value: true,
//     ).then((value) {
//       navigateTo(
//         context,
//         ShopLoginScreen(),
//       );
//     });
//   }

//   override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         elevation: 0,
//         actions: [
//           defaultTextButton(function: submit, text: 'skip'),
//         ],
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(20.0),
//         child: Column(
//           children: [
//             Expanded(
//               child: PageView.builder(
//                 controller: boardController,
//                 physics: const BouncingScrollPhysics(),
//                 itemBuilder: (context, index) => buildBoarding(boarding[index]),
//                 itemCount: boarding.length,
//                 onPageChanged: (int index) {
//                   if (index == boarding.length - 1) {
//                     isLast = true;
//                   } else {
//                     isLast = false;
//                   }
//                 },
//               ),
//             ),
//             const SizedBox(
//               height: 40,
//             ),
//             Row(
//               children: [
//                 SmoothPageIndicator(
//                   controller: boardController,
//                   count: boarding.length,
//                   effect: const ExpandingDotsEffect(
//                       dotColor: Colors.grey,
//                       dotHeight: 10,
//                       expansionFactor: 4,
//                       dotWidth: 10,
//                       spacing: 5),
//                 ),
//                 const Spacer(),
//                 FloatingActionButton(
//                     onPressed: () {
//                       if (isLast) {
//                         submit();
//                       } else {
//                         boardController.nextPage(
//                             duration: const Duration(milliseconds: 750),
//                             curve: Curves.fastLinearToSlowEaseIn);
//                       }
//                     },
//                     child: const Icon(
//                       Icons.arrow_forward_ios,
//                       color: Colors.white,
//                     )),
//               ],
//             )
//           ],
//         ),
//       ),
//     );
//   }

//   Widget buildBoarding(BoardingModel model) => Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Expanded(
//             child: Image(image: AssetImage('${model.image}')),
//           ),
//           const SizedBox(
//             height: 40,
//           ),
//           Text(
//             '${model.title}',
//             style: const TextStyle(color: Colors.black, fontSize: 25),
//           ),
//           const SizedBox(
//             height: 20,
//           ),
//           Text(
//             '${model.body}',
//             style: const TextStyle(color: Colors.black, fontSize: 20),
//           ),
//         ],
//       );
// }
import 'package:flutter/material.dart';
import 'package:shop_app/modules/shop%20login/shop_login.dart';
import 'package:shop_app/shared/colors.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class BoardingModel {
  final String image;
  final String title;
  final String body;

  BoardingModel({
    required this.title,
    required this.image,
    required this.body,
  });
}

class OnBoardingScreen extends StatefulWidget {
  @override
  createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  var boardController = PageController();

  List<BoardingModel> boarding = [
    BoardingModel(
      image: 'assets/images/onboard_1.jpg',
      title: 'On Board 1 Title',
      body: 'On Board 1 Body',
    ),
    BoardingModel(
      image: 'assets/images/onboard_1.jpg',
      title: 'On Board 2 Title',
      body: 'On Board 2 Body',
    ),
    BoardingModel(
      image: 'assets/images/onboard_1.jpg',
      title: 'On Board 3 Title',
      body: 'On Board 3 Body',
    ),
  ];

  bool isLast = false;

  void submit() {
    CacheHelper.saveData(
      key: 'onBoarding',
      value: true,
    ).then((value) {
      if (value) {
        navigateAndFinish(
          context,
          ShopLoginScreen(),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          defaultTextButton(
            function: submit,
            text: 'skip',
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                physics: const BouncingScrollPhysics(),
                controller: boardController,
                onPageChanged: (int index) {
                  if (index == boarding.length - 1) {
                    setState(() {
                      isLast = true;
                    });
                  } else {
                    setState(() {
                      isLast = false;
                    });
                  }
                },
                itemBuilder: (context, index) =>
                    buildBoardingItem(boarding[index]),
                itemCount: boarding.length,
              ),
            ),
            const SizedBox(
              height: 40.0,
            ),
            Row(
              children: [
                SmoothPageIndicator(
                  controller: boardController,
                  effect: const ExpandingDotsEffect(
                    dotColor: Colors.grey,
                    activeDotColor: defaultcolor,
                    dotHeight: 10,
                    expansionFactor: 4,
                    dotWidth: 10,
                    spacing: 5.0,
                  ),
                  count: boarding.length,
                ),
                const Spacer(),
                FloatingActionButton(
                  onPressed: () {
                    if (isLast) {
                      submit();
                    } else {
                      boardController.nextPage(
                        duration: const Duration(
                          milliseconds: 750,
                        ),
                        curve: Curves.fastLinearToSlowEaseIn,
                      );
                    }
                  },
                  child: const Icon(
                    Icons.arrow_forward_ios,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildBoardingItem(BoardingModel model) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Image(
              image: AssetImage('${model.image}'),
            ),
          ),
          const SizedBox(
            height: 30.0,
          ),
          const SizedBox(
            height: 15.0,
          ),
          Text(
            '${model.title}',
            style: const TextStyle(
              fontSize: 24.0,
            ),
          ),
          Text(
            '${model.body}',
            style: const TextStyle(
              fontSize: 14.0,
            ),
          ),
          const SizedBox(
            height: 30.0,
          ),
        ],
      );
}
