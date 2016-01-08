//::///////////////////////////////////////////////
//::
//:: DM_Itm_Chrg_Rem5
//::
//:: dm_itm_rem5.nss
//::
//:: Written for the persistant world of Brynsaar
//:: visit us at http://brynsaar.com/
//::
//:://////////////////////////////////////////////
//::
//:: This script will remove 5 charges from the item.
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
    SetItemCharges(oItem, nCharges-5);
}
