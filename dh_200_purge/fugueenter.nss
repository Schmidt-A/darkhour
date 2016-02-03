#include "_incl_location"
#include "_incl_pc_data"

void main()
{
    object oDead = GetEnteringObject();

    if(!PCDGetUsedOneChance(oDead))
    {
        PCDSetAlive(oDead);
        PCDSetUsedOneChance(oDead);
        AssignCommand(oDead,ClearAllActions(TRUE));

        CreateItemOnObject("snotesaved",oDead);

        PortToWaypoint(oDead, "DMX_RESPAWN");
        DelayCommand(1.5f,FloatingTextStringOnCreature("You awaken with bandages covering your wounds and no recollection of what happened between now and your unfortunate fall to the zombies, whomever brought you here is gone, but they seem to have left you a note...",oDead,FALSE));
    }

}
