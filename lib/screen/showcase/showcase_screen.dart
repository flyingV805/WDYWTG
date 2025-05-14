import 'package:flutter/material.dart';

import '../../uiKit/whereToText/where_to_text.dart';

class ShowcaseScreen extends StatefulWidget {

  const ShowcaseScreen({super.key});

  @override
  State<StatefulWidget> createState() => _ShowcaseScreenState();

}

final class _ShowcaseScreenState extends State<ShowcaseScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Where to?'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: (){},
            icon: Icon(Icons.settings)
          )
        ]
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(child: WhereToText()),
          SliverToBoxAdapter(child: SizedBox(height: 8)),

        ]
      ),
    );
  }

}