void main()
{   object oGm = GetPCSpeaker();
    int count = 101;
    int TotalPlayers = GetLocalInt(oGm,"playersnumber");
    for ( count=101;count<=TotalPlayers; count++)
        {
        DeleteLocalString(oGm,IntToString(count));
        }
  DeleteLocalString(oGm,"playersnumber");
}
