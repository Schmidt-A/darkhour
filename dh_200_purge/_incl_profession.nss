#include "_incl_probability"
#include "_incl_pc_data"

int CanUseGatherObj(object oPC, object oGather);


//Can more than one profession gather from the same thing?
int CanUseGatherObj(object oPC, object oGather)
{
    if (PCDGetProfession(oPC) == GetLocalString(oGather, "sProfession"))
        return TRUE;
    else
        return FALSE;
}

//This one works via damaging it
int MineOre(object oPC, object oGather, int iNewDamage)
{
    if (CanUseGatherObj(oPC, oGather))
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