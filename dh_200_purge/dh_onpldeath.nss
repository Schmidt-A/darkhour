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

#include "subdual_inc"
#Include "_incl_pc_data"

void Raise(object oPC)
{
        SetLocalInt(oPC, "raiseattempts", 0);
        effect eVisual = EffectVisualEffect(VFX_IMP_RESTORATION);

        effect eBad = GetFirstEffect(oPC);
        ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectResurrection(),oPC);
        ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectHeal(GetMaxHitPoints(oPC)), oPC);

        PCDSetAlive(oPC);

        //Search for negative effects
        while(GetIsEffectValid(eBad))
        {
            if (GetEffectType(eBad) == EFFECT_TYPE_ABILITY_DECREASE ||
                GetEffectType(eBad) == EFFECT_TYPE_AC_DECREASE ||
                GetEffectType(eBad) == EFFECT_TYPE_ATTACK_DECREASE ||
                GetEffectType(eBad) == EFFECT_TYPE_DAMAGE_DECREASE ||
                GetEffectType(eBad) == EFFECT_TYPE_DAMAGE_IMMUNITY_DECREASE ||
                GetEffectType(eBad) == EFFECT_TYPE_SAVING_THROW_DECREASE ||
                GetEffectType(eBad) == EFFECT_TYPE_SPELL_RESISTANCE_DECREASE ||
                GetEffectType(eBad) == EFFECT_TYPE_SKILL_DECREASE ||
                GetEffectType(eBad) == EFFECT_TYPE_BLINDNESS ||
                GetEffectType(eBad) == EFFECT_TYPE_DEAF ||
                GetEffectType(eBad) == EFFECT_TYPE_PARALYZE ||
                GetEffectType(eBad) == EFFECT_TYPE_NEGATIVELEVEL)
                {
                    //Remove effect if it is negative.
                    RemoveEffect(oPC, eBad);
                }
            eBad = GetNextEffect(oPC);
        }
        //Fire cast spell at event for the specified target
        SetLocalInt(oPC, "raiseattempts", 0);
        SignalEvent(oPC, EventSpellCastAt(OBJECT_SELF, SPELL_RESTORATION, FALSE));
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eVisual, oPC);
}

void main()
{
    object oPC = GetLastPlayerDied();
    object oKiller = GetLastHostileActor(oPC);

    SetLocalInt(oPC, "raiseattempts", 0);

    if (CheckSubdual(oPC))
        return;

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

    // Remove any Ki Shuriken
    object oShuriken = GetItemInSlot(INVENTORY_SLOT_RIGHTHAND,oPC);
    if (GetTag(oShuriken) == "kishuriken")
    {
        DestroyObject(oShuriken);
    }
    oShuriken = GetFirstItemInInventory(oPC);
    while (oShuriken != OBJECT_INVALID)
    {
        if (GetTag(oShuriken) == "kishuriken")
        {
            DestroyObject(oShuriken);
        }
        oShuriken = GetNextItemInInventory(oPC);
    }

    // Now move all Droppable items into the placeable's inventory
    object oItem = GetFirstItemInInventory(oPC);
    while (GetIsObjectValid(oItem))
    {
        if ((GetItemCursedFlag(oItem) == FALSE) && (GetTag(oItem)!="NW_WBWSL001") && (GetTag(oItem)!="DyeKit"))
        {
            AssignCommand(oCorpse,ActionTakeItem(oItem,oPC));
        }
        oItem = GetNextItemInInventory(oPC);
    }
    AssignCommand(oCorpse,TakeGoldFromCreature(GetGold(oPC),oPC));
    SetLocalString(oCorpse,"PlayerName",GetPCPlayerName(oPC));
    SetName(oCorpse,GetName(oPC)+"'s Corpse");
    SetLocalString(oCorpse,"PlayerName",GetPCPlayerName(oPC));

    PCDSetDead(oPC);
    ExportSingleCharacter(oPC);
}
