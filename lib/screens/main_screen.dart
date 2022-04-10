
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:football_scores_api/football_model/fixtures_model.dart';

import '../components/component.dart';
import '../cubit/cubit.dart';
import '../cubit/states.dart';
import 'fixture_details_screen.dart';
class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FootballCubit,FootballStates>(
        listener:(context,state) {},
        builder: (context,state){
          var cubit = FootballCubit.get(context);
          return SafeArea(
            child: Scaffold(
      backgroundColor: Color(0xff081b25),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 50),
        color: Colors.black87,
        child: ListView.separated(
              itemBuilder: (context ,index) => buildFixturesWidget(context ,cubit.fixturesResponseList[index],index),
              separatorBuilder: (context ,index)=> const SizedBox(height: 1),
              itemCount: cubit.fixturesResponseList.length
        ),
      ),
            ),
          );},
    );
  }

  InkWell buildFixturesWidget(BuildContext context,FixturesResponseModel fixturesResponseList,index) {
    var cubit = FootballCubit.get(context);
    return InkWell(
      onTap: (){
       // cubit.getAllLineups(
       //     fixtureId:  fixturesResponseList.fixture!.id!.toInt(),
       //     context:  context,
       //     index:  index
       //  );
       //  cubit.getAllH2H(
       //      fixturesResponseList.teams!.home!.id!.toInt(),
       //      fixturesResponseList.teams!.away!.id!.toInt(),
       //  );
        cubit.getAllEvents(fixtureId: fixturesResponseList.fixture!.id!.toInt(), context: context);
        navigateTo(route: FixtureDetailsScreen(index: index), context: context);
        print(cubit.lineupsResponseList.length.toString());
      },
      borderRadius: BorderRadius.circular(20),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
        child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              flex: 5,
                            child: Column(
                              children: [

                                CircleAvatar(
                                  foregroundImage: NetworkImage(fixturesResponseList.teams!.home!.logo.toString()),
                                  radius: 30,
                                ),
                                SizedBox(height: 15,),
                                Text(fixturesResponseList.teams!.home!.name.toString(),textAlign: TextAlign.center,maxLines: 1),
                              ],
                            ),
                          ),
                            SizedBox(width: 10,),
                            Expanded(
                                  flex: 5,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Flexible(child: Text(fixturesResponseList.goals!.homeGoals.toString(), style: Theme.of(context).textTheme.headline3,)),
                                      SizedBox(width: 10,),
                                      Flexible(child: Text(fixturesResponseList.fixture!.status!.short.toString(), style: Theme.of(context).textTheme.caption,)),
                                      SizedBox(width: 10,),
                                      Flexible(child: Text(fixturesResponseList.goals!.awayGoals.toString(), style: Theme.of(context).textTheme.headline3,)),
                                    ],
                                  ),
                                  Text(fixturesResponseList.fixture!.status!.long.toString(),style: Theme.of(context).textTheme.caption,),
                                  SizedBox(height: 10,),
                                  Text(
                                      fixturesResponseList.fixture!.status!.elapsed != null?
                                      fixturesResponseList.fixture!.status!.elapsed.toString():
                                      fixturesResponseList.fixture!.date!.toString().substring(11,16)

                                      ,style: Theme.of(context).textTheme.caption),
                                ],
                              ),
                            ),
                            SizedBox(width: 10,),
                            Expanded(
                              flex:5,
                              child: Column(
                                children: [

                                  CircleAvatar(
                                    foregroundImage: NetworkImage(fixturesResponseList.teams!.away!.logo.toString()),
                                    radius: 30,
                                  ),
                                  SizedBox(height: 15,),
                                  Text(fixturesResponseList.teams!.away!.name.toString(),textAlign: TextAlign.center,maxLines: 1),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
              ),
      ),
    );
  }
}
