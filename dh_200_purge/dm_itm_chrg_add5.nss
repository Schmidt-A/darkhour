//::///////////////////////////////////////////////
//::
//:: DM_Itm_Chrg_Add5
//::
//:: dm_itm_add5.nss
//::
//:: Written for the persistant world of Brynsaar
//:: visit us at http://brynsaar.com/
//::
//:://////////////////////////////////////////////
//::
//:: This script will add 5 charges from the item.
//::
//:://////////////////////////////////////////////
//::
//:: Created By: Nordavind
//::         On: June 4, 2004
//::
//:://////////////////////////////////////////////


void main()
{
    object oItem = GetLocalObject(GetPCSpeaker(), "TARGETED_ITEM");
    int nCharges = GetItemCharges(oItem);
    SetItemCharges(oItem, nCharges+5);
}
