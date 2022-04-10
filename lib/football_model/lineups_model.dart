class LineupsResponseModel {
  TeamModel? team;
  String? formation;
  List<StartXIModel> startXI =[];
  List<SubstitutesModel> substitutes =[];
  CoachModel? coach;

  LineupsResponseModel( this.formation, this.team, this.substitutes);

  LineupsResponseModel.fromJson(Map<String, dynamic>json){
    team = TeamModel.fromJson(json['team']);
    formation =json['formation']??'';
    json['startXI'].forEach((element){
      startXI.add(StartXIModel.fromJson(element));
    });
    json['substitutes'].forEach((element){
      substitutes.add(SubstitutesModel.fromJson(element));
    });
    coach = CoachModel.fromJson(json['coach']);

  }
}

// to get TeamData
  class TeamModel{
  int? id;
  String? name;
  String? logo;

  TeamModel(this.id,this.logo,this.name,);

  TeamModel.fromJson(Map<String,dynamic>json ){
  id = json['id'];
  name = json['name']??'';
  logo = json['logo']??'';
  }

  }
// to get startXI --- main eleven players
class StartXIModel{
  StartXIPlayersModel? mainPlayer;

  StartXIModel(this.mainPlayer,);

  StartXIModel.fromJson(Map<String,dynamic>json ){

      mainPlayer = StartXIPlayersModel.fromJson(json['player']);
  }

}
class StartXIPlayersModel{

  int? id;
  String? name;
  dynamic number; //type of int?
  String? pos;
  String? grid;

  StartXIPlayersModel(this.id,this.grid,this.name,this.pos,this.number,);

  StartXIPlayersModel.fromJson(Map<String,dynamic>json ){
    id = json['id'];
    name = json['name']??'';
    number = json['number']??'';
    pos = json['pos']??'';
    grid = json['grid']??'';

  }

}

// to get SubstitutesData
  class SubstitutesModel{
  SubstitutesPlayersModel? subPlayer;

  SubstitutesModel(this.subPlayer,);

  SubstitutesModel.fromJson(Map<String,dynamic>json ){
     subPlayer =SubstitutesPlayersModel.fromJson(json['player']);
  }

  }
  class SubstitutesPlayersModel{

  int? id;
  String? name;
  dynamic number; //type of int?
  String? pos;
  String? grid;

  SubstitutesPlayersModel(this.id,this.grid,this.name,this.pos,this.number,);

  SubstitutesPlayersModel.fromJson(Map<String,dynamic>json ){
  id = json['id'];
  name = json['name']??'';
  number = json['number']??'';
  pos = json['pos']??'';
  grid = json['grid']??'';

  }

  }
// to get CoachData
class CoachModel{
  int? id;
  String? name;
  String? photo;

  CoachModel(this.id,this.photo,this.name,);

  CoachModel.fromJson(Map<String,dynamic>json ){
    id = json['id'];
    name = json['name']??'';
    photo = json['photo']??'';
  }

}