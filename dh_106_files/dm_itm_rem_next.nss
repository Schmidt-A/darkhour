//::///////////////////////////////////////////////
//::
//:: DM_Itm_Rem_Next
//::
//:: dm_itm_rem_next.nss
//::
//:: Written for the persistant world of Bryansaar
//:: visit us at http://brynsaar.com/
//::
//:://////////////////////////////////////////////
//::
//:: This script is is used to cycle through the
//:: item properties and select the next item
//:: property.
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

    nPropertySelected ++;
    if(nPropertySelected > nNumberOfProperties)
        nPropertySelected = 1;

    SetLocalInt(oPC, "SELECTED_PROPERTY", nPropertySelected);
}
