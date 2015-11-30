void main()
{
    object oPC = GetEnteringObject();
    effect eSafe = EffectSanctuary(99);
    effect eProtect = EffectDamageResistance(DAMAGE_TYPE_SLASHING,10);
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eSafe,oPC,5.5);
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eProtect,oPC,5.5);

    object oToken = GetItemPossessedBy(oPC,"SanctuaryToken");
    if ((oToken == OBJECT_INVALID) && (GetIsPC(oPC) == TRUE) && (GetIsDM(oPC) == FALSE))
    {
        CreateItemOnObject("sanctuarytoken",oPC);
    }
}
