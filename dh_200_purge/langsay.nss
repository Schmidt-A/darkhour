void main()
{
object oPC = GetPCSpeaker();
int iAmount = GetLocalInt(oPC, "langamount");
SendMessageToPC(oPC, "You have " + IntToString(iAmount) + " remaining language(s) to choose.");
}
