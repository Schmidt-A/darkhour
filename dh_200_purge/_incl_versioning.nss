//Versioning for each PC that enters the mod -Aez

#include "_incl_subrace"

void GiveClassItems(object oPC, int iPCClass);
void CullClassItems(object oPC, int iPCClass);
void ZeroToVersionOne(object oPC);
void ZeroToVersionTwo(object oPC);

/* Replace kill/survival time tokens with variables on the players' PC token. */
void TokensToVars(object oPC, object oPCToken);

void GiveClassItems(object oPC, int iPCClass)
{
    switch(iPCClass)
    {
        // should we use the resref or the tag?
        case CLASS_TYPE_WIZARD:
            //what's the bloodmagic resref?
            CreateItemOnObject("BloodMagicBook",oPC);
            CreateItemOnObject("arcanecloak",oPC);
            CreateItemOnObject("rodofmagicmissil",oPC);
            break;
        case CLASS_TYPE_SORCERER:
            CreateItemOnObject("BloodMagicBook",oPC);
            CreateItemOnObject("arcanecloak",oPC);
            CreateItemOnObject("rodofmagicmissil",oPC);
            break;
        case CLASS_TYPE_ROGUE:
            CreateItemOnObject("extrascavenger",oPC);
            break;
        case CLASS_TYPE_RANGER:
            CreateItemOnObject("forager",oPC);
            break;
        case CLASS_TYPE_PALADIN:
            break;
        case CLASS_TYPE_MONK:
            CreateItemOnObject("monkboots",oPC);
            break;
        case CLASS_TYPE_FIGHTER:
            CreateItemOnObject("warriorring",oPC);
            break;
        case CLASS_TYPE_DRUID:
            CreateItemOnObject("foodpurifier",oPC);
            CreateItemOnObject("herbalforager",oPC);
            break;
        case CLASS_TYPE_CLERIC:
            if (GetAlignmentGoodEvil(oPC) == ALIGNMENT_GOOD)
            {
                CreateItemOnObject("holysymbol",oPC);
            }
            else if (GetAlignmentGoodEvil(oPC) == ALIGNMENT_EVIL)
            {
                CreateItemOnObject("holysymbol2",oPC);
            }
            else
            {
                CreateItemOnObject("holysymbol3",oPC);
            }
            break;
        case CLASS_TYPE_BARD:
            CreateItemOnObject("sheetmusic",oPC);
            break;
        case CLASS_TYPE_BARBARIAN:
            CreateItemOnObject("warriorring",oPC);
            break;
        default:
            break;
    }
}

void CullClassItems(object oPC, int iLaterClass)
{
    switch(iLaterClass)
    {
        // should we use the resref or the tag?
        case CLASS_TYPE_WIZARD:
            DestroyObject(GetItemPossessedBy(oPC, "ArcaneCloak"), 0.0f);
            DestroyObject(GetItemPossessedBy(oPC, "ROMM"), 0.0f);
            break;
        case CLASS_TYPE_SORCERER:
            DestroyObject(GetItemPossessedBy(oPC, "ArcaneCloak"), 0.0f);
            DestroyObject(GetItemPossessedBy(oPC, "ROMM"), 0.0f);
            break;
        case CLASS_TYPE_ROGUE:
            DestroyObject(GetItemPossessedBy(oPC, "ExtraScavenger"), 0.0f);
            break;
        case CLASS_TYPE_RANGER:
            DestroyObject(GetItemPossessedBy(oPC, "Forager"), 0.0f);
            break;
        case CLASS_TYPE_PALADIN:
            break;
        case CLASS_TYPE_MONK:
            DestroyObject(GetItemPossessedBy(oPC, "MonkBoots"), 0.0f);
            break;
        case CLASS_TYPE_FIGHTER:
            //this int is never used
            SetCampaignInt(GetName(GetModule()), "Has_WRing", 0, oPC);
            if (GetClassByPosition(1, oPC) != CLASS_TYPE_BARBARIAN)
            {
                DestroyObject(GetItemPossessedBy(oPC, "WarriorRing"), 0.0f);
            }
            break;
        case CLASS_TYPE_DRUID:
            DestroyObject(GetItemPossessedBy(oPC, "FoodPurifier"), 0.0f);
            DestroyObject(GetItemPossessedBy(oPC, "HerbalForager"), 0.0f);
            break;
        case CLASS_TYPE_CLERIC:
            DestroyObject(GetItemPossessedBy(oPC, "holysymbol"), 0.0f);
            DestroyObject(GetItemPossessedBy(oPC, "holysymbol2"), 0.0f);
            DestroyObject(GetItemPossessedBy(oPC, "holysymbol3"), 0.0f);
            break;
        case CLASS_TYPE_BARD:
            DestroyObject(GetItemPossessedBy(oPC, "SheetMusic"), 0.0f);
            break;
        case CLASS_TYPE_BARBARIAN:
            //this int is never used
            SetCampaignInt(GetName(GetModule()), "Has_WRing", 0, oPC);
            if (GetClassByPosition(1, oPC) != CLASS_TYPE_FIGHTER)
            {
                DestroyObject(GetItemPossessedBy(oPC, "WarriorRing"), 0.0f);
            }
            break;
        default:
            break;
    }
}

