void main()
{
//object oSanta = OBJECT_SELF;
object oPC = GetPCSpeaker();
string sName = GetPCPlayerName(oPC);
int nPoints = GetLocalInt(oPC, sName);
SetLocalInt(oPC, sName, 1 + nPoints);
}
