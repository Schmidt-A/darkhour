#include "team_balance"
void main()
{
    if (GetLocalInt(GetModule(), "TeamBalance") && !GetLocalInt(GetModule(), "NearEndOfRound"))
    {
        CheckHasEnemyInRange(GetClickingObject());
        CheckPlayerBalance(GetClickingObject());
    }
}
