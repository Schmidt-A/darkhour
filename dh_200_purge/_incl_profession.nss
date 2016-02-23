/* All of the profession stuff
 * Unless we decide to split it out*/

#include "_incl_probability"
#include "_incl_pc_data"
#include "_incl_time"

int CanUseProfessionObj(object oPC, object oProfObject);
int IsOwnedBy(object oPC, object oProfObject);
void MineOre(object oPC, object oGather, int iNewDamage);
void DestroyPlant(object oPlant);
void HarvestCrops(object oPC, object oGather);
void PlantCrops(object oPC, object oSoil, object oSeed);


//Can more than one profession gather from the same thing?
int CanUseProfessionObj(object oPC, object oProfObject)
{
    string sLocalProf = GetLocalString(oProfObject, "sProfession");

    if (sLocalProf == "")
        return TRUE;
    else if (PCDGetProfession(oPC) == sLocalProf)
        return TRUE;
    else
        return FALSE;
}

int isOwnedBy(object oPC, object oProfObject)
{
    string sLocalOwner = GetLocalString(oProfObject, "sOwner");

    if (sLocalOwner == "")
        return TRUE;
    else if (PCDUniqueReference(oPC) == sLocalOwner)
        return TRUE;
    else
        return FALSE;
}

//This one works via damaging it
//Returns true or false
void MineOre(object oPC, object oGather, int iNewDamage)
{
    if (CanUseProfessionObj(oPC, oGather))
    {    
        iDamage = GetLocalInt(oGather, "iDamage") + iNewDamage;
        if (iDamage > GetLocalInt(oGather, "iDamageThreshold"))
        {
            //create the ore based on local vars
            object oFound = CreateRandomLocalRef(oGather, OBJECT_TYPE_ITEM, oPC, GetLocation(oPC));
            if (GetIsObjectValid(oFound))
            {
                FloatingTextStringOnCreature("Found "+GetName(oFound)+"!", oPC, FALSE);
            }
            else
            {
                //This ore is broken, needs to be fixed
                FloatingTextStringOnCreature("This spot is all tapped out. No more ore to be found.", oPC, FALSE);
            }

            SetLocalInt(oGather, "iDamage", 0);
            return TRUE;
        }
        else
        {

            SetLocalInt(oGather, "iDamage", iDamage);
            return FALSE;
        }
    }
    else 
    {
        FloatingTextStringOnCreature("You hammer at the rocks, but are unable to make any progress.", oPC, FALSE);
    }
}

void DestroyPlant(object oPlant)
{
    object oSoil = GetLocalObject(oPlant, "oSoil");
    SetLocalString(oSoil, "sOwner", "");

    DestroyObject(oPlant);
}

void HarvestCrops(object oPC, object oGather)
{
    float fStartTime = GetLocalFloat(oPlant, "fStartTime");
    float fGrowTime = GetLocalFloat(oPlant, "fGrowTime");
    float fWitherTime = fGrowTime * 2.0f;
    float fNow = GetModTime();
    string sMessage;

    if (IsOwnedBy(oPC, oGather))
    {
        if (fStartTime + fGrowTime > fNow)
        {
            sMessage = "It's not ready yet. You still need to wait " +
                                FloatToString((fStartTime + fGrowTime - fNow) / 3600, 0, 0) +
                                " hours before you can pick this plant.";
        }
        else if (fStartTime + fWitherTime > fNow)
        {
            string sYield = GetLocalString(oPlant, "sYield");

            CreateItemOnObject(sYield, oPC);
            DestroyPlant(oPlant);

            sMessage = "You harvested a " + GetName(sYield) + "!";
        }
        else 
        {
            DestroyPlant(oPlant);

            sMessage = "Your crops withered " +
                                FloatToString((fNow - fStartTime - fWitherTime) / 3600, 0, 0) +
                                " hours ago. Next time you should check up on it sooner!";           
        }
        FloatingTextStringOnCreature(sMessage, oPC, FALSE);
    }
    else
    {
        if (fStartTime + fWitherTime < fNow)
        {
            DestroyPlant(oPlant);

            FloatingTextStringOnCreature("Someone elses' plant has withered away, you can plant something else.", oPC, FALSE);
        }
        else 
        {
            FloatingTextStringOnCreature("You can't pick other peoples' crops.", oPC, FALSE);
        }
    }
}


void PlantCrops(object oPC, object oSoil, object oSeed)
{
    int bCanUse = 1;
    string sFailure = "You can't plant here because: ";
    string sSuccess = "";

    if (!CanUseProfessionObj(oPC, oSoil))
    {
        bCanUse = 0;
        sFailure += "you don't know how to till this soil ";
    }
    if (!CanUseProfessionObj(oPC, oSeed))
    {
        bCanUse = 0; 
        sFailure += "you don't know how to plant these seeds ";
    }

    if (!IsOwnedBy(oPC, oSoil))
    {
        object oPlant = GetLocalObject(oSoil, "oPlant");
        float fStartTime = GetLocalFloat(oPlant, "fStartTime");
        float fWitherTime = GetLocalFloat(oPlant, "fGrowTime") * 2.0f;
        float fNow = GetModTime();

        if (fNow < fStartTime + fWitherTime)
        {
            bCanUse = 0;
            sFailure += "someone else already planted here and has " +
                        FloatToString((fStartTime + fWitherTime - fNow) / 3600, 0, 0) +
                        " hours left to harvest their crop.";
        }
        else
        {
            DestroyPlant(oPlant);

            sSuccess += "Someone elses' plant has withered away, ";
        }
    }

    if (bCanUse)
    {
        string sPlantPlace = GetLocalString(oSeed, "sPlaceable");
        string sPlantYield = GetLocalString(oSeed, "sYield");
        location lSoil = GetLocation(oSoil);
        float fSoilMod = GetLocalFloat(oSoil, "fTimeMod");
        float fSeedTime = GetLocalFloat(oSeed, "fTime");

        object oPlant = CreateObject(OBJECT_TYPE_PLACEABLE, sPlantPlace, lSoil, TRUE);

        SetLocalString (oPlant, "sYield", sPlantYield);
        SetLocalString(oPlant, "sOwner", PCDUniqueReference(oPC));
        SetLocalString(oSoil, "sOwner", PCDUniqueReference(oPC));
        SetLocalObject(oPlant, "oSoil", oSoil);
        SetLocalObject(oSoil, "oPlant", oPlant);
        SetLocalFloat(oPlant, "fStartTime", GetModTime());
        SetLocalFloat(oPlant, "fGrowTime", fSoilMod * fSeedTime);

        sSuccess += "You planted " + GetName(oSeed) + "! You need to wait " +
                    FloatToString(fGrowTime) / 3600, 0, 0) + 
                    " before it will be ready to harvest.";
        FloatingTextStringOnCreature(sSuccess, oPC, FALSE);
    }
    else 
    {
        FloatingTextStringOnCreature(sFailure, oPC, FALSE);
    }
}