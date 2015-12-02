void main()
{
object oItem        = GetItemActivated();
object oPC          = GetItemActivator();
string sItemTag     = GetTag(oItem);

AssignCommand(oPC, ActionStartConversation(oPC, "dye_dyekit", TRUE,FALSE));
}
