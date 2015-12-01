void main()
{
    object oPC = GetLastUsedBy();
    object oToken = GetItemPossessedBy(oPC,"KALARAM");
    if (oToken != OBJECT_INVALID)
    {
        location lLoc = GetLocation(GetWaypointByTag("telestone_kalaram"));
        AssignCommand(oPC,JumpToLocation(lLoc));
    }
    else
    {
        FloatingTextStringOnCreature("You have not visited Kalaram yet.",oPC,FALSE);
    }
}
