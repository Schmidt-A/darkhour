void main()
{
object oPC = OBJECT_SELF;
int iRand = d6();
if(iRand == 1)
    {
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY , EffectAbilityIncrease(ABILITY_DEXTERITY, 2), oPC, 600.0);
    SendMessageToPC(oPC, "Eating this healthy mean has increased your dexterity temporarily.");
    }
else if(iRand == 2)
    {
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY , EffectAbilityIncrease(ABILITY_CHARISMA, 2), oPC, 600.0);
    SendMessageToPC(oPC, "Eating this healthy mean has increased your charisma temporarily.");
    }
else if(iRand == 3)
    {
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY , EffectAbilityIncrease(ABILITY_CONSTITUTION, 2), oPC, 600.0);
    SendMessageToPC(oPC, "Eating this healthy mean has increased your constitution temporarily.");
    }
else if(iRand == 4)
    {
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY , EffectAbilityIncrease(ABILITY_INTELLIGENCE, 2), oPC, 600.0);
    SendMessageToPC(oPC, "Eating this healthy mean has increased your intelligence temporarily.");
    }
else if(iRand == 5)
    {
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY , EffectAbilityIncrease(ABILITY_STRENGTH, 2), oPC, 600.0);
    SendMessageToPC(oPC, "Eating this healthy mean has increased your strength temporarily.");
    }
else if(iRand == 6)
    {
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY , EffectAbilityIncrease(ABILITY_WISDOM, 2), oPC, 600.0);
    SendMessageToPC(oPC, "Eating this healthy mean has increased your wisdom temporarily.");
    }
effect eHP = EffectTemporaryHitpoints(5);
ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eHP, oPC, 600.0);
}
