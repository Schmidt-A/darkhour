//::///////////////////////////////////////////////
//::
//:: DM_Itm_GetDurati
//::
//:: dm_itm_getdurati.nss
//::
//:: Written for the persistant world of Brynsaar
//:: visit us at http://brynsaar.com/
//::
//:://////////////////////////////////////////////
//::
//:: This script is used to set the duration of
//:: the item property and is the last script before
//:: applying the property to the item. It also has
//:: conversation tokens.
//::
//:: <CUSTOM80001> The exact time in minutes and hour
//:: <CUSTOM80002> The duration (Permanent/Temporary)
//:: <CUSTOM80005> The item property name
//:: <CUSTOM80006> The item sub property name
//:: <CUSTOM80007> The item sub-sub property name
//:: <CUSTOM80008> The item property modifier
//::
//:://////////////////////////////////////////////
//::
//:: Created By: Nordavind
//::         On: June 4, 2004
//::
//:://////////////////////////////////////////////


int StartingConditional()
{
    object oPC = GetPCSpeaker();
    int nResult = TRUE;

    float fPropertyDuration = GetLocalFloat(oPC, "ITEM_PROPERTY_DURATION");

    string sSubPropertyName = GetLocalString(oPC, "ITEM_SUB_PROPERTY_NAME");
    string sItemProperty = GetLocalString(oPC, "ITEM_PROPERTY_NAME");
    string sItemPropertyModifier = GetLocalString(oPC, "ITEM_PROPERTY_MODIFIER_NAME");
    string sSubSubPropertyName = "None";

    int nMinutes = FloatToInt(fPropertyDuration/60);
    float fHour = (fPropertyDuration/60)/60;

    string sTime = IntToString(nMinutes)+" Minutes ["+FloatToString(fHour, 0, 2)+" hours]";
    string sDuration = "Temporary";

    if(fPropertyDuration == 0.0)
        sDuration = "Permanent";

    SetCustomToken(80001, sTime);
    SetCustomToken(80002, sDuration);

    SetCustomToken(80005, sItemProperty);
    SetCustomToken(80006, sSubPropertyName);
    SetCustomToken(80007, sSubSubPropertyName);
    SetCustomToken(80008, sItemPropertyModifier);

    return nResult;
}
