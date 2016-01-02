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
    int nDamage = d6(3);
    int nMetaMagic = GetMetaMagicFeat();
    object oTarget = GetSpellTargetObject();
    effect eDam;
    effect eVis = EffectVisualEffect(VFX_IMP_DEATH);
    effect eVis2 = EffectVisualEffect(VFX_IMP_SONIC);
	if(!GetIsReactionTypeFriendly(oTarget))
	{
        //Fire cast spell at event for the specified target
        SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_PHANTASMAL_KILLER));
        //Make an SR check
        if(!MyResistSpell(OBJECT_SELF, oTarget))
        {
            //Make a Will save
            if (!MySavingThrow(SAVING_THROW_WILL,  oTarget, GetSpellSaveDC(), SAVING_THROW_TYPE_MIND_SPELLS))
            {
                //Make a Fort save
                if (MySavingThrow(SAVING_THROW_FORT, oTarget, GetSpellSaveDC(),SAVING_THROW_TYPE_DEATH))
                {
                     //Check for metamagic
                     if (nMetaMagic == METAMAGIC_MAXIMIZE)
                     {
                        nDamage = 18;
                     }
                     if (nMetaMagic == METAMAGIC_EMPOWER)
                     {
                        nDamage = FloatToInt( IntToFloat(nDamage) * 1.5 );
                     }
                     //Set the damage property
                     eDam = EffectDamage(nDamage, DAMAGE_TYPE_MAGICAL);
                     //Apply the damage effect and VFX impact
                     ApplyEffectToObject(DURATION_TYPE_INSTANT, eDam, oTarget);
                     ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis2, oTarget);
                }
                else
                {
                     //Apply the death effect and VFX impact
                     ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectDeath(), oTarget);
                     //ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
                }
            }
        }
    }
}
