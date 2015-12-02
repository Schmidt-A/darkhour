#include "inc_bs_module"
#include "aw_include"
void main()
{

    object oGm = GetPCSpeaker();
    object oMyTarget = GetLocalObject(oGm,"MyTarget");
    int nTeam = GetLocalInt(oMyTarget, "nTeam");
    int nEnemyTeam = 3 - nTeam;

 FloatingTextStringOnCreature("You have been changed to balance teams, plz don't try to change back",oMyTarget, FALSE);

     if (GetLocalInt(oMyTarget,"pause") == 1)   FreezeUnfreeze(oMyTarget,oGm);


    if (nTeam == TEAM_GOOD || nTeam == TEAM_EVIL)
     {
        RemovePlayerFromTeam(nTeam, oMyTarget);
        AddPlayerToTeam(nEnemyTeam, oMyTarget);
        DelayCommand(0.4,MovePlayerToSpawn(oMyTarget));
        DelayCommand(14.4,FloatingTextStringOnCreature("<céOÙ>You have been changed to balance teams, plz don't try to change back</c>",oMyTarget, FALSE));
     }
}
