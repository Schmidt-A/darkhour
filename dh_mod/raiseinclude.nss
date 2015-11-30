//#include "subdual_inc"
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
        effect eVisual = EffectVisualEffect(VFX_IMP_PULSE_HOLY);

        effect eBad = GetFirstEffect(oPlayer);
        ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectResurrection(),oPlayer);

        if ((OBJECT_INVALID != GetItemPossessedBy(oPlayer, "DeathToken")) && (GetIsPossessedFamiliar(oPlayer) == FALSE))
        {
            DestroyObject(GetItemPossessedBy(oPlayer, "DeathToken"));
        }
        if ((OBJECT_INVALID != GetItemPossessedBy(oPlayer, "ReaperToken")) && (GetIsPossessedFamiliar(oPlayer) == FALSE))
        {
            DestroyObject(GetItemPossessedBy(oPlayer, "ReaperToken"));
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
        SignalEvent(oPlayer, EventSpellCastAt(OBJECT_SELF, SPELL_RESTORATION, FALSE));
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eVisual, oPlayer);
}
