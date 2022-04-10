import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:football_scores_api/components/component.dart';
import 'package:football_scores_api/football_model/events_model.dart';
import 'package:football_scores_api/football_model/head_to_head_model.dart';

import '../../cubit/cubit.dart';
import '../../cubit/states.dart';
import '../../football_model/lineups_model.dart';

class EventsTab extends StatelessWidget {
   EventsTab({Key? key , required this.fixturesIndex}) : super(key: key);
final  int fixturesIndex;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FootballCubit,FootballStates>(
        listener:(context,state) {},
        builder: (context,state) {
          var cubit = FootballCubit.get(context);
          if(cubit.eventsResponseList.isNotEmpty) {
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
                                padding:const EdgeInsets.symmetric(
                                    horizontal: 30,vertical: 20
                                ) ,
                             physics: const NeverScrollableScrollPhysics(),
                                itemBuilder: (context ,index) {
                                if(cubit.fixturesResponseList[fixturesIndex].teams!.home!.id ==cubit.eventsResponseList[index].team!.id ) {
                                  return   eventsMatchTeam1(context ,cubit.eventsResponseList[index],index);
                                }else{
                                  return eventsMatchTeam2(context ,cubit.eventsResponseList[index],index);
                                }
                                },


                                separatorBuilder: (context ,index)=> SizedBox(height: 20,),
                                itemCount:cubit.eventsResponseList.length
                            ),
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

  Row eventsMatchTeam1(context ,EventsResponseModel eventsResponseList,index) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          eventsResponseList.time!.elapsed.toString(),
          style: Theme.of(context).textTheme.subtitle1,
        ),
        SizedBox(width: 15,),
        if(eventsResponseList.type == 'Goal')
          Row(
            children: [
              const Image(
                image: AssetImage('assets/images/football.png'),
                height: 25,
                width: 25,
              ),
              SizedBox(width: 10,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [


                  Text(
                    eventsResponseList.player!.name.toString(),
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                  if(eventsResponseList.assist!.name.toString() !='')
                    Row(
                      children: [
                        Text(
                          'Assist by ',
                          style: Theme.of(context).textTheme.caption,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          eventsResponseList.assist!.name.toString(),
                          style: Theme.of(context).textTheme.caption,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  SizedBox(height: 5,),
                  if(eventsResponseList.detail!.toString() =='Penalty')
                    const Image(
                      image: AssetImage('assets/images/penalty.jpg'),
                      height: 20,
                      fit: BoxFit.fitHeight,
                    ),
                  if(eventsResponseList.detail!.toString() =='Own Goal')
                    Row(
                      children: [
                        Icon(Icons.heart_broken_outlined,color: Colors.redAccent,size:25 ,),
                        SizedBox(width: 10,),
                        Text(
                          eventsResponseList.detail!.toString(),
                          style: Theme.of(context).textTheme.caption!.copyWith(
                              color: Colors.redAccent
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),

                      ],
                    ),

                ],
              ),

            ],
          ),
        if(eventsResponseList.type == 'Card')
          Row(
              children: [
                if(eventsResponseList.detail == 'Yellow Card')
                  const Image(
                    image: AssetImage('assets/images/yellowCard.png'),
                    height: 25,
                    width: 25,
                  ),
                if(eventsResponseList.detail == 'Second Yellow card')
                  const Image(
                    image: AssetImage('assets/images/SecondYellowCard.png'),
                    height: 25,
                    width: 25,
                  ),
                if(eventsResponseList.detail == 'Red Card')
                  const Image(
                    image: AssetImage('assets/images/redCard.png'),
                    height: 25,
                    width: 25,
                  ),
                SizedBox(width: 10,),
                Text(
                  eventsResponseList.player!.name.toString(),
                  style: Theme.of(context).textTheme.subtitle1,
                  overflow: TextOverflow.ellipsis,
                ),

              ]),
        if(eventsResponseList.type == 'subst')
          Column (
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              Row(
                children: [
                  Icon(Icons.arrow_circle_right_outlined ,color: Colors.green,size: 25,),
                  SizedBox(width: 10,),
                  Text(
                    eventsResponseList.player!.name.toString(),
                    style: Theme.of(context).textTheme.subtitle1!.copyWith(
                        color: Colors.green
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),


                ],
              ),
              if(eventsResponseList.assist!.name.toString() !='')
                Row(
                  children: [
                    Icon(Icons.arrow_circle_left_outlined ,color: Colors.redAccent,size:25 ,),
                    SizedBox(width: 10,),
                    Text(
                      eventsResponseList.assist!.name.toString(),
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.caption!.copyWith(
                          color: Colors.redAccent
                      ),
                    ),
                  ],
                ),

            ],
          ),
Spacer()


      ],
    );

  }
  Row eventsMatchTeam2(context ,EventsResponseModel eventsResponseList,index) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [

        if(eventsResponseList.type == 'Goal')
        Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  eventsResponseList.player!.name.toString(),
                  style: Theme.of(context).textTheme.subtitle1,
                  overflow: TextOverflow.ellipsis,
                ),
                if(eventsResponseList.assist!.name.toString() !='')
                  Row(
                    children: [
                      Text(
                        'Assist by ',
                        style: Theme.of(context).textTheme.caption,
                        overflow: TextOverflow.fade,
                      ),
                      Text(
                        eventsResponseList.assist!.name.toString(),
                        style: Theme.of(context).textTheme.caption,
                        overflow: TextOverflow.fade,
                      ),
                    ],
                  ),
                SizedBox(height: 5,),
                if(eventsResponseList.detail!.toString() =='Penalty')
                const Image(
                  image: AssetImage('assets/images/penalty.jpg'),
                  height: 20,
                  fit: BoxFit.fitHeight,
                ),
                if(eventsResponseList.detail!.toString() =='Own Goal')
                  Row(
                    children: [
                      Text(
                        eventsResponseList.detail!.toString(),
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.caption!.copyWith(
                            color: Colors.redAccent
                        ),
                      ),
                      SizedBox(width: 10,),
                      Icon(Icons.heart_broken_outlined,color: Colors.redAccent,size:25 ,),
                    ],
                  ),
              ],
            ),
            SizedBox(width: 10,),
            const Image(
              image: AssetImage('assets/images/football.png'),
              height: 25,
              width: 25,
            ),

          ],
        ),
        if(eventsResponseList.type == 'Card')
       Row(
           children: [
             Text(
               eventsResponseList.player!.name.toString(),
               style: Theme.of(context).textTheme.subtitle1,
             ),
             SizedBox(width: 10,),
         if(eventsResponseList.detail == 'Yellow Card')
           const Image(
             image: AssetImage('assets/images/yellowCard.png'),
             height: 25,
             width: 25,
           ),
         if(eventsResponseList.detail == 'Second Yellow card')
           const Image(
             image: AssetImage('assets/images/SecondYellowCard.png'),
             height: 25,
             width: 25,
           ),
         if(eventsResponseList.detail == 'Red Card')
           const Image(
             image: AssetImage('assets/images/redCard.png'),
             height: 25,
             width: 25,
           ),

       ]),
        if(eventsResponseList.type == 'subst')
          Column (
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [

                  Row(
                    children: [


                      Text(
                        eventsResponseList.player!.name.toString(),
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.subtitle1!.copyWith(
                            color: Colors.green
                        ),
                      ),
                      SizedBox(width: 10,),
                      Icon(Icons.arrow_circle_left_outlined ,color: Colors.green,size: 25,),

                    ],
                  ),
                  if(eventsResponseList.assist!.name.toString() !='')
                    Row(
                      children: [
                        Text(
                          eventsResponseList.assist!.name.toString(),
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.caption!.copyWith(
                              color: Colors.redAccent
                          ),
                        ),
                        SizedBox(width: 10,),
                        Icon(Icons.arrow_circle_right_outlined ,color: Colors.redAccent,size:25 ,),
                      ],
                    ),

            ],
          ),
        SizedBox(width: 15,),
        Text(
          eventsResponseList.time!.elapsed.toString(),
          overflow: TextOverflow.ellipsis,
          style: Theme.of(context).textTheme.subtitle1,
        ),


      ],
    );

  }

}
