//:://////////////////////////////////////////////////
//:: NW_C2_DEFAULT1
/*
  Default OnHeartbeat script for NPCs.

  This script causes NPCs to perform default animations
  while not otherwise engaged.

  This script duplicates the behavior of the default
  script and just cleans up the code and removes
  redundant conditional checks.

 */
//:://////////////////////////////////////////////////
//:: Copyright (c) 2002 Floodgate Entertainment
//:: Created By: Naomi Novik
//:: Created On: 12/22/2002
//:://////////////////////////////////////////////////

#include "nw_i0_generic"

void main()
{
    if(GetNearestCreature(CREATURE_TYPE_PLAYER_CHAR, PLAYER_CHAR_IS_PC) == OBJECT_INVALID)
        {
        return;
        }
    if(GetTag(OBJECT_SELF) == "huggles")
        {
        return;
        }
    object oBadToken = GetItemPossessedBy(OBJECT_SELF,"DeathToken");
    int nMove = GetLocalInt(OBJECT_SELF,"MovementSpeed");
    object oSkin = GetItemInSlot(INVENTORY_SLOT_CARMOUR);
    if (oBadToken != OBJECT_INVALID)
    {
        DestroyObject(oBadToken);
    }
    int nDMFrenzy = GetLocalInt(OBJECT_SELF,"DM_Frenzy");
    int nDMMove = GetLocalInt(OBJECT_SELF,"DM_MovementSpeed");
    int nTime = GetTimeHour();
    if(nTime==0 && nMove != 1)
    {
    SetLocalInt(OBJECT_SELF,"MovementSpeed",1);
    itemproperty ipLoop=GetFirstItemProperty(oSkin);
    ApplyEffectToObject(DURATION_TYPE_PERMANENT,ExtraordinaryEffect(EffectHaste()),OBJECT_SELF);
    ApplyEffectToObject(DURATION_TYPE_PERMANENT,ExtraordinaryEffect(EffectVisualEffect(VFX_DUR_PARALYZED)),OBJECT_SELF);
    ApplyEffectToObject(DURATION_TYPE_PERMANENT,ExtraordinaryEffect(EffectAbilityIncrease(ABILITY_STRENGTH,d4(1))),OBJECT_SELF);
    ApplyEffectToObject(DURATION_TYPE_PERMANENT,ExtraordinaryEffect(EffectAbilityIncrease(ABILITY_CONSTITUTION,d4(1))),OBJECT_SELF);
    ApplyEffectToObject(DURATION_TYPE_PERMANENT,ExtraordinaryEffect(EffectSeeInvisible()),OBJECT_SELF);
    //Loop for as long as the ipLoop variable is valid
    while (GetIsItemPropertyValid(ipLoop))
        {
        //If ipLoop is a true seeing property, remove it
        if (GetItemPropertyType(ipLoop)==ITEM_PROPERTY_SPECIAL_WALK)
        RemoveItemProperty(oSkin, ipLoop);

        //Next itemproperty on the list...
        ipLoop=GetNextItemProperty(oSkin);
        }
    }
    else if(nTime!=0 && nMove ==1)
    {
    SetLocalInt(OBJECT_SELF,"MovementSpeed",0);
    AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertySpecialWalk(),oSkin);
    effect eLoop=GetFirstEffect(OBJECT_SELF);
    while (GetIsEffectValid(eLoop))
        {
            if (GetEffectType(eLoop)==EFFECT_TYPE_ABILITY_INCREASE || GetEffectType(eLoop)==EFFECT_TYPE_HASTE || GetEffectType(eLoop)==EFFECT_TYPE_VISUALEFFECT || GetEffectType(eLoop)==EFFECT_TYPE_SEEINVISIBLE)
            {RemoveEffect(OBJECT_SELF, eLoop);}
            eLoop=GetNextEffect(OBJECT_SELF);
        }
    }

    if(nDMFrenzy==TRUE && nDMMove != 1)
    {
    SetLocalInt(OBJECT_SELF,"DM_MovementSpeed",1);
    itemproperty ipLoop=GetFirstItemProperty(oSkin);
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY,ExtraordinaryEffect(EffectHaste()),OBJECT_SELF,120.0);
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY,ExtraordinaryEffect(EffectVisualEffect(VFX_DUR_PARALYZED)),OBJECT_SELF,120.0);
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY,ExtraordinaryEffect(EffectAbilityIncrease(ABILITY_STRENGTH,d4(1))),OBJECT_SELF,120.0);
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY,ExtraordinaryEffect(EffectAbilityIncrease(ABILITY_CONSTITUTION,d4(1))),OBJECT_SELF,120.0);
    //Loop for as long as the ipLoop variable is valid
    while (GetIsItemPropertyValid(ipLoop))
        {
        //If ipLoop is a true seeing property, remove it
        if (GetItemPropertyType(ipLoop)==ITEM_PROPERTY_SPECIAL_WALK)
        RemoveItemProperty(oSkin, ipLoop);

        //Next itemproperty on the list...
        ipLoop=GetNextItemProperty(oSkin);
        }
    }
    else if(nDMFrenzy==FALSE && nDMMove ==1)
    {
    SetLocalInt(OBJECT_SELF,"DM_MovementSpeed",0);
    AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertySpecialWalk(),oSkin);
    }
    if ((GetCurrentAction() == ACTION_INVALID) && (GetLocalInt(OBJECT_SELF,"feeding") == 0) && (GetTag(OBJECT_SELF) != "ZN_ZOMBIEL"))
    {
        ClearAllActions();
        ActionRandomWalk();
    }

    // * if not runnning normal or better Ai then exit for performance reasons
    if (GetAILevel() == AI_LEVEL_VERY_LOW) return;

    // Buff ourselves up right away if we should
    if(GetSpawnInCondition(NW_FLAG_FAST_BUFF_ENEMY))
    {
        // This will return TRUE if an enemy was within 40.0 m
        // and we buffed ourselves up instantly to respond --
        // simulates a spellcaster with protections enabled
        // already.
        if(TalentAdvancedBuff(40.0))
        {
            // This is a one-shot deal
            SetSpawnInCondition(NW_FLAG_FAST_BUFF_ENEMY, FALSE);

            // This return means we skip sending the user-defined
            // heartbeat signal in this one case.
            return;
        }
    }


    if(GetHasEffect(EFFECT_TYPE_SLEEP))
    {
        // If we're asleep and this is the result of sleeping
        // at night, apply the floating 'z's visual effect
        // every so often

        if(GetSpawnInCondition(NW_FLAG_SLEEPING_AT_NIGHT))
        {
            effect eVis = EffectVisualEffect(VFX_IMP_SLEEP);
            if(d10() > 6)
            {
                ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, OBJECT_SELF);
            }
        }
    }

    // If we have the 'constant' waypoints flag set, walk to the next
    // waypoint.
