//::///////////////////////////////////////////////
//::
//:: DM_Itm_GetPropNe
//::
//:: dm_itm_getpropne.nss
//::
//:: Written for the persistant world of Brynsaar
//:: visit us at http://brynsaar.com/
//::
//:://////////////////////////////////////////////
//::
//:: This script cycles through the item properties
//:: and will select the next property.
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
    int nNumber = GetLocalInt(oPC, "ITEM_PROPERTY_SELECTED");

    nNumber ++;

    if(nNumber >= 85)
        nNumber = 0;

    SetLocalInt(oPC, "ITEM_PROPERTY_SELECTED", nNumber);
}
