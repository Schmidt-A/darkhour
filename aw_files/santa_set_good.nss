#include "aps_include"

void main()
{
object oPC = GetPCSpeaker();
SetPersistentInt(oPC,"SantaJudgement",3,0,"christmas");

// give the Bad Player card. ResRef: imagoodplayer
object oItem = GetFirstItemInInventory(oPC);
while(GetIsObjectValid(oItem))
{
if(GetTag(oItem) == "imabadplayer" || GetTag(oItem) == "imagoodplayer" )
DestroyObject( oItem);
oItem = GetNextItemInInventory(oPC);
}

TakeGoldFromCreature(1,oPC,TRUE);
CreateItemOnObject("imagoodplayer",oPC);
ActionSpeakString("<cO•Ê>"+GetName(oPC)+" is a Good Player!</c>",TALKVOLUME_SHOUT);

}
