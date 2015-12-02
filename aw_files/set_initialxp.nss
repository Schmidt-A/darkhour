void main()
{
object oPC = GetPCSpeaker();
if(GetLocalInt(oPC,"initialLevel") == 0)
{
SetLocalInt(oPC,"initialLevel",GetXP(oPC));
//PrintString(GetName(oPC)+ " Re-do his Level - CharName: "+GetPCPlayerName(oPC)+ " Initial Level: " +IntToString(GetLocalInt(oPC,"initialLevel")));
}
}
