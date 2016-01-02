void main()
{
SendMessageToPC(GetPCSpeaker(), "Use this tool again on the item you wish to copy. The item will be placed in your inventory.");
SetLocalInt(GetPCSpeaker(), "DHDMTOOL", 3);
}
