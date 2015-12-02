////// When a player use the Portal "Fron Death Match" /////


#include "inc_bs_module"

void main()
{
object oPlayer = GetLastUsedBy();
location lAfk;
object oAfk;
oAfk = GetObjectByTag("AFK");
lAfk = GetLocation(oAfk);

AssignCommand(oPlayer, MoveMeToLocation(lAfk));
}



