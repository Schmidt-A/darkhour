//::///////////////////////////////////////////////
//:: Battletide
//:: X2_S0_BattTide
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    You create an aura that steals energy from your
    enemies. Your enemies suffer a -2 circumstance
    penalty on saves, attack rolls, and damage rolls,
    once entering the aura. On casting, you gain a
    +2 circumstance bonus to your saves, attack rolls,
    and damage rolls.
*/
//:://////////////////////////////////////////////
//:: Created By: Andrew Nobbs
//:: Created On: Dec 04, 2002
//:://////////////////////////////////////////////
//:: Last Updated By: Andrew Nobbs 06/06/03

#include "NW_I0_SPELLS"
#include "x2_i0_spells"

#include "x2_inc_spellhook"

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

//Antiworld change not to stack Attack bonus for clerics Divine Favor and Divine Power unstackable   Battletide
   if (GetHasEffect(EFFECT_TYPE_ATTACK_INCREASE, OBJECT_SELF )&& ( GetHasSpellEffect(SPELL_DIVINE_FAVOR,OBJECT_SELF) ||  GetHasSpellEffect(SPELL_DIVINE_POWER,OBJECT_SELF)||  GetHasSpellEffect(SPELL_BATTLETIDE,OBJECT_SELF) ) )
    {
        effect eLoop = GetFirstEffect(OBJECT_SELF);
        int nDone = 0;
        while (GetIsEffectValid(eLoop) && nDone == 0)
        {

            if ( GetEffectType(eLoop) == EFFECT_TYPE_ATTACK_INCREASE && (GetEffectSpellId(eLoop) == SPELL_DIVINE_FAVOR || GetEffectSpellId(eLoop) == SPELL_DIVINE_POWER || GetEffectSpellId(eLoop) == SPELL_BATTLETIDE )  )
            {
                RemoveEffect(OBJECT_SELF, eLoop);
                nDone = 1;
           }
            eLoop = GetNextEffect(OBJECT_SELF);
        }
        FloatingTextStringOnCreature("Attack bonus from this spell doesn't stack",OBJECT_SELF,FALSE);

    }

// End of Spell Cast Hook


    //Declare major variables
    effect eAOE = EffectAreaOfEffect(41);
    int nDuration = GetCasterLevel(OBJECT_SELF);
    //Make nDuration at least 1 round.
    if (nDuration < 1)
    {
        nDuration = 1;
    }
    int nMetaMagic = GetMetaMagicFeat();
    //Make metamagic check for extend
    if (nMetaMagic == METAMAGIC_EXTEND)
    {
        nDuration = nDuration *2;   //Duration is +100%
    }
    //Create the AOE object at the selected location
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eAOE, OBJECT_SELF, RoundsToSeconds(nDuration));
}

