//::///////////////////////////////////////////////
//::
//:: DM_Itm_GetSubMoN
//::
//:: dm_itm_getsubmon.nss
//::
//:: Written for the persistant world of Brynsaar
//:: visit us at http://brynsaar.com/
//::
//:://////////////////////////////////////////////
//::
//:: This script cycles through the item sub modifiers
//:: and will get the next modifier.
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
    int nNumber = GetLocalInt(oPC, "ITEM_PROPERTY_MODIFIER");

    nNumber ++;

    if(nNumber >= GetLocalInt(oPC, "ITEM_PROPERTY_MODIFIER_MAX")+1)
        nNumber = 0;

    SetLocalInt(oPC, "ITEM_PROPERTY_MODIFIER", nNumber);
}
