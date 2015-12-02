//::///////////////////////////////////////////////
//:: Darkfire
//:: X2_S0_Darkfire
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
  Gives a melee weapon 1d6 fire damage +1 per two caster
  levels to a maximum of +10.
*/
//:://////////////////////////////////////////////
//:: Created By: Andrew Nobbs
//:: Created On: Dec 04, 2002
//:://////////////////////////////////////////////
//:: Updated by Andrew Nobbs May 08, 2003
//:: 2003-07-29: Rewritten, Georg Zoeller


#include "nw_i0_spells"
#include "x2_i0_spells"

#include "x2_inc_spellhook"


void AddFlamingEffectToWeapon(object oTarget, float fDuration, int nCasterLvl)
{
   // If the spell is cast again, any previous itemproperties matching are removed.
   //IPSafeAddItemProperty(oTarget, ItemPropertyOnHitCastSpell(127,nCasterLvl), fDuration, X2_IP_ADDPROP_POLICY_REPLACE_EXISTING);
    int nBonus = IP_CONST_DAMAGEBONUS_2;
   if (nCasterLvl >= 25) nBonus = IP_CONST_DAMAGEBONUS_1d10;
   else if (nCasterLvl >= 20 ) nBonus = IP_CONST_DAMAGEBONUS_1d8;
   else if (nCasterLvl >= 15 ) nBonus = IP_CONST_DAMAGEBONUS_1d6;
   else if (nCasterLvl >= 10 ) nBonus = IP_CONST_DAMAGEBONUS_1d4;

   IPSafeAddItemProperty(oTarget,  ItemPropertyDamageBonus(IP_CONST_DAMAGETYPE_FIRE,nBonus), fDuration, X2_IP_ADDPROP_POLICY_REPLACE_EXISTING);

   IPSafeAddItemProperty(oTarget, ItemPropertyVisualEffect(ITEM_VISUAL_FIRE), fDuration,X2_IP_ADDPROP_POLICY_REPLACE_EXISTING,FALSE,TRUE);
   return;
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
    effect eVis = EffectVisualEffect(VFX_IMP_PULSE_FIRE);
    eVis = EffectLinkEffects(EffectVisualEffect(VFX_IMP_FLAME_M),eVis);
    effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_POSITIVE);
    int nDuration = 2 * GetCasterLevel(OBJECT_SELF);
    int nMetaMagic = GetMetaMagicFeat();
    int nCasterLvl = GetCasterLevel(OBJECT_SELF);

    if (nMetaMagic == METAMAGIC_EXTEND)
    {
        nDuration = nDuration * 2; //Duration is +100%
    }

   object oMyWeapon   =  IPGetTargetedOrEquippedMeleeWeapon();

   if(GetIsObjectValid(oMyWeapon) )
   {
        SignalEvent(GetItemPossessor(oMyWeapon), EventSpellCastAt(OBJECT_SELF, GetSpellId(), FALSE));

        if (nDuration>0)
        {
            ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, GetItemPossessor(oMyWeapon));
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eDur, GetItemPossessor(oMyWeapon), TurnsToSeconds(nDuration));
            AddFlamingEffectToWeapon(oMyWeapon, TurnsToSeconds(nDuration),nCasterLvl);
         }
            return;
    }
     else
    {
           FloatingTextStrRefOnCreature(83615, OBJECT_SELF);
           return;
    }

}
