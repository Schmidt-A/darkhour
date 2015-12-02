//::///////////////////////////////////////////////
//:: Find Traps
//:: NW_S0_FindTrap
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Finds and removes all traps within 30m.
*/
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: Oct 29, 2001
//:://////////////////////////////////////////////

#include "x2_inc_spellhook"

void main()
{

/*
  Spellcast Hook Code
  Added 2003-06-23 by GeorgZ
  If you want to make changes to all spells,
  check x2_inc_spellhook.nss to find out more

*/

    if (!X2PreSpellCastCode())
    {
    // If code within the PreSpellCastHook (i.e. UMD) reports FALSE, do not run this spell
        return;
    }

// End of Spell Cast Hook


    effect eVis = EffectVisualEffect(VFX_IMP_KNOCK);
    int nCnt = 1;
    object oTrap = GetNearestObject(OBJECT_TYPE_TRIGGER | OBJECT_TYPE_DOOR | OBJECT_TYPE_PLACEABLE, OBJECT_SELF, nCnt);
    int oTrapDC = GetTrapDisarmDC(oTrap);
    int nRoll = d20();
    int nIntAbilityMod = GetAbilityModifier(ABILITY_INTELLIGENCE,OBJECT_SELF);
    int nChaAbilityMod = GetAbilityModifier(ABILITY_CHARISMA,OBJECT_SELF);
    int nAbilityMod = 0;
    if  (nIntAbilityMod > nChaAbilityMod)  nAbilityMod = nIntAbilityMod ; else nAbilityMod = nChaAbilityMod;
    int nSpellDC = GetCasterLevel(OBJECT_SELF)+ nAbilityMod + nRoll;
    SendMessageToPC(OBJECT_SELF, IntToString(nRoll) + " (Roll) + " + IntToString(nAbilityMod) + " (Caster Ability Modifier) + Caster Level, versus Traps DC");

    while(GetIsObjectValid(oTrap) && GetDistanceToObject(oTrap) <= 25.0 && nSpellDC >= oTrapDC)
    {
        if(GetIsTrapped(oTrap))
        {
            SetTrapDetectedBy(oTrap, OBJECT_SELF);
            ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eVis, GetLocation(oTrap));
            DelayCommand(2.0, SetTrapDisabled(oTrap));
        }
        nCnt++;
        oTrap = GetNearestObject(OBJECT_TYPE_TRIGGER | OBJECT_TYPE_DOOR | OBJECT_TYPE_PLACEABLE, OBJECT_SELF, nCnt);
        oTrapDC = GetLockUnlockDC(oTrap);
    }
}

