//::///////////////////////////////////////////////
//::
//:: _OnActivateItem
//::
//:: _onactivateitem.nss
//::
//:: Written for the persistant world of Brynsaar
//:: visit us at http://brynsaar.com/
//::
//:://////////////////////////////////////////////
//::
//:: This script is used in the OnActivateItem event
//:: of the module. Copy and paste the code below into
//:: your OnActivateItem event script.
//::
//:://////////////////////////////////////////////
//::
//:: Created By: Nordavind
//::         On: June 7, 2003
//::
//:://////////////////////////////////////////////


void main()
{
    // Setting the variables
    object oPC = GetItemActivator();
    object oItem = GetItemActivated();
    object oTarget = GetItemActivatedTarget();
    string sItemTag = GetTag(oItem);

    // DM Item Modifier
    if(sItemTag == "DM_Item_Manipulator")
    {
        if(GetIsObjectValid(oTarget) == TRUE && GetObjectType(oTarget) == OBJECT_TYPE_ITEM)
        {
            SetLocalObject(oPC, "TARGETED_ITEM", oTarget);
            AssignCommand(oPC, ActionStartConversation(oPC, "dm_wand_item", TRUE, FALSE));
        }
        else
            SendMessageToPC(oPC, "That is not a valid item");

        return;
    }
}
