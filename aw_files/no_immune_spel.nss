void main()
{
object oGm = GetPCSpeaker();

    effect  eImmuneEffect;
    eImmuneEffect=GetFirstEffect(oGm);
    while(GetIsEffectValid(eImmuneEffect))
    {
      if ((GetEffectDurationType(eImmuneEffect) == DURATION_TYPE_PERMANENT) &&  (GetEffectType(eImmuneEffect) == EFFECT_TYPE_SPELL_IMMUNITY))
      {
        RemoveEffect(oGm, eImmuneEffect);
        FloatingTextStringOnCreature("Immunity effect removed!",oGm,FALSE);
      }
      eImmuneEffect = GetNextEffect(oGm);
   }
}
