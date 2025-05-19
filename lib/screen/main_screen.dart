import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:wdywtg/screen/showcase/showcase_screen.dart';

import '../core/log/loger.dart';
import '../features/featureFind/find_place.dart';
import '../features/featureList/places_list.dart';
import '../features/featureUpdater/info_updater.dart';
import '../features/featureUserLocation/user_location.dart';
import '../features/featureUserLocation/user_location_notifier.dart';
import '../uiKit/whereToText/where_to_text.dart';

class MainScreen extends StatefulWidget {

  const MainScreen({super.key});

  @override
  State<StatefulWidget> createState() => _MainScreenState();

}

class _MainScreenState extends State<MainScreen> {

  final _ulStateNotifier = GetIt.I.get<UserLocationFeatureState>();
  final _scrollController = ScrollController();
  late final AppLifecycleListener _appStateListener;
  bool _displayShowcase = false;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((duration){
      GetIt.I.get<InfoUpdater>().startUpdater(context);
    });

    _appStateListener = AppLifecycleListener(
      onResume: (){
        GetIt.I.get<InfoUpdater>().appResumed(context);
      }
    );

    super.initState();
  }

  @override
  void dispose() {
    _appStateListener.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Where to?'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: (){
              _scrollController.jumpTo(0);
              setState(() { _displayShowcase = true; });
            },
            icon: Icon(Icons.help)
          ),
          PopupMenuButton(
            icon: Icon(Icons.settings),
            onSelected: (item){
              switch(item){
                case 'ul_action':
                  _ulStateNotifier.flipState();
                  break;
              }
            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
              PopupMenuItem(
                value: 'ul_action',
                child: Row(
                  children: [
                    Icon(_ulStateNotifier.featureEnabled ? Icons.location_disabled : Icons.my_location ),
                    SizedBox(width: 16),
                    Text(_ulStateNotifier.featureEnabled ? 'Disable My Location' : 'Enable My Location')
                  ],
                )
              ),
            ],
          )
        ],
      ),
      body: Stack(
        children: [
          CustomScrollView(
            controller: _scrollController,
            slivers: [
              SliverToBoxAdapter(child: UserLocation()),
              SliverToBoxAdapter(child: WhereToText()),
              SliverToBoxAdapter(child: SizedBox(height: 8)),
              SliverToBoxAdapter(child: FindPlace()),
              PlacesList()
            ],
          ),
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 350),
            child: _displayShowcase ? ShowcaseScreen(
              key: ValueKey('showcase_wrapper'),
              ulEnabled: _ulStateNotifier.featureEnabled,
              onFinished: (){
                Log().i('Showcase finished');
                setState(() { _displayShowcase = false; });
              },
            ): SizedBox.shrink(key: ValueKey('showcase_placeholder')),
          )
        ],
      ),
    );
  }

}