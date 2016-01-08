void main()
{
    object oPC = GetLastUsedBy();
    object oSeed = GetItemPossessedBy(oPC,"Seeds");
    if (oSeed != OBJECT_INVALID)
    {
        DestroyObject(oSeed);
        AssignCommand(oPC,ActionPlayAnimation(ANIMATION_LOOPING_GET_LOW, 1.0, 1.5));
        FloatingTextStringOnCreature("Seeds planted.",oPC,FALSE);
        int nSSN = GetLocalInt(OBJECT_SELF,"ssn");
        int nInstance = 1;
        location lPlant = GetLocation(OBJECT_SELF);
        object oSoil = GetNearestObjectByTag("ssloc",OBJECT_SELF,nInstance);
        while (GetLocalInt(oSoil,"ssn") != nSSN)
        {
            nInstance += 1;
            object oSoil = GetNearestObjectByTag("ssloc",OBJECT_SELF,nInstance);
        }
        lPlant = GetLocation(oSoil);
        object oNew = CreateObject(OBJECT_TYPE_PLACEABLE,"seededground",lPlant);
        SetLocalInt(oNew,"ssn",nSSN);
        ExecuteScript("soil02",oNew);
        DestroyObject(OBJECT_SELF);
    }
    else
    {
        oSeed = GetItemPossessedBy(oPC,"HerbalSeeds");
        if (oSeed != OBJECT_INVALID)
        {
            DestroyObject(oSeed);
            AssignCommand(oPC,ActionPlayAnimation(ANIMATION_LOOPING_GET_LOW, 1.0, 1.5));
            FloatingTextStringOnCreature("Seeds planted.",oPC,FALSE);
            int nSSN = GetLocalInt(OBJECT_SELF,"ssn");
            int nInstance = 1;
            location lPlant;
            object oSoil = GetNearestObjectByTag("ssloc",OBJECT_SELF,nInstance);
            while (GetLocalInt(oSoil,"ssn") != nSSN)
            {
                nInstance += 1;
                object oSoil = GetNearestObjectByTag("ssloc",OBJECT_SELF,nInstance);
            }
            lPlant = GetLocation(oSoil);
            object oNew = CreateObject(OBJECT_TYPE_PLACEABLE,"seededground2",lPlant);
            SetLocalInt(oNew,"ssn",nSSN);
            ExecuteScript("soil05",oNew);
            DestroyObject(OBJECT_SELF);
        }
    }
}
