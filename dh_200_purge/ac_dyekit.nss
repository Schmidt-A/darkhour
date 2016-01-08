void main()
{
    object oPC = GetItemActivator();
    AssignCommand(oPC, ActionStartConversation(oPC, "dye_dyekit", TRUE));
}
