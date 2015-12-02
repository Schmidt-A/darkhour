#include "inc_bs_module"
void main()
{
    object oAttacker = GetLastAttacker();
    int nFlagTeam = StringToInt(GetStringRight(GetTag(OBJECT_SELF), 1));
    if(GetPlayerTeam(oAttacker) != nFlagTeam)
    {
        ActionAttack(oAttacker);
        DelayCommand(9.0, ClearAllActions(TRUE));
    }
}
