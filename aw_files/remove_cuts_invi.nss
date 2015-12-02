void main()
{
object oGm = GetPCSpeaker();

effect  eVisualEffect;
   eVisualEffect=GetFirstEffect(oGm);
    while(GetIsEffectValid(eVisualEffect))
    {
      if ((GetEffectDurationType(eVisualEffect) == DURATION_TYPE_PERMANENT) && (GetEffectType(eVisualEffect) ==  EFFECT_TYPE_VISUALEFFECT ))
      {
        RemoveEffect(oGm, eVisualEffect);
        FloatingTextStringOnCreature("Visual effect removed!",oGm,FALSE);
        PlaySound("sce_positive");
      }
      eVisualEffect = GetNextEffect(oGm);
   }

}
