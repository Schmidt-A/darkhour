void GiveNote(object oDead)
{
CreateItemOnObject("snotesaved",oDead);
}

void main()
{
object oDead = GetEnteringObject();
object oToken = GetItemPossessedBy(oDead,"ReaperToken");
//FloatingTextStringOnCreature("ZOMBIE DEATH VARIABLE = "+IntToString(GetLocalInt(oToken,"ZOMBIEDEATH")),oDead);
if(GetLocalInt(oToken,"ZOMBIEDEATH")==TRUE && GetItemPossessedBy(oDead,"DMX_RELIVE") == OBJECT_INVALID)
    {
        DestroyObject(oToken);
        AssignCommand(oDead,ClearAllActions(TRUE));
        GiveNote(oDead);
        AssignCommand(oDead,JumpToLocation(GetLocation(GetWaypointByTag("DMX_RESPAWN"))));
        DelayCommand(1.5f,FloatingTextStringOnCreature("You awaken with bandages covering your wounds and no recollection of what happened between now and your unfortunate fall to the zombies, whomever brought you here is gone, but they seem to have left you a note...",oDead,FALSE));
    }

}
