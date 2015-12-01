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

/************************************************************
Modified November 15th, 2015 by Tweek. cr_* files now call Craft()
instead of having all implementation details in each one. This way we can make
changes to the system without having to modify 60+ files. Includes necessary
code to provide XP to ECL characters with our subrace system.
*************************************************************/
#include "_incl_xp"

void CreateAmmo(object oPC, string sItemTag, int iRand)
{
    if(iRand < 100)
        CreateItemOnObject(sItemTag, oPC, iRand);
    else
    {
        CreateItemOnObject(sItemTag, oPC, 99);
        CreateItemOnObject(sItemTag, oPC, iRand - 99);
    }
    SendMessageToPC(oPC, "You have created " + IntToString(iRand) + " ammunition.");
}

void UpdateAndNotify(object oPC, object oCrafting, int iAmount, int iCost)
{
    SetLocalInt(oCrafting, "crafting", iAmount - iCost);
    string sFinalAmount = "You currently have " + IntToString(iAmount - iCost) + " crafting points.";
    SendMessageToPC(oPC, sFinalAmount);
}

void TryForLevelup(object oPC, object oCrafting, int iOdds, int iSkillroll, int iSkill)
{
    //If d100 roll is (iOdds) or less, and your crafting skill is 9 or below, level up!
    if (iSkillroll <= iOdds && iSkill < 10 )
    {
        SetLocalInt(oCrafting, "skill", iSkill + 1);
        int iSkill = GetLocalInt(oCrafting, "skill");
        SendMessageToPC(oPC, "You have gained some knowledge in crafting!");
        SendMessageToPC(oPC, "Your crafting skill has advanced to level " + IntToString(iSkill));
        GiveXPToCreatureDH(oPC, 50);
    }
}

void Craft(string sItemTag, string sMWTag, int iCost, int ammo=FALSE)
{
    object oPC = GetPCSpeaker();
    object oCrafting = GetItemPossessedBy(oPC,"craftingitem");
    int iAmount = GetLocalInt(oCrafting, "crafting");

    // Players can't craft an item if they don't have enough points for it.
    if (iAmount < iCost)
    {
        SendMessageToPC(oPC, "You do not have enough crafting points to craft this item.");
        return;
    }

    int iSkill = GetLocalInt(oCrafting, "skill");
    int iWeaponSkill = GetSkillRank(SKILL_CRAFT_ARMOR, oPC, FALSE);
    int iArmorSkill = GetSkillRank(SKILL_CRAFT_WEAPON, oPC, FALSE);

    int iRoll = d20();
    int iSkillroll = d100();
    string sRoll = IntToString(iRoll);
    int iRand = 0;

    // If the player is crafting ammo, figure out how much they made.
    if(ammo == TRUE)
    {
        iRand = Random(80) + Random(80) + 40 + iWeaponSkill + iArmorSkill;
        if(iRand > 198)
            iRand = 198;
    }

    // Try to create a masterwork item.
    if(iSkillroll + iWeaponSkill + iArmorSkill >= 105)
    {
        if(ammo == TRUE)
            CreateAmmo(oPC, sMWTag, iRand);
        else
            CreateItemOnObject(sMWTag, oPC);
        TryForLevelup(oPC, oCrafting, 15, iSkillroll, iSkill);
        SendMessageToPC(oPC, "You have crafted a masterwork item!");

    }

    //If masterwork roll is failed, try for a normal one.
    if (iRoll + iSkill + ((iWeaponSkill + iArmorSkill)/5) >= 19)
    {
        if(ammo == TRUE)
            CreateAmmo(oPC, sItemTag, iRand);
        else
            CreateItemOnObject(sItemTag, oPC);
        TryForLevelup(oPC, oCrafting, 15, iSkillroll, iSkill);
        SendMessageToPC(oPC, "You have successfully crafted an item!");
        UpdateAndNotify(oPC, oCrafting, iAmount, iCost);
        return;
    }

    // If we got here, they failed to craft anything. Let's give them a little
    // chance to level to be nice.
    SetLocalInt(oCrafting, "crafting", iAmount - iRoll);
    SendMessageToPC(oPC, "You failed to craft anything and lost " + IntToString(iAmount) + " crafting points in the process");
    TryForLevelup(oPC, oCrafting, 5, iSkillroll, iSkill);
}
