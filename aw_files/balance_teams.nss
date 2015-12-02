#include "team_balance"
void main()
{
    object oTarget = GetItemActivatedTarget();
    if (GetIsObjectValid(oTarget) && GetIsPC(oTarget) && (GetItemActivator() != oTarget))
    {
        CheckPlayerBalance(oTarget);
    }
    else
    {
        BalanceTeams(); //doesn't matter who we assign to
    }
}
