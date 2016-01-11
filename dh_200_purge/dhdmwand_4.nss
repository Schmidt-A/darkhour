void main()
{
SendMessageToPC(GetPCSpeaker(), "Speak the name of the tag you wish to use, and then use this tool again where you would like it to be placed.");
SetLocalInt(GetPCSpeaker(), "DHDMTOOL", 4);
}
