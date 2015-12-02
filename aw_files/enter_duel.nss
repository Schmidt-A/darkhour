#include "inc_bs_module"


void main()
{
    object oPlayer = GetLastOpenedBy();
    location lDuel;
    object oDuel;
    oDuel = GetObjectByTag("Duel");
    lDuel = GetLocation(oDuel);
    AssignCommand(oPlayer, JumpToLocation(lDuel));
    ActionWait(3.0);
    ActionCloseDoor(OBJECT_SELF);

}
