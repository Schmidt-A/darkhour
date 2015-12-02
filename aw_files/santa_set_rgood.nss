#include "aps_include"

void main()
{
object oPC = GetPCSpeaker();
SetPersistentInt(oPC,"SantaJudgement",5,0,"christmas");
///delete the stored point
string sName = GetPCPlayerName(oPC);
DeleteLocalInt(oPC,sName);
}
