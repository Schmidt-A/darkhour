void main()
{
    object oPC = GetItemActivator();
    AssignCommand(oPC ,ActionStartConversation(oPC ,"subdualconv", TRUE));
}
