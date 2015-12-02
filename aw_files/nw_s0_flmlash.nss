//::///////////////////////////////////////////////
//:: Flame Lash
//:: NW_S0_FlmLash.nss
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Creates a whip of fire that targets a single
    individual
*/
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: Nov 21, 2001
//:://////////////////////////////////////////////

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
    object oTarget = GetSpellTargetObject();
    int nCasterLevel = GetCasterLevel(OBJECT_SELF);
    int nMetaMagic = GetMetaMagicFeat();
    int nCasterLevel2 = 1;

    if (nCasterLevel > 0)
    {
        nCasterLevel2 = nCasterLevel/5;
    }

    if(nCasterLevel > 3)
    {
        nCasterLevel = (nCasterLevel-3)/3;
    }
    else
    {
        nCasterLevel = 0;
    }
    int nDamage = d6(2 + nCasterLevel);
    int nDamage2 = d6(nCasterLevel2);
    //Enter Metamagic conditions
    if (nMetaMagic == METAMAGIC_MAXIMIZE)
    {
        nDamage = 6 * (2 + nCasterLevel);//Damage is at max
        nDamage2 = 6 * (nCasterLevel2);
    }
    else if (nMetaMagic == METAMAGIC_EMPOWER)
    {
        nDamage = nDamage + (nDamage/2); //Damage/Healing is +50%
        nDamage2 = nDamage2 + (nDamage2/2);
    }
    effect eVis = EffectVisualEffect(VFX_IMP_FLAME_S);
    effect eRay = EffectBeam(VFX_BEAM_FIRE_LASH, OBJECT_SELF, BODY_NODE_HAND);
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eRay, oTarget, 1.7);

    if(!GetIsReactionTypeFriendly(oTarget))
    {
        //Fire cast spell at event for the specified target
        SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_FLAME_LASH));
        if (!MyResistSpell(OBJECT_SELF, oTarget, 1.0))
        {
            nDamage = GetReflexAdjustedDamage(nDamage, oTarget, GetSpellSaveDC(), SAVING_THROW_TYPE_FIRE);
            effect eDam = EffectDamage(nDamage, DAMAGE_TYPE_FIRE);
            effect eDam2 =  EffectDamage(nDamage2,DAMAGE_TYPE_SLASHING);
            effect eLink =  EffectLinkEffects(eDam,eDam2);
            if(nDamage > 0)
            {
                //Apply the VFX impact and effects
                DelayCommand(1.0, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget));
                DelayCommand(1.0, ApplyEffectToObject(DURATION_TYPE_INSTANT, eLink, oTarget));
            }
        }
    }
}
