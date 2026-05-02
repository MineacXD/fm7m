extends Node

#variables used for player tracking
var z_index_player = 0 #z index the player is currently on

#variables used for battle player tracking
var playerX = 0
var playerY = 0

#Battle variables
var PreviousScreen #used to return to the previous map from battles
var BattleFinished = false #when you finish a battle sucessfully
var BattleFailed = false #when you lose a battle
var lives = 1 #lives for the battle
var babyOffset = 0 #offset for the baby timer

#Gui variables
var skinChange = false #false when skin = ena and true when its mafuyu
var PlayerBusy = false #used when the player cant move

#Switches (literally)
var PreCastleButtonPressed = false #switch for button in map03

var StartCastleButtonPressed = false #switch for the first button in map04
var StartCastlePasscodeDone = false #switch for the passcode in map04
