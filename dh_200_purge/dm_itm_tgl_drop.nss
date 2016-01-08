//::///////////////////////////////////////////////
//::
//:: DM_Itm_Tgl_Drop
//::
//:: dm_itm_tgl_drop.nss
//::
//:: Written for the persistant world of Brynsaar
//:: visit us at http://brynsaar.com/
//::
//:://////////////////////////////////////////////
//::
//:: This script is used in the item manipulating
//:: conversation. It will toggle the drop flag
//:: of the item on/off.
//::
//:: This flag is only used for NPCs, turned on the
//:: item will drop if the NPC is killed.
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
    int nDroppable = GetDroppableFlag(oItem);
    int nState;

    if (nDroppable == TRUE)
        nState = FALSE;

    if (nDroppable == FALSE)
        nState = TRUE;

    SetDroppableFlag(oItem, nState);
}
