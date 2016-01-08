void main()
{
    object oUser = GetLastUsedBy();

    if (GetIsPC(oUser))
    {
        object oVoice = GetObjectByTag("FugueAltar");
        AssignCommand(oVoice, ActionStartConversation(oUser));
    }
}
