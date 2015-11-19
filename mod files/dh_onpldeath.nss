#include "subdual_inc"
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
void Raise(object oPlayer)
{
        SetLocalInt(oPlayer, "raiseattempts", 0);
        effect eVisual = EffectVisualEffect(VFX_IMP_RESTORATION);

        effect eBad = GetFirstEffect(oPlayer);
        ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectResurrection(),oPlayer);
        ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectHeal(GetMaxHitPoints(oPlayer)), oPlayer);

        if ((OBJECT_INVALID != GetItemPossessedBy(oPlayer, "DeathToken")) && (GetIsPossessedFamiliar(oPlayer) == FALSE))
        {
            DestroyObject(GetItemPossessedBy(oPlayer, "DeathToken"));
        }

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
                    RemoveEffect(oPlayer, eBad);
                }
            eBad = GetNextEffect(oPlayer);
        }
        //Fire cast spell at event for the specified target
        SetLocalInt(oPlayer, "raiseattempts", 0);
        SignalEvent(oPlayer, EventSpellCastAt(OBJECT_SELF, SPELL_RESTORATION, FALSE));
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eVisual, oPlayer);
}

void main()
{
object oSaveMe = GetLastPlayerDied();
SetLocalInt(oSaveMe, "raiseattempts", 0);
if(GetTag(GetArea(oSaveMe)) == "UnknownArea")
    {
    Raise(oSaveMe);
    DelayCommand(10.0, Raise(oSaveMe));
    ExecuteScript("amalgkill", oSaveMe);
    return;
    }
if (CheckSubdual(GetLastPlayerDied())) return;

    object oPlayer = GetLastPlayerDied();
    // * increment global tracking number of times that I died
    SetLocalInt(oPlayer, "NW_L_PLAYER_DIED", GetLocalInt(oPlayer, "NW_L_PLAYER_DIED") + 1);

    // * BK: Automation Control. Autopcs ignore death
    if (GetLocalInt(oPlayer, "NW_L_AUTOMATION") == 10)
    {
        Raise(oPlayer);
        DelayCommand(1.0, ExecuteScript("crawl", OBJECT_SELF));
        return; // Raise and return
    }


    // * Handle Spirit of the Wood Death
     string sArea = GetTag(GetArea(oPlayer));
/*
    if (sArea == "MAP_M2Q2F2" && GetDistanceBetweenLocations(GetLocation(GetObjectByTag("M2Q2F2_M2Q2G")), GetLocation(oPlayer)) < 5.0 && GetLocalInt(GetModule(),"NW_M2Q2E_WoodsFreed") == 0)
    {
        int bValid;

        Raise(oPlayer);
        string sDestTag = "WP_M2Q2GtoM2Q2F";
        object oSpawnPoint = GetObjectByTag(sDestTag);
        AssignCommand(oPlayer,JumpToLocation(GetLocation(oSpawnPoint)));
        return;

    }
*/
    // * in last level of the Sourcestone, move the player to the beginning of the area
    // * May 16 2002: or the main area of the Snowglobe (to prevent plot logic problems).
    // * May 21 2002: or Castle Never
    if (sArea == "M4Q1D2" || sArea == "M3Q3C" || sArea == "MAP_M1Q6A")
    {

        //Raise(oPlayer);
        //string sDestTag = "M4QD07_ENTER";
        //object oSpawnPoint = GetObjectByTag(sDestTag);
//        AssignCommand(oPlayer, DelayCommand(1.0, JumpToLocation(GetLocation(oSpawnPoint))));
// * MAY 2002: Just popup the YOU ARE DEAD panel at this point
        DelayCommand(2.5, PopUpDeathGUIPanel(oPlayer,FALSE, TRUE, 66487));
        return;
    }

    // * make friendly to Each of the 3 common factions
    AssignCommand(oPlayer, ClearAllActions());
    // * Note: waiting for Sophia to make SetStandardFactionReptuation to clear all personal reputation
    if (GetStandardFactionReputation(STANDARD_FACTION_COMMONER, oPlayer) <= 10)
    {   SetLocalInt(oPlayer, "NW_G_Playerhasbeenbad", 10); // * Player bad
        SetStandardFactionReputation(STANDARD_FACTION_COMMONER, 80, oPlayer);
    }
    if (GetStandardFactionReputation(STANDARD_FACTION_MERCHANT, oPlayer) <= 10)
    {   SetLocalInt(oPlayer, "NW_G_Playerhasbeenbad", 10); // * Player bad
        SetStandardFactionReputation(STANDARD_FACTION_MERCHANT, 80, oPlayer);
    }
    if (GetStandardFactionReputation(STANDARD_FACTION_DEFENDER, oPlayer) <= 10)
    {   SetLocalInt(oPlayer, "NW_G_Playerhasbeenbad", 10); // * Player bad
        SetStandardFactionReputation(STANDARD_FACTION_DEFENDER, 80, oPlayer);
    }

//  DelayCommand(2.5, PopUpGUIPanel(oPlayer,GUI_PANEL_PLAYER_DEATH));
    if (OBJECT_INVALID != GetItemPossessedBy(oPlayer, "DeathToken"))
    {
        DestroyObject(GetItemPossessedBy(oPlayer, "DeathToken"));
    }
    location lDeathSpot = GetLocation(oPlayer);
    object oCorpse = CreateObject(OBJECT_TYPE_PLACEABLE,"playercorpse",lDeathSpot);

    // Remove any Ki Shuriken
    object oShuriken = GetItemInSlot(INVENTORY_SLOT_RIGHTHAND,oPlayer);
    if (GetTag(oShuriken) == "kishuriken")
    {
        DestroyObject(oShuriken);
    }
    oShuriken = GetFirstItemInInventory(oPlayer);
    while (oShuriken != OBJECT_INVALID)
    {
        if (GetTag(oShuriken) == "kishuriken")
        {
            DestroyObject(oShuriken);
        }
        oShuriken = GetNextItemInInventory(oPlayer);
    }

    // Now move all Droppable items into the placeable's inventory
    object oItem = GetFirstItemInInventory(oPlayer);
    while (GetIsObjectValid(oItem))
    {
        if ((GetItemCursedFlag(oItem) == FALSE) && (GetTag(oItem)!="NW_WBWSL001") && (GetTag(oItem)!="DyeKit"))
        {
            AssignCommand(oCorpse,ActionTakeItem(oItem,oPlayer));
        }
        oItem = GetNextItemInInventory(oPlayer);
    }
    AssignCommand(oCorpse,TakeGoldFromCreature(GetGold(oPlayer),oPlayer));
    SetLocalString(oCorpse,"PlayerName",GetPCPlayerName(oPlayer));
    SetName(oCorpse,GetName(oPlayer)+"'s Corpse");
    SetLocalString(oCorpse,"PlayerName",GetPCPlayerName(oPlayer));
    CreateItemOnObject("deathtoken",oPlayer);
    CreateItemOnObject("reapertoken",oPlayer);
    ExportSingleCharacter(oPlayer);
}
