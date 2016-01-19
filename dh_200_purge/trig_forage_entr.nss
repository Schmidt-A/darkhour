void main()
{
    object oPC = GetEnteringObject();

    if(GetLevelByClass(CLASS_TYPE_DRUID, oPC) > 0 ||
       GetLevelByClass(CLASS_TYPE_RANGER, oPC) > 0)
    {
        FloatingTextStringOnCreature("You may be able to find useful herbs here.", oPC, FALSE);
        SetLocalInt(oPC, "bCanForage", TRUE);
    }
}
