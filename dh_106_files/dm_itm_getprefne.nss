//::///////////////////////////////////////////////
//::
//:: DM_Itm_GetPrefNe
//::
//:: dm_itm_getprefne.nss
//::
//:: Written for the persistant world of Brynsaar
//:: visit us at http://brynsaar.com/
//::
//:://////////////////////////////////////////////
//::
//:: This script cycles through the item property
//:: sub category and will select the next sub category.
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

    nNumber ++;

    if(nNumber >= GetLocalInt(oPC, "ITEM_SUB_PROPERTY_MAXIMUM")+1)
        nNumber = 0;

    SetLocalInt(oPC, "ITEM_SUB_PROPERTY_SELECTED", nNumber);
}
