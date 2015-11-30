//Name: Salvaging and Crafting Point System: Main
//Developer: Skeet/DM Malevolent
//Date: 8-02-2007
//Purpose: A system that would work for Zombie Survival
//         and in unison with the searching scripts
//         to salvage found 'craftable' material
//         to use in crafting new material.
#include "disease_inc"
#include "lnx_inc_eval_itm"

void DMX_ZOMBIEKILLS(object oPC, object oItem)
{
    int nKills = GetCampaignInt(GetPCPlayerName(oPC),GetName(oPC)+"_ZOMBIEKILLS",oPC);
    nKills++;
    int nFrenzy = GetCampaignInt(GetPCPlayerName(oPC),GetName(oPC)+"_FRENZYKILLS",oPC);
    if(GetTimeHour()==0)
        {
        nFrenzy++;
        SetCampaignInt(GetPCPlayerName(oPC),GetName(oPC)+"_ZOMBIEKILLS",nFrenzy,oPC);
        }
    SetCampaignInt(GetPCPlayerName(oPC),GetName(oPC)+"_ZOMBIEKILLS",nKills,oPC);
    if ((nKills >= 500) && (OBJECT_INVALID == GetItemPossessedBy(oPC,"badge21")))
        {
          CreateItemOnObject("badge21",oPC);
          FloatingTextStringOnCreature("You received a new badge!", oPC, FALSE);
          GiveXPToCreature(oPC,100);
        }
    if ((nFrenzy >= 50) && (OBJECT_INVALID == GetItemPossessedBy(oPC,"badge22")))
        {
          CreateItemOnObject("badge22",oPC);
          FloatingTextStringOnCreature("You received a new badge!", oPC, FALSE);
          GiveXPToCreature(oPC,100);
        }
        DestroyObject(oItem);
}



void main()
{
object oItem = GetModuleItemAcquired();
object oAcquirer = GetModuleItemAcquiredBy();
// Quit if not a character
if (GetIsPC(oAcquirer) == FALSE && GetIsDM(oAcquirer) == FALSE && GetIsDMPossessed(oAcquirer) == FALSE)
    {
    return;
    }
// If this is not an item we want to evaluate for sharpness/durability, skip.
if (GetItemType(oItem) != "OTHER" && GetLocalInt(oItem, "MATERIAL") == 0)
    {
    EvaluateItem(oItem);
    }

string sRef = GetResRef(oItem);
string sTag = GetTag(oItem);

if(sTag == "ZombieKill")
    {
    DMX_ZOMBIEKILLS(oAcquirer,oItem);
    }

if(sTag == "zkxthous")
    {
    ExecuteScript("tenthouszk", oAcquirer);
    }
//PICKPOCKET RESTRICTION
if (sTag == "SurvivalTime")
{
        int nTime = GetCampaignInt(GetPCPlayerName(oAcquirer),GetName(oAcquirer)+"_SURVIVALTIME",oAcquirer);
        nTime++;
        SetCampaignInt(GetPCPlayerName(oAcquirer),GetName(oAcquirer)+"_SURVIVALTIME",nTime,oAcquirer);
        if ((nTime >= 100) && (OBJECT_INVALID == GetItemPossessedBy(oAcquirer,"badge23")))
        {
          CreateItemOnObject("badge23",oAcquirer);
          FloatingTextStringOnCreature("You received a new badge!", oAcquirer, FALSE);
          GiveXPToCreature(oAcquirer,100);
        }
        DestroyObject(oItem);
        //ExecuteScript("survivaltimes", oAcquirer);
}
else if (sTag == "ZombieKill")
{
        //ExecuteScript("zombiekill", oAcquirer);
}
else if (sTag == "FrenzyKill")
{
       // ExecuteScript("frenzykill", oAcquirer);
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
     ApplyEffectToObject(DURATION_TYPE_PERMANENT,SupernaturalEffect(EffectAbilityDecrease(ABILITY_CONSTITUTION,2)),oAcquirer);
     SetLocalInt(oAcquirer,"DiseaseApplied",TRUE);
     }
else if(nDisease == 3)
     {
     ApplyEffectToObject(DURATION_TYPE_PERMANENT,SupernaturalEffect(EffectAbilityDecrease(ABILITY_DEXTERITY,2)),oAcquirer);
     }
else if(nDisease == 4)
     {
     ApplyEffectToObject(DURATION_TYPE_PERMANENT,SupernaturalEffect(EffectAbilityDecrease(ABILITY_STRENGTH,2)),oAcquirer);
     }
else if(nDisease == 5)
     {
     ApplyEffectToObject(DURATION_TYPE_PERMANENT,SupernaturalEffect(EffectAbilityDecrease(ABILITY_INTELLIGENCE,2)),oAcquirer);
     }
else if(nDisease == 6)
     {
     ApplyEffectToObject(DURATION_TYPE_PERMANENT,SupernaturalEffect(EffectAbilityDecrease(ABILITY_WISDOM,2)),oAcquirer);
     }
else if(nDisease == 7)
     {
     ApplyEffectToObject(DURATION_TYPE_PERMANENT,SupernaturalEffect(EffectAbilityDecrease(ABILITY_CHARISMA,2)),oAcquirer);
     }
else if(nDisease == 8)
{
     ApplyEffectToObject(DURATION_TYPE_PERMANENT,SupernaturalEffect(EffectAbilityDecrease(ABILITY_CONSTITUTION,2)),oAcquirer);
     ApplyEffectToObject(DURATION_TYPE_PERMANENT,SupernaturalEffect(EffectAbilityDecrease(ABILITY_DEXTERITY,2)),oAcquirer);
     ApplyEffectToObject(DURATION_TYPE_PERMANENT,SupernaturalEffect(EffectAbilityDecrease(ABILITY_STRENGTH,2)),oAcquirer);
}
else if(nDisease == 9)
{
ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectConfused(),oAcquirer,IntToFloat(Random(60)+1));
}
}

}
