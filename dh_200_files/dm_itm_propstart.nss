//::///////////////////////////////////////////////
//::
//:: DM_Itm_Rem_Start
//::
//:: dm_itm_rem_start.nss
//::
//:: Written for the persistant world of Brynsaar
//:: visit us at http://brynsaar.com/
//::
//:://////////////////////////////////////////////
//::
//:: This script is is used to check for item
//:: properties and sets the required conversation
//:: token.
//::
//:: <CUSTOM600601> The number of item properties.
//::
//:://////////////////////////////////////////////
//::
//:: Created By: Nordavind
//::         On: June 4, 2004
//::
//:://////////////////////////////////////////////
#include "dm_itm_inc"


int StartingConditional()
{
    object oPC = GetPCSpeaker();
    object oItem = GetLocalObject(oPC, "TARGETED_ITEM");
    int nResult = TRUE;
    int nPropertyCounter;
    int nPropType;
    // some checks:
    itemproperty ipProperty =  GetFirstItemProperty(oItem);

    while(GetIsItemPropertyValid(ipProperty) == TRUE)
    {
        nPropertyCounter ++;
        nPropType = GetItemPropertyType(ipProperty);
SendMessageToPC(oPC, "Item Property "+IntToString(nPropertyCounter)+": "+IntToString(nPropType)+" "+GetPropertyName(nPropType));
        ipProperty = GetNextItemProperty(oItem);
    }

    SetLocalInt(oPC, "NUMBER_OF_PROPERTIES", nPropertyCounter);
    SetCustomToken(600601, IntToString(nPropertyCounter)+" properties");

    return TRUE;
}
