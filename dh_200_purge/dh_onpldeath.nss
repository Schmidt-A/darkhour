//::///////////////////////////////////////////////
//:: Death Script
//:: NW_O0_DEATH.NSS
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    This script handles the default behavior
    that occurs when a player dies.

    BK: October 8 2002: Overriden for Expansion
*/
//:://////////////////////////////////////////////
//:: Created By: Brent Knowles
//:: Created On: November 6, 2001
//:://////////////////////////////////////////////

#include "_incl_pc_data"
#include "nwnx_funcs"
#include "subdual_inc"

/* Reset any raise tool attempts that have been used on this player before
 * and also reset the "dead too long" value. */
void ClearRaiseData(object oPC)
{
    struct LocalVariable var = GetFirstLocalVariable(oPC);
    struct LocalVariable nextVar;

    while(var.obj != OBJECT_INVALID)
    {
        nextVar = GetNextLocalVariable(var);
        if(GetStringLeft(var.name, 13) == "bRaiseAttempt")
            DeleteLocalInt(oPC, var.name);
        var = nextVar;
    }
    SetLocalInt(oPC, "bDeadTooLong", FALSE);
    DelayCommand(240.0, SetLocalInt(oPC, "bDeadTooLong", TRUE));
}

void main()
{
    object oPC = GetLastPlayerDied();
    object oKiller = GetLastHostileActor(oPC);

    if (CheckSubdual(oPC))
        return;

    PCDSetDead(oPC);
    ClearRaiseData(oPC);

    // * increment global tracking number of times that I died
    SetLocalInt(oPC, "NW_L_PLAYER_DIED", GetLocalInt(oPC, "NW_L_PLAYER_DIED") + 1);

    // * make friendly to Each of the 3 common factions
    AssignCommand(oPC, ClearAllActions());
    // * Note: waiting for Sophia to make SetStandardFactionReptuation to clear all personal reputation
    if (GetStandardFactionReputation(STANDARD_FACTION_COMMONER, oPC) <= 10)
    {   SetLocalInt(oPC, "NW_G_Playerhasbeenbad", 10); // * Player bad
        SetStandardFactionReputation(STANDARD_FACTION_COMMONER, 80, oPC);
    }
    if (GetStandardFactionReputation(STANDARD_FACTION_MERCHANT, oPC) <= 10)
    {   SetLocalInt(oPC, "NW_G_Playerhasbeenbad", 10); // * Player bad
        SetStandardFactionReputation(STANDARD_FACTION_MERCHANT, 80, oPC);
    }
    if (GetStandardFactionReputation(STANDARD_FACTION_DEFENDER, oPC) <= 10)
    {   SetLocalInt(oPC, "NW_G_Playerhasbeenbad", 10); // * Player bad
        SetStandardFactionReputation(STANDARD_FACTION_DEFENDER, 80, oPC);
    }

    PCDSetAlive(oPC);

    location lDeathSpot = GetLocation(oPC);
    object oCorpse = CreateObject(OBJECT_TYPE_PLACEABLE,"playercorpse",lDeathSpot);

    // Destroy equipped ki shuriken
    object oShuriken = GetItemInSlot(INVENTORY_SLOT_RIGHTHAND,oPC);
    if (GetTag(oShuriken) == "kishuriken")
        DestroyObject(oShuriken);

    // Destroy ki shuriken in inventory, move droppable items into corpse
    string sTag;
    object oItem = GetFirstItemInInventory(oPC);
    while (GetIsObjectValid(oItem))
    {
        sTag = GetTag(oItem);
        if(sTag == "kishuriken")
            DestroyObject(oItem);

        else if (GetItemCursedFlag(oItem) == FALSE &&  sTag != "NW_WBWSL001" &&
                 sTag != "token_pc")
            AssignCommand(oCorpse, ActionTakeItem(oItem,oPC));

        oItem = GetNextItemInInventory(oPC);
    }
    AssignCommand(oCorpse, TakeGoldFromCreature(GetGold(oPC), oPC));
    SetLocalString(oCorpse, "PlayerName", GetPCPlayerName(oPC));
    SetName(oCorpse, GetName(oPC)+"'s Corpse");

    ExportSingleCharacter(oPC);
}
