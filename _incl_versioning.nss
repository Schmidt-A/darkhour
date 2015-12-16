

ZeroToVersionTwo()
{
	
}

OneToVersionTwo() 
{
	if ((OBJECT_INVALID == GetItemPossessedBy(oPC, "ROMM")) && (GetIsDM(oPC) == FALSE) && ((GetLevelByClass(CLASS_TYPE_WIZARD,oPC)) + (GetLevelByClass(CLASS_TYPE_SORCERER,oPC)) > 0))
	{
	    object oMMRod = CreateItemOnObject("rodofmagicmissil",oPC);
	}
}

