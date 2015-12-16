/* ChronusH: Modified routines to use a standard applier to more accurately
    remove effect and apply them. */


void ApplyDisease(object oPC)
{
    //DISEASE ADDITION - DEMON X
    nDisease = 0;
    oCheckDisease = GetFirstItemInInventory(oPC);
    while (oCheckDisease != OBJECT_INVALID)
    {
        if (GetTag(oCheckDisease) == "ZombieDisease")
        {
            nDisease += 1;
            if(nDisease == 2)
            {
                ApplyEffectToObject(DURATION_TYPE_PERMANENT,SupernaturalEffect(EffectAbilityDecrease(ABILITY_CONSTITUTION,2)),oPC);
                SetLocalInt(oPC,"DiseaseApplied",TRUE);
            }
            else if(nDisease == 3)
            {
                ApplyEffectToObject(DURATION_TYPE_PERMANENT,SupernaturalEffect(EffectAbilityDecrease(ABILITY_DEXTERITY,2)),oPC);
            }
            else if(nDisease == 4)
            {
                ApplyEffectToObject(DURATION_TYPE_PERMANENT,SupernaturalEffect(EffectAbilityDecrease(ABILITY_STRENGTH,2)),oPC);
            }
            else if(nDisease == 5)
            {
                ApplyEffectToObject(DURATION_TYPE_PERMANENT,SupernaturalEffect(EffectAbilityDecrease(ABILITY_INTELLIGENCE,2)),oPC);
            }
            else if(nDisease == 6)
            {
                ApplyEffectToObject(DURATION_TYPE_PERMANENT,SupernaturalEffect(EffectAbilityDecrease(ABILITY_WISDOM,2)),oPC);
            }
            else if(nDisease == 7)
            {
                ApplyEffectToObject(DURATION_TYPE_PERMANENT,SupernaturalEffect(EffectAbilityDecrease(ABILITY_CHARISMA,2)),oPC);
            }
            else if(nDisease == 8)
            {
                ApplyEffectToObject(DURATION_TYPE_PERMANENT,SupernaturalEffect(EffectAbilityDecrease(ABILITY_CONSTITUTION,2)),oPC);
                ApplyEffectToObject(DURATION_TYPE_PERMANENT,SupernaturalEffect(EffectAbilityDecrease(ABILITY_DEXTERITY,2)),oPC);
                ApplyEffectToObject(DURATION_TYPE_PERMANENT,SupernaturalEffect(EffectAbilityDecrease(ABILITY_STRENGTH,2)),oPC);
            }
            else if(nDisease == 9)
            {
                ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectConfused(),oPC,IntToFloat(Random(60)+1));
            }
        }
        oCheckDisease = GetNextItemInInventory(oPC);
    }

}

