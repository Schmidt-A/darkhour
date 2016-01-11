void main()
{
    object oPC = GetEnteringObject();

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

    if (OBJECT_INVALID == GetItemPossessedBy(oPC, "DeathToken") && (GetIsDM(oPC) == FALSE) && (GetIsPC(oPC) == TRUE))
    {
        CreateItemOnObject("deathtoken",oPC);
    }

SetLocalInt(oPC, GetTag(OBJECT_SELF), TRUE);
    effect eDeath = EffectDarkness();
    effect eSafe = EffectVisualEffect(VFX_DUR_ETHEREAL_VISAGE);
    effect eProtect = EffectDamageResistance(DAMAGE_TYPE_SLASHING,10);
    if (GetIsDM(oPC) == FALSE && GetIsPC(oPC))
    {
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eDeath,oPC, 2.0);
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eSafe,oPC,5000000.5);
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eProtect,oPC,5.5);
    }


}
