//::///////////////////////////////////////////////
//::
//:: DM_Itm_GetSubMoL
//::
//:: dm_itm_getsubmol.nss
//::
//:: Written for the persistant world of Brynsaar
//:: visit us at http://brynsaar.com/
//::
//:://////////////////////////////////////////////
//::
//:: This script cycles through the item sub modifiers
//:: and will get the last modifier.
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

    nNumber --;

    if(nNumber <= -1)
        nNumber = GetLocalInt(oPC, "ITEM_PROPERTY_MODIFIER_MAX");

    SetLocalInt(oPC, "ITEM_PROPERTY_MODIFIER", nNumber);
}
