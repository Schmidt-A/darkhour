//:://////////////////////////////////////////////////
//:: NW_C2_DEFAULT6 + MISSILE RECOVERY
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
//:://////////////////////////////////////////////////
//:: Modified By: Deva Winblood
//:: Modified On: Jan 17th, 2008
//:: Added Support for Mounted Combat Feat Support
//:://////////////////////////////////////////////////

// Refactored and bug-fixed by Tweek.

#include "nw_i0_generic"
#include "x3_inc_horse"

void TryMountedDamageEvasion(object oDamager)
{
    // No horsey damage to negate if we don't have the feat or are not mounted.
    // Also can only negate physical damage. Bail out if it's not.
    if(!GetHasFeat(FEAT_MOUNTED_COMBAT) || !HorseGetIsMounted(OBJECT_SELF)
            || !GetLocalInt(OBJECT_SELF, "bX3_LAST_ATTACK_PHYSICAL"))
        return;

    int nHPBefore=GetLocalInt(OBJECT_SELF, "nX3_HP_BEFORE");

    if (!GetLocalInt(OBJECT_SELF, "bX3_ALREADY_MOUNTED_COMBAT"))
    {
        // haven't already had a chance to use this for the round
        SetLocalInt(OBJECT_SELF, "bX3_ALREADY_MOUNTED_COMBAT", TRUE);

        int nAttackRoll = d20() + GetBaseAttackBonus(oDamager);
        int nRideCheck = d20() + GetSkillRank(SKILL_RIDE, OBJECT_SELF);
        if (nRideCheck >= nAttackRoll && !GetIsDead(OBJECT_SELF))
        {
            // averted attack
            if (GetIsPC(oDamager))
                SendMessageToPC(oDamager, GetName(OBJECT_SELF) + GetStringByStrRef(111991));
            // heal
            if (GetCurrentHitPoints(OBJECT_SELF) < nHPBefore)
            {
                effect eHeal = EffectHeal(nHPBefore - GetCurrentHitPoints(OBJECT_SELF));
                AssignCommand(GetModule(), ApplyEffectToObject(DURATION_TYPE_INSTANT, eHeal, OBJECT_SELF));
            }
        }
    }
}

int ShouldTargetSwitch(object oDamager, object oTarget)
{
    // Switch targets if:
    // - our target isn't valid OR
    // - our damager has just dealt us 25% or more of our hp in damage OR
    // - our damager is more than 2HD more powerful than our target
    return (!GetIsObjectValid(oTarget)
        || (
            oTarget != oDamager
            &&  (
                 GetTotalDamageDealt() > (GetMaxHitPoints(OBJECT_SELF) / 4)
                 || (GetHitDice(oDamager) - 2) > GetHitDice(oTarget)
                 )
            )
        );
}

void TryAmmoSalvage(object oDamager, object oWeapon)
{
    object oAmmo = OBJECT_INVALID;
    int iCheck = d2();

    if (GetBaseItemType(oWeapon) == BASE_ITEM_LONGBOW || GetBaseItemType(oWeapon) == BASE_ITEM_SHORTBOW)
        oAmmo = GetItemInSlot(INVENTORY_SLOT_ARROWS, oDamager);
    else if (GetBaseItemType(oWeapon) == BASE_ITEM_LIGHTCROSSBOW || GetBaseItemType(oWeapon) == BASE_ITEM_HEAVYCROSSBOW)
        oAmmo = GetItemInSlot(INVENTORY_SLOT_BOLTS, oDamager);
    else if (GetBaseItemType(oWeapon) == BASE_ITEM_SLING)
        oAmmo = GetItemInSlot(INVENTORY_SLOT_BULLETS, oDamager);
    else
        // If this is a ranged weapon that wasn't a sling/bow/etc, it's a
        // throwing weapon.
        oAmmo = oWeapon;

    // 50% chance of salvage success.
    if(oAmmo != OBJECT_INVALID && iCheck == 1)
    {
        object oCreate =  CreateItemOnObject(GetResRef(oAmmo), oDamager);
        SendMessageToPC(oDamager, "You were able to salvage some of your " + GetName(oAmmo) + " ammunition.");
        SetIdentified(oCreate, TRUE);
    }
}

