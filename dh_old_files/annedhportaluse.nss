void main()
{
    object oPC = GetLastUsedBy();
    object oToken = GetItemPossessedBy(oPC,"ANNEDHEL");
    if (oToken != OBJECT_INVALID)
    {
        location lLoc = GetLocation(GetWaypointByTag("ANNEDHEL"));
        AssignCommand(oPC,JumpToLocation(lLoc));
    }
    else
    {
        FloatingTextStringOnCreature("You have not visited Annedhel yet.",oPC,FALSE);
    }
}
