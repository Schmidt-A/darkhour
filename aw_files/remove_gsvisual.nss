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
      }
      eVisualEffect = GetNextEffect(oGm);
   }
        effect eSanc = EffectEthereal();
        effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_POSITIVE);
        effect eLink = EffectLinkEffects(eSanc, eDur);
        ApplyEffectToObject(DURATION_TYPE_PERMANENT, eLink, oGm);

}
