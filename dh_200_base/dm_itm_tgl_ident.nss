//::///////////////////////////////////////////////
//::
//:: DM_Itm_Tgl_Ident
//::
//:: dm_itm_tgl_ident.nss
//::
//:: Written for the persistant world of Brynsaar
//:: visit us at http://brynsaar.com/
//::
//:://////////////////////////////////////////////
//::
//:: This script is used in the item manipulating
//:: conversation. It will toggle the identified flag
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
    int nIdentified = GetIdentified(oItem);
    int nState;

    if (nIdentified == TRUE)
        nState = FALSE;

    if (nIdentified == FALSE)
        nState = TRUE;

    SetIdentified(oItem, nState);
}
