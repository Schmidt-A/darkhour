//::///////////////////////////////////////////////
//:: Phantasmal Killer
//:: NW_S0_PhantKill
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Target of the spell must make 2 saves or die.
*/
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: Dec 14 , 2001
//:://////////////////////////////////////////////
//:: VFX Pass By: Preston W, On: June 22, 2001
//:: Update Pass By: Preston W, On: Aug 3, 2001
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

