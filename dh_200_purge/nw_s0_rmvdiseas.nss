//::///////////////////////////////////////////////
//:: Remove Disease
//:: NW_S0_RmvDiseas.nss
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Removes all disease effects on the character.
*/
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: Aug 7, 2001
//:://////////////////////////////////////////////
//:: VFX Pass By: Preston W, On: June 22, 2001

#include "_incl_disease"
#include "_incl_pc_data"

void main()
{
    object oCaster  = GetLastSpellCaster();
    object oTarget  = GetSpellTargetObject();

    int iCasterLevel = GetCasterLevel(oCaster);
    int iDisease     = PCDGetDiseaseValue(oTarget);
    int bDoVFX       = FALSE;

    string sMsg;

    //Fire cast spell at event for the specified target
    SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_REMOVE_DISEASE, FALSE));

    // Zombie disease effects.
    if(iCasterLevel >= iDisease && iDisease > 0)
    {
        CureDisease(oTarget, iDisease);
        sMsg = "You manage to cleanse " + GetName(oTarget) + "'s plague.";
    }
    else if(iDisease > 0)
    {
        sMsg = "Your divine magic is not potent enough to deal with " +
            GetName(oTarget) + "'s disease, ill as they are.";
    }
    else
        sMsg = GetName(oTarget) + " has no trace of the plague on them.";
    FloatingTextStringOnCreature(sMsg, oCaster, FALSE);

    // Normal disease effects.
    effect eEffect = GetFirstEffect(oTarget);
    while(GetIsEffectValid(eEffect))
    {
        if (GetEffectType(eEffect) == EFFECT_TYPE_DISEASE)
        {
            RemoveEffect(oTarget, eEffect);
            bDoVFX = TRUE;
        }
        GetNextEffect(oTarget);
    }
    if(bDoVFX)
    {
        ApplyEffectToObject(DURATION_TYPE_INSTANT,
                EffectVisualEffect(VFX_IMP_REMOVE_CONDITION), oTarget);
    }
}
