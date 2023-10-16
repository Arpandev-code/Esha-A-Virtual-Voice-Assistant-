import 'package:flutter/material.dart';

class About extends StatelessWidget {
  const About({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'About Dev',
          style: TextStyle(fontFamily: 'Cera Pro'),
        ),
      ),
      body: Column(children: [
        Container(
          height: MediaQuery.of(context).size.height * 0.3,
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(
                    'assets/images/devbg.jpg',
                  ),
                  fit: BoxFit.fill)),
          child: const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: CircleAvatar(
                  radius: 50,
                  backgroundImage: AssetImage('assets/images/devpic.jpg'),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'Arpandev Bhattacharya',
                style: TextStyle(
                    fontFamily: 'Cera Pro', fontSize: 18, color: Colors.white),
              ),
              Text(
                'B.Tech, CSE',
                style: TextStyle(
                    fontFamily: 'Cera Pro', fontSize: 10, color: Colors.white),
              )
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 5),
          margin: const EdgeInsets.symmetric(horizontal: 10).copyWith(top: 30),
          decoration: BoxDecoration(
              border: Border.all(
                color: Colors.blueGrey,
              ),
              borderRadius: BorderRadius.circular(20)),
          child: const Padding(
            padding: EdgeInsets.symmetric(vertical: 9, horizontal: 0),
            child: Text(
              "Hello I'm Arpandev Bhattacharaya, a B.Tech student and aspiring Flutter Developer. I have a passion for developing mobile applications using the Flutter framework, and I am constantly learning and expanding my knowledge in this field",
              style: TextStyle(color: Colors.black, fontSize: 17),
            ),
          ),
        ),
      ]),
    );
  }
}
