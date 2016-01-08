void main()
{
object oCreature = GetEnteringObject();
if(GetStringLeft(GetTag(oCreature), 7) == "ZN_ZOMB")
    {
    effect eVis = EffectVisualEffect(VFX_IMP_SUNSTRIKE);
    effect eVisTwo = EffectVisualEffect(VFX_IMP_DIVINE_STRIKE_HOLY);
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oCreature);
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eVisTwo, oCreature);
    ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectKnockdown(), oCreature);
    DelayCommand(2.0, DestroyObject(oCreature));
    return;
    }
if(GetIsPC(oCreature) == TRUE)
    {
    SendMessageToPC(oCreature, "A great warmth overwhelms you as you cross over the barrier.");
    }
}
