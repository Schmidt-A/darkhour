//::///////////////////////////////////////////////
//::
//:: DM_Itm_GetDurA1H
//::
//:: dm_itm_getdura1h.nss
//::
//:: Written for the persistant world of Brynsaar
//:: visit us at http://brynsaar.com/
//::
//:://////////////////////////////////////////////
//::
//:: This script cycles through the item property
//:: duration and will add 1 hour to the
//:: set time. When the time is set to 0.0 it becomes
//:: permanent.
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
    float fPropertyDuration = GetLocalFloat(oPC, "ITEM_PROPERTY_DURATION");

    fPropertyDuration += 3600.0;

    SetLocalFloat(oPC, "ITEM_PROPERTY_DURATION", fPropertyDuration);
}
