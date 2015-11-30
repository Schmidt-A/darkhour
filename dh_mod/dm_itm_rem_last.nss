//::///////////////////////////////////////////////
//::
//:: DM_Itm_Rem_Last
//::
//:: dm_itm_rem_last.nss
//::
//:: Written for the persistant world of Brynsaar
//:: visit us at http://brynsaar.com/
//::
//:://////////////////////////////////////////////
//::
//:: This script is is used to cycle through the
//:: item properties and select the last property.
//::
//:://////////////////////////////////////////////
//::
//:: Created By: Nordavind
//::         On: June 4, 2004
//::
//:://////////////////////////////////////////////


void main()
{
    object oPC = GetPCSpeaker();
    int nNumberOfProperties = GetLocalInt(oPC, "NUMBER_OF_PROPERTIES");
    int nPropertySelected = GetLocalInt(oPC, "SELECTED_PROPERTY");

    nPropertySelected --;
    if(nPropertySelected < 1)
        nPropertySelected = nNumberOfProperties;

    SetLocalInt(oPC, "SELECTED_PROPERTY", nPropertySelected);
}
