//::///////////////////////////////////////////////
//::
//:: DM_Itm_Start
//::
//:: dm_itm_Start.nss
//::
//:: Written for the persistant world of Brynsaar
//:: visit us at http://brynsaar.com/
//::
//:://////////////////////////////////////////////
//::
//:: This script is used in the item manipulating
//:: conversation and will remove all local variables
//:: on the player.
//::
//:://////////////////////////////////////////////


void main()
{
    object oPC = GetPCSpeaker();

    // deleting the item
    DeleteLocalObject(oPC, "TARGETED_ITEM");

    // deleting the integers
    DeleteLocalInt(oPC, "ITEM_SUB_SUB_PROPERTY");
    DeleteLocalInt(oPC, "ITEM_SUB_SUB_PROPERTY_MAX");
    DeleteLocalInt(oPC, "ITEM_SUB_SUB_PROPERTY_SELECTED");
    DeleteLocalInt(oPC, "ITEM_PROPERTY_MODIFIER_MAX");
    DeleteLocalInt(oPC, "ITEM_PROPERTY_SELECTED");
    DeleteLocalInt(oPC, "ITEM_PROPERTY_MODIFIER");
    DeleteLocalInt(oPC, "ITEM_SUB_PROPERTY_MAXIMUM");
    DeleteLocalInt(oPC, "ITEM_SUB_PROPERTY_SELECTED");
    DeleteLocalInt(oPC, "NUMBER_OF_PROPERTIES");
    DeleteLocalInt(oPC, "SELECTED_PROPERTY");

    // deleting the float
    DeleteLocalFloat(oPC, "ITEM_PROPERTY_DURATION");

    // deleting the strings
    DeleteLocalString(oPC, "ITEM_PROPERTY_NAME");
    DeleteLocalString(oPC, "ITEM_SUB_PROPERTY_NAME");
    DeleteLocalString(oPC, "ITEM_SUB_SUB_PROPERTY_NAME");
    DeleteLocalString(oPC, "ITEM_PROPERTY_MODIFIER_NAME");
}
