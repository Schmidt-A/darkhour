//Trap zone OnEnter trigger script
//triggers are same TAG with same script but they have a nTeam variable 1 or 2
#include "inc_bs_module"
void main()
{
 object oPlayer = GetEnteringObject();
 int nTeam = GetPlayerTeam(oPlayer);
 int nTriggerTeam = GetLocalInt(OBJECT_SELF, "nTeam");
 if(GetHasSkill(SKILL_SET_TRAP,oPlayer) && ( nTriggerTeam == 3-nTeam )   )
  {
  int nSkillRank = FloatToInt(GetSkillRank(SKILL_SET_TRAP,oPlayer)*0.8);
  // a trapper is entering the enemy base trigger   80% skill decrease
  effect eSetTrapPenalty  = EffectSkillDecrease(SKILL_SET_TRAP,nSkillRank);
  eSetTrapPenalty = SupernaturalEffect(eSetTrapPenalty);
  ApplyEffectToObject(DURATION_TYPE_PERMANENT,eSetTrapPenalty,oPlayer);
  }
  else if (nTriggerTeam == nTeam )
  {
  //remove the penalty
  effect ePenaltyEffect = GetFirstEffect(oPlayer);
      while ( GetIsEffectValid(ePenaltyEffect)  )
      {
        if ( GetTag(GetEffectCreator(ePenaltyEffect)) == "trap_zone")
        {
        RemoveEffect(oPlayer, ePenaltyEffect);
        }
      ePenaltyEffect = GetNextEffect(oPlayer);
      }
  }
}
