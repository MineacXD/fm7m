extends Node

var z_index_player = 0

#Battle variables
var PreviousScreen #used to return to the previous map from battles
var BattleFinished = false #when you finish a battle sucessfully
var BattleFailed = false #when you lose a battle
var lives = 1 #lives for the battle

#Gui variables
var skinChange = false #false when skin = ena and true when its mafuyu
var PlayerBusy = false #used when the player cant move

#Switches (literally)
var PreCastleButtonPressed = false
