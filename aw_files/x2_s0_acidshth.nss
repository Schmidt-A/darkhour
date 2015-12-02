//::///////////////////////////////////////////////
//:: Mestil's Acid Sheath
//:: X2_S0_AcidShth
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    This spell creates an acid shield around your
    person. Any creature striking you with its body
    does normal damage, but at the same time the
    attacker takes 1d6 points +2 points per caster
    level of acid damage. Weapons with exceptional
    reach do not endanger thier uses in this way.
*/
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: Jan 7, 2002
//:: 2003-07-07: Stacking Spell Pass, Georg Zoeller
//:://////////////////////////////////////////////

#include "x2_inc_spellhook"
#include "x0_i0_spells"

void ApplyFireShield(object oTarget,object SpellTracker)
{


        int nNow = FloatToInt(HoursToSeconds(GetCalendarDay()*24 + GetTimeHour())) + GetTimeMinute()*60 + GetTimeSecond();

        int nLastUse = GetLocalInt(SpellTracker,"LastUse" + IntToString(SPELL_ELEMENTAL_SHIELD));
        int doExtend = GetLocalInt(SpellTracker,"fireShieldExtend");
        int nDuration;

        if (doExtend)
        {
            nDuration = (GetCasterLevel(oTarget)*2) - ((nNow - nLastUse)/6);
        }
        else
        {
            nDuration = GetCasterLevel(oTarget) - ((nNow - nLastUse)/6);
        }

        //FloatingTextStringOnCreature(IntToString(nDuration),oTarget);



        RemoveSpellEffects(SPELL_ELEMENTAL_SHIELD,oTarget,oTarget);




        effect eVis = EffectVisualEffect(VFX_DUR_ELEMENTAL_SHIELD);
        int nDamage = GetCasterLevel(OBJECT_SELF)/2;
        //int nMetaMagic = GetMetaMagicFeat();
        //FloatingTextStringOnCreature(IntToString(nDamage),OBJECT_SELF);
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

                //Enter Metamagic conditions
                /*if (nMetaMagic == METAMAGIC_EXTEND)
                {
                    nDuration = nDuration *2; //Duration is +100%
                }  */
                //Apply the VFX impact and effects
        DelayCommand(1.0,ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, RoundsToSeconds(nDuration)));






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

    //record use of spell for anti stacking
    int nNow = FloatToInt(HoursToSeconds(GetCalendarDay()*24 + GetTimeHour())) + GetTimeMinute()*60 + GetTimeSecond();
    object SpellTracker = GetLocalObject(OBJECT_SELF,"spelltracker");
    SetLocalInt(SpellTracker,"LastUse"+IntToString(SPELL_MESTILS_ACID_SHEATH),nNow);
    //Declare major variables
    effect eVis = EffectVisualEffect(448);
    int nDuration = GetCasterLevel(OBJECT_SELF);
    //:Xarg: Booyah.. The Shield Stacking Mages are sure off balance... int nDamage = nDuration * 2;
    int nDamage = nDuration;

    int nMetaMagic = GetMetaMagicFeat();
    object oTarget = OBJECT_SELF;

    if (GetHasSpellEffect(SPELL_ELEMENTAL_SHIELD))
    {
        nDamage = nDamage/2;
        ApplyFireShield(oTarget,SpellTracker);
    }

    effect eShield = EffectDamageShield(nDamage, DAMAGE_BONUS_1d6, DAMAGE_TYPE_ACID);
    effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_POSITIVE);

    //Link effects
    effect eLink = EffectLinkEffects(eShield, eDur);
    eLink = EffectLinkEffects(eLink, eVis);

    //Fire cast spell at event for the specified target
    SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, GetSpellId(), FALSE));

    //Enter Metamagic conditions
    if (nMetaMagic == METAMAGIC_EXTEND)
    {
        nDuration = nDuration *2; //Duration is +100%
        SetLocalInt(SpellTracker,"acidShieldExtend",1);
    }
    else
    {
        SetLocalInt(SpellTracker,"acidShieldExtend",0);
    }

    // 2003-07-07: Stacking Spell Pass, Georg
    RemoveEffectsFromSpell(oTarget, GetSpellId());

    //Apply the VFX impact and effects
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, RoundsToSeconds(nDuration));
}

