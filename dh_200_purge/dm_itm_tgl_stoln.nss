//::///////////////////////////////////////////////
//::
//:: DM_Itm_Tgl_Stoln
//::
//:: dm_itm_tgl_stoln.nss
//::
//:: Written for the persistant world of Brynsaar
//:: visit us at http://brynsaar.com/
//::
//:://////////////////////////////////////////////
//::
//:: This script is used in the item manipulating
//:: conversation. It will toggle the stolen flag
//:: of the item on/off.
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
    object oItem = GetLocalObject(oPC, "TARGETED_ITEM");
    int nStolen = GetStolenFlag(oItem);
    int nState;

    if (nStolen == TRUE)
        nState = FALSE;

    if (nStolen == FALSE)
        nState = TRUE;

    SetStolenFlag(oItem, nState);
}
