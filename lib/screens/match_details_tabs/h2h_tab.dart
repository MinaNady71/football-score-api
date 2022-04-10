import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:football_scores_api/components/component.dart';
import 'package:football_scores_api/football_model/head_to_head_model.dart';
import '../../cubit/cubit.dart';
import '../../cubit/states.dart';

class H2HTab extends StatelessWidget {
  const H2HTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FootballCubit,FootballStates>(
        listener:(context,state) {},
        builder: (context,state) {
          var cubit = FootballCubit.get(context);
          if(cubit.h2hResponseList.isNotEmpty) {
            return   SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  LimitedBox(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 15,horizontal: 5),
                      child: Container(
                        decoration: BoxDecoration(
                            color: Color(0xff1D1D1D),
                            borderRadius: BorderRadius.circular(15)
                        ),
                        child: Column(
                          children: [
                            ListView.separated(
                              shrinkWrap: true,
                                padding:const EdgeInsets.only(
                                    right:30,left:30,bottom: 0,top: 20
                                ) ,
                             physics: const NeverScrollableScrollPhysics(),
                                itemBuilder: (context ,index) => h2hPreviousMatchesTeam(context ,cubit.h2hResponseList[index],index),
                                separatorBuilder: (context ,index)=> Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 10,),
                                  child: defaultDivider(color: Colors.grey[800]),
                                ),
                                itemCount:cubit.showMoreH2HPreviousMatch? cubit.h2hResponseList.length:cubit.h2hResponseList.length >=2?2:1
                            ),
                            SizedBox(width: double.infinity,child: defaultTextButton(
                                label:cubit.showMoreH2HPreviousMatch? 'View Less':'View More',
                                onPressed: (){
                                  cubit.toggleToShowMoreH2HPreviousMatch();
                            }))
                          ],
                        ),
                      ),
                    ),
                  ),

                ],
              ),
            );
          }else{
            return const Center(child: CircularProgressIndicator(),);
          }
        });}

  Column h2hPreviousMatchesTeam(context ,H2HResponseModel h2hResponseList,index) {
    return Column(
      children: [
        const SizedBox(height: 5,),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
       Text(h2hResponseList.fixture!.date!.toString().substring(0,10),style: Theme.of(context).textTheme.caption,),
       Text(h2hResponseList.fixture!.referee.toString(),style: Theme.of(context).textTheme.caption,),
          ],
        ),
        const SizedBox(height: 5,),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(flex: 12,
                child: Text(h2hResponseList.teams!.home!.name.toString(),overflow: TextOverflow.ellipsis,textAlign:TextAlign.right,)),
            const SizedBox(width: 10,),
            Expanded(flex: 3,
              child: CircleAvatar(
                foregroundImage: NetworkImage(h2hResponseList.teams!.home!.logo.toString()),
                radius: 25,
              ),
            ),
                  SizedBox(width: 10,),
            Expanded(flex: 1,
                child: Text(h2hResponseList.goals!.homeGoals.toString(),overflow: TextOverflow.ellipsis,textAlign:TextAlign.center)),
            SizedBox(width: 5,),
            const Text('-',
                textAlign:TextAlign.center),
            SizedBox(width: 5,),
            Expanded(flex: 1,
                child: Text(h2hResponseList.goals!.awayGoals.toString(),overflow: TextOverflow.ellipsis,textAlign:TextAlign.center)),
            SizedBox(width: 10,),
               //away
            Expanded(flex: 3,
              child: CircleAvatar(
                foregroundImage: NetworkImage(h2hResponseList.teams!.away!.logo.toString()),
                radius: 25,
              ),
            ),
            const SizedBox(width: 10,),
            Expanded(flex: 12,
                child: Text(h2hResponseList.teams!.away!.name.toString(),overflow: TextOverflow.ellipsis,textAlign:TextAlign.left)),
          ],
        ),
      ],
    );

  }

}
