void main()
{
object oPlayer = GetItemActivator();
object oTarget = GetItemActivatedTarget();

if (GetHasFeat( FEAT_EPIC_WILD_SHAPE_DRAGON,oTarget ))
    {
    effect eEffect = GetFirstEffect(oTarget);
    while(GetIsEffectValid(eEffect))
        {
         if (GetEffectType(eEffect) == EFFECT_TYPE_POLYMORPH)
             {
             if (GetRacialType(oTarget) == RACIAL_TYPE_DRAGON)
                 {
                 RemoveEffect(oTarget, eEffect);
                 }
              else FloatingTextStringOnCreature("Target is not Shifted into Dragon" , oPlayer  , FALSE);
              }
         eEffect = GetNextEffect(oTarget);
        }
    }
  else FloatingTextStringOnCreature("Target is Shifted into Dragon" , oPlayer  , FALSE);
}
