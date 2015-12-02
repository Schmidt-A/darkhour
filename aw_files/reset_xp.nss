void main()
{
object oPC = GetPCSpeaker();
int xp = GetLocalInt(oPC,"initialLevel");
SetXP(oPC,xp);
}
