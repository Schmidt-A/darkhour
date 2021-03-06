#include "_incl_xp"
//Name: Salvaging and Crafting Point System: Item Handler
//Developer: Skeet/DM Malevolent
//Date: 8-02-2007
//Purpose: A system that works specifically with the Main
//         system I've developed to create crafted and
//         masterworked items, gain skill points, and
//         award a little bit of experience upon
//         creating a crafted item if their craft skill
//         is not at the maximum level.
//
//Notes: "crafted" int variable on item being crafted needs set to skill point cost
//Regular items resref: cr_<itemname>    (For Tracking purposes)
//Masterwork items resref: mw_<itemname> (For Tracking purposes)
//You do not necessarily have to craft an item to gain a skill point
//to show that sometimes people will learn from their mistakes
//and will be better at crafting next time around.

void main()
{
object oPC = GetPCSpeaker();
object oCrafting = GetObjectByTag("craftingitem");
int iSkill = GetLocalInt(oCrafting, "skill");
int iAmount = GetLocalInt(oCrafting, "crafting");
int iRoll = d20();
int iSkillroll = d100();
string sRoll = IntToString(iRoll);

//All of this will check if the cost of the crafted
//item exceeds the crafting points the player currently
//has available.  If it does, then a message is sent to
//the player and the script ends.

int iCost = 100;

if (iAmount < iCost)
{
SendMessageToPC(oPC, "You do not have enough crafting points to craft this item.");
return;
}

//If a d100 roll is greater than or equal to
//95, create a masterwork and return

if (iSkillroll >= 95)
{
SendMessageToPC(oPC, "You have crafted a masterwork item!");
CreateItemOnObject("mastcrafteddart", oPC);
return;
}

//If masterwork roll is failed, roll d20 + crafting roll vs. DC 19
//if successful, create a crafted item

if (iRoll + iSkill >= 19)
{
CreateItemOnObject("crafteddart", oPC);
return;
}

//If d100 roll is 75 or greater, and
//your crafting skill is 9 or below
//Award 1 skill point and 50xp

else if (iSkillroll > 85 && iSkill < 10 )
{
SetLocalInt(oCrafting, "skill", iSkill + 1);
int iSkill = GetLocalInt(oCrafting, "skill");
string sSkill = IntToString(iSkill);
SendMessageToPC(oPC, "You have gained some knowledge in crafting!");
SendMessageToPC(oPC, "Your crafting skill has advanced to level " + sSkill);
GiveXPToCreatureDH(oPC, 50);
return;
}
else
SetLocalInt(oCrafting, "crafting", iAmount - iRoll);
SendMessageToPC(oPC, "You failed to craft anything and lost " + sRoll + " crafting points in the process");
return;
}
