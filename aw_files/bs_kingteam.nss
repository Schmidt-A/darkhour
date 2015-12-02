#include "inc_bs_module"

void main()
{
    object oPlayer = GetPCSpeaker();
    int nTeam = GetLocalInt(oPlayer, "nTeam");
    int nOtherTeam = 3 - nTeam;

    if (nTeam == TEAM_GOOD || nTeam == TEAM_EVIL)
    {
        RemovePlayerFromTeam(nTeam, oPlayer);
        AddPlayerToTeam(nOtherTeam, oPlayer);
        MovePlayerToSpawn(oPlayer);
    }
}
