import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubit/cubit.dart';
import '../../cubit/states.dart';
import '../../football_model/lineups_model.dart';

class LineupTab extends StatelessWidget {
  const LineupTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FootballCubit,FootballStates>(
        listener:(context,state) {},
        builder: (context,state) {
          var cubit =FootballCubit.get(context);
          var lineupsTeamResponseList = FootballCubit.get(context).lineupsResponseList;
          if(cubit.lineupsResponseList.isNotEmpty) {
            return   Padding(
      padding: const EdgeInsets.symmetric(vertical: 15,horizontal: 5),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                  color: Color(0xff1D1D1D),
                  borderRadius: BorderRadius.circular(15)
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30,vertical: 20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                          'Coach',
                          style:Theme.of(context).textTheme.headline5!.copyWith(color: Colors.yellow)),
                    ),
                    SizedBox(height: 20,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Expanded(
                          child: Column(
                            children: [
                              CircleAvatar(
                                foregroundImage: NetworkImage(lineupsTeamResponseList[0].coach!.photo.toString()),
                                radius: 25,
                              ),
                              SizedBox(height: 10,),
                              Text(lineupsTeamResponseList[0].coach!.name.toString(),
                                  style:Theme.of(context).textTheme.subtitle1),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              CircleAvatar(
                                foregroundImage: NetworkImage(lineupsTeamResponseList[1].coach!.photo.toString()),
                                radius: 25,
                              ),
                              SizedBox(height: 10,),
                              Text(lineupsTeamResponseList[1].coach!.name.toString(),
                                  style:Theme.of(context).textTheme.subtitle1),
                            ],
                          ),
                        ),
                      ],)

                  ],
                ),
              ),
            ),

            //Start XI
            SizedBox(height: 10),
            Container(
              decoration: BoxDecoration(
                  color: Color(0xff1D1D1D),
                  borderRadius: BorderRadius.circular(15)
              ),
              child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30,vertical: 20),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                            'Start XI',
                            style:Theme.of(context).textTheme.headline5!.copyWith(color: Colors.yellow)),
                      ),
                      const SizedBox(height: 20,),
                      LimitedBox(
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            listOfMainPlayersTeam(lineupsTeamResponseList[0]),
                            SizedBox(width: 10,),
                            listOfMainPlayersTeam(lineupsTeamResponseList[1]),

                          ],
                        ),
                      ),
                    ],)



              ),
            ),
            //Bench XI
            SizedBox(height: 10),
            Container(
              decoration: BoxDecoration(
                  color: Color(0xff1D1D1D),
                  borderRadius: BorderRadius.circular(15)
              ),
              child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30,vertical: 20),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                            'Substitutions',
                            style:Theme.of(context).textTheme.headline5!.copyWith(color: Colors.yellow)),
                      ),
                      SizedBox(height: 20,),

                      LimitedBox(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            listOfBenchPlayersTeam(lineupsTeamResponseList[0]),
                            SizedBox(width: 10,),
                            listOfBenchPlayersTeam(lineupsTeamResponseList[1]),

                          ],
                        ),
                      ),
                    ],)



              ),
            ),
          ],
        ),
      ),
    );
          }else{
            return const Center(child: CircularProgressIndicator(),);
          }
  });}

  Flexible listOfMainPlayersTeam(LineupsResponseModel lineupsTeam1ResponseList) {
    return Flexible(
      flex: 1,
      child: ListView.separated(
        shrinkWrap: true,
        physics: BouncingScrollPhysics(),
        padding: EdgeInsets.zero,
        separatorBuilder:(context,index)=>SizedBox(height: 10) ,
        itemCount: lineupsTeam1ResponseList.startXI.length,
        itemBuilder: (context,index){
          return Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              Flexible(
                child: Text(
                    lineupsTeam1ResponseList.startXI[index].mainPlayer!.number.toString(),
                    style: Theme.of(context).textTheme.subtitle1
                ),
              ),
              SizedBox(width: 5,),
              Flexible(
                flex: 8,
                child: Text(lineupsTeam1ResponseList.startXI[index].mainPlayer!.name.toString(),
                    style: Theme.of(context).textTheme.subtitle1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Flexible listOfBenchPlayersTeam(LineupsResponseModel lineupsTeam1ResponseList) {
    return Flexible(
      flex: 1,
      child: ListView.separated(
        shrinkWrap: true,
        physics: BouncingScrollPhysics(),
        padding: EdgeInsets.zero,
        separatorBuilder:(context,index)=>SizedBox(height: 10) ,
        itemCount: lineupsTeam1ResponseList.substitutes.length,
        itemBuilder: (context,index){
          return Row(  mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [


              Flexible(
                child: Text(
                    lineupsTeam1ResponseList.substitutes[index].subPlayer!.number.toString(),
                    style: Theme.of(context).textTheme.subtitle1
                ),
              ),
              SizedBox(width: 5,),
              Flexible(
                flex: 8,
                child: Text(lineupsTeam1ResponseList.substitutes[index].subPlayer!.name.toString(),
                    style: Theme.of(context).textTheme.subtitle1,
                overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
