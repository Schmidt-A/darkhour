void main()
{
SendMessageToPC(GetPCSpeaker(), "Speak the number of zombies you want to be available, (ex: 5), and then use this tool again where you would like them to spawn.");
SetLocalInt(GetPCSpeaker(), "DHDMTOOL", 7);
}
