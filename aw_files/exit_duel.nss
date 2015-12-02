#include "inc_bs_module"


void main()
{
    object oPlayer = GetLastOpenedBy();
   location lAfk;
    object oAfk;
    oAfk = GetObjectByTag("AFK");
    lAfk = GetLocation(oAfk);
    AssignCommand(oPlayer, MoveMeToLocation(lAfk));
     ActionWait(3.0);
        ActionCloseDoor(OBJECT_SELF);

}
