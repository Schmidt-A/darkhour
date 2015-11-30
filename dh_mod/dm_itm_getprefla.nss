//::///////////////////////////////////////////////
//::
//:: DM_Itm_GetPrefLa
//::
//:: dm_itm_getprefla.nss
//::
//:: Written for the persistant world of Brynsaar
//:: visit us at http://brynsaar.com/
//::
//:://////////////////////////////////////////////
//::
//:: This script cycles through the item property
//:: sub category and will select the last sub category.
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
    int nNumber = GetLocalInt(oPC, "ITEM_SUB_PROPERTY_SELECTED");

    nNumber --;

    if(nNumber <= -1)
        nNumber = GetLocalInt(oPC, "ITEM_SUB_PROPERTY_MAXIMUM");

    SetLocalInt(oPC, "ITEM_SUB_PROPERTY_SELECTED", nNumber);
}
