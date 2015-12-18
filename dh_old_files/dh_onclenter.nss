//
// enter_script -- This script, or the code from it, may be added to
// onEnterModule if you wish to automatically give the scavenger object to
// each player as they enter the module.
//
#include "disease_inc"
#include "x3_inc_horse"
#include "_incl_xp"
void main()
{

    object oPC = GetEnteringObject();
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

    //set their xp vars
    SetXPVars(oPC);

    //Demon X6
    if (GetPCPlayerName(oPC)=="ThisIsAFakeAccountNameLawl")
    {
        SendMessageToAllDMs (GetName(oPC) + " has entered the game.");
        PrintString(GetName(oPC) + " has entered the game.");
    }
    else
    {
        string sMessage = GetName(oPC) + " is entering the game from: " +
                            GetPCPublicCDKey(oPC) + " IP ADDRESS: " +
                            GetPCIPAddress(oPC);
        string sLog = "ENTRY: " + GetName(oPC) + " | " +
                                    GetPCPublicCDKey(oPC) + " | " +
                                    GetPCIPAddress(oPC) + " | " +
                                    IntToString(GetXPDH(oPC));
        SendMessageToAllDMs(sMessage);
        PrintString(sMessage);
        // a new logging form
        WriteTimestampedLogEntry(sLog);

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
    AddJournalQuestEntry("Stuff1_5",1,oPC,FALSE);
    AddJournalQuestEntry("Stuff2",1,oPC,FALSE);
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

     //we should get rid of the DM check
    if ((OBJECT_INVALID == GetItemPossessedBy(oPC, "ROMM")) && (GetIsDM(oPC) == FALSE) && ((GetLevelByClass(CLASS_TYPE_WIZARD,oPC)) + (GetLevelByClass(CLASS_TYPE_SORCERER,oPC)) > 0))
    {
        object oMMRod = CreateItemOnObject("rodofmagicmissil",oPC);
    }
    if ((OBJECT_INVALID == GetItemPossessedBy(oPC, "BloodMagicBook")) && (GetIsDM(oPC) == FALSE) && ((GetLevelByClass(CLASS_TYPE_WIZARD,oPC)) + (GetLevelByClass(CLASS_TYPE_SORCERER,oPC)) > 0))
    {
        //what is the resref?
        object oBloodMagic = CreateItemOnObject("BloodMagicBook",oPC);
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
    //we should get rid fo the check for an item in that slot
    if ((OBJECT_INVALID == GetItemPossessedBy(oPC, "MonkBoots")) && (OBJECT_INVALID == GetItemInSlot(INVENTORY_SLOT_BOOTS,oPC)) && (GetLevelByClass(CLASS_TYPE_MONK,oPC) > 0))
    {
        object oMBoots = CreateItemOnObject("monkboots",oPC);
    }
    if ((OBJECT_INVALID == GetItemPossessedBy(oPC, "WarriorRing")) && (OBJECT_INVALID == GetItemInSlot(INVENTORY_SLOT_RIGHTRING,oPC)) + (OBJECT_INVALID == GetItemInSlot(INVENTORY_SLOT_LEFTRING,oPC)) && ((GetLevelByClass(CLASS_TYPE_FIGHTER,oPC)) + (GetLevelByClass(CLASS_TYPE_BARBARIAN,oPC)) > 0) && GetItemPossessedBy(oPC, "w_telepring") == OBJECT_INVALID && GetCampaignInt(GetName(GetModule()), "Has_WRing", oPC) == 0)
    {
        SetCampaignInt(GetName(GetModule()), "Has_WRing", 1, oPC);
        object oWRing = CreateItemOnObject("warriorring",oPC);
    }
    if ((OBJECT_INVALID == GetItemPossessedBy(oPC, "holysymbol")) && 
            (OBJECT_INVALID == GetItemPossessedBy(oPC, "holysymbol2")) &&
            (OBJECT_INVALID == GetItemPossessedBy(oPC, "holysymbol3")) &&
            (GetLevelByClass(CLASS_TYPE_CLERIC,oPC) > 0))
    {
        if (GetAlignmentGoodEvil(oPC) == ALIGNMENT_GOOD)
        {
            object oHolyS = CreateItemOnObject("holysymbol",oPC);
        }
        else if (GetAlignmentGoodEvil(oPC) == ALIGNMENT_EVIL)
        {
            object oHolyS = CreateItemOnObject("holysymbol2",oPC);
        }
        else
        {
            object oHolyS = CreateItemOnObject("holysymbol3",oPC);
        }
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
    {
        DelayCommand(0.5,AssignCommand(oPC,JumpToLocation(GetLocation(GetWaypointByTag("lostsoularrive")))));
    }

    if (OBJECT_INVALID != GetItemPossessedBy(oPC, "DeathToken"))
    {
//      effect eDeath = EffectDeath();
//      ApplyEffectToObject(DURATION_TYPE_INSTANT,eDeath,oPC);

        int nAlign = GetAlignmentGoodEvil(oPC);
        location lLoc;
        if (nAlign == ALIGNMENT_EVIL)
        {
            lLoc = GetLocation(GetWaypointByTag("GoToFugue"));
        }
        else if (nAlign == ALIGNMENT_GOOD)
        {
            lLoc = GetLocation(GetWaypointByTag("GoToFugue"));
        }
        else
        {
            lLoc = GetLocation(GetWaypointByTag("GoToFugue"));
        }
        DelayCommand(0.5,AssignCommand(oPC,JumpToLocation(lLoc)));
    }
    if (OBJECT_INVALID != GetItemPossessedBy(oPC, "ReaperToken"))
    {
//      effect eDeath = EffectDeath();
//      ApplyEffectToObject(DURATION_TYPE_INSTANT,eDeath,oPC);

        int nAlign = GetAlignmentGoodEvil(oPC);
        location lLoc;
        if (nAlign == ALIGNMENT_EVIL)
        {
            lLoc = GetLocation(GetWaypointByTag("GoToFugue"));
        }
        else if (nAlign == ALIGNMENT_GOOD)
        {
            lLoc = GetLocation(GetWaypointByTag("GoToFugue"));
        }
        else
        {
            lLoc = GetLocation(GetWaypointByTag("GoToFugue"));
        }
        DelayCommand(0.5,AssignCommand(oPC,JumpToLocation(lLoc)));
    }




    // If the entering object happens to be a DM and they don't have a PC list item,
    // give one to them.
    if (GetIsDM(oPC) && GetItemPossessedBy(oPC, "PC_LIST") == OBJECT_INVALID)
    {
        CreateItemOnObject("pc_list", oPC, 1);
    }

    ExecuteScript("window_mod_enter", OBJECT_SELF);

    if(GetItemPossessedBy(oPC,"ZombieDisease") != OBJECT_INVALID && GetLocalInt(oPC,"DiseaseApplied") != TRUE)
    {
        ApplyDisease(oPC);
    }


     if(!GetIsObjectValid(GetItemPossessedBy(GetEnteringObject(),"SubdualModeTog")))
       CreateItemOnObject("subdualmodetog",GetEnteringObject());
}