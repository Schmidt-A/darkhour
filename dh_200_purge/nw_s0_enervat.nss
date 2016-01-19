//::///////////////////////////////////////////////
//:: Enervation
//:: NW_S0_Enervat.nss
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Target Loses 1d4 levels for 1 hour per caster
    level
*/
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: Jan 7, 2002
//:://////////////////////////////////////////////
// Edited by ChronusH
#include "NW_I0_SPELLS"
#include "x2_inc_spellhook"
void main()
{
SendMessageToPC(OBJECT_SELF, "This spell has been banned from use. Please relevel or reselect spells.");

    if (!X2PreSpellCastCode())
    {
    // If code within the PreSpellCastHook (i.e. UMD) reports FALSE, do not run this spell
        return;
    }
SetModuleOverrideSpellScriptFinished();
}

