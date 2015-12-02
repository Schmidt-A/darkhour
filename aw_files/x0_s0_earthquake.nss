//::///////////////////////////////////////////////
//:: Earthquake
//:: X0_S0_Earthquake
//:: Copyright (c) 2002 Bioware Corp.
//:://////////////////////////////////////////////
/*
// Ground shakes. 1d6 damage, max 10d6
// LOCKINDAL: Changed to alternate: DC 15 or knock down, 25% creatures must make DC 20 or die.
*/
#include "X0_I0_SPELLS"
#include "x2_inc_spellhook"

void main()
{
SetLocalInt(OBJECT_SELF, "X2_L_LAST_SPELLSCHOOL_VAR", SPELL_SCHOOL_EVOCATION);
/*
  Spellcast Hook Code
  Added 2003-06-20 by Georg
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

    object oCaster = OBJECT_SELF;
    int CasterLvl = GetCasterLevel(OBJECT_SELF);
    int nMetaMagic = GetMetaMagicFeat();
    int nRandom = 0;
    int nSpectacularDeath = TRUE;
    int nDisplayFeedback = TRUE;
    float fDelay;
    float nSize =  RADIUS_SIZE_COLOSSAL;
    effect eExplode = EffectVisualEffect(VFX_COM_CHUNK_STONE_MEDIUM);
    effect eExplode2 = EffectVisualEffect(VFX_FNF_GAS_EXPLOSION_NATURE);
    effect eExplode3 = EffectVisualEffect(VFX_IMP_DUST_EXPLOSION);
    effect eVis = EffectVisualEffect(VFX_IMP_HEAD_NATURE);
    effect eShake = EffectVisualEffect(356);
    effect eKnockdown = EffectKnockdown();
    float fDuration = 9.0;
    //Get the spell target location as opposed to the spell target.
    location lTarget = GetSpellTargetLocation();
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eShake, OBJECT_SELF, RoundsToSeconds(6));

    //Apply epicenter explosion on caster
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eExplode, GetLocation(OBJECT_SELF));
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eExplode2, GetLocation(OBJECT_SELF));
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eExplode3, GetLocation(OBJECT_SELF));
    //Declare the spell shape, size and the location.  Capture the first target object in the shape.
    object oTarget = GetFirstObjectInShape(SHAPE_SPHERE, nSize, lTarget, TRUE, OBJECT_TYPE_CREATURE | OBJECT_TYPE_DOOR | OBJECT_TYPE_PLACEABLE);
    //Cycle through the targets within the spell shape until an invalid object is captured.
    while (GetIsObjectValid(oTarget))
    {
        nRandom = d4();   // if they roll a 3 on this, they must make nDC or die.

        //knockdown effect applies to ALL creatures; nDC or knockdown.
        if(spellsIsTarget(oTarget, SPELL_TARGET_STANDARDHOSTILE, OBJECT_SELF))
        {
            SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_EARTHQUAKE));
           if(oTarget != oCaster)
           {
                if(ReflexSave(oTarget, GetSpellSaveDC(), SAVING_THROW_REFLEX, OBJECT_SELF) == 0)

                {
                 ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eKnockdown, oTarget, fDuration);
                }
           }
        }

        if (spellsIsTarget(oTarget, SPELL_TARGET_STANDARDHOSTILE, OBJECT_SELF) && nRandom == 3)
        {
            //Fire cast spell at event for the specified target
            //Get the distance between the explosion and the target to calculate delay
                fDelay = GetDistanceBetweenLocations(lTarget, GetLocation(oTarget))/20;
                //Reflex nDC or die.
                if (oTarget != oCaster)
                {
                  if(ReflexSave(oTarget, GetSpellSaveDC(), SAVING_THROW_REFLEX, OBJECT_SELF) == 0)
                  {

                    effect eDeath = EffectDeath(nSpectacularDeath, nDisplayFeedback);
                    ApplyEffectToObject(DURATION_TYPE_INSTANT,eDeath, oTarget);
                  }
                }
        }
       //Select the next target within the spell shape.
       oTarget = GetNextObjectInShape(SHAPE_SPHERE, nSize, lTarget, TRUE, OBJECT_TYPE_CREATURE | OBJECT_TYPE_DOOR | OBJECT_TYPE_PLACEABLE);
    }

DeleteLocalInt(OBJECT_SELF, "X2_L_LAST_SPELLSCHOOL_VAR");
// Erasing the variable used to store the spell's spell school
}
