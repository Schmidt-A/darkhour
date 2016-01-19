/*****************************************************
Name: Salvaging and Crafting Point System: Main
Developer: Skeet/DM Malevolent
Date: 8-02-2007
Purpose: A system that would work for Zombie Survival
         and in unison with the searching scripts
         to salvage found 'craftable' material
         to use in crafting new material.

Refactored by Tweek Dec 2015
    - When I have time, this token stuff will get moved to DB vars and there'll
      be more heavy refactoring
*****************************************************/

#include "disease_inc"
#include "_incl_subrace"

// Do ECL setup if they got a token for the first time
void AcquireECL(object oAcquirer)
{
    string sPre = GetDBVarName(oAcquirer);
    if(GetCampaignInt("SUBRACE", sPre + "iCumulativeXP") == 0)
    {
        int iLA = GetLA(GetStringLowerCase(GetSubRace(oAcquirer)));
        SetCampaignInt("SUBRACE", sPre + "iLA", iLA);
        SetCampaignInt("SUBRACE", sPre + "iECL", 1+iLA);
        SetCampaignInt("SUBRACE", sPre + "iXPNeeded", GetSubraceXP(1+iLA));
        SetCampaignInt("SUBRACE", sPre + "iCumulativeXP", 0);
        SetCampaignInt("SUBRACE", sPre + "iRealXP", 1000);
    }
}

// In the long run this will get moved somewhere else. For now it is item based.
void AcquireDisease(object oAcquirer)
{
    int iDisease = 0;
    object oApplier = GetObjectByTag("Disease_Applier");

    // See how many disease tokens we already have
    object oCheckDisease = GetFirstItemInInventory(oAcquirer);
    while (oCheckDisease != OBJECT_INVALID)
    {
        if (GetTag(oCheckDisease) == "ZombieDisease")
            iDisease += 1;
        oCheckDisease = GetNextItemInInventory(oAcquirer);
    }

    switch(iDisease)
    {
        case 2:
            AssignCommand(oApplier, ApplyEffectToObject(DURATION_TYPE_PERMANENT,SupernaturalEffect(EffectAbilityDecrease(ABILITY_CONSTITUTION,2)),oAcquirer));
            SetLocalInt(oAcquirer,"DiseaseApplied",TRUE);
            break;
        case 3:
            AssignCommand(oApplier, ApplyEffectToObject(DURATION_TYPE_PERMANENT,SupernaturalEffect(EffectAbilityDecrease(ABILITY_DEXTERITY,2)),oAcquirer));
            break;
        case 4:
            AssignCommand(oApplier, ApplyEffectToObject(DURATION_TYPE_PERMANENT,SupernaturalEffect(EffectAbilityDecrease(ABILITY_STRENGTH,2)),oAcquirer));
            break;
        case 5:
            AssignCommand(oApplier, ApplyEffectToObject(DURATION_TYPE_PERMANENT,SupernaturalEffect(EffectAbilityDecrease(ABILITY_INTELLIGENCE,2)),oAcquirer));
            break;
        case 6:
            AssignCommand(oApplier, ApplyEffectToObject(DURATION_TYPE_PERMANENT,SupernaturalEffect(EffectAbilityDecrease(ABILITY_WISDOM,2)),oAcquirer));
            break;
        case 7:
            AssignCommand(oApplier, ApplyEffectToObject(DURATION_TYPE_PERMANENT,SupernaturalEffect(EffectAbilityDecrease(ABILITY_CHARISMA,2)),oAcquirer));
            break;
        case 8:
            AssignCommand(oApplier, ApplyEffectToObject(DURATION_TYPE_PERMANENT,SupernaturalEffect(EffectAbilityDecrease(ABILITY_CONSTITUTION,2)),oAcquirer));
            AssignCommand(oApplier, ApplyEffectToObject(DURATION_TYPE_PERMANENT,SupernaturalEffect(EffectAbilityDecrease(ABILITY_DEXTERITY,2)),oAcquirer));
            AssignCommand(oApplier, ApplyEffectToObject(DURATION_TYPE_PERMANENT,SupernaturalEffect(EffectAbilityDecrease(ABILITY_STRENGTH,2)),oAcquirer));
            break;
        case 9:
            AssignCommand(oApplier, ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectConfused(),oAcquirer,IntToFloat(Random(60)+1)));
            break;
        default:
            break;
    }
}

void AcquireCrafting(object oAcquirer, object oItem)
{
    string sMsg = "";
    object oCrafting = GetItemPossessedBy(oAcquirer, "craftingitem");
    int iCPs = GetLocalInt(oCrafting, "crafting");
    int iSkillSearch = GetSkillRank(SKILL_SEARCH, oAcquirer);
    int iFormula = d20() + 19 + iSkillSearch;

    // Sanity check
    if(GetLocalInt(oCrafting, "crafting") < 0)
        iCPs = 0;

    SendMessageToPC(oAcquirer, "You have found some craftable material!");
    SetLocalInt(oCrafting, "crafting", iCPs + iFormula);
    iCPs = GetLocalInt(oCrafting, "crafting");

    sMsg = "You currently have " + IntToString(iCPs) + " crafting points.";
    SendMessageToPC(oAcquirer, sMsg);
    DestroyObject(oItem);
}

void main()
{
    object oItem = GetModuleItemAcquired();
    object oAcquirer = GetModuleItemAcquiredBy();
    string sRef = GetResRef(oItem);
    string sTag = GetTag(oItem);

    if(GetWeight(oItem)>=40)
        SetPickpocketableFlag(oItem,FALSE);

    // None of the rest of this stuff is applicable to NPCs
    if(!GetIsPC(oAcquirer))
        return;

    object oArea = GetArea(oAcquirer);
    string sAreaName = GetName(oArea);
    string sAreaTag = GetTag(oArea);
    // Ignore these from logging because it's spammy as hell
    if(GetSubString(sRef, 0, 10) != "zombiekill" && sRef != "zombiedisease" &&
                    sTag != "SurvivalTime" && sAreaTag != "OOCPlayerLounge" &&
                    sRef != "cr_arrows")
    {
        // Format : ITEM_ACQUIRE:[pc name] | [account name] | [item resref] | [item name] | [area name]
        // Example: ITEM_ACQUIRE:Seth | Tweek | item001 | Test Item  | Sundered Desolation
        string sLog = "ITEM_ACQUIRE:" + GetName(oAcquirer) + " | " +
                        GetPCPlayerName(oAcquirer) + " | " +
                        sRef + " | " +
                        GetName(oItem) + " | " +
                        sAreaName;
        WriteTimestampedLogEntry(sLog);
    }

    if(sTag == "ecl_token")
        AcquireECL(oAcquirer);

    if(GetTag(oItem)=="ZombieDisease")
        AcquireDisease(oAcquirer);

    if(GetIsPC(oAcquirer) && sTag == "craftingpoints")
        AcquireCrafting(oAcquirer, oItem);

    if(sTag == "zkxthous")
        ExecuteScript("tenthouszk", oAcquirer);
}
