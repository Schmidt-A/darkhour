//
// enter_script -- This script, or the code from it, may be added to
// onEnterModule if you wish to automatically give the scavenger object to
// each player as they enter the module.
//
#include "_incl_location"
#include "disease_inc"
#include "x3_inc_horse"

void DMX_ITEMFIXES(object oPC)
{
if(GetItemPossessedBy(oPC,"pickrocks")==OBJECT_INVALID)
    CreateItemOnObject("dmx_pickrocks",oPC);
}

void main()
{

    object oPC = GetEnteringObject();
    if(GetIsPC(oPC))
    {
        DMX_ITEMFIXES(oPC);
    }
    string sModName = GetName(GetModule());
    if(GetHasFeat(FEAT_HORSE_MENU, oPC) == FALSE)
    {
    HorseAddHorseMenu(oPC);
    }
    if(GetCampaignInt(GetPCPlayerName(oPC)+"_BANNED",GetPCPlayerName(oPC))==TRUE)
    {
        BootPC(oPC);
    }
    else if(GetCampaignInt(GetPCIPAddress(oPC)+"_BANNED",GetPCIPAddress(oPC))==TRUE)
    {
        BootPC(oPC);
    }
    else if(GetCampaignInt(GetPCPublicCDKey(oPC)+"_BANNED",GetPCPublicCDKey(oPC))==TRUE)
    {
        BootPC(oPC);
    }
    string sName = GetName(oPC);
    int nHitpoints = GetLocalInt(GetModule(),sName);
    //Demon X6
    if (GetPCPlayerName(oPC)=="ThisIsAFakeAccountNameLawl")
    {
        SendMessageToAllDMs (GetName(oPC) + " has entered the game.");
        PrintString(GetName(oPC) + " has entered the game.");
    }
    else
    {
        SendMessageToAllDMs (GetName(oPC) + " is entering the game from: " + GetPCPublicCDKey(oPC) + " IP ADDRESS: " + GetPCIPAddress(oPC));
        PrintString(GetName(oPC) + " is entering the game from: " + GetPCPublicCDKey(oPC) + " IP ADDRESS: " + GetPCIPAddress(oPC));
    }
    if (OBJECT_INVALID != GetItemPossessedBy(oPC, "Banner"))
    {
        BootPC(oPC);
    }
    if (nHitpoints > 0)
    {
        int nLessHP = GetMaxHitPoints(oPC) - nHitpoints;
        if (nLessHP > 0)
        {
            ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectDamage(nLessHP),oPC);
        }
    }
    AddJournalQuestEntry("Stuff1",1,oPC,FALSE);
    AddJournalQuestEntry("RULES2",1,oPC,FALSE);
    AddJournalQuestEntry("Stuff3",1,oPC,FALSE);
    AddJournalQuestEntry("Stuff4",1,oPC,FALSE);
    AddJournalQuestEntry("DMTEAM",1,oPC,FALSE);
    AddJournalQuestEntry("CraftingSystem",1,oPC,FALSE);
    AddJournalQuestEntry("ClawingFeverInfo",1,oPC,FALSE);

    DelayCommand(12.0,SetLocalInt(oPC,"ingame",1));
    if ((OBJECT_INVALID == GetItemPossessedBy(oPC, "scavenger")) && (GetIsDM(oPC) == FALSE))
    {
        ExecuteScript("setupnewstuff",oPC);
    }

    if ((OBJECT_INVALID == GetItemPossessedBy(oPC, "craftingitem")))
     {

        object oCraft = CreateItemOnObject("craftingitem",oPC);
     }



    if ((OBJECT_INVALID == GetItemPossessedBy(oPC, "ROMM")) && (GetIsDM(oPC) == FALSE) && ((GetLevelByClass(CLASS_TYPE_WIZARD,oPC)) + (GetLevelByClass(CLASS_TYPE_SORCERER,oPC)) > 0))
    {
        object oMMRod = CreateItemOnObject("rodofmagicmissil",oPC);
    }
    if ((OBJECT_INVALID == GetItemPossessedBy(oPC, "ArcaneCloak")) && (GetIsDM(oPC) == FALSE) && ((GetLevelByClass(CLASS_TYPE_WIZARD,oPC)) + (GetLevelByClass(CLASS_TYPE_SORCERER,oPC)) > 0))
    {
        object oArCloak = CreateItemOnObject("arcanecloak",oPC);
    }
    if ((OBJECT_INVALID == GetItemPossessedBy(oPC, "SheetMusic")) && (GetLevelByClass(CLASS_TYPE_BARD,oPC) > 0))
    {
        object oMuzak = CreateItemOnObject("sheetmusic",oPC);
    }
    if ((OBJECT_INVALID == GetItemPossessedBy(oPC, "ExtraScavenger")) && (GetLevelByClass(CLASS_TYPE_ROGUE,oPC) > 0))
    {
            object oXtraScav = CreateItemOnObject("extrascavenger",oPC);
    }
    if ((OBJECT_INVALID == GetItemPossessedBy(oPC, "FoodPurifier")) && (GetLevelByClass(CLASS_TYPE_DRUID,oPC) > 0))
    {
        object oFoodPure = CreateItemOnObject("foodpurifier",oPC);
    }
    if ((OBJECT_INVALID == GetItemPossessedBy(oPC, "HerbalForager")) && (GetLevelByClass(CLASS_TYPE_DRUID,oPC) > 0))
    {
        object oHerbForage = CreateItemOnObject("herbalforager",oPC);
    }
    if ((OBJECT_INVALID == GetItemPossessedBy(oPC, "Forager")) && (GetLevelByClass(CLASS_TYPE_RANGER,oPC) > 0))
    {
        object oForager = CreateItemOnObject("forager",oPC);
    }
    if ((OBJECT_INVALID == GetItemPossessedBy(oPC, "MonkBoots")) && (OBJECT_INVALID == GetItemInSlot(INVENTORY_SLOT_BOOTS,oPC)) && (GetLevelByClass(CLASS_TYPE_MONK,oPC) > 0))
    {
        object oMBoots = CreateItemOnObject("monkboots",oPC);
    }
    if ((OBJECT_INVALID == GetItemPossessedBy(oPC, "WarriorRing")) && (OBJECT_INVALID == GetItemInSlot(INVENTORY_SLOT_RIGHTRING,oPC)) + (OBJECT_INVALID == GetItemInSlot(INVENTORY_SLOT_LEFTRING,oPC)) && ((GetLevelByClass(CLASS_TYPE_FIGHTER,oPC)) + (GetLevelByClass(CLASS_TYPE_BARBARIAN,oPC)) > 0) && GetItemPossessedBy(oPC, "w_telepring") == OBJECT_INVALID && GetCampaignInt(GetName(GetModule()), "Has_WRing", oPC) == 0)
    {
        SetCampaignInt(GetName(GetModule()), "Has_WRing", 1, oPC);
        object oWRing = CreateItemOnObject("warriorring",oPC);
    }

    int nDisease = 0;
    object oCheckDisease = GetFirstItemInInventory(oPC);
    while (oCheckDisease != OBJECT_INVALID)
    {
        if (GetTag(oCheckDisease) == "ZombieDisease")
        {
            nDisease += 1;
        }
        oCheckDisease = GetNextItemInInventory(oPC);
    }
    if (nDisease >= 10)
        DelayCommand(0.5, PortToWaypoint(oPC, "lostsoularrive"));

    // TODO: Get rid of needing both.
    if (GetItemPossessedBy(oPC, "DeathToken") != OBJECT_INVALID ||
    	GetItemPossessedBy(oPC, "ReaperToken") != OBJECT_INVALID)
    {
    	DelayCommand(0.5, PortToWaypoint(oPC, "GoToFugue"));
    }

    // If the entering object happens to be a DM and they don't have a PC list item,
    // give one to them.
    if (GetIsDM(oPC) && GetItemPossessedBy(oPC, "PC_LIST") == OBJECT_INVALID)
    {CreateItemOnObject("pc_list", oPC, 1);}

    ExecuteScript("window_mod_enter", OBJECT_SELF);
    //DISEASE ADDITION - DEMON X
    if(GetItemPossessedBy(oPC,"ZombieDisease") != OBJECT_INVALID && GetLocalInt(oPC,"DiseaseApplied") != TRUE)
    {
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


     if(!GetIsObjectValid(GetItemPossessedBy(GetEnteringObject(),"SubdualModeTog")))
       CreateItemOnObject("subdualmodetog",GetEnteringObject());
}
