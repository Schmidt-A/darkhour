void main()
{
    object oPC = GetItemActivator();

    if (GetItemPossessedBy(oPC, "CraftingNecklace") != OBJECT_INVALID)
        return;

    AssignCommand(oPC, ActionStartConversation(oPC, "newalchemy", TRUE));
}
