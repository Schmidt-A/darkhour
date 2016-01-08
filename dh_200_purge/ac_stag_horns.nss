void main()
{
    object oTarget = GetItemActivatedTarget();
    effect eEffect = EffectRegenerate(3, 2.0f);

    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eEffect, oTarget, 12.0f);
}
