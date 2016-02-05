#include "nwnx_funcs"
#include "nw_i0_spells"
#include "x0_i0_petrify"

void BehemothRampage(object oEnemy)
{
    // TODO: Add param for lesser/greater behemoths.
    // We can't stack rampages. :(
    if (GetLocalInt(OBJECT_SELF, "rampaging"))
        return;

    location lMyLocation = GetLocation(OBJECT_SELF);
    object oTarget = GetFirstObjectInShape(SHAPE_SPHERE, 51.0, lMyLocation);
    int iSave;

    SetLocalInt(OBJECT_SELF, "rampaging", TRUE);

    SpeakString("The lumbering behemoth has become enraged by your assault! " +
            "It roars and slams its fists into the ground with such fury that " +
            "the ground trembles. It then begins racing towards you!",
            TALKVOLUME_TALK);

    //Excerpted because the nwnx movement funcs didn't work for whatever reason
    //SetMovementRate(OBJECT_SELF, MOVEMENT_RATE_NORMAL);

    //We're increasing the speed by 99 percent after removing their movespeed decrease
    RemoveSpecificEffect(EFFECT_TYPE_MOVEMENT_SPEED_DECREASE, OBJECT_SELF);

    effect BehemothRage = EffectLinkEffects(EffectVisualEffect(VFX_DUR_AURA_RED_DARK),
                            EffectMovementSpeedIncrease(60));

    ApplyEffectToObject(DURATION_TYPE_PERMANENT, BehemothRage, OBJECT_SELF);
    ApplyEffectToObject(DURATION_TYPE_INSTANT,
                        EffectVisualEffect(VFX_FNF_HOWL_MIND), OBJECT_SELF);

    while(GetIsObjectValid(oTarget))
    {
        // Ignore placeables, doors, etc.
        if(!GetObjectType(oTarget) == OBJECT_TYPE_CREATURE)
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
                ApplyEffectToObject(DURATION_TYPE_TEMPORARY,
                            EffectKnockdown(), oTarget, 3.0);
            }
        }
        oTarget = GetNextObjectInShape(SHAPE_SPHERE, 51.0, lMyLocation);
    }
}

void ApplyFrenzy(object oSkin, object oEnemy)
{
    itemproperty ipLoop = GetFirstItemProperty(oSkin);
    ApplyEffectToObject(DURATION_TYPE_PERMANENT,
                        ExtraordinaryEffect(EffectHaste()),oEnemy);
    ApplyEffectToObject(DURATION_TYPE_PERMANENT,
                        ExtraordinaryEffect(EffectVisualEffect(VFX_DUR_PARALYZED)),oEnemy);
    ApplyEffectToObject(DURATION_TYPE_PERMANENT,
                        ExtraordinaryEffect(EffectAbilityIncrease(ABILITY_STRENGTH,d4(1))),oEnemy);
    ApplyEffectToObject(DURATION_TYPE_PERMANENT,
                        ExtraordinaryEffect(EffectAbilityIncrease(ABILITY_CONSTITUTION,d4(1))),oEnemy);
    ApplyEffectToObject(DURATION_TYPE_PERMANENT,
                        ExtraordinaryEffect(EffectSeeInvisible()),oEnemy);

    while (GetIsItemPropertyValid(ipLoop))
    {
        //If ipLoop is a true seeing property, remove it
        if (GetItemPropertyType(ipLoop) == ITEM_PROPERTY_SPECIAL_WALK)
        RemoveItemProperty(oSkin, ipLoop);
        ipLoop = GetNextItemProperty(oSkin);
    }
}

void RemoveFrenzy(object oSkin, object oEnemy)
{
    AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertySpecialWalk(), oSkin);

    effect eLoop = GetFirstEffect(oEnemy);
    while (GetIsEffectValid(eLoop))
    {
        if (GetEffectType(eLoop) == EFFECT_TYPE_ABILITY_INCREASE ||
            GetEffectType(eLoop) == EFFECT_TYPE_HASTE ||
            GetEffectType(eLoop) == EFFECT_TYPE_VISUALEFFECT ||
            GetEffectType(eLoop) == EFFECT_TYPE_SEEINVISIBLE)
        {
            RemoveEffect(oEnemy, eLoop);
        }
        eLoop=GetNextEffect(oEnemy);
    }
}

void BehemothEndRampage(object oEnemy)
{
    SetLocalInt(oEnemy, "rampaging", FALSE);

    //Excerpted because the nwnx movement funcs didn't work for whatever reason
    //SetMovementRate(OBJECT_SELF, MOVEMENT_RATE_VERY_SLOW);
    RemoveEffectOfType(oEnemy, EFFECT_TYPE_MOVEMENT_SPEED_INCREASE);

    //Add in a speed decrease again
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, EffectMovementSpeedIncrease(60), oEnemy);

    SpeakString("With the worst of its injuries having renegerated, the hulking " +
            "beast seems placated... For now.", TALKVOLUME_TALK);
}

//This is the enemy that is surprised - when spawning, they aren't able to move or attack properly
//Gives a 99% miss chance and a 50% slow for 3 seconds
//Casting is not effected - on purpose.
void SpawnSurprise(object oEnemy)
{
    effect eMiss = EffectMissChance(99, MISS_CHANCE_TYPE_NORMAL);
    effect eSlowDown = EffectMovementSpeedDecrease(50);
    effect eSurprise = EffectLinkEffects(eMiss, eSlowDown);

    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eSurprise, OBJECT_SELF, 3.0f);
}


