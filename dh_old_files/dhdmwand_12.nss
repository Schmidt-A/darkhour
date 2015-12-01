void main()
{
object oPC = GetPCSpeaker();
SendMessageToPC(oPC, "Use this tool again on the object you wish to make a key for.");
SetLocalInt(GetPCSpeaker(), "DHDMTOOL", 12);
}
