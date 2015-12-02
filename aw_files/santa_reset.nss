void main()
{
object oPC = GetPCSpeaker();
string sName = GetPCPlayerName(oPC);
DeleteLocalInt(oPC,sName);

}
