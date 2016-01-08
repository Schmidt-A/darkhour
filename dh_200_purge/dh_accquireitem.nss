//Name: Salvaging and Crafting Point System: Main
//Developer: Skeet/DM Malevolent
//Date: 8-02-2007
//Purpose: A system that would work for Zombie Survival
//         and in unison with the searching scripts
//         to salvage found 'craftable' material
//         to use in crafting new material.
#include "disease_inc"
#include "_incl_subrace"
void main()
{

object oItem = GetModuleItemAcquired();
object oAcquirer = GetModuleItemAcquiredBy();
string sRef = GetResRef(oItem);
string sTag = GetTag(oItem);
if(sTag == "ecl_token")
{
    int iLA = GetLA(GetStringLowerCase(GetSubRace(oAcquirer)));
    SetLocalInt(oItem, "iLA", iLA);
    SetLocalInt(oItem, "iECL", 1+iLA);
    SetLocalInt(oItem, "iXPNeeded", GetSubraceXP(1+iLA));
    SetLocalInt(oItem, "iCumulativeXP", 0);
    SetLocalInt(oItem, "iRealXP", 1000);
}
if(sTag == "zkxthous")
    {
    ExecuteScript("tenthouszk", oAcquirer);
    }
//PICKPOCKET RESTRICTION
if (sTag == "SurvivalTime")
{
        ExecuteScript("survivaltimes", oAcquirer);
}
else if (sTag == "ZombieKill")
{
        ExecuteScript("zombiekill", oAcquirer);
}
else if (sTag == "FrenzyKill")
{
        ExecuteScript("frenzykill", oAcquirer);
}
//else if(sTag == "td_it_quillpen")
//    {
//    ExecuteScript("td_it_quillpen", oPC);
//    }
if(GetWeight(oItem)>=40)
{
SetPickpocketableFlag(oItem,FALSE);
}
//END

string sItem = GetTag(oItem);

object oCrafting = GetItemPossessedBy(oAcquirer, "craftingitem");
object oCrafted = GetObjectByTag("crafted");

int iAmount = GetLocalInt(oCrafting, "crafting");
int iCost = GetLocalInt(oItem, "crafted");
int iSkillSearch = GetSkillRank(SKILL_SEARCH, oAcquirer);
int iFormula = d20() + 19 + iSkillSearch;
int iStopCheck = GetLocalInt(oCrafted, "stopcpcheck");
object oApplier = GetObjectByTag("Disease_Applier");
 if(GetTag(oItem)=="ZombieDisease")
{
int nDisease = 0;
object oCheckDisease = GetFirstItemInInventory(oAcquirer);
while (oCheckDisease != OBJECT_INVALID)
    {
        if (GetTag(oCheckDisease) == "ZombieDisease")
        {
            nDisease += 1;
        }
        oCheckDisease = GetNextItemInInventory(oAcquirer);
     }
if(nDisease == 2)
     {
     AssignCommand(oApplier, ApplyEffectToObject(DURATION_TYPE_PERMANENT,SupernaturalEffect(EffectAbilityDecrease(ABILITY_CONSTITUTION,2)),oAcquirer));
     SetLocalInt(oAcquirer,"DiseaseApplied",TRUE);
     }
else if(nDisease == 3)
     {
     AssignCommand(oApplier, ApplyEffectToObject(DURATION_TYPE_PERMANENT,SupernaturalEffect(EffectAbilityDecrease(ABILITY_DEXTERITY,2)),oAcquirer));
     }
else if(nDisease == 4)
     {
     AssignCommand(oApplier, ApplyEffectToObject(DURATION_TYPE_PERMANENT,SupernaturalEffect(EffectAbilityDecrease(ABILITY_STRENGTH,2)),oAcquirer));
     }
else if(nDisease == 5)
     {
     AssignCommand(oApplier, ApplyEffectToObject(DURATION_TYPE_PERMANENT,SupernaturalEffect(EffectAbilityDecrease(ABILITY_INTELLIGENCE,2)),oAcquirer));
     }
else if(nDisease == 6)
     {
     AssignCommand(oApplier, ApplyEffectToObject(DURATION_TYPE_PERMANENT,SupernaturalEffect(EffectAbilityDecrease(ABILITY_WISDOM,2)),oAcquirer));
     }
else if(nDisease == 7)
     {
     AssignCommand(oApplier, ApplyEffectToObject(DURATION_TYPE_PERMANENT,SupernaturalEffect(EffectAbilityDecrease(ABILITY_CHARISMA,2)),oAcquirer));
     }
else if(nDisease == 8)
{
     AssignCommand(oApplier, ApplyEffectToObject(DURATION_TYPE_PERMANENT,SupernaturalEffect(EffectAbilityDecrease(ABILITY_CONSTITUTION,2)),oAcquirer));
     AssignCommand(oApplier, ApplyEffectToObject(DURATION_TYPE_PERMANENT,SupernaturalEffect(EffectAbilityDecrease(ABILITY_DEXTERITY,2)),oAcquirer));
     AssignCommand(oApplier, ApplyEffectToObject(DURATION_TYPE_PERMANENT,SupernaturalEffect(EffectAbilityDecrease(ABILITY_STRENGTH,2)),oAcquirer));
}
else if(nDisease == 9)
{
AssignCommand(oApplier, ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectConfused(),oAcquirer,IntToFloat(Random(60)+1)));
}
}
//This else if statement handles the received crafting points, ie, the salvaging system.  It will add
//The crafting points for each crafting point item gained to the base crafting
//item, which is based on iFormula.

if(GetIsPC(oAcquirer) && sItem == "craftingpoints")
{
if(GetLocalInt(oCrafting, "crafting") < 0)
    {
    iAmount = 0;
    }
SendMessageToPC(oAcquirer, "You have found some craftable material!");
SetLocalInt(oCrafting, "crafting", iAmount + iFormula);
int iAmount = GetLocalInt(oCrafting, "crafting");
string sAmount = IntToString(iAmount);
string sFinalAmount = "You currently have " + sAmount + " crafting points.";
SendMessageToPC(oAcquirer, sFinalAmount);

DestroyObject(oItem);
}
}
