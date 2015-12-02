////// When a player use the Portal "Back to start from Jail!" /////


#include "inc_bs_module"

void main()
{
object oPlayer = GetLastUsedBy();
location lAfk;
object oAfk;
oAfk = GetObjectByTag("AFK");
lAfk = GetLocation(oAfk);
int nTeam;
SetLocalInt(oPlayer, "nScore", 0);
nTeam = GetPlayerTeam(oPlayer);
RemovePlayerFromTeam(nTeam,oPlayer);
//RemoveAllEffects(oPlayer);
AssignCommand(oPlayer, MoveMeToLocation(lAfk));
}



