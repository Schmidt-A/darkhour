void main()
{
SendMessageToPC(GetPCSpeaker(), "Speak now what you wish the description to be, and then use this tool again on the object whos description you wish to change. You may speak several times.");
SetLocalInt(GetPCSpeaker(), "DHDMTOOL", 2);
DelayCommand(1.0, SendMessageToPC(GetPCSpeaker(), "DHDMTOOL = " + IntToString(GetLocalInt(GetPCSpeaker(), "DHDMTOOL"))));
}
