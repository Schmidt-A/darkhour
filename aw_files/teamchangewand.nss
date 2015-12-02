#include "aw_include"
#include "inc_bs_module"

void main()
{


    object oMyTarget = GetItemActivatedTarget();
    object oItem = GetItemActivated();
    object oGM = GetItemActivator();

    if(GetIsGM(oGM) || GetIsGMNormalChar(oGM))
    {
    int nTeam = GetLocalInt(oMyTarget, "nTeam");
    int nEnemyTeam = 3 - nTeam;

 FloatingTextStringOnCreature("You have been changed to balance teams, plz don't try to change back",oMyTarget, FALSE);


    if (nTeam == TEAM_GOOD || nTeam == TEAM_EVIL)
     {
        RemovePlayerFromTeam(nTeam, oMyTarget);
        AddPlayerToTeam(nEnemyTeam, oMyTarget);
        DelayCommand(0.4,MovePlayerToSpawn(oMyTarget));


     }
    }
    else DestroyObject(oItem, 0.5);
}
