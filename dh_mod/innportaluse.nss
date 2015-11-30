void main()
{
    object oPC = GetLastUsedBy();
    object oToken = GetItemPossessedBy(oPC,"INN");
    if (oToken != OBJECT_INVALID)
    {
        location lLoc = GetLocation(GetWaypointByTag("INN"));
        AssignCommand(oPC,JumpToLocation(lLoc));
    }
    else
    {
        FloatingTextStringOnCreature("You have not visited The Lucky Coin Inn yet.",oPC,FALSE);
    }
}
