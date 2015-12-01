//::///////////////////////////////////////////////
//::
//:: DM_Itm_Tgl_PCDrp
//::
//:: dm_itm_tgl_pcdrp.nss
//::
//:: Written for the persistant world of Brynsaar
//:: visit us at http://brynsaar.com/
//::
//:://////////////////////////////////////////////
//::
//:: This script is used in the item manipulating
//:: conversation. It will toggle the cursed flag
//:: of the item on/off.
//::
//:: The Character is not able to drop a cursed
//:: item.
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
    int nCursed = GetItemCursedFlag(oItem);
    int nState;

    if (nCursed == TRUE)
        nState = FALSE;

    if (nCursed == FALSE)
        nState = TRUE;

    SetItemCursedFlag(oItem, nState);
}
