//::///////////////////////////////////////////////
//:: zep_demi_userdef
//:://////////////////////////////////////////////
/*
    Custom events for the demilich.

    HEARTBEAT: The demilich will revert to "rest" mode
    if there are no threats nearby.

    SPELL CAST AT: The demilich may attempt to trap
    the soul of the caster.
*/
//:://////////////////////////////////////////////
//:: Created by: Loki Hakanin
//:: Modified by: The Krit
//:: Modified on: May 10, 2007
//:://////////////////////////////////////////////


// Unused. Commented out for efficiency.
//const int EVENT_USER_DEFINED_PRESPAWN = 1510;
//const int EVENT_USER_DEFINED_POSTSPAWN = 1511;


#include "nw_i0_generic"
#include "zep_inc_demi"


void main()
{
    // Determine what kind of event this is.
    switch ( GetUserDefinedEventNumber() )
    {
        case EVENT_HEARTBEAT:
                // If we're not fighting and we're at least 20 meters from
                // hostiles we want to go into "rest" mode.
                if ( !GetIsInCombat() )
                {
                    // I split the conditions so the lower CPU-cost one is checked first. -- TK
                    float fDistance = GetDistanceToObject(GetNearestCreature(
                                        CREATURE_TYPE_REPUTATION, REPUTATION_TYPE_ENEMY,
                                        OBJECT_SELF, 1, CREATURE_TYPE_IS_ALIVE, TRUE));
                    if ( fDistance < 0.0  ||  20.0 < fDistance )
                    {
                        // Spawn the appropriate skull and dust placeables.
                        ZEPDemilichSpawnBones(OBJECT_SELF, FALSE);
                        // Retreat into the placeables, so to speak.
                        SetIsDestroyable(TRUE);
                        DestroyObject(OBJECT_SELF);
                    }
                }
                break;

        // Unused. Commented out for efficiency.
        //case EVENT_PERCEIVE:
        //        break;

        // Unused. Commented out for efficiency.
        //case EVENT_END_COMBAT_ROUND:
        //        break;

        // Unused. Commented out for efficiency.
        //case EVENT_DIALOGUE:
        //        break;

        // Unused. Commented out for efficiency.
        //case EVENT_ATTACKED:
        //        break;

        // Unused. Commented out for efficiency.
        //case EVENT_DAMAGED:
        //        break;

        // case 1007: DEATH  - do not use for critical code, does not fire reliably all the time.
        //        break;

        // Unused. Commented out for efficiency.
        //case EVENT_DISTURBED:
        //        break;

        case EVENT_SPELL_CAST_AT:
                // Who dares?
                object oPC = GetLastSpellCaster();
                float  fDistance = GetDistanceToObject(oPC);
                // Choose a soul gem for the impertinent caster.
                int nGem = ZEPDemilichChooseSoulGem(oPC);

                // See if the caster is a viable target.
                // This should affect casters within maximum spell range.
                if ( nGem >= 0  &&  0.0 <= fDistance  &&  fDistance <= 50.0 )
                {
                    // Even a demilich can't do two things at once.
                    ClearAllActions();
                    // Announce our intent.
                    SpeakString(ZEP_DEMI_ONSPELL_MSG);  //"Yes, I sense you have power...your potential shall be mine!"
                    // Send feedback to the player.
                    SendMessageToPC(oPC, GetNameNPCColor(OBJECT_SELF) + ColorTokenGameEngine() +
                                    ZEP_DEMI_TRAPSOUL_MESSAGE + ColorTokenEnd());

                    // Get the save DC from the demilich.
                    int nDC = GetLocalInt(OBJECT_SELF, "ZEP_DEMI_TrapSoul_SaveDC");
                    if ( nDC == 0 )
                        // Use the module default.
                        nDC = ZEP_DEMI_TRAPSOUL_SAVEDC;
                    // Allow a fortitude save.
                    if ( FortitudeSave(oPC, nDC) == 0 )
                        // Trap the caster's soul.
                        ZEPDemilichTrapSoul(oPC, nGem);
                    else
                        // Just play a visual effect.
                        ApplyEffectToObject(DURATION_TYPE_TEMPORARY,
                            EffectBeam(VFX_BEAM_BLACK, OBJECT_SELF, BODY_NODE_HAND),
                            oPC, 1.5);

                    // Resume combat when done.
                    // (TrapSoul is timed to take up less than a combat flurry.)
                    DelayCommand(2.0, DetermineCombatRound());
                }
                break;

        // Unused. Commented out for efficiency.
        //case EVENT_USER_DEFINED_PRESPAWN:
        //        break;

        // Unused. Commented out for efficiency.
        //case EVENT_USER_DEFINED_POSTSPAWN:
        //        break;

    }//switch ( GetUserDefinedEventNumber() )
}