void ZeroToVersionOne(object oPC)
{
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

    // If the entering object happens to be a DM and they don't have a PC list item,
    // give one to them.
    if (GetIsDM(oPC) && GetItemPossessedBy(oPC, "PC_LIST") == OBJECT_INVALID)
    {
        CreateItemOnObject("pc_list", oPC, 1);
    }


    if(!GetIsObjectValid(GetItemPossessedBy(GetEnteringObject(),"SubdualModeTog")))
    {
        CreateItemOnObject("subdualmodetog",GetEnteringObject());
    }

    string sPre = GetDBVarName(oPC);
    SetCampaignInt("VERSIONING", sPre+"Version", 1);
}


void ZeroToVersionTwo(object oPC)
{
    int iPCClass = GetClassByPosition(1, oPC);

    //They are version 0
    if (GetItemPossessedBy(oPC, "scavenger") == OBJECT_INVALID)
    {
        ZeroToVersionOne(oPC);
        if (GetIsDM(oPC) == FALSE)
        {

            GiveClassItems(oPC, iPCClass);
        }
    }
    // They are actually version 1 because they've logged in before
    else
    {
        if (!GetIsDM(oPC))
        {

            int iSecondClass = GetClassByPosition(2, oPC);
            if (iSecondClass != 255)
            {
                CullClassItems(oPC, iSecondClass);
            }
            int iThirdClass = GetClassByPosition(3, oPC);
            if (iThirdClass != 255)
            {
                CullClassItems(oPC, iThirdClass);
            }
            if (iPCClass == CLASS_TYPE_WIZARD || iPCClass == CLASS_TYPE_SORCERER)
            {
                CreateItemOnObject("BloodMagicBook",oPC);
            }

        }
    }

    string sPre = GetDBVarName(oPC);
    SetCampaignInt("VERSIONING", sPre+"Version", 2);
}

void TokensToVars(object oPC, object oPCToken)
{
    SetLocalInt(oPCToken, "bTokensInit", TRUE);

    int iSurvivalTokens     = 0;
    int iZombieKillTokens   = 0;
    int iFrenzyKillTokens   = 0;
    int iStackSize;
    string sTag;

    // First loop - count how many tokens we have
    object oItem = GetFirstItemInInventory(oPC);
    while(GetIsObjectValid(oItem))
    {
        sTag = GetTag(oItem);
        iStackSize = GetItemStackSize(oItem);

        if (sTag == "ZombieKill")
            iZombieKillTokens += 1 * iStackSize;
        else if (sTag == "ZK10")
            iZombieKillTokens += 10 * iStackSize;
        else if (sTag == "ZKHUNDRED")
            iZombieKillTokens += 100 * iStackSize;
        else if (sTag == "ZKTHOUSAND")
            iZombieKillTokens += 1000 * iStackSize;
        else if (sTag == "zkxthous")
            iZombieKillTokens += 10000 * iStackSize;

        else if (sTag == "SurvivalTime")
            iSurvivalTokens += 1 * iStackSize;
        else if (sTag == "ST10")
            iSurvivalTokens += 10 * iStackSize;
        else if (sTag == "ST100")
            iSurvivalTokens += 100 * iStackSize;
        else if (sTag == "ST1000")
            iSurvivalTokens += 1000 * iStackSize;

        else if (sTag == "FrenzyKill")
            iFrenzyKillTokens += 1 * iStackSize;
        else if (sTag == "FK10")
            iFrenzyKillTokens += 10 * iStackSize;
        else if (sTag == "FK100")
            iFrenzyKillTokens += 100 * iStackSize;
    }

    SetLocalInt(oPCToken, "iZombieKills", iZombieKillTokens);
    SetLocalInt(oPCToken, "iSurvivalTimes", iSurvivalTokens);
    SetLocalInt(oPCToken, "iFrenzyKills", iFrenzyKillTokens);

    /* Second loop - clean up the tokens. Doing it in two loops as opposed to
     * one because lists get screwy if you add/remove while iterating over
     * them. */
    oItem = GetFirstItemInInventory(oPC);
    while(GetIsObjectValid(oItem))
    {
        sTag = GetTag(oItem);

        if(sTag == "ZombieKill" || sTag == "ZK10" || sTag == "ZKHUNDRED" ||
           sTag == "ZKTHOUSAND" || sTag == "zkxthous" || sTag == "SurvivalTime" ||
           sTag == "ST10" || sTag == "ST100" || sTag == "ST1000" ||
           sTag == "FrenzyKill" || sTag == "FK10" || sTag == "FK100")
        {
            DestroyObject(oItem);
        }
    }
}
