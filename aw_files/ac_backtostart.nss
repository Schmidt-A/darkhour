////// When a player use the Portal "Back to start from Jail!" /////


#include "inc_bs_module"

void main()
{
object oPlayer = GetLastUsedBy();
int nGold = GetTotalPlayerItemCost(oPlayer)+ GetGold(oPlayer);
int nXP = GetXP(oPlayer);
if(GetIsPlayableRacialType(oPlayer) != TRUE)
{
    effect eLook = GetFirstEffect(oPlayer);
        while(GetIsEffectValid(eLook))
        {
            if(GetEffectType(eLook) == EFFECT_TYPE_POLYMORPH )
            {
                RemoveEffect(oPlayer, eLook);
            }
            eLook = GetNextEffect(oPlayer);
        }
    FloatingTextStringOnCreature("You can't exit jail while you are shifted/polymorphed!!", oPlayer, FALSE);
}
else
{
      if (nGold <= nXP)
      {
       //RemoveAllEffects(oPlayer);
       MovePlayerToSpawn(oPlayer);
       }
        else
        {
            FloatingTextStringOnCreature("Your Gold and Item value must be equal or lesser then your xp to exit jail!", oPlayer, FALSE);
           }
}
}



