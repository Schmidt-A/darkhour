//::///////////////////////////////////////////////
//::
//:: DM_Itm_Rem_Start
//::
//:: dm_itm_rem_start.nss
//::
//:: Written for the persistant world of Bryansaar
//:: visit us at http://brynsaar.com/
//::
//:://////////////////////////////////////////////
//::
//:: This script is is used to check for item
//:: properties and sets the required conversation
//:: tokens.
//::
//:: <CUSTOM600620> The item property Name
//:: <CUSTOM600621> Duration of the item property
//::                (Permanent/Temporary)
//:: Non descriptive tokens:
//:: <CUSTOM600622> Item Property Parameter 1
//:: <CUSTOM600623> Item Property Parameter 1 Value
//:: <CUSTOM600624> Item Property Sub-Type
//::
//:://////////////////////////////////////////////
//::
//:: Created By: Nordavind
//::         On: June 4, 2004
//::
//:://////////////////////////////////////////////
#include "dm_itm_inc"
#include "authorization"


int StartingConditional()
{
    object oPC = GetPCSpeaker();
    object oItem = GetLocalObject(oPC, "TARGETED_ITEM");

// uncomment the two lines below to restrict item property manipulation.
// Also see the script "dm_itm_getproprt" and "authorization" as you'll
// need to modify them to.
//    if(GetIsAdmin(oPC) != TRUE)
//        return FALSE;

    itemproperty ipProperty = GetFirstItemProperty(oItem);
    int nResult = TRUE;
    int nCounter = 1;
    int nNumberOfProperties = GetLocalInt(oPC, "NUMBER_OF_PROPERTIES");
    int nPropertySelected = GetLocalInt(oPC, "SELECTED_PROPERTY");
    int nPropType;
    int nDurationType;

    string sPropType,
           sPropDurationType,
           sPropParm1,
           sPropParm1Value,
           sPropSubType;

    // some checks:
    if(nNumberOfProperties == 0)
        return FALSE;
    if(nPropertySelected == 0)
        nPropertySelected = 1;

    while(GetIsItemPropertyValid(ipProperty) == TRUE && nPropertySelected != nCounter)
    {
        ipProperty = GetNextItemProperty(oItem);
        nCounter ++;
    }

    sPropType = GetPropertyName(GetItemPropertyType(ipProperty));
    nDurationType = GetItemPropertyDurationType(ipProperty);
    if (nDurationType == 1)
        sPropDurationType = "Temporary";
    if (nDurationType == 2)
        sPropDurationType = "Permanent";
    sPropParm1 = IntToString(GetItemPropertyParam1(ipProperty));
    sPropParm1Value = IntToString(GetItemPropertyParam1Value(ipProperty));
    sPropSubType = IntToString(GetItemPropertySubType(ipProperty));

    SetCustomToken(600620, sPropType);
    SetCustomToken(600621, sPropDurationType);
    SetCustomToken(600622, sPropParm1);
    SetCustomToken(600623, sPropParm1Value);
    SetCustomToken(600624, sPropSubType);

    return nResult;
}
