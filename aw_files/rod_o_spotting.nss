//::///////////////////////////////////////////////
//:: Rod o Spotting
//:: rod_o_spotting
//:: Created by Jantima on June 2004  for Antiworld
//:://////////////////////////////////////////////
/*
    The creature can seen all invisible, sanctuared,
    or hidden opponents.
    The creature gain a bonus
*/
//:://////////////////////////////////////////////
//:: Created By: Jantima
//:: Created On: June 2004
//:://////////////////////////////////////////////

#include "x2_inc_spellhook"

void main()
{
//Replaces the old rod of spotting with "unique power, Cast Spell", with the new one with clairaudience/clairvoyance )level-10)
 object oRod =  GetItemActivated();
 object oPC = GetItemActivator();
 GiveGoldToCreature(oPC , GetGoldPieceValue(oRod));
 DestroyObject( oRod,0.2);
 FloatingTextStringOnCreature("<cé†Õ>Please buy the new 'Sixth Sense Rod'!</c>",oPC );
//CreateItemOnObject("rodofsixthsen",GetItemActivator(),1);



/*
    //Declare major variables
    object oTarget = GetItemActivatedTarget();
    object oUser = GetItemActivator();
    int oPower = GetHitDice(oUser);
    effect eVis = EffectVisualEffect(VFX_DUR_GLOW_LIGHT_GREEN);
    effect eDur = EffectVisualEffect(VFX_DUR_IOUNSTONE_GREEN);
    effect eUltra = EffectUltravision();
    effect eSpot = EffectSkillIncrease(SKILL_SPOT,(oPower+10)/2);
    effect eListen = EffectSkillIncrease(SKILL_LISTEN, (oPower+10)/2);
    effect eLink = EffectLinkEffects(eVis, eUltra);
    eLink = EffectLinkEffects(eLink,eDur);
    eLink = EffectLinkEffects(eLink,eSpot);
    eLink = EffectLinkEffects(eLink,eListen);
    //eLink = EffectLinkEffects(eLink,eUltra);
    //Fire cast spell at event for the specified target
    SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_TRUE_SEEING, FALSE));
    int nDuration = oPower/2;

    //Apply the VFX impact and effects
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, TurnsToSeconds(nDuration));
    */
}