//    else if ( GetWalkCondition(NW_WALK_FLAG_CONSTANT) )
//    {
//        WalkWayPoints();
//    }

    // Check to see if we should be playing default animations
    // - make sure we don't have any current targets
//  else if ( !GetIsObjectValid(GetAttemptedAttackTarget())
//        && !GetIsObjectValid(GetAttemptedSpellTarget())
//        // && !GetIsPostOrWalking())
//        && !GetIsObjectValid(GetNearestSeenEnemy()))
//  {
//      if (GetBehaviorState(NW_FLAG_BEHAVIOR_SPECIAL) || GetBehaviorState(NW_FLAG_BEHAVIOR_OMNIVORE) ||
//          GetBehaviorState(NW_FLAG_BEHAVIOR_HERBIVORE))
//      {
            // This handles special attacking/fleeing behavior
            // for omnivores & herbivores.
//          DetermineSpecialBehavior();
//      }
//      else if (!IsInConversation(OBJECT_SELF))
//      {
//          if (GetSpawnInCondition(NW_FLAG_AMBIENT_ANIMATIONS)
//              || GetSpawnInCondition(NW_FLAG_AMBIENT_ANIMATIONS_AVIAN)
//              || GetIsEncounterCreature())
//          {
//              PlayMobileAmbientAnimations();
//          }
//          else if (GetSpawnInCondition(NW_FLAG_IMMOBILE_AMBIENT_ANIMATIONS))
//          {
//              PlayImmobileAmbientAnimations();
//          }
//      }
//  }

    // Send the user-defined event signal if specified
    if(GetSpawnInCondition(NW_FLAG_HEARTBEAT_EVENT))
    {
        SignalEvent(OBJECT_SELF, EventUserDefined(EVENT_HEARTBEAT));
    }
}

