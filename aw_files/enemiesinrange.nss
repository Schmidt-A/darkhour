#include "team_balance"
void main()
{
   if (CheckHasEnemyInRange(OBJECT_SELF))
      SetExecutedScriptReturnValue(TRUE);
   else
      SetExecutedScriptReturnValue(FALSE);
}


