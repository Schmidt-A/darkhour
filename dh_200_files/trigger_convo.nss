void main()
{
    object oPC = GetEnteringObject();

    if(!GetIsPC(oPC))
        return;

    string sConversation = GetLocalString(OBJECT_SELF, "sConversation");
    ActionStartConversation(oPC, sConversation);
}
