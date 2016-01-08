//::///////////////////////////////////////////////
//::
//:: DM_Itm_GetSubSul
//::
//:: dm_itm_subsul.nss
//::
//:: Written for the persistant world of Brynsaar
//:: visit us at http://brynsaar.com/
//::
//:://////////////////////////////////////////////
//::
//:: This script will get the last sub-sub category
//:: of the item property beeing set.
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
    int nNumber = GetLocalInt(oPC, "ITEM_SUB_SUB_PROPERTY_SELECTED");

    nNumber --;

    if(nNumber <= -1)
        nNumber = GetLocalInt(oPC, "ITEM_SUB_SUB_PROPERTY_MAX");

    SetLocalInt(oPC, "ITEM_SUB_SUB_PROPERTY_SELECTED", nNumber);
}
