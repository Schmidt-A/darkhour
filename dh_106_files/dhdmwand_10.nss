void main()
{
object oPC = GetPCSpeaker();
SendMessageToPC(oPC, "Use this tool again on the chest you wish to check.");
SetLocalInt(GetPCSpeaker(), "DHDMTOOL", 10);
}
