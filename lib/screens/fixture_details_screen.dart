import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:football_scores_api/screens/match_details_tabs/h2h_tab.dart';
import 'package:football_scores_api/screens/match_details_tabs/lineups_tab.dart';
import '../cubit/cubit.dart';
import '../cubit/states.dart';
import 'match_details_tabs/events_tab.dart';

class FixtureDetailsScreen extends StatefulWidget {
   const FixtureDetailsScreen({Key? key,required this.index}) : super(key: key);
 final int? index;

  @override
  State<FixtureDetailsScreen> createState() => _FixtureDetailsScreenState();
}

class _FixtureDetailsScreenState extends State<FixtureDetailsScreen> with TickerProviderStateMixin {
 TabController? tabController;
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    tabController = TabController(length: 3, vsync: this);
  }
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FootballCubit,FootballStates>(
        listener:(context,state) {},
    builder: (context,state) {
      var cubit = FootballCubit.get(context);
      var fixturesResponseList = FootballCubit.get(context).fixturesResponseList[widget.index!];
      var homeGoals =fixturesResponseList.goals!.homeGoals.toString();
      var awayGoals =fixturesResponseList.goals!.awayGoals.toString();
      var elapsed =fixturesResponseList.fixture!.status!.elapsed.toString();
      if(homeGoals == 'null') homeGoals = '-';
      if(awayGoals == 'null') awayGoals = '-';
      if(elapsed == 'null') elapsed = '0';

      return SafeArea(
        child: Scaffold(
          extendBodyBehindAppBar: true,
          backgroundColor: Color(0xff081b25),

          body: NestedScrollView(
            floatHeaderSlivers: true,
            headerSliverBuilder: (context,innerBoxIsScrolled){
              return <Widget>[
                SliverAppBar(
                  expandedHeight:200,
                  floating: true,
                  snap: true,
                  pinned: true,
                  backgroundColor: Color(0xff141414),
                  flexibleSpace: FlexibleSpaceBar(
                         centerTitle: true,background:  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30,vertical: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          flex: 5,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [

                              CircleAvatar(
                                foregroundImage: NetworkImage(fixturesResponseList.teams!.home!.logo.toString()),
                                radius: 30,
                              ),
                              SizedBox(height: 15,),
                              Text(fixturesResponseList.teams!.home!.name.toString(),textAlign: TextAlign.center,),
                              SizedBox(height: 2.5,),
                              if(cubit.lineupsResponseList.isNotEmpty )
                              Text(cubit.lineupsResponseList[0].formation.toString(),
                                  style:Theme.of(context).textTheme.caption),
                            ],
                          ),
                        ),
                        SizedBox(width: 10,),
                        Expanded(
                          flex: 5,
                          child: Column(  mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Flexible(child: Text(homeGoals, style: Theme.of(context).textTheme.headline3,)),
                                  SizedBox(width: 10,),
                                  Flexible(child: Text(fixturesResponseList.fixture!.status!.short.toString(), style: Theme.of(context).textTheme.caption,)),
                                  SizedBox(width: 10,),
                                  Flexible(child: Text(awayGoals, style: Theme.of(context).textTheme.headline3,)),
                                ],
                              ),
                              Text(fixturesResponseList.fixture!.status!.long.toString(),style: Theme.of(context).textTheme.caption,),
                              SizedBox(height: 10,),
                              Text(elapsed+'m',style: Theme.of(context).textTheme.caption),
                            ],
                          ),
                        ),
                        SizedBox(width: 10,),
                        Expanded(
                          flex:5,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              CircleAvatar(
                                foregroundImage: NetworkImage(fixturesResponseList.teams!.away!.logo.toString()),
                                radius: 30,
                              ),
                              const SizedBox(height: 15,),
                              Text(fixturesResponseList.teams!.away!.name.toString(),textAlign: TextAlign.center),
                              const SizedBox(height: 2.5,),
                              if(cubit.lineupsResponseList.isNotEmpty )
                              Text(cubit.lineupsResponseList[1].formation.toString(),
                                  style:Theme.of(context).textTheme.caption),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                       ),
                  bottom: TabBar(
                      controller: tabController,
                      tabs: const [
                        Tab(
                        child:Text('Lineup'),
                        ),
                        Tab(
                          child:Text('H2H'),
                        ),
                        Tab(
                          child:Text('Events'),
                        ),
                  ]),
                )
              ];
            } ,
            body: Container(
              color: Colors.black,
              child: TabBarView(
                controller: tabController,
                  children:  [
                    const LineupTab(),
                    const H2HTab(),
                    EventsTab(fixturesIndex: widget.index!),

                  ]),
            ),
          ),
        ),
      );
    });}


}
