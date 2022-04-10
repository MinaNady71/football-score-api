class FixturesResponseModel{
  FixtureModel?  fixture;
  LeagueModel?  league;
  TeamsModel?  teams;
  GoalsModel? goals;
  ScoreModel?  score;

  FixturesResponseModel(this.fixture,this.score,this.teams);

  FixturesResponseModel.fromJson(Map<String,dynamic>json ){
    fixture = FixtureModel.fromJson(json['fixture']);
    league = LeagueModel.fromJson(json['league']);
    teams = TeamsModel.fromJson( json['teams']);
    goals = GoalsModel.fromJson( json['goals']);
    score =ScoreModel.fromJson( json['score']);
    
  }



}
//// to get fixtures data from response list
class FixtureModel{
    int?  id;
    String?  date;
    StatusModel?  status;

    FixtureModel(this.id,this.date,this.status);

    FixtureModel.fromJson(Map<String,dynamic>json ){
      id = json['id'];
      date = json['date'];
      status = StatusModel.fromJson( json['status']);
    }
}

class StatusModel{

String? long;
String? short;
int? elapsed; // it is finished time

StatusModel(this.long,this.short,this.elapsed);

StatusModel.fromJson(Map<String,dynamic>json ){
  long = json['long']??'';
  short = json['short']??'';
  elapsed = json['elapsed'];
}

}


//// to get fixtures data from response list
class LeagueModel{
  int? id;
  String? name;
  String? country;
  String? logo;
  String? flag;
  int? season;
  String? round;

  LeagueModel(this.id,this.country,this.flag,this.logo,this.name,this.season,this.round,);

  LeagueModel.fromJson(Map<String,dynamic>json ){
    id = json['id'];
    name = json['name']??'';
    country = json['country']??'';
    logo = json['logo']??'';
    flag = json['flag']??'';
    season = json['season'];
    round = json['round']??'';

  }
}

//// to get teams data from response list
class TeamsModel{
 TeamHomeModel? home;
 TeamAwayModel? away;

 TeamsModel(this.home,this.away);

 TeamsModel.fromJson(Map<String,dynamic>json ){
   home = TeamHomeModel.fromJson(json['home']);
   away = TeamAwayModel.fromJson(json['away']);
 }

}
class TeamHomeModel{
  int? id;
  String? name;
  String? logo;
  bool? winner;

  TeamHomeModel(this.id,this.logo,this.name,this.winner);

  TeamHomeModel.fromJson(Map<String,dynamic>json ){
    id = json['id'];
    name = json['name']??'';
    logo = json['logo']??'';
    winner = json['winner'];
  }

}
class TeamAwayModel{
  int? id;
  String? name;
  String? logo;
  bool? winner;

  TeamAwayModel(this.id,this.logo,this.name,this.winner);

  TeamAwayModel.fromJson(Map<String,dynamic>json ){
    id = json['id'];
    name = json['name']??'';
    logo = json['logo']??'';
    winner = json['winner'];
  }

}


//// to get goals data from response list
class GoalsModel{
  int? homeGoals;
  int? awayGoals;

  GoalsModel(this.awayGoals,this.homeGoals);

  GoalsModel.fromJson(Map<String,dynamic>json ){
    homeGoals = json['home']??0;
    awayGoals = json['away']??0;

  }

}


//// to get Score data from response list
class ScoreModel{
  HalfTimeModel? halfTime;
  FullTimeModel? fullTime;
  ExtraTimeModel? extraTime;
  PenaltyModel? penalty;

  ScoreModel(this.extraTime,this.fullTime,this.halfTime,this.penalty);

  ScoreModel.fromJson(Map<String,dynamic>json ){
    halfTime = HalfTimeModel.fromJson(json['halftime']);
    fullTime = FullTimeModel.fromJson(json['halftime']);
    extraTime = ExtraTimeModel.fromJson(json['halftime']);
    penalty = PenaltyModel.fromJson(json['halftime']);

  }

}
class HalfTimeModel{
  int? homeGoals;
  int? awayGoals;

  HalfTimeModel(this.awayGoals,this.homeGoals);

  HalfTimeModel.fromJson(Map<String,dynamic>json ){
    homeGoals = json['home']??0;
    awayGoals = json['away']??0;

  }

}
class FullTimeModel{
  int? homeGoals;
  int? awayGoals;

  FullTimeModel(this.awayGoals,this.homeGoals);

  FullTimeModel.fromJson(Map<String,dynamic>json ){
    homeGoals = json['home']??0;
    awayGoals = json['away']??0;

  }

}
class ExtraTimeModel{
  int? homeGoals;
  int? awayGoals;

  ExtraTimeModel(this.awayGoals,this.homeGoals);

  ExtraTimeModel.fromJson(Map<String,dynamic>json ){
    homeGoals = json['home']??0;
    awayGoals = json['away']??0;

  }

}
class PenaltyModel{
  int? homeGoals;
  int? awayGoals;

  PenaltyModel(this.awayGoals,this.homeGoals);

  PenaltyModel.fromJson(Map<String,dynamic>json ){
    homeGoals = json['home']??0;
    awayGoals = json['away']??0;

  }

}
