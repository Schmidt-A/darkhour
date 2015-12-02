void main()
{   object oPC = GetPCSpeaker();
    int count = 301;
    int TotalPlayers = GetLocalInt(oPC,"playersnumber");
    for ( count=301;count<=TotalPlayers; count++)
        {
        DeleteLocalString(oPC,IntToString(count));
        }
  DeleteLocalString(oPC,"playersnumber");
}
