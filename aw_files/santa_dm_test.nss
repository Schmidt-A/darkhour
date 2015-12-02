void main()
{
object oPC = GetPCSpeaker();
if (GetIsDM(oPC) || GetIsDMPossessed(oPC))
   {
   string sName = GetPCPlayerName(oPC);
   int nPoints = GetLocalInt(oPC, sName);
   FloatingTextStringOnCreature("Your Points are: "+IntToString(nPoints),oPC);
   }
}