void RemoveDiseasedEffects(object oPC)
{         /*
AssignCommand(oPC, ClearAllActions());
int iHP = GetMaxHitPoints(oPC) - GetCurrentHitPoints(oPC);
if(iHP > 0)
    {
    DelayCommand(0.2, ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectDamage(iHP), oPC));
    }
AssignCommand(oPC, ActionCastSpellAtObject(SPELL_GREATER_RESTORATION, OBJECT_SELF, METAMAGIC_ANY, TRUE, 0 ,PROJECTILE_PATH_TYPE_DEFAULT, TRUE));
*/
object oApplier = GetObjectByTag("Disease_Applier");
effect eEffect = GetFirstEffect(oPC);
while(GetIsEffectValid(eEffect))
    {
    if(GetEffectCreator(eEffect) == oApplier)
    {
        RemoveEffect(oPC,eEffect);
    }
    eEffect = GetNextEffect(oPC);
    }
}
void RemoveDiseaseEffects(object oPC)
{
object oApplier = GetObjectByTag("Disease_Applier");
int nDisease = 0;
if(GetItemPossessedBy(oPC,"ZombieDisease")!= OBJECT_INVALID)
{
object oCheckDisease = GetFirstItemInInventory(oPC);
while (oCheckDisease != OBJECT_INVALID)
    {
        if (GetTag(oCheckDisease) == "ZombieDisease")
        {
            nDisease += 1;
        }
        oCheckDisease = GetNextItemInInventory(oPC);
    }
}
if(nDisease == 1)
{
RemoveDiseasedEffects(oPC);
}
else if(nDisease == 2)
{
RemoveDiseasedEffects(oPC);
AssignCommand(oApplier, ApplyEffectToObject(DURATION_TYPE_PERMANENT,SupernaturalEffect(EffectAbilityDecrease(ABILITY_CONSTITUTION,2)),oPC));
}
else if(nDisease == 3)
{
RemoveDiseasedEffects(oPC);
AssignCommand(oApplier, ApplyEffectToObject(DURATION_TYPE_PERMANENT,SupernaturalEffect(EffectAbilityDecrease(ABILITY_CONSTITUTION,2)),oPC));
AssignCommand(oApplier, ApplyEffectToObject(DURATION_TYPE_PERMANENT,SupernaturalEffect(EffectAbilityDecrease(ABILITY_DEXTERITY,2)),oPC));
}
else if(nDisease == 4)
{
RemoveDiseasedEffects(oPC);
AssignCommand(oApplier, ApplyEffectToObject(DURATION_TYPE_PERMANENT,SupernaturalEffect(EffectAbilityDecrease(ABILITY_CONSTITUTION,2)),oPC));
AssignCommand(oApplier, ApplyEffectToObject(DURATION_TYPE_PERMANENT,SupernaturalEffect(EffectAbilityDecrease(ABILITY_DEXTERITY,2)),oPC));
AssignCommand(oApplier, ApplyEffectToObject(DURATION_TYPE_PERMANENT,SupernaturalEffect(EffectAbilityDecrease(ABILITY_STRENGTH,2)),oPC));
}
else if(nDisease == 5)
{
RemoveDiseasedEffects(oPC);
AssignCommand(oApplier, ApplyEffectToObject(DURATION_TYPE_PERMANENT,SupernaturalEffect(EffectAbilityDecrease(ABILITY_CONSTITUTION,2)),oPC));
AssignCommand(oApplier, ApplyEffectToObject(DURATION_TYPE_PERMANENT,SupernaturalEffect(EffectAbilityDecrease(ABILITY_DEXTERITY,2)),oPC));
AssignCommand(oApplier, ApplyEffectToObject(DURATION_TYPE_PERMANENT,SupernaturalEffect(EffectAbilityDecrease(ABILITY_STRENGTH,2)),oPC));
AssignCommand(oApplier, ApplyEffectToObject(DURATION_TYPE_PERMANENT,SupernaturalEffect(EffectAbilityDecrease(ABILITY_INTELLIGENCE,2)),oPC));
}
else if(nDisease == 6)
{
RemoveDiseasedEffects(oPC);
AssignCommand(oApplier, ApplyEffectToObject(DURATION_TYPE_PERMANENT,SupernaturalEffect(EffectAbilityDecrease(ABILITY_CONSTITUTION,2)),oPC));
AssignCommand(oApplier, ApplyEffectToObject(DURATION_TYPE_PERMANENT,SupernaturalEffect(EffectAbilityDecrease(ABILITY_DEXTERITY,2)),oPC));
AssignCommand(oApplier, ApplyEffectToObject(DURATION_TYPE_PERMANENT,SupernaturalEffect(EffectAbilityDecrease(ABILITY_STRENGTH,2)),oPC));
AssignCommand(oApplier, ApplyEffectToObject(DURATION_TYPE_PERMANENT,SupernaturalEffect(EffectAbilityDecrease(ABILITY_INTELLIGENCE,2)),oPC));
AssignCommand(oApplier, ApplyEffectToObject(DURATION_TYPE_PERMANENT,SupernaturalEffect(EffectAbilityDecrease(ABILITY_WISDOM,2)),oPC));
}
else if(nDisease == 7)
{
RemoveDiseasedEffects(oPC);
AssignCommand(oApplier, ApplyEffectToObject(DURATION_TYPE_PERMANENT,SupernaturalEffect(EffectAbilityDecrease(ABILITY_CONSTITUTION,2)),oPC));
AssignCommand(oApplier, ApplyEffectToObject(DURATION_TYPE_PERMANENT,SupernaturalEffect(EffectAbilityDecrease(ABILITY_DEXTERITY,2)),oPC));
AssignCommand(oApplier, ApplyEffectToObject(DURATION_TYPE_PERMANENT,SupernaturalEffect(EffectAbilityDecrease(ABILITY_STRENGTH,2)),oPC));
AssignCommand(oApplier, ApplyEffectToObject(DURATION_TYPE_PERMANENT,SupernaturalEffect(EffectAbilityDecrease(ABILITY_INTELLIGENCE,2)),oPC));
AssignCommand(oApplier, ApplyEffectToObject(DURATION_TYPE_PERMANENT,SupernaturalEffect(EffectAbilityDecrease(ABILITY_WISDOM,2)),oPC));
AssignCommand(oApplier, ApplyEffectToObject(DURATION_TYPE_PERMANENT,SupernaturalEffect(EffectAbilityDecrease(ABILITY_CHARISMA,2)),oPC));
}
else if(nDisease == 8)
{
RemoveDiseasedEffects(oPC);
AssignCommand(oApplier, ApplyEffectToObject(DURATION_TYPE_PERMANENT,SupernaturalEffect(EffectAbilityDecrease(ABILITY_CONSTITUTION,4)),oPC));
AssignCommand(oApplier, ApplyEffectToObject(DURATION_TYPE_PERMANENT,SupernaturalEffect(EffectAbilityDecrease(ABILITY_DEXTERITY,4)),oPC));
AssignCommand(oApplier, ApplyEffectToObject(DURATION_TYPE_PERMANENT,SupernaturalEffect(EffectAbilityDecrease(ABILITY_STRENGTH,4)),oPC));
AssignCommand(oApplier, ApplyEffectToObject(DURATION_TYPE_PERMANENT,SupernaturalEffect(EffectAbilityDecrease(ABILITY_INTELLIGENCE,2)),oPC));
AssignCommand(oApplier, ApplyEffectToObject(DURATION_TYPE_PERMANENT,SupernaturalEffect(EffectAbilityDecrease(ABILITY_WISDOM,2)),oPC));
AssignCommand(oApplier, ApplyEffectToObject(DURATION_TYPE_PERMANENT,SupernaturalEffect(EffectAbilityDecrease(ABILITY_CHARISMA,2)),oPC));
}
else if(nDisease == 9)
{
RemoveDiseasedEffects(oPC);
AssignCommand(oApplier, ApplyEffectToObject(DURATION_TYPE_PERMANENT,SupernaturalEffect(EffectAbilityDecrease(ABILITY_CONSTITUTION,4)),oPC));
AssignCommand(oApplier, ApplyEffectToObject(DURATION_TYPE_PERMANENT,SupernaturalEffect(EffectAbilityDecrease(ABILITY_DEXTERITY,4)),oPC));
AssignCommand(oApplier, ApplyEffectToObject(DURATION_TYPE_PERMANENT,SupernaturalEffect(EffectAbilityDecrease(ABILITY_STRENGTH,4)),oPC));
AssignCommand(oApplier, ApplyEffectToObject(DURATION_TYPE_PERMANENT,SupernaturalEffect(EffectAbilityDecrease(ABILITY_INTELLIGENCE,2)),oPC));
AssignCommand(oApplier, ApplyEffectToObject(DURATION_TYPE_PERMANENT,SupernaturalEffect(EffectAbilityDecrease(ABILITY_WISDOM,2)),oPC));
AssignCommand(oApplier, ApplyEffectToObject(DURATION_TYPE_PERMANENT,SupernaturalEffect(EffectAbilityDecrease(ABILITY_CHARISMA,2)),oPC));
}
}
