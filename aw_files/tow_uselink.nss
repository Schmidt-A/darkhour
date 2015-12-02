// tow_uselink
// Scripted By: Demon X
// For: Antiworld
// This script is placed on the Link Points OnUsed event
void main()
{
object oPC = GetLastUsedBy();
int nTeam = GetLocalInt(OBJECT_SELF,"nTeam");
int nHP;
string sHP;
if(nTeam == 1)
    {
    nHP = GetLocalInt(OBJECT_SELF,"ClaimHP");
    sHP = IntToString(nHP);
    FloatingTextStringOnCreature("Good Link Point: "+sHP+" HP",oPC);
    }
else if(nTeam == 2)
    {
    nHP = GetLocalInt(OBJECT_SELF,"ClaimHP");
    sHP = IntToString(nHP);
    FloatingTextStringOnCreature("Evil Link Point: "+sHP+" HP",oPC);
    }
else
    {
    nHP = GetLocalInt(OBJECT_SELF,"LinkHP");
    sHP = IntToString(nHP);
    FloatingTextStringOnCreature("Neutral Link Point: "+sHP+" HP",oPC);
    }
}
