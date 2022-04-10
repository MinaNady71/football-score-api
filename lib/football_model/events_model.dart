class EventsResponseModel{
  TimeModel?  time;
  TeamModel?  team;
  PlayerModel?  player;
  AssistModel? assist;
  String? type; //Goal -- Card --subst
  String? detail;
  String? comments;

  EventsResponseModel(this.assist,this.comments,this.detail,this.player,this.team,this.time,this.type);

  EventsResponseModel.fromJson(Map<String,dynamic>json ){
    time   = TimeModel.fromJson(json['time']);
    team = TeamModel.fromJson(json['team']);
    player   = PlayerModel.fromJson( json['player']);
    assist = AssistModel.fromJson( json['assist']);
    type = json['type']??'';
    detail =  json['detail']??'';
    comments =  json['comments']??'';

  }



}
//// to get TimeModel data from response list
class TimeModel{
    int?  elapsed;
    int?  extra;

    TimeModel(this.elapsed,this.extra);

    TimeModel.fromJson(Map<String,dynamic>json ){
      elapsed = json['elapsed']??0;
      extra = json['extra']??0;

    }
}

class TeamModel{
  int? id;
  String? name;
  String? logo;


  TeamModel(this.id,this.logo,this.name);

  TeamModel.fromJson(Map<String,dynamic>json ){
    id = json['id'];
    logo = json['logo']??'';
    name = json['name']??'';
}

}


class PlayerModel{
  int? id;
  String? name;


  PlayerModel(this.id,this.name,);

  PlayerModel.fromJson(Map<String,dynamic>json ){
    id = json['id'];
    name = json['name']??'';
  }
}


class AssistModel{
  int? id;
  String? name;


  AssistModel(this.id,this.name,);

  AssistModel.fromJson(Map<String,dynamic>json ){
    id = json['id'];
    name = json['name']??'';
  }
}



