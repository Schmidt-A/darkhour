void main()
{
object oSanta = OBJECT_SELF;
object oPC = GetPCSpeaker();
string sName = GetPCPlayerName(oPC);
SetLocalInt(oSanta, sName, 0);
}
