void main()
{

object oPC = GetClickingObject();

if (!GetIsPC(oPC)) return;

ActionStartConversation(oPC, "backtosignet");

}

