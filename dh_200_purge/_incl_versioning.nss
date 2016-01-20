//Versioning for each PC that enters the mod -Aez

#include "_cls_bard"
#include "_incl_subrace"

void GiveClassItems(object oPC, int iPCClass);
void CullClassItems(object oPC, int iPCClass);

void ZeroToVersionOne(object oPC);
void ZeroToVersionTwo(object oPC);
void TwoToVersionThree(object oPC);
void FindVersion(object oPC);


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
            CreateItemOnObject("kishuriken",OBJECT_SELF,20);
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
            DestroyObject(GetItemPossessedBy(oPC, "kishuriken"), 0.0f);
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

void ZeroToVersionOne(object oPC, string sPre)
{

    DelayCommand(12.0,SetLocalInt(oPC,"ingame",1));
    object oTemp;
    oTemp = GetFirstItemInInventory();
    while (GetIsObjectValid(oTemp))
    {
        DestroyObject(oTemp);
        oTemp = GetNextItemInInventory();
    }

    SubraceLogin(OBJECT_SELF);

    CreateItemOnObject("dmfi_pc_emote",OBJECT_SELF);
    CreateItemOnObject("greatroleplay",OBJECT_SELF);
    CreateItemOnObject("dmfi_pc_dicebag",OBJECT_SELF);
    CreateItemOnObject("scavenger",OBJECT_SELF);
    CreateItemOnObject("professionpc",OBJECT_SELF);
    CreateItemOnObject("langselect", OBJECT_SELF);
    if ((GetHasFeat(FEAT_WEAPON_PROFICIENCY_DRUID)) || (GetHasFeat(FEAT_WEAPON_PROFICIENCY_MONK)) || (GetHasFeat(FEAT_WEAPON_PROFICIENCY_ROGUE)) || (GetHasFeat(FEAT_WEAPON_PROFICIENCY_SIMPLE)))
    {
        CreateItemOnObject("zn_sling",OBJECT_SELF);
        CreateItemOnObject("zn_stones",OBJECT_SELF,99);
        CreateItemOnObject("chairleg",OBJECT_SELF);
    }
    else
    {
        CreateItemOnObject("zn_crossbow",OBJECT_SELF);
        CreateItemOnObject("zn_bolts",OBJECT_SELF,50);
        CreateItemOnObject("chairleg",OBJECT_SELF);
    }
    CreateItemOnObject("zn_medkit",OBJECT_SELF);
    CreateItemOnObject("mil_dyekit002",OBJECT_SELF);
    CreateItemOnObject("bread",OBJECT_SELF);
    CreateItemOnObject("bread",OBJECT_SELF);
    CreateItemOnObject("craftingitem",oPC);
    CreateItemOnObject("subdualmodetog",GetEnteringObject());

    // If the entering object happens to be a DM and they don't have a PC list item,
    // give one to them.
    if (GetIsDM(oPC) && GetItemPossessedBy(oPC, "PC_LIST") == OBJECT_INVALID)
    {
        CreateItemOnObject("pc_list", oPC, 1);
    }

    SetCampaignInt("VERSIONING", sPre+"Version", 1);
}


void ZeroToVersionTwo(object oPC, string sPre)
{
    int iPCClass = GetClassByPosition(1, oPC);

    //They are version 0
    if (GetItemPossessedBy(oPC, "scavenger") == OBJECT_INVALID)
    {
        ZeroToVersionOne(oPC, sPre);
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

    SetCampaignInt("VERSIONING", sPre+"Version", 2);
}

//Subrace update
void TwoToVersionThree(object oPC, string sPre)
{
    //Remove the subrace skins people currently have
    if(GetCampaignInt("SUBRACE", sPre+"enabled") == TRUE)
        RemoveSkin(oPC);

    object oPCToken = CreateItemOnObject("token_pc", oPC);
        // Setup for brand new bard
        if (GetClassByPosition(1, oPC) == CLASS_TYPE_BARD && GetHitDice(oPC) == 1)
            SetupNewBard(oPC);

    }

    // clean up their tokens, if they have any
    //Dis needs done
    if (!GetLocalInt(oPCToken, "bTokensInit"))
        TokensToVars(oPC, oPCToken);

    SetCampaignInt("VERSIONING", sPre+"Version", 3);   
}

void FindVersion(object oPC)
{
    string sPre = GetDBVarName(oPC);
    int iVersion = GetCampaignInt("VERSIONING", sPre+"Version");

    switch(iVersion)
    {
        case 2:
            TwoToVersionThree(oPC, sPre);
            break;
        case 3:
            //They're up to date!
            break;
        default:
            ZeroToVersionTwo(oPC, sPre);
            break;
    }

}
