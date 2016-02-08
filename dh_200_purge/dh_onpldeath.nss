/* Big overhaul on this thing to support our new PC Token persistent storage,
 * and the updates to the raise tool by Tweek Feb 2016. */

#include "_incl_pc_data"
#include "_incl_inventory"
#include "nwnx_funcs"
#include "subdual_inc"
#include "x3_inc_string"
#include "x0_i0_stringlib"


/* Reset any raise tool attempts that have been used on this player before
   and also reset the "dead too long" value. */
void ClearRaiseData(object oPC)
{
    struct LocalVariable var = GetFirstLocalVariable(oPC);
    struct sStringTokenizer st;
    string sVars = "";

    // Collect all variables we need to delete because lists + deletion is dumb
    while(var.name != "")
    {
        if(GetStringLeft(var.name, 13) == "bRaiseAttempt")
            sVars += var.name + "|";
        var = GetNextLocalVariable(var);
    }

    // Deletion loop
    st = GetStringTokenizer(sVars, "|");
    while(HasMoreTokens(st))
    {
        DeleteLocalInt(oPC, GetNextToken(st));
        st = AdvanceToNextToken(st);

        // Need to do it for the last one, since we won't hit this loop again.
        if(!HasMoreTokens(st))
            DeleteLocalInt(oPC, GetNextToken(st));
    }

    SetLocalInt(oPC, "bDeadTooLong", FALSE);
    DelayCommand(240.0, SetLocalInt(oPC, "bDeadTooLong", TRUE));
}

void ResetFactions(object oPC)
{
    AssignCommand(oPC, ClearAllActions());
    // * Note: waiting for Sophia to make SetStandardFactionReptuation to clear all personal reputation
    // Tweek note: dafuq
    // * make friendly to Each of the 3 common factions
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
}

void main()
{
    object oPC = GetLastPlayerDied();
    object oKiller = GetLastHostileActor(oPC);

    if (CheckSubdual(oPC))
        return;

    PCDSetDead(oPC);
    ClearRaiseData(oPC);
    ResetFactions(oPC);

    location lDeathSpot = GetLocation(oPC);
    object oCorpse = CreateObject(OBJECT_TYPE_PLACEABLE, "playercorpse",
            lDeathSpot);
    TransferAllItems(oPC, oCorpse);
    SetName(oCorpse, GetName(oPC)+"'s Corpse");

    // Used for the auto-pickup script.
    SetLocalString(oCorpse, "PlayerName", GetPCPlayerName(oPC));

    ExportSingleCharacter(oPC);
}
