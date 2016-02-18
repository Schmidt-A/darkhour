
int LocalContains(object oLocalVar, string sRef);
void FailedRef(object oLocalVar, string sRef, int iCount);
object TryCreateRef(object oLocalVar, int iType, string sRef, int iCount, object oUser, location lWay);
object RandomizeRefs(object oLocalVar, int iType, int iCount, int iTotalChance, object oUser, location lWay);
object CreateRandomLocalRef(object oLocalVar, int iType, object oUser, location lWay);

//Does the object have this resref as a local var
int LocalContains(object oLocalVar, string sRef)
{
	int iCount = 1;
	string sResref = GetLocalString(oLocalVar, "Resref"+IntToString(iCount));
	while (sResref != "") 
	{
		if (sResref == sRef)
			return TRUE;

		//increment
		iCount++;
		string sResref = GetLocalString(oLocalVar, "Resref"+IntToString(iCount));
	}
	return FALSE;
}

//Removes the Ref from the local variables RefChance so that it can't keep showing up
void FailedRef(object oLocalVar, string sRef, int iCount)
{
	// stop that shit from showing up again ideally
    SetLocalInt(oLocalVar, "RefChance"+IntToString(iCount), 0);

    //also add oUser
    //add time
    PrintString("The resref " + sRef + " was selected by " + GetName(oLocalVar) + " at TIME");  
}

//Creates an object and checks if the Ref has a proper GetName value
object TryCreateRef(object oLocalVar, int iType, string sRef, int iCount, object oUser, location lWay)
{
	object oCreate;

	//We can create basically any object using this strategy, including placeables and so on
	switch(iType)
	{
		case OBJECT_TYPE_CREATURE:
			oCreate = CreateObject(iType, sRef, lWay);
			break;
		case OBJECT_TYPE_ITEM:
			oCreate = CreateItemOnObject(sRef, oUser);
			break;
		default:
			oCreate = GetLocalObject(oLocalVar, "null");
			break;
	}

	//Is this check accurate for both creatures and items?
	if (GetName(oCreate) != "_")
	{
		return oCreate;
	}
	else 
	{
		FailedRef(sRef, iCount, oLocalVar);

		//I WISH I COULD JUST SET THIS TO NULL
		//This will equal: OBJECT_INVALID
		return GetLocalObject(oLocalVar, "null");
	}
}

//Generate a random Ref with appropriate weighting based on local variables
object RandomizeRefs(object oLocalVar, int iType, int iCount, int iTotalChance, object oUser, location lWay) 
{
	int iRand = Random(iTotalChance);
	int iIterate = 0;
	int iAccumChance = 0;
	string sRef = "";
	object oCreate;
	while (iIterate < iCount+1) 
	{

	    // check where the random number falls in the generated int chance
	    int iChance = GetLocalInt(oLocalVar, "RefChance"+IntToString(iIterate));
	    if (iRand >= iAccumChance && iRand < iAccumChance + iChance) 
	    {
	        string sRef = GetLocalString(oLocalVar, "Resref"+IntToString(iIterate));

	        oCreate = CheckRef(string sRef);
	        
	        if (GetIsObjectValid(oCreate)) 
	        {
	            //PrintString("RESREF:</c  "+GetLocalString(oLocalVar, "Resref"+IntToString(iIterate)), oUser, FALSE);

	            // end the loop, cuz they have their item
	            iIterate = iCount + 1;
	        }
	        else 
	        {
	            iPos = -1;             
	            iIterate++;
	        }
	    }
	    else 
	    {
	        // the chance didn't match for this item
	        // keep looping, add the chance values up
	        iIterate++;
	        iAccumChance += iChance;
	    }
	}

	return oCreate;     
}

//Setup all the local variables for appropriate iteration via the RandomizeRefs
object CreateRandomLocalRef(object oLocalVar, int iType, object oUser, location lWay)
{
	// It checks all the resrefs on the trigger object (ResRef1-??)
	// What is the max?? -Aez

	// Will iteratre over the RefChance float for each resref
	int iCount = 1;
	int iTotalChance = 0;
	string sResref = GetLocalString(oLocalVar, "Resref"+IntToString(iCount));
	while (sResref != "") 
	{
	    int iRefChance = GetLocalInt(oLocalVar, "RefChance"+IntToString(iCount));
	    if (iRefChance == 0) 
	    {
	        //default ref chance if people forget to add one for any given ref
	        iRefChance = 50;
	        SetLocalInt(oLocalVar, "RefChance"+IntToString(iCount), iRefChance);
	    }
	    else if (iRefChance == -1)
	    {
	        iRefChance = 0;
	    }
	    iTotalChance += iRefChance;

	    //Get the next local ref
	    iCount++;
	    sResref = GetLocalString(oLocalVar, "Resref"+IntToString(iCount));
	}

	//decrement it by one since it's a 1 based number
	iCount--;

	return RandomizeRefs(oLocalvar, iType, iCount, iTotalChance, oUser, lWay);
}
	