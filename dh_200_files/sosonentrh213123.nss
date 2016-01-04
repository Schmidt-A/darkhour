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

FloatingTextStringOnCreature("As you enter the hut, vile smell invades your nostrils, a mixture of rotting fish and the pungent smell of dead body makes you nearly want to throw up in disgust. ", oPC);

}
}
