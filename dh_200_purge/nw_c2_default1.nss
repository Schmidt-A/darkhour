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

/*
  Refactored by Tweek Jan 2016
  Note: I got rid of all the "SunDesGate" related door-attacking. That's
  not even the tag that is used for SunDes entrances so I don't think it's
  doing anything. Also removed DM-triggered frenzies for now because it needs
  better implementation.
*/

#include "nw_i0_generic"

void ApplyFrenzy(object oSkin)
{
    itemproperty ipLoop = GetFirstItemProperty(oSkin);
    ApplyEffectToObject(DURATION_TYPE_PERMANENT,
                        ExtraordinaryEffect(EffectHaste()),OBJECT_SELF);
    ApplyEffectToObject(DURATION_TYPE_PERMANENT,
                        ExtraordinaryEffect(EffectVisualEffect(VFX_DUR_PARALYZED)),OBJECT_SELF);
    ApplyEffectToObject(DURATION_TYPE_PERMANENT,
                        ExtraordinaryEffect(EffectAbilityIncrease(ABILITY_STRENGTH,d4(1))),OBJECT_SELF);
    ApplyEffectToObject(DURATION_TYPE_PERMANENT,
                        ExtraordinaryEffect(EffectAbilityIncrease(ABILITY_CONSTITUTION,d4(1))),OBJECT_SELF);
    ApplyEffectToObject(DURATION_TYPE_PERMANENT,
                        ExtraordinaryEffect(EffectSeeInvisible()),OBJECT_SELF);

    while (GetIsItemPropertyValid(ipLoop))
    {
        //If ipLoop is a true seeing property, remove it
        if (GetItemPropertyType(ipLoop) == ITEM_PROPERTY_SPECIAL_WALK)
        RemoveItemProperty(oSkin, ipLoop);
        ipLoop = GetNextItemProperty(oSkin);
    }
}

void RemoveFrenzy(object oSkin)
{
    AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertySpecialWalk(), oSkin);

    effect eLoop = GetFirstEffect(OBJECT_SELF);
    while (GetIsEffectValid(eLoop))
    {
        if (GetEffectType(eLoop) == EFFECT_TYPE_ABILITY_INCREASE ||
            GetEffectType(eLoop) == EFFECT_TYPE_HASTE ||
            GetEffectType(eLoop) == EFFECT_TYPE_VISUALEFFECT ||
            GetEffectType(eLoop) == EFFECT_TYPE_SEEINVISIBLE)
        {
            RemoveEffect(OBJECT_SELF, eLoop);
        }
        eLoop=GetNextEffect(OBJECT_SELF);
    }
}

void BehemothEndRampage()
{
    SetLocalInt(OBJECT_SELF, "rampaging", FALSE);

    effect eLoop = GetFirstEffect(OBJECT_SELF);
    while (GetIsEffectValid(eLoop))
    {
        if (GetEffectType(eLoop) == EFFECT_TYPE_VISUALEFFECT ||
            GetEffectType(eLoop) == EFFECT_TYPE_MOVEMENT_SPEED_INCREASE)
        {
            RemoveEffect(OBJECT_SELF, eLoop);
        }
        eLoop=GetNextEffect(OBJECT_SELF);
    }
    SpeakString("With the worst of its injuries having renegerated, the hulking " +
            "beast seems placated... For now.", TALKVOLUME_TALK);
}

void main()
{
    // Bail if we're not a zombie or there're no PCs around.
    if(GetRacialType(OBJECT_SELF) != RACIAL_TYPE_UNDEAD ||
       GetNearestCreature(CREATURE_TYPE_PLAYER_CHAR,
                          PLAYER_CHAR_IS_PC) == OBJECT_INVALID)
        return;

    int nMove        = GetLocalInt(OBJECT_SELF, "MovementSpeed");
    int nTime        = GetTimeHour();
    object oSkin     = GetItemInSlot(INVENTORY_SLOT_CARMOUR);
    object oBadToken = GetItemPossessedBy(OBJECT_SELF, "DeathToken");

    // I'm not sure why we're doing this.
    if (oBadToken != OBJECT_INVALID)
        DestroyObject(oBadToken);

    if(nTime==0 && nMove != 1)
    {
        SetLocalInt(OBJECT_SELF,"MovementSpeed", 1);
        ApplyFrenzy(oSkin);
    }
    else if(nTime != 0 && nMove == 1)
    {
        SetLocalInt(OBJECT_SELF,"MovementSpeed", 0);
        RemoveFrenzy(oSkin);
    }
    // If we're a behemoth, see if we should stop rampaging.
    if(GetTag(OBJECT_SELF) == "ZN_ZOMBIEB" && GetLocalInt(OBJECT_SELF, "rampaging"))
    {
        if(GetPercentageHPLoss(OBJECT_SELF) > 64)
            BehemothEndRampage();
    }
    if (GetCurrentAction() == ACTION_INVALID &&
        GetLocalInt(OBJECT_SELF,"feeding") == 0 &&
        GetTag(OBJECT_SELF) != "ZN_ZOMBIEL")
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

    // Send the user-defined event signal if specified
    if(GetSpawnInCondition(NW_FLAG_HEARTBEAT_EVENT))
        SignalEvent(OBJECT_SELF, EventUserDefined(EVENT_HEARTBEAT));
}
