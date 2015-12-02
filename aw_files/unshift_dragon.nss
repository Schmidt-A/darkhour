void main()
{
object oPlayer = GetItemActivator();
object oTarget = GetItemActivatedTarget();
int Playerlevel = GetHitDice(oPlayer);
int Targetlevel = GetHitDice(oTarget);
if ( ((Playerlevel+5 )< Targetlevel) || ((Playerlevel-5 )> Targetlevel) )
 {
 FloatingTextStringOnCreature("Your level range doesn't allow you to unshift that target" ,oPlayer,FALSE); //your level range don't allow you to unshift that target
 }
else if (GetHasFeat(FEAT_EPIC_WILD_SHAPE_DRAGON,oTarget))
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
             else FloatingTextStringOnCreature("Target is not Shifted into Dragon",oPlayer,FALSE);
            }
         else FloatingTextStringOnCreature("Target is not Shifted",oPlayer,FALSE);
         eEffect = GetNextEffect(oTarget);
        }
    }
else FloatingTextStringOnCreature("Target is not valid" ,oPlayer,FALSE); //target dont have the feat
}

