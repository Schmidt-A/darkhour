void main()
{
object oGm = GetPCSpeaker();

    effect  eSanctEffect;
   eSanctEffect=GetFirstEffect(oGm);
    while(GetIsEffectValid(eSanctEffect))
    {
      if ((GetEffectDurationType( eSanctEffect) == DURATION_TYPE_PERMANENT && GetEffectType(eSanctEffect) ==  EFFECT_TYPE_VISUALEFFECT ) || (GetEffectDurationType( eSanctEffect) == DURATION_TYPE_PERMANENT && GetEffectType(eSanctEffect) == EFFECT_TYPE_ETHEREAL ))
      {
         RemoveEffect(oGm, eSanctEffect);
      }
      eSanctEffect = GetNextEffect(oGm);
   }
}
