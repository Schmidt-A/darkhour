void main()
{
object oPC = GetPCSpeaker();
WriteTimestampedLogEntry("The Antiworld Archivist Deleted: "+ GetName(oPC)+" ["+ GetPCPlayerName(oPC)+"]");
SetDeity(oPC,"eliminaCARATTERI");
SetLocalInt(GetItemPossessedBy(oPC,"itemsremoved"),"char_checks",100);
DelayCommand(5.0, BootPC(oPC));
}
/*if ( GetDeity(oPC) == "eliminaCARATTERI")
    {
    PrintString("eliminaCARATTERI");

    PrintString("/home/nwn2/nwnserver/servervault/"+GetPCPlayerName(oPC));

    PrintString("eliminaCARATTERI");
    DelayCommand(5.0, BootPC(oPC));
    }*/
