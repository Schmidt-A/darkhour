//::///////////////////////////////////////////////
//::
//:: DM_Itm_Chrg_Strt
//::
//:: dm_itm_chrg_strt.nss
//::
//:: Written for the persistant world of Brynsaar
//:: visit us at http://brynsaar.com/
//::
//:://////////////////////////////////////////////
//::
//:: This script is used to get the amount of charges
//:: on the item. It also sets a conversation token
//::
//:: <CUSTOM600700> The amount of charges on the item
//::
//:://////////////////////////////////////////////
//::
//:: Created By: Nordavind
//::         On: June 4, 2004
//::
//:://////////////////////////////////////////////


int StartingConditional()
{
    int nResult = TRUE;
    object oItem = GetLocalObject(GetPCSpeaker(), "TARGETED_ITEM");

    int nCharges = GetItemCharges(oItem);
    string sCharges = IntToString(nCharges);

    SetCustomToken(600700, sCharges);
    return TRUE;
}
