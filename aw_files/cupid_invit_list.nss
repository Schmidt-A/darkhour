int StartingConditional()
{
    object oPC = GetPCSpeaker();
    int nInvitations = GetLocalInt(oPC,"invitations");
    int count;
    int nNewCount = 4001;
    for (count=1; count <= nInvitations; count++)
        {
        object oInviter = GetLocalObject(oPC,"inviter"+IntToString(count+400));
        if (GetIsObjectValid(oInviter)) //if some old inviter has logged out do not count
           {
           //use a new counter so to remove the empties spaces due to logged out players.
           SetCustomToken(nNewCount,GetName(oInviter)+" ["+GetPCPlayerName(oInviter)+"]");
           //  SetCustomToken(4001 / 4002 / 4003 / 4004 etc
           //ReSet the objects numbers, with the new count
           SetLocalObject(oPC,"inviter"+IntToString(nNewCount),oInviter);
           nNewCount++;
           }
        }
    SetLocalInt(oPC,"ValidInviters",nNewCount-4001);
    return TRUE;
}



