void main()
{
object oPc = GetItemActivator();
    effect eDarkness = EffectDarkness();
    AssignCommand(GetModule(), ApplyEffectToObject(DURATION_TYPE_PERMANENT, eDarkness, oPc));
    DelayCommand(1.0,RemoveEffect(oPc, eDarkness));
    DelayCommand(1.0,ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_RESTORATION), oPc));
}
