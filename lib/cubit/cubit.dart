
import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:football_scores_api/cubit/states.dart';
import 'package:football_scores_api/football_model/events_model.dart';
import 'package:football_scores_api/football_model/head_to_head_model.dart';
import 'package:football_scores_api/football_model/lineups_model.dart';
import 'package:football_scores_api/shared/local/cache_helper.dart';
import '../end_points.dart';
import '../football_model/fixtures_model.dart';
import '../shared/network/dio_helper/dio_helper.dart';



class FootballCubit extends Cubit<FootballStates>{
  FootballCubit() : super(FootballInitialState());

  static FootballCubit get(context)=> BlocProvider.of(context);


  List<FixturesResponseModel> fixturesResponseList = [];
  List<FixturesResponseModel> fixturesResponseListFromCache = [];
  void getAllFixtures(){
    var date =     DateTime.now().toString().substring(0,10);
    DioHelper.getData(
        url: kFixtures,
        query: {
        //'live':'all',
          'date':'2022-04-09',
        }
    ).then((value) async{
      fixturesResponseList = [];
      value.data['response'].forEach((element) {
        fixturesResponseList.add(FixturesResponseModel.fromJson(element));
        emit(FootballGetAllFixturesState());
      });
    await  setListOfString(list: value.data['response'], sharedKey: 'fixtures');
      emit(FootballGetAllFixturesState());
        print(fixturesResponseList.length.toString());
        print('done kFixtures');
    });


emit(FootballGetAllFixturesState());
  }
  List<LineupsResponseModel> lineupsResponseList = [];
  List<LineupsResponseModel> lineupsResponseListFromCache = [];
  void getAllLineups({required int fixtureId,required context,required index}) {
    var date = DateTime.now().toString().substring(0,10);
    DioHelper.getData(
        url: '$kFixtures/$kLineups',
      query: {
        'fixture':fixtureId
      }
    ).then((value)async {
      lineupsResponseList = [];
    await  value.data['response'].forEach((element) {
        lineupsResponseList.add(LineupsResponseModel.fromJson(element));
        emit(FootballGetAllLineupsState());
      });
      await  setListOfString(list: value.data['response'], sharedKey: 'lineups');
      getListOfStringFromCache('lineups').then((value){
        value.forEach((element){
         lineupsResponseListFromCache.add(LineupsResponseModel.fromJson(element));
        });
      });
      emit(FootballGetAllLineupsState());
        print('done kLineups');
    }).catchError((e){
      getListOfStringFromCache('lineups').then((value){
        value.forEach((element){
         lineupsResponseListFromCache.add(LineupsResponseModel.fromJson(element));
        });
      });
    });


emit(FootballGetAllFixturesState());
  }

  List<H2HResponseModel> h2hResponseList = [];
  List<H2HResponseModel> h2hResponseListFromCache = [];
  void getAllH2H(int teamHomeId,int teamAwayId){
    DioHelper.getData(
        url: '$kFixtures/$kH2H',
        query: {
          "h2h": "$teamHomeId-$teamAwayId",
        }
    ).then((value) async{
      h2hResponseList = [];
      value.data['response'].forEach((element) {
        h2hResponseList.add(H2HResponseModel.fromJson(element));
        emit(FootballGetAllH2HState());
      });
      await  setListOfString(list: value.data['response'], sharedKey: 'h2h');
     getListOfStringFromCache('h2h').then((value){
        value.forEach((element){
         h2hResponseListFromCache.add(H2HResponseModel.fromJson(element));
        });
      });
      emit(FootballGetAllH2HState());
      print(h2hResponseList.length.toString());
      print('done h2hResponseList');
    }).catchError((e){
      getListOfStringFromCache('h2h').then((value){
        value.forEach((element){
          h2hResponseListFromCache.add(H2HResponseModel.fromJson(element));
        });
      });
    });
    emit(FootballGetAllH2HState());
  }

  List<EventsResponseModel> eventsResponseList = [];
  List<EventsResponseModel> eventsResponseListFromCache = [];
  void getAllEvents({required int fixtureId,required context,}) {
    var date = DateTime.now().toString().substring(0,10);
    DioHelper.getData(
        url: '$kFixtures/$kEvents',
        query: {
          'fixture':fixtureId
        }
    ).then((value)async {
      eventsResponseList = [];
      await  value.data['response'].forEach((element) {
        eventsResponseList.add(EventsResponseModel.fromJson(element));
        emit(FootballGetAllEventsState());
      });
      await  setListOfString(list: value.data['response'], sharedKey: 'events');
      getListOfStringFromCache('events').then((value){
        value.forEach((element){
          eventsResponseListFromCache.add(EventsResponseModel.fromJson(element));
        });
      });
      print(eventsResponseList.length.toString() +' mna');
      emit(FootballGetAllEventsState());
      print('done eventsResponseList');
    }).catchError((e){
      getListOfStringFromCache('events').then((value){
      value.forEach((element){
        eventsResponseListFromCache.add(EventsResponseModel.fromJson(element));
      });
    });});


    emit(FootballGetAllEventsState());
  }





bool showMoreH2HPreviousMatch = false;

  void toggleToShowMoreH2HPreviousMatch(){
    showMoreH2HPreviousMatch = !showMoreH2HPreviousMatch;
    emit(FootballtoggleToShowMoreH2HPreviousMatchState());
  }



Future<void> setListOfString({required List list,required String sharedKey})async{
 List<String> encodeList =  list.map((e) => jsonEncode(e)).toList();
 await CacheHelper.putList(key: sharedKey, value:encodeList);
 emit(FootballSetListOfStringInSharedState());
}

  Future<List> getListOfFixturesCache(String sharedKey)async{
   await CacheHelper.init();
      List decodeList =  await CacheHelper.getList(sharedKey);
      List getList = decodeList.map((e) => jsonDecode(e)).toList();
      getList.forEach((element){
        fixturesResponseListFromCache.add(FixturesResponseModel.fromJson(element));
      });
      emit(FootballGetFixturesCacheState());
    return getList;
  }

  Future<List> getListOfStringFromCache(String sharedKey)async{
    await CacheHelper.init();
    List decodeList =  await CacheHelper.getList(sharedKey);
    List getList = decodeList.map((e) => jsonDecode(e)).toList();
    if(getList.isNotEmpty) {
      getList.forEach((element){
      fixturesResponseListFromCache.add(FixturesResponseModel.fromJson(element));
    });
    }
    emit(FootballGetListOfStringFromCacheState());
    return getList;
  }



}

