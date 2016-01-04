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
if (!GetIsPC(oPC)) return;

object oTarget;
oTarget = oPC;

effect eEffect;
eEffect = EffectSpellFailure(100, SPELL_SCHOOL_GENERAL);

eEffect = ExtraordinaryEffect(eEffect);

ApplyEffectToObject(DURATION_TYPE_PERMANENT, eEffect, oTarget);


    if (GetLocalInt(oPC,"finishcreate") == 1)
    {
        SetDroppableFlag(GetFirstItemInInventory(oPC),FALSE);
        DestroyObject(oPC);
    }
}
