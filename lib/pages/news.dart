import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class NewsPage extends StatelessWidget {
  const NewsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Hot TechNews',
            style: TextStyle(fontFamily: 'Cera Pro'),
          ),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset('assets/images/working.json', height: 300, width: 300),
            const Center(
              child: Text('Page Under Developement',
                  style: TextStyle(
                    fontFamily: 'Cera Pro',
                    fontSize: 18,
                  )),
            )
          ],
        ));
  }
}
