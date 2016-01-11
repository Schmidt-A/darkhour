void main()
{
object oPC = GetPCSpeaker();
SendMessageToPC(oPC, "Use this tool again on the chest whose last user you want to ban.");
SetLocalInt(GetPCSpeaker(), "DHDMTOOL", 11);
}