void BehemothRampage()
{
    // TODO: Add param for lesser/greater behemoths.
    // We can't rampage more than once. :(
    if (GetLocalInt(OBJECT_SELF, "rampaged"))
        return;

    location lMyLocation = GetLocation(OBJECT_SELF);
    object oTarget = GetFirstObjectInShape(SHAPE_SPHERE, 51.0, lMyLocation);
    int iSave;

    SetLocalInt(OBJECT_SELF, "rampaged", TRUE);

    SpeakString("The lumbering behemoth has become enraged by your assault! " +
            "It roars and slams its fists into the ground with such fury that " +
            "the ground trembles. It then begins racing towards you!",
            TALKVOLUME_TALK);

    ApplyEffectToObject(DURATION_TYPE_PERMANENT,
                        EffectMovementSpeedIncrease(300), OBJECT_SELF);
    ApplyEffectToObject(DURATION_TYPE_INSTANT,
                        EffectVisualEffect(VFX_FNF_HOWL_MIND), OBJECT_SELF);
    ApplyEffectToObject(DURATION_TYPE_PERMANENT,
                        EffectVisualEffect(VFX_DUR_AURA_RED_DARK), OBJECT_SELF);

    while(GetIsObjectValid(oTarget))
    {

        // Ignore placeables, doors, etc. Also zombies for now.
        if(!GetObjectType(oTarget) == OBJECT_TYPE_CREATURE ||
            GetStringLeft(GetTag(oTarget),9) == "ZN_ZOMBIE")
        {
            oTarget = GetNextObjectInShape(SHAPE_SPHERE, 51.0, lMyLocation);
            continue;
        }

        // If close enough, GET REKT
        if ((GetDistanceBetween(OBJECT_SELF, oTarget) <= 50.0)
                && (GetDistanceBetween(OBJECT_SELF, oTarget) > 0.0))
        {
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY,
                            EffectVisualEffect(VFX_FNF_SCREEN_SHAKE), oTarget, 2.0);
            if(ReflexSave(oTarget, 10) < 1)
            {
                //AssignCommand(oTarget, ClearAllActions(TRUE));
                ApplyEffectToObject(DURATION_TYPE_TEMPORARY,
                            EffectKnockdown(), oTarget, 3.0);
            }
        }
        oTarget = GetNextObjectInShape(SHAPE_SPHERE, 51.0, lMyLocation);
    }
}

void main()
{
    object oDamager = GetLastDamager();
    TryMountedDamageEvasion(oDamager);

    // Act only if we're not fleeing.
    if(!GetFleeToExit() && !GetSpawnInCondition(NW_FLAG_SET_WARNINGS))
    {
        if(GetIsObjectValid(oDamager) &&!GetIsFighting(OBJECT_SELF))
        {
            // If we're not fighting, determine combat round.
            if(GetBehaviorState(NW_FLAG_BEHAVIOR_SPECIAL))
                DetermineSpecialBehavior(oDamager);
            else
            {
                if(!GetObjectSeen(oDamager)
                   && GetArea(OBJECT_SELF) == GetArea(oDamager))
                {
                    // We don't see our attacker, go find them.
                    ActionMoveToLocation(GetLocation(oDamager), TRUE);
                    ActionDoCommand(DetermineCombatRound());
                }
                else
                    DetermineCombatRound();
            }
        }
        else if(GetIsObjectValid(oDamager))
        {
            // We are fighting already -- consider switching if we've been
            // attacked by a more powerful enemy.
            object oTarget = GetAttackTarget();
            if (!GetIsObjectValid(oTarget))
                oTarget = GetAttemptedAttackTarget();
            if (!GetIsObjectValid(oTarget))
                oTarget = GetAttemptedSpellTarget();

            if(ShouldTargetSwitch(oDamager, oTarget))
                DetermineCombatRound(oDamager);
        }
    }

    // Send the user-defined event signal.
    if(GetSpawnInCondition(NW_FLAG_DAMAGED_EVENT))
        SignalEvent(OBJECT_SELF, EventUserDefined(EVENT_DAMAGED));

    // See if we can salvage ammo if the attacker was using a ranged weapon.
    object oWeapon = GetItemInSlot(INVENTORY_SLOT_RIGHTHAND, oDamager);
    int iPhysicalDamage = GetDamageDealtByType(DAMAGE_TYPE_BASE_WEAPON);
    if(GetWeaponRanged(oWeapon) && iPhysicalDamage > 0)
        TryAmmoSalvage(oDamager, oWeapon);

    // If we're a damaged behemoth, FUCK 'EM UP.
    if(GetTag(OBJECT_SELF) == "ZN_ZOMBIEB" && GetPercentageHPLoss(OBJECT_SELF) < 50)
        BehemothRampage();
}
