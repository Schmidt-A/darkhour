//::///////////////////////////////////////////////
//:: Elemental Shield
//:: NW_S0_FireShld.nss
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Caster gains 50% cold and fire immunity.  Also anyone
    who strikes the caster with melee attacks takes
    1d6 + 1 per caster level in damage.
*/
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: Jan 7, 2002
//:://////////////////////////////////////////////
//:: Created On: Aug 28, 2003, GZ: Fixed stacking issue
#include "x2_inc_spellhook"
#include "x0_i0_spells"


void ApplyAcidShield(object oTarget,object SpellTracker)
{
        int nDuration;
        int nNow = FloatToInt(HoursToSeconds(GetCalendarDay()*24 + GetTimeHour())) + GetTimeMinute()*60 + GetTimeSecond();
        int nLastUse = GetLocalInt(SpellTracker,"LastUse" + IntToString(SPELL_MESTILS_ACID_SHEATH));

        int doExtend = GetLocalInt(SpellTracker,"acidShieldExtend");

        if (doExtend)
        {
            nDuration = (GetCasterLevel(oTarget)*2) - ((nNow - nLastUse)/6);
        }
        else
        {
            nDuration = GetCasterLevel(oTarget) - ((nNow - nLastUse)/6);
        }





        RemoveSpellEffects(SPELL_MESTILS_ACID_SHEATH,oTarget,oTarget);


        effect eVis = EffectVisualEffect(448);

        int nDamage = GetCasterLevel(oTarget)/2;

        int nMetaMagic = GetMetaMagicFeat();

        effect eShield = EffectDamageShield(nDamage, DAMAGE_BONUS_1d6, DAMAGE_TYPE_ACID);
        effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_POSITIVE);

        //Link effects
        effect eLink = EffectLinkEffects(eShield, eDur);
        eLink = EffectLinkEffects(eLink, eVis);

        //Fire cast spell at event for the specified target
        SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, GetSpellId(), FALSE));

        //Enter Metamagic conditions
        /*if (nMetaMagic == METAMAGIC_EXTEND)
        {
            nDuration = nDuration *2; //Duration is +100%
        }  */

        // 2003-07-07: Stacking Spell Pass, Georg


        //Apply the VFX impact and effects
        DelayCommand(1.0,ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, RoundsToSeconds(nDuration)));



}



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

    //set last use
    object SpellTracker = GetLocalObject(OBJECT_SELF,"spelltracker");
      int nNow = FloatToInt(HoursToSeconds(GetCalendarDay()*24 + GetTimeHour())) + GetTimeMinute()*60 + GetTimeSecond();
      int nLastUse = GetLocalInt(SpellTracker,"LastUse"+IntToString(GetSpellId()));

      SetLocalInt(SpellTracker,"LastUse"+IntToString(SPELL_ELEMENTAL_SHIELD),nNow);

    //Declare major variables
    effect eVis = EffectVisualEffect(VFX_DUR_ELEMENTAL_SHIELD);
    int nDuration = GetCasterLevel(OBJECT_SELF);
    int nMetaMagic = GetMetaMagicFeat();
    object oTarget = OBJECT_SELF;
    int nDamage = nDuration;

    if (GetHasSpellEffect(SPELL_MESTILS_ACID_SHEATH))
    {
        nDamage = nDamage/2;
        ApplyAcidShield(oTarget,SpellTracker);
    }

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
    SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_ELEMENTAL_SHIELD, FALSE));

    //  *GZ: No longer stack this spell
    if (GetHasSpellEffect(GetSpellId(),oTarget))
    {
         RemoveSpellEffects(GetSpellId(), OBJECT_SELF, oTarget);
    }

    //Enter Metamagic conditions
    if (nMetaMagic == METAMAGIC_EXTEND)
    {
        SetLocalInt(SpellTracker,"fireShieldExtend",1);
        nDuration = nDuration *2; //Duration is +100%
    }
    else
    {
        SetLocalInt(SpellTracker,"fireShieldExtend",0);
    }
    //Apply the VFX impact and effects
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, RoundsToSeconds(nDuration));
}

