#include "aps_include"

void main()
{
object oPC = GetPCSpeaker();
SetPersistentInt(oPC,"SantaJudgement",1,0,"christmas");
}
