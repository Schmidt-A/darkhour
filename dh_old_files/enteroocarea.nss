void main()
{
    object oPC = GetEnteringObject();
    if (GetIsPC(oPC) != TRUE)
    {
    return;
    }
    else if (GetIsPC(oPC))
    {
        DelayCommand(6.0,FloatingTextStringOnCreature("<cþ× >Welcome to Dark Hour!</c>",oPC,FALSE));
        int nDisease = 0;
        object oCheckDisease = GetFirstItemInInventory(oPC);
        while (oCheckDisease != OBJECT_INVALID)
        {
            if (GetTag(oCheckDisease) == "ZombieDisease")
            {
                nDisease += GetItemStackSize(oCheckDisease);
            }
            oCheckDisease = GetNextItemInInventory(oPC);
        }
        if (nDisease >= 10)
        {
            DelayCommand(0.5,AssignCommand(oPC,JumpToLocation(GetLocation(GetWaypointByTag("lostsoularrive")))));
        }

        if (OBJECT_INVALID != GetItemPossessedBy(oPC, "DeathToken"))
        {
            int nAlign = GetAlignmentGoodEvil(oPC);
            location lLoc;
            if (nAlign == ALIGNMENT_EVIL)
            {
                lLoc = GetLocation(GetWaypointByTag("GoToHell"));
            }
            else if (nAlign == ALIGNMENT_GOOD)
            {
                lLoc = GetLocation(GetWaypointByTag("GoToHeaven"));
            }
            else
            {
                lLoc = GetLocation(GetWaypointByTag("GoToLimbo"));
            }
            DelayCommand(0.5,AssignCommand(oPC,JumpToLocation(lLoc)));
        }
    }
if(GetItemPossessedBy(oPC, "IsBraveclaw") != OBJECT_INVALID)
    {

    }
}
