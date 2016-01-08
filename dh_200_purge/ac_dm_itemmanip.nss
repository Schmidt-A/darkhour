// DM Item Manipulator activation script.

void main()
{
    object oPC = GetItemActivator();
    object oTarget = GetItemActivatedTarget();

    if(GetIsObjectValid(oTarget) == TRUE &&
       GetObjectType(oTarget) == OBJECT_TYPE_ITEM)
    {
        SetLocalObject(oPC, "TARGETED_ITEM", oTarget);
        AssignCommand(oPC, ActionStartConversation(oPC,
                            "dm_wand_item", TRUE, FALSE));
        return;
    }
    else
        SendMessageToPC(oPC, "That is not a valid item");
}
