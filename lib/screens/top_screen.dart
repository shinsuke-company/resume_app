import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'search_screen.dart';
import 'package:resume_app/utils/size_config.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'test_inifinty.dart';

class TopScreen extends StatefulWidget {
  const TopScreen({super.key});

  @override
  State<TopScreen> createState() => _TopScreenState();
}

class _TopScreenState extends State<TopScreen> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(onPressed: () => {}, icon: const Icon(Icons.chat)),
          IconButton(onPressed: () => {}, icon: const Icon(Icons.notifications))
        ],
      ),
      body: Center(
        child: Column(
          children: [
            Carousel(),
            Text('Develop Language'),
            DevelopmentLanguageList(),
            Text('Reccomend Engineer'),
            RecommendEngineer(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.close),
        onPressed: () {
          Navigator.of(context).push(
            PageRouteBuilder(
                pageBuilder: (context, animation, secondaryAnimation) {
              return SearchScreen(searchValue: '');
            }, transitionsBuilder:
                    (context, animation, secondaryAnimation, child) {
              final Offset begin = Offset(0.0, 1.0);
              final Offset end = Offset.zero;
              final Animatable<Offset> tween = Tween(begin: begin, end: end)
                  .chain(CurveTween(curve: Curves.easeInOut));
              final Animation<Offset> offsetAnimation = animation.drive(tween);
              return SlideTransition(position: offsetAnimation, child: child);
            }),
          );
        },
      ),
    );
  }
}

class Carousel extends StatelessWidget {
  const Carousel({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
          height: SizeConfig.blockSizeVertical! * 20, autoPlay: true),
      items: [
        Card(
          child: Container(
            height: SizeConfig.blockSizeVertical! * 80,
            width: SizeConfig.blockSizeHorizontal! * 80,
            child: Image.asset('images/sauna2.jpg'),
          ),
        ),
        Card(
          child: Container(
            height: SizeConfig.blockSizeVertical! * 80,
            width: SizeConfig.blockSizeHorizontal! * 80,
            child: Image.asset('images/sauna1.jpg'),
          ),
        ),
        Card(
          child: Container(
            height: SizeConfig.blockSizeVertical! * 80,
            width: SizeConfig.blockSizeHorizontal! * 80,
            child: Image.asset('images/sauna3.jpg'),
          ),
        )
      ],
    );
  }
}

class DevelopmentLanguageList extends StatelessWidget {
  const DevelopmentLanguageList({super.key});

  @override
  Widget build(BuildContext context) {
    List devlist = [
      {'icon': FontAwesomeIcons.react, 'language': 'react'},
      {'icon': FontAwesomeIcons.vuejs, 'language': 'vuejs'},
      {'icon': FontAwesomeIcons.angular, 'language': 'angular'},
      {'icon': FontAwesomeIcons.js, 'language': 'js'},
      {'icon': FontAwesomeIcons.node, 'language': 'node'},
      {'icon': FontAwesomeIcons.java, 'language': 'java'},
      {'icon': FontAwesomeIcons.php, 'language': 'php'},
      {'icon': FontAwesomeIcons.python, 'language': 'python'},
      {'icon': FontAwesomeIcons.c, 'language': 'c'},
      {'icon': FontAwesomeIcons.rust, 'language': 'rust'},
      {'icon': FontAwesomeIcons.android, 'language': 'android'},
      {'icon': FontAwesomeIcons.apple, 'language': 'apple'},
      {'icon': FontAwesomeIcons.swift, 'language': 'swift'},
      {'icon': FontAwesomeIcons.unity, 'language': 'unity'},
      {'icon': FontAwesomeIcons.f, 'language': 'f'},
    ];

    return Container(
        height: SizeConfig.blockSizeVertical! * 29,
        // color: Colors.amber,
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 5, //カラム数
          ),
          itemCount: devlist.length,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return ElevatedButton.icon(
                style: ElevatedButton.styleFrom(elevation: 0),
                onPressed: () {
                  Navigator.of(context).push(
                    PageRouteBuilder(
                        pageBuilder: (context, animation, secondaryAnimation) {
                      return SearchScreen(
                          searchValue: devlist[index]['language']);
                    }, transitionsBuilder:
                            (context, animation, secondaryAnimation, child) {
                      final Offset begin = Offset(0.0, 1.0);
                      final Offset end = Offset.zero;
                      final Animatable<Offset> tween =
                          Tween(begin: begin, end: end)
                              .chain(CurveTween(curve: Curves.easeInOut));
                      final Animation<Offset> offsetAnimation =
                          animation.drive(tween);
                      return SlideTransition(
                          position: offsetAnimation, child: child);
                    }),
                  );
                },
                icon: Icon(devlist[index]['icon']),
                label: Text(''));
          },
        ));
  }
}

class RecommendEngineer extends StatefulWidget {
  const RecommendEngineer({super.key});

  @override
  State<RecommendEngineer> createState() => _RecommendEngineerState();
}

class _RecommendEngineerState extends State<RecommendEngineer> {
  final List<String> _contents = [];
  final int loadLength = 30;

  int _lastIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: SizeConfig.blockSizeVertical! * 28,
      color: Colors.amber,
    );
  }
}
