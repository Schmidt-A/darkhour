//::///////////////////////////////////////////////
//::
//:: DM_Itm_GetSubSun
//::
//:: dm_itm_subsun.nss
//::
//:: Written for the persistant world of Brynsaar
//:: visit us at http://brynsaar.com/
//::
//:://////////////////////////////////////////////
//::
//:: This script will get the next sub-sub category
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

    nNumber ++;

    if(nNumber >= GetLocalInt(oPC, "ITEM_SUB_SUB_PROPERTY_MAX")+1)
        nNumber = 0;

    SetLocalInt(oPC, "ITEM_SUB_SUB_PROPERTY_SELECTED", nNumber);
}
