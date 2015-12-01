//:://////////////////////////////////////////////////
//:: NW_C2_DEFAULT6
//:: Default OnDamaged handler
/*
    If already fighting then ignore, else determine
    combat round
 */
//:://////////////////////////////////////////////////
//:: Copyright (c) 2002 Floodgate Entertainment
//:: Created By: Naomi Novik
//:: Created On: 12/22/2002
//:://////////////////////////////////////////////////

#include "nw_i0_generic"
void Minions(location lLoc)
{
object oCre = CreateObject(OBJECT_TYPE_CREATURE,"dh_hunter1",lLoc);
DelayCommand(2.0,ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_IMP_HARM),oCre));
}
void main()
{
    object oDamager = GetLastDamager();
    int nHP = GetCurrentHitPoints();
    int nLoop = 1;
    int nOnce = GetLocalInt(OBJECT_SELF,"MinionsOnce");
    if(nOnce == FALSE)
    {
        if(nHP <= 150)
        {
        SetLocalInt(OBJECT_SELF,"MinionsOnce",TRUE);
        AssignCommand(OBJECT_SELF,SpeakString("To me my minions!"));
        ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_FNF_PWKILL), GetLocation(OBJECT_SELF));
        SoundObjectPlay(GetObjectByTag("ZLHELP"));
        TalentHeal(TRUE, OBJECT_SELF);
        while(nLoop != 6)
            {
            Minions(GetLocation(GetWaypointByTag("ZL_Minion"+IntToString(nLoop))));
            nLoop=nLoop+1;
            }
        }
    }
    if(GetFleeToExit()) {
        // We're supposed to run away, do nothing
    } else if (GetSpawnInCondition(NW_FLAG_SET_WARNINGS)) {
        // don't do anything?
    } else {
        object oDamager = GetLastDamager();
        if (!GetIsObjectValid(oDamager)) {
            // don't do anything, we don't have a valid damager
        } else if (!GetIsFighting(OBJECT_SELF)) {
            // If we're not fighting, determine combat round
            if(GetBehaviorState(NW_FLAG_BEHAVIOR_SPECIAL)) {
                DetermineSpecialBehavior(oDamager);
            } else {
                if(!GetObjectSeen(oDamager)
                   && GetArea(OBJECT_SELF) == GetArea(oDamager)) {
                    // We don't see our attacker, go find them
                    ActionMoveToLocation(GetLocation(oDamager), TRUE);
                    ActionDoCommand(DetermineCombatRound());
                } else {
                    DetermineCombatRound();
                }
            }
        } else {
            // We are fighting already -- consider switching if we've been
            // attacked by a more powerful enemy
            object oTarget = GetAttackTarget();
            if (!GetIsObjectValid(oTarget))
                oTarget = GetAttemptedAttackTarget();
            if (!GetIsObjectValid(oTarget))
                oTarget = GetAttemptedSpellTarget();

            // If our target isn't valid
            // or our damager has just dealt us 25% or more
            //    of our hp in damager
            // or our damager is more than 2HD more powerful than our target
            // switch to attack the damager.
            if (!GetIsObjectValid(oTarget)
                || (
                    oTarget != oDamager
                    &&  (
                         GetTotalDamageDealt() > (GetMaxHitPoints(OBJECT_SELF) / 4)
                         || (GetHitDice(oDamager) - 2) > GetHitDice(oTarget)
                         )
                    )
                )
            {
                // Switch targets
                DetermineCombatRound(oDamager);
            }
        }
    }

    // Send the user-defined event signal
    if(GetSpawnInCondition(NW_FLAG_DAMAGED_EVENT))
    {
        SignalEvent(OBJECT_SELF, EventUserDefined(EVENT_DAMAGED));
    }
    object oRanged = GetItemInSlot(INVENTORY_SLOT_RIGHTHAND, oDamager);
    if (GetIsRangedAttacker(oDamager) == TRUE)
        {
        int iChance = d20();
        if(iChance < 4)
            {
            AssignCommand(OBJECT_SELF,SpeakString("To me, coward!"));
            effect eVanish = EffectVisualEffect(VFX_FNF_PWSTUN);
            ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eVanish, GetLocation(oDamager));
            DelayCommand(0.6, AssignCommand(oDamager, ClearAllActions(TRUE)));
            DelayCommand(0.65, AssignCommand(oDamager, JumpToLocation(GetLocation(OBJECT_SELF))));
            }
        }
}
