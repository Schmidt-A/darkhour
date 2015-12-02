void main()
{
//object oSanta = OBJECT_SELF;
object oPC = GetPCSpeaker();
string sName = GetPCPlayerName(oPC);
int nPoints = GetLocalInt(oPC, sName);
SetLocalInt(oPC, sName, 4 + nPoints);
if (GetIsDM(oPC) || GetIsDMPossessed(oPC))
   {
   string sName = GetPCPlayerName(oPC);
   int nPoints = GetLocalInt(oPC, sName);
   FloatingTextStringOnCreature("Your Points are: "+IntToString(nPoints),oPC);
   }
}
