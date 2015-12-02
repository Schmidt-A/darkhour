//Bestow Curse
//Melee Touch Attack
//ByEva01goneBerserk

#include "NW_I0_SPELLS"
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
    //Declare major variables
    int nDuration = GetCasterLevel(OBJECT_SELF);
    object oTarget = GetSpellTargetObject();
    effect eVis = EffectVisualEffect(VFX_IMP_REDUCE_ABILITY_SCORE);
    effect eCurse = EffectCurse(2, 2, 2, 2, 2, 2);
    //Make sure that curse is of type supernatural not magical
    eCurse = SupernaturalEffect(eCurse);
    if(!GetIsReactionTypeFriendly(oTarget))
    {
    //Signal spell cast at event
    SignalEvent(oTarget, EventSpellCastAt(oTarget, SPELL_BESTOW_CURSE));
    //Make SR Check
    if(!MyResistSpell(OBJECT_SELF, oTarget) && TouchAttackMelee(oTarget))
    {
    //Apply Effect and VFX
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eCurse, oTarget, RoundsToSeconds(nDuration/3));
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
    }
    }
    }

