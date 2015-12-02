//::///////////////////////////////////////////////
//:: Blade Thrist
//:: X2_S0_BldeThst
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
  Grants a +3 enhancement bonus to a slashing weapon
*/
//:://////////////////////////////////////////////
//:: Created By: Andrew Nobbs
//:: Created On: Nov 27, 2002
//:://////////////////////////////////////////////
//:: Updated by Andrew Nobbs May 08, 2003
//:: 2003-07-07: Stacking Spell Pass, Georg Zoeller
//:: 2003-07-21: Complete Rewrite to make use of Item Property System


//Changes made july 2005 by Eva01goneBerserk
//Spell grant Vampiric Regen +1 per 3 caster levels to a max of + 5
//For a number of turns equall to your caster level
#include "nw_i0_spells"
#include "x2_i0_spells"

#include "x2_inc_spellhook"


void  AddEnhanceEffectToWeapon(object oMyWeapon, float fDuration)

{
   int nScale = (GetCasterLevel(OBJECT_SELF) / 3);
    // * must fall between +1 and +5
    if (nScale < 1)
        nScale = 1;
    else
    if (nScale > 5)
        nScale = 5;
   IPSafeAddItemProperty(oMyWeapon,ItemPropertyVampiricRegeneration(nScale), fDuration, X2_IP_ADDPROP_POLICY_REPLACE_EXISTING,FALSE,TRUE);
}

void main()
{

    /*
      Spellcast Hook Code
      Added 2003-07-07 by Georg Zoeller
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
    effect eVis = EffectVisualEffect(VFX_IMP_SUPER_HEROISM);
    effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_POSITIVE);
    int nDuration = 2 * GetCasterLevel(OBJECT_SELF);
    int nMetaMagic = GetMetaMagicFeat();

     object oMyWeapon   =  IPGetTargetedOrEquippedMeleeWeapon();

    if (nMetaMagic == METAMAGIC_EXTEND)
    {
        nDuration = nDuration * 2; //Duration is +100%
    }

     if(GetIsObjectValid(oMyWeapon) )
    {
        SignalEvent(GetItemPossessor(oMyWeapon), EventSpellCastAt(OBJECT_SELF, GetSpellId(), FALSE));

        if (nDuration>0)
        {
            ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, GetItemPossessor(oMyWeapon));
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eDur, GetItemPossessor(oMyWeapon), TurnsToSeconds(nDuration));
            AddEnhanceEffectToWeapon(oMyWeapon, TurnsToSeconds(nDuration));

        }
        return;
    }
        else
    {
           FloatingTextStrRefOnCreature(83615, OBJECT_SELF);
           return;
    }
}

