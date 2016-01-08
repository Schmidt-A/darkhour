#include "_incl_location"

void main()
{
    object oDead = GetEnteringObject();
    object oToken = GetItemPossessedBy(oDead,"ReaperToken");

    if(GetLocalInt(oToken,"ZOMBIEDEATH")==TRUE && 
       GetItemPossessedBy(oDead,"DMX_RELIVE") == OBJECT_INVALID)
    {
        AssignCommand(oDead,ClearAllActions(TRUE));

        DestroyObject(oToken);
    	CreateItemOnObject("snotesaved",oDead);

	PortToWaypoint(oDead, "DMX_RESPAWN");
        DelayCommand(1.5f,FloatingTextStringOnCreature("You awaken with bandages covering your wounds and no recollection of what happened between now and your unfortunate fall to the zombies, whomever brought you here is gone, but they seem to have left you a note...",oDead,FALSE));
    }

}
