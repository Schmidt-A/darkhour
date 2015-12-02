#include "aps_include"
void main()
{
object oPC = GetPCSpeaker();
//store persistant
SetPersistentInt(oPC,"SantaJudgement",5,0,"christmas");
//give Xp and gold ( one level and half)
int nXP = GetHitDice(oPC)*1500;
SetXP(oPC,(GetXP(oPC)+ nXP));
GiveGoldToCreature(oPC,  nXP-1);
PlaySound("as_mg_frstmagic1");

 //shout
ActionSpeakString("<cO•Ê>"+GetName(oPC)+" is a Good Player!</c>",TALKVOLUME_SHOUT);
//give a specil item " the oscar"
if (GetGender(oPC) == GENDER_FEMALE)
    {
    TakeGoldFromCreature(1,oPC,TRUE);
    CreateItemOnObject("specialitemf",oPC);
    }
    else
    {
    TakeGoldFromCreature(1,oPC,TRUE);
    CreateItemOnObject("specialitem",oPC);
    }
//create the good player item //
object oItem = GetFirstItemInInventory(oPC);
while(GetIsObjectValid(oItem))
{
if(GetTag(oItem) == "imabadplayer" || GetTag(oItem) == "imagoodplayer" )
DestroyObject( oItem);
oItem = GetNextItemInInventory(oPC);
}

TakeGoldFromCreature(1,oPC,TRUE);
CreateItemOnObject("imagoodplayer",oPC);
//delete the stored points
//string sName = GetPCPlayerName(oPC);
//DeleteLocalInt(oPC,sName);
}
