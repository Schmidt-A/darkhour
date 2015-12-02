// tow_avatarhp
// Scripted By: Demon X
// For: Antiworld
// This script is attached to the avatars OnUsed Event.
void main()
{
object oPC = GetLastUsedBy();
int nHP = GetLocalInt(OBJECT_SELF,"AvatarHP");
string sHP = IntToString(nHP);
if(GetTag(OBJECT_SELF)=="9")
FloatingTextStringOnCreature("Evil Avatar: "+sHP+" HP",oPC);
else if(GetTag(OBJECT_SELF)=="0")
FloatingTextStringOnCreature("Good Avatar: "+sHP+" HP",oPC);
}
