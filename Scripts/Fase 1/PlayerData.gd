extends Node

var id;
var nickname;
var scoreCurrent = 0;
var scoreFromDatabase;
var authorization;

func addId(id: int):
	self.id = id
	
func addNickname(nickname: String):
	self.nickname = nickname

func addScoreCurrent(score: int):
	self.scoreCurrent = score
	
func addScoreFromDatabase(score: int):
	self.scoreFromDatabase = score
	
func addAuthorization(authorization):
	self.authorization = authorization
