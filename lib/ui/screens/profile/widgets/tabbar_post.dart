import 'package:flutter/material.dart';

class TabBar_Post extends StatefulWidget {
  const TabBar_Post({super.key});

  @override
  State<TabBar_Post> createState() => _TabBar_PostState();
}

class _TabBar_PostState extends State<TabBar_Post> {
  bool showContaner = true;
  @override
  Widget build(BuildContext context) {
    return showContaner
        ? Scaffold(
            body: GridView.count(
              crossAxisCount: 2,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: SafeArea(
                    child: Container(
                      decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/images/avt.jpg'),
                          ),
                          // color: Colors.red,
                          borderRadius: BorderRadius.circular(10)),
                      width: double.infinity,
                      height: MediaQuery.of(context).size.height * 0.5,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          IconButton(
                            onPressed: () {
                              print('Xoá ');
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: Text('Xoá'),
                                      actions: [
                                        ElevatedButton(
                                          child: Text('Xoá'),
                                          onPressed: () {
                                            setState(() {
                                              showContaner = false;
                                            });
                                            Navigator.of(context).pop();
                                          },
                                        )
                                      ],
                                    );
                                  });
                            },
                            icon: Icon(Icons.more_vert),
                            color: Colors.white,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        : Container();
  }
}
