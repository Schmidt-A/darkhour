#include "aps_include"
void main()
{
object oPC = GetPCSpeaker();
SetPersistentInt(oPC,"SantaJudgement",5,0,"christmas");
// I need you to find a good present...:D//
//give Xp and gold ( one level and half)
int nXP = GetHitDice(oPC)*2000;
SetXP(oPC,(GetXP(oPC)+ nXP));
GiveGoldToCreature(oPC,  nXP-1);
PlaySound("as_mg_frstmagic1");

// give the Perfect Player card. ResRef: imagoodplayer
object oItem = GetFirstItemInInventory(oPC);
while(GetIsObjectValid(oItem))
{
if(GetTag(oItem) == "imabadplayer" || GetTag(oItem) == "imagoodplayer" )
DestroyObject( oItem);
oItem = GetNextItemInInventory(oPC);
}

TakeGoldFromCreature(1,oPC,TRUE);
CreateItemOnObject("imaperfectplayer",oPC);
//shout
ActionSpeakString("<c¯ß>"+GetName(oPC)+" is a Perfect Player!</c>",TALKVOLUME_SHOUT);
///special item
if (GetGender(oPC) == GENDER_FEMALE)
    {
    CreateItemOnObject("specialitemf",oPC);
    }
    else
    {
    CreateItemOnObject("specialitem",oPC);
    }
///delete the stored point
//string sName = GetPCPlayerName(oPC);
//DeleteLocalInt(oPC,sName);
}
