#include "aps_include"

void main()
{
object oPC = GetPCSpeaker();
SetPersistentInt(oPC,"SantaJudgement",4,0,"christmas");
}
