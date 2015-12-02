#include "aps_include"
void MoveToPen(object oPC);
void MoveToPen(object oPC)
{
//move player to Pen
 object oLoc = GetObjectByTag("AntiworldPen");
 location lLoc = GetLocation(oLoc);
 AssignCommand( oPC,ClearAllActions(TRUE));
 AssignCommand( oPC,JumpToLocation(lLoc));
}

void main()
{
object oPC = GetPCSpeaker();
SetPersistentInt(oPC,"SantaJudgement",2,0,"christmas");

//Bad Player Punishment ///
///visual effect - death or some.

// give the Bad Player card. ResRef: imabadplayer
object oItem = GetFirstItemInInventory(oPC);
while(GetIsObjectValid(oItem))
{
if(GetTag(oItem) == "imabadplayer" || GetTag(oItem) == "imagoodplayer" )
DestroyObject( oItem);
oItem = GetNextItemInInventory(oPC);
}
TakeGoldFromCreature(1,oPC,TRUE);
CreateItemOnObject("imabadplayer",oPC);
ActionSpeakString("<cßQ>"+GetName(oPC)+" is a Bad Player!</c>",TALKVOLUME_SHOUT);

//move player to Pen

DelayCommand(4.0,MoveToPen(oPC));
}
