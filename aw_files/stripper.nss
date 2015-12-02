#include "inc_bs_module"
#include "x0_i0_spells"
void main()
{
    float nDuration = 120.0;
    object oPC= GetItemActivator();
    object oTarget = GetItemActivatedTarget();

    int nPCTeam = GetLocalInt(oPC, "nTeam");

    BroadcastMessage("<cëLÊ>" + GetName(oPC) + " of " + GetTeamName(nPCTeam) + " used the Stripper!! </c>");

    effect eTarget = GetFirstEffect(oTarget);

    while (GetIsEffectValid(eTarget))
    {

        if ( GetEffectDurationType(eTarget) == DURATION_TYPE_TEMPORARY) //only remove temporary effects
        {
            int nSpellID = GetEffectSpellId(eTarget);

            if (nSpellID == SPELL_ELEMENTAL_SHIELD)
            {
                    int nDamage = GetCasterLevel(oTarget);
                    effect eVis = EffectVisualEffect(VFX_DUR_ELEMENTAL_SHIELD);
                    effect eShield = EffectDamageShield(nDamage, DAMAGE_BONUS_1d6, DAMAGE_TYPE_FIRE);
                    effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_POSITIVE);
                    effect eCold = EffectDamageImmunityIncrease(DAMAGE_TYPE_COLD, 50);
                    effect eFire = EffectDamageImmunityIncrease(DAMAGE_TYPE_FIRE, 50);

                    //Link effects
                    effect eLink = EffectLinkEffects(eShield, eCold);
                    eLink = EffectLinkEffects(eLink, eFire);
                    eLink = EffectLinkEffects(eLink, eDur);
                    eLink = EffectLinkEffects(eLink, eVis);

                    //Fire cast spell at event for the specified target
                    SignalEvent(oPC, EventSpellCastAt(oPC, SPELL_ELEMENTAL_SHIELD, FALSE));

                    //  *GZ: No longer stack this spell
                    if (GetHasSpellEffect(SPELL_ELEMENTAL_SHIELD,oTarget))
                    {
                         RemoveSpellEffects(SPELL_ELEMENTAL_SHIELD, oPC, oTarget);
                    }

                    //Apply the VFX impact and effects
                    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oPC,nDuration);
            }
            else if (nSpellID == SPELL_MESTILS_ACID_SHEATH)
            {
                    effect eVis = EffectVisualEffect(448);
                    int nDamage = GetCasterLevel(oTarget);
                    effect eShield = EffectDamageShield(nDamage, DAMAGE_BONUS_1d6, DAMAGE_TYPE_ACID);
                    effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_POSITIVE);

                    //Link effects
                    effect eLink = EffectLinkEffects(eShield, eDur);
                    eLink = EffectLinkEffects(eLink, eVis);

                    //Fire cast spell at event for the specified target
                    SignalEvent(oTarget, EventSpellCastAt(oPC, GetSpellId(), FALSE));



                    // 2003-07-07: Stacking Spell Pass, Georg
                    RemoveEffectsFromSpell(oTarget, SPELL_MESTILS_ACID_SHEATH);

                    //Apply the VFX impact and effects
                    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oPC,nDuration);
            }
            else if (nSpellID == SPELL_WOUNDING_WHISPERS)
            {
                    effect eVis = EffectVisualEffect(VFX_DUR_MIND_AFFECTING_POSITIVE);
                    int nDuration = GetCasterLevel(oTarget);
                    int nBonus = nDuration;
                    int nMetaMagic = GetMetaMagicFeat();

                    effect eShield = EffectDamageShield(d6(1) + nBonus, 0, DAMAGE_TYPE_SONIC);
                    effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_POSITIVE);

                    //Link effects
                    effect eLink = EffectLinkEffects(eShield, eDur);
                    eLink = EffectLinkEffects(eLink, eVis);

                    //Fire cast spell at event for the specified target
                    SignalEvent(oTarget, EventSpellCastAt(oPC, 441, FALSE));

                    if (GetHasSpellEffect(GetSpellId()))
                    {
                        RemoveSpellEffects(GetSpellId(),oPC,oPC);
                    }

                    //Enter Metamagic conditions
                    if (nMetaMagic == METAMAGIC_EXTEND)
                    {
                        nDuration = nDuration *2; //Duration is +100%
                    }
                    //Apply the VFX impact and effects
                    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oPC, RoundsToSeconds(nDuration));
            }
            else
            {
                ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eTarget,oPC,120.0);
            }

            RemoveEffect(oTarget,eTarget);
        }
        eTarget = GetNextEffect(oTarget);
    }
}
