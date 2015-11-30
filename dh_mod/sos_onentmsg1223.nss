void main()
{
    object oPC = GetEnteringObject();
    effect eSafe = EffectSanctuary(99);
    effect eProtect = EffectDamageResistance(DAMAGE_TYPE_SLASHING,10);
    if (GetIsDM(oPC) == FALSE)
    {
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eSafe,oPC,5.5);
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eProtect,oPC,5.5);
    }

    if (GetLocalInt(oPC,"finishcreate") == 1)
    {
        SetDroppableFlag(GetFirstItemInInventory(oPC),FALSE);
        DestroyObject(oPC);
    }


{

object oPC = GetEnteringObject();

if (!GetIsPC(oPC)) return;

FloatingTextStringOnCreature("As you trek through the snow and pass through the small forest clearing, you hear the loud screech of a falcon that seems to be circling the nearby hut, and the sound of water flowing through fallen timber nearly drowns out the eerie sounds of the forest the river flows out of.", oPC);

}
}
