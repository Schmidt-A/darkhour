//Versioning for each PC that enters the mod -Aez

void GiveClassItems(object oPC, int iPCClass)
{
	switch(iPCClass)
	{
		// should we use the resref or the tag?
		case 10:
			//wizard
			//what's the bloodmagic resref?
			object oBloodMagic = CreateItemOnObject("BloodMagicBook",oPC);
			object oArCloak = CreateItemOnObject("arcanecloak",oPC);
			object oMMRod = CreateItemOnObject("rodofmagicmissil",oPC);
			break;
		case 9:
			//sorcerer
			object oBloodMagic = CreateItemOnObject("BloodMagicBook",oPC);
			object oArCloak = CreateItemOnObject("arcanecloak",oPC);
			object oMMRod = CreateItemOnObject("rodofmagicmissil",oPC);
			break;
		case 8:
			//rogue
			object oXtraScav = CreateItemOnObject("extrascavenger",oPC);
			break;
		case 7:
			//ranger
			object oForager = CreateItemOnObject("forager",oPC);
			break;
		case 6:
			//paladin
			break;
		case 5:
			//monk
			object oMBoots = CreateItemOnObject("monkboots",oPC);
			break;
		case 4:
			//fighter
			//this int is never used
			SetCampaignInt(GetName(GetModule()), "Has_WRing", 1, oPC);
        	object oWRing = CreateItemOnObject("warriorring",oPC);
			break;
		case 3:
			//druid
			object oFoodPure = CreateItemOnObject("foodpurifier",oPC);
			object oHerbForage = CreateItemOnObject("herbalforager",oPC);
			break;
		case 2:
			//cleric
			break;
		case 1:
			//bard
			object oMuzak = CreateItemOnObject("sheetmusic",oPC);
			break;
		case 0:
			//barbarian
			//this int is never used
			SetCampaignInt(GetName(GetModule()), "Has_WRing", 1, oPC);
        	object oWRing = CreateItemOnObject("warriorring",oPC);
			break;
		default:
			break;
	}
}

string CullClassItems(object oPC, int iLaterClass)
{
	switch(iLaterClass)
	{
		// should we use the resref or the tag?
		case 10:
			//wizard
			DestroyObject(GetItemPossessedBy(oPC, "ArcaneCloak"), 0.0f, TRUE);
			DestroyObject(GetItemPossessedBy(oPC, "ROMM"), 0.0f, TRUE);
			break;
		case 9:
			//sorcerer
			DestroyObject(GetItemPossessedBy(oPC, "ArcaneCloak"), 0.0f, TRUE);
			DestroyObject(GetItemPossessedBy(oPC, "ROMM"), 0.0f, TRUE);
			break;
		case 8:
			//rogue
			DestroyObject(GetItemPossessedBy(oPC, "ExtraScavenger"), 0.0f, TRUE);
			break;
		case 7:
			//ranger
			DestroyObject(GetItemPossessedBy(oPC, "Forager"), 0.0f, TRUE);
			break;
		case 6:
			//paladin
			break;
		case 5:
			//monk
			DestroyObject(GetItemPossessedBy(oPC, "MonkBoots"), 0.0f, TRUE);
			break;
		case 4:
			//fighter
			//this int is never used
			SetCampaignInt(GetName(GetModule()), "Has_WRing", 0, oPC);
        	DestroyObject(GetItemPossessedBy(oPC, "WarriorRing"), 0.0f, TRUE);
			break;
		case 3:
			//druid
			DestroyObject(GetItemPossessedBy(oPC, "FoodPurifier"), 0.0f, TRUE);
			DestroyObject(GetItemPossessedBy(oPC, "HerbalForager"), 0.0f, TRUE);
			break;
		case 2:
			//cleric
			break;
		case 1:
			//bard
			DestroyObject(GetItemPossessedBy(oPC, "SheetMusic"), 0.0f, TRUE);
			break;
		case 0:
			//barbarian
			//this int is never used
			SetCampaignInt(GetName(GetModule()), "Has_WRing", 0, oPC);
        	DestroyObject(GetItemPossessedBy(oPC, "WarriorRing"), 0.0f, TRUE);
			break;
		default:
			break;
	}
}

void ZeroToVersionOne(object oPC)
{
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

    SetLocalInt(oPC, "Version", 1);
}


void ZeroToVersionTwo(object oPC)
{
	ZeroToVersionOne(oPC);
	
	if (GetIsDM(oPC) == FALSE)
	{
		int iPCClass = GetClassByPosition(oPC);
		GiveClassItems(oPC);		
	}
	

    SetLocalInt(oPC, "Version", 2);
}

void OneToVersionTwo(object oPC) 
{
	
	int iFirstClass = GetClassByPosition(1, oPC);

	if (!GetIsDM(oPC))
	{
		int iSecondClass = GetClassByPosition(2, oPC);
		if (iSecondClass != 255)
		{
			CullClassItems(iSecondClass);
		}
		int iThirdClass = GetClassByPosition(3, oPC);
		if (iThirdClass != 255)
		{
			CullClassItems(iThirdClass);
		}
		
	}

	//do you think we should have if statements this nested?
	if ((OBJECT_INVALID == GetItemPossessedBy(oPC, "BloodMagicBook")) && (iFirstClass == 10 || iFirstClass == 9))
    {
        //what is the resref?
        object oBloodMagic = CreateItemOnObject("BloodMagicBook",oPC);
    }

    SetLocalInt(oPC, "Version", 2);

}

