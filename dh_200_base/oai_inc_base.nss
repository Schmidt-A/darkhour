////////////////////////////////////////////////////////////////////////////////
//
//  Olander's AI
//  oai_inc_base
//  by Don Anderson
//  dandersonru@msn.com
//
//  Main AI Script
//  Original script by Fallen
//
////////////////////////////////////////////////////////////////////////////////

#include "oai_inc_constant"

int HasSpell(int SpellID, int TalentType, int SpellLevel);
int HasTalent(int iTalent);
void WhatToDoAfterCasting(object oTarget, int TalentType);
int DoCastSpellAtObject(int SpellID, object oTarget, int TalentType, int SpellLevel, int ImmunityType = 0, int iInstantSpell = FALSE, int iOverrideCast = FALSE, int iSpellLevelBonus = 0);
void CastAuras();
void SetStatusCondition(int nCondition, int bValid = TRUE);
int GetStatusCondition(int nCondition, object oWho = OBJECT_SELF);
void SetBattleCondition(int nCondition, int bValid = TRUE, object oWho = OBJECT_SELF);
int GetBattleCondition(int nCondition, object oWho = OBJECT_SELF);
int GetHasItemType(int iBaseItemType, object oWho = OBJECT_SELF);
void SetSpawnInCondition(int nCondition, int bValid = TRUE);
int GetSpawnInCondition(int nCondition);
void BlinkMove();
void BlinkMelee(object oTarget);

int HasSpell(int SpellID, int TalentType, int SpellLevel)
{
  if(GetHasSpell(SpellID, OBJECT_SELF)) return TRUE;
  talent tSpell = GetCreatureTalentBest(TalentType, SpellLevel);
  if(GetIsTalentValid(tSpell) && GetTypeFromTalent(tSpell) == TALENT_TYPE_SPELL && GetIdFromTalent(tSpell) == SpellID) return TRUE;
  return FALSE;
}

int HasTalent(int iTalent)
{
  talent tUse = GetCreatureTalentRandom(iTalent);
  if(GetIsTalentValid(tUse)) return TRUE;
  return FALSE;
}

void WhatToDoAfterCasting(object oTarget, int TalentType)
{
  object oNearest = GetNearestCreature(CREATURE_TYPE_REPUTATION, REPUTATION_TYPE_ENEMY, OBJECT_SELF, 1, CREATURE_TYPE_IS_ALIVE, TRUE, CREATURE_TYPE_PERCEPTION, PERCEPTION_SEEN);
  int iAmAWeakling = (GetMaxHitPoints(OBJECT_SELF) < (MyHD * OAI_RUN_OR_FIGHT_HITDICE)
                      && !GetBattleCondition(OAI_ROLE_DRAGON)
                      && (GetBattleCondition(OAI_ROLE_AOE_SPECIALIST)
                          || GetBattleCondition(OAI_ROLE_ATTACK_CASTER)
                          || GetBattleCondition(OAI_ROLE_STATUS_CASTER)));
  if(GetBattleCondition(OAI_BLINK_SELF))
  {
    if(Random(100) >= GetLocalInt(OBJECT_SELF, "OAI_BLINK_FAILURE"))
    {
      if(TalentType == 3 || TalentType == 5) BlinkMelee(oTarget);
      else BlinkMove();
    }
  }
  else if(GetIsObjectValid(oNearest))
  {
    if(GetDistanceToObject(oNearest) < 3.0 && !iAmAWeakling) ActionAttack(oNearest);
    else if(iAmAWeakling) ActionMoveAwayFromObject(oNearest, TRUE, 12.0);
  }
  else if(oTarget != OBJECT_SELF) ActionMoveAwayFromObject(oTarget, TRUE, 12.0);
}

int DoCastSpellAtObject(int SpellID, object oTarget, int TalentType, int SpellLevel, int ImmunityType = 0, int iInstantSpell = FALSE, int iOverrideCast = FALSE, int iSpellLevelBonus = 0)
{
  //FloatingTextStringOnCreature(GetName(OBJECT_SELF) + ": CastSpellAtObject: " + IntToString(SpellID), GetFirstPC());
  //PrintString("---- Attempting spell: " + IntToString(SpellID));
  if(GetHasSpellEffect(SpellID, oTarget) || (!iOverrideCast && Random(MyCappedHD) > (SpellLevel + OAI_PREFERED_SPELL_RANGE + iSpellLevelBonus))) return FALSE;
  if(GetHasSpell(SpellID))
  {
    //PrintString("---- casting spell: " + IntToString(SpellID));
    ActionCastSpellAtObject(SpellID, oTarget, METAMAGIC_ANY, FALSE, 0, PROJECTILE_PATH_TYPE_DEFAULT, iInstantSpell);
    if(ImmunityType > 0)
    {
      if(oTarget != OBJECT_SELF) SetLocalInt(OBJECT_SELF, "OAI_LASTSPELLHP", GetCurrentHitPoints(oTarget));
      SetLocalInt(OBJECT_SELF, "OAI_LASTSPELLTYPE", ImmunityType);
    }
    if(!iInstantSpell) WhatToDoAfterCasting(oTarget, TalentType);
    return TRUE;
  }
  else if(!iInstantSpell)
  {
    talent tSpell = GetCreatureTalentBest(TalentType, SpellLevel);
    if(GetIsTalentValid(tSpell) && GetTypeFromTalent(tSpell) == TALENT_TYPE_SPELL && GetIdFromTalent(tSpell) == SpellID)
    {
      //PrintString("---- casting talent spell: " + IntToString(SpellID));
      ActionUseTalentOnObject(tSpell, oTarget);
      if(ImmunityType > 0)
      {
        if(oTarget != OBJECT_SELF) SetLocalInt(OBJECT_SELF, "OAI_LASTSPELLHP", GetCurrentHitPoints(oTarget));
        SetLocalInt(OBJECT_SELF, "OAI_LASTSPELLTYPE", ImmunityType);
      }
      WhatToDoAfterCasting(oTarget, TalentType);
      return TRUE;
    }
    else if(oTarget == OBJECT_SELF)
    {
      int PotionType;
      if(TalentType == 4 || TalentType == 5) PotionType= 17;
      else if(TalentType == 6 || TalentType == 7) PotionType= 18;
      else if(TalentType >= 8 && TalentType <= 10) PotionType= 21;
      else if(TalentType >= 12 && TalentType <= 14) PotionType= 20;
      else return FALSE;
      tSpell = GetCreatureTalentBest(PotionType, SpellLevel);
      if(GetIsTalentValid(tSpell) && GetTypeFromTalent(tSpell) == TALENT_TYPE_SPELL && GetIdFromTalent(tSpell) == SpellID)
      {
        //PrintString("---- casting potion spell: " + IntToString(SpellID));
        ActionUseTalentOnObject(tSpell, oTarget);
        WhatToDoAfterCasting(oTarget, PotionType);
        return TRUE;
      }
    }
  } //end instant spell check
//PrintString("---- failed.");
return FALSE;
}

void CastAuras()
{
    DoCastSpellAtObject(SPELLABILITY_AURA_MENACE, OBJECT_SELF, TALENT_CATEGORY_PERSISTENT_AREA_OF_EFFECT, 5, 0, TRUE, TRUE);
    DoCastSpellAtObject(SPELLABILITY_AURA_UNNATURAL, OBJECT_SELF, TALENT_CATEGORY_PERSISTENT_AREA_OF_EFFECT, 5, 0, TRUE, TRUE);
    DoCastSpellAtObject(SPELLABILITY_TYRANT_FOG_MIST, OBJECT_SELF, TALENT_CATEGORY_PERSISTENT_AREA_OF_EFFECT, 5, 0, TRUE, TRUE);

    DoCastSpellAtObject(SPELLABILITY_AURA_FIRE, OBJECT_SELF, TALENT_CATEGORY_PERSISTENT_AREA_OF_EFFECT, 7, 0, TRUE, TRUE);
    DoCastSpellAtObject(SPELLABILITY_AURA_ELECTRICITY, OBJECT_SELF, TALENT_CATEGORY_PERSISTENT_AREA_OF_EFFECT, 7, 0, TRUE, TRUE);
    DoCastSpellAtObject(SPELLABILITY_AURA_COLD, OBJECT_SELF, TALENT_CATEGORY_PERSISTENT_AREA_OF_EFFECT, 7, 0, TRUE, TRUE);
    DoCastSpellAtObject(SPELLABILITY_AURA_FEAR, OBJECT_SELF, TALENT_CATEGORY_PERSISTENT_AREA_OF_EFFECT, 7, 0, TRUE, TRUE);
    DoCastSpellAtObject(SPELLABILITY_AURA_PROTECTION, OBJECT_SELF, TALENT_CATEGORY_PERSISTENT_AREA_OF_EFFECT, 7, 0, TRUE, TRUE);

    DoCastSpellAtObject(SPELLABILITY_AURA_BLINDING, OBJECT_SELF, TALENT_CATEGORY_PERSISTENT_AREA_OF_EFFECT, 9, 0, TRUE, TRUE);
    DoCastSpellAtObject(SPELLABILITY_AURA_STUN, OBJECT_SELF, TALENT_CATEGORY_PERSISTENT_AREA_OF_EFFECT, 9, 0, TRUE, TRUE);

    DoCastSpellAtObject(SPELLABILITY_AURA_UNEARTHLY_VISAGE, OBJECT_SELF, TALENT_CATEGORY_PERSISTENT_AREA_OF_EFFECT, 13, 0, TRUE, TRUE);
    DoCastSpellAtObject(SPELLABILITY_DRAGON_FEAR, OBJECT_SELF, TALENT_CATEGORY_PERSISTENT_AREA_OF_EFFECT, 13, 0, TRUE, TRUE);
}

void SetStatusCondition(int nCondition, int bValid = TRUE)
{
    int nPlot = GetLocalInt(OBJECT_SELF, "OAI_STATUS");
    if(bValid == TRUE)
    {
      nPlot = nPlot | nCondition;
      SetLocalInt(OBJECT_SELF, "OAI_STATUS", nPlot);
    }
    else if (bValid == FALSE)
    {
      nPlot = nPlot & ~nCondition;
      SetLocalInt(OBJECT_SELF, "OAI_STATUS", nPlot);
    }
}

int GetStatusCondition(int nCondition, object oWho = OBJECT_SELF)
{
    int nPlot = GetLocalInt(oWho, "OAI_STATUS");
    if((nPlot & nCondition) == nCondition) return TRUE;
    return FALSE;
}

void SetBattleCondition(int nCondition, int bValid = TRUE, object oWho = OBJECT_SELF)
{
    int nPlot = GetLocalInt(oWho, "OAI_BATTLE");
    if(bValid == TRUE)
    {
      nPlot = nPlot | nCondition;
      SetLocalInt(oWho, "OAI_BATTLE", nPlot);
      if(nCondition == OAI_CAST_AURAS_NOW) CastAuras();
    }
    else if (bValid == FALSE)
    {
      nPlot = nPlot & ~nCondition;
      SetLocalInt(oWho, "OAI_BATTLE", nPlot);
    }
}

int GetBattleCondition(int nCondition, object oWho = OBJECT_SELF)
{
    int nPlot = GetLocalInt(oWho, "OAI_BATTLE");
    if((nPlot & nCondition) == nCondition) return TRUE;
    return FALSE;
}

int GetHasItemType(int iBaseItemType, object oWho = OBJECT_SELF)
{
    object oO = GetFirstItemInInventory(oWho);
    while (GetIsObjectValid(oO))
    {
      if(GetBaseItemType(oO) == iBaseItemType) return TRUE;
      oO = GetNextItemInInventory(oWho);
    }
    return FALSE;
}

void SetSpawnInCondition(int nCondition, int bValid = TRUE)
{
    int nPlot = GetLocalInt(OBJECT_SELF, "NW_GENERIC_MASTER");
    if(bValid == TRUE)
    {
      nPlot = nPlot | nCondition;
      SetLocalInt(OBJECT_SELF, "NW_GENERIC_MASTER", nPlot);
    }
    else if (bValid == FALSE)
    {
      nPlot = nPlot & ~nCondition;
      SetLocalInt(OBJECT_SELF, "NW_GENERIC_MASTER", nPlot);
    }
}

int GetSpawnInCondition(int nCondition)
{
    int nPlot = GetLocalInt(OBJECT_SELF, "NW_GENERIC_MASTER");
    if(nPlot & nCondition) return TRUE;
    return FALSE;
}

void BlinkMove()
{
    vector vWho = GetPosition(OBJECT_SELF);
    float fWho;
    location lWho;
    location lOld = GetLocation(OBJECT_SELF);
    effect eBlink=EffectVisualEffect(GetLocalInt(OBJECT_SELF, "OAI_BLINK_FX"));
    int iX, iY;
    while(iX==0 && iY==0)
    {
      iX = (Random(7) - 3) * 2;
      iY = (Random(7) - 3) * 2;
    }
    vWho.x += IntToFloat(iX);
    vWho.y += IntToFloat(iY);
    iX=Random(3601);
    fWho=IntToFloat(iX) / 10.0;
    lWho=Location(GetArea(OBJECT_SELF), vWho, fWho);
    ClearAllActions();
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eBlink, lOld);
    DelayCommand(0.5, JumpToLocation(lWho));
    DelayCommand(1.0, ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eBlink, lWho));
    ActionDoCommand(SetFacing(fWho));
    if(GetIsPC(OBJECT_SELF)) SetCameraFacing(fWho);
}

void BlinkMelee(object oTarget)
{
    vector vWho = GetPosition(oTarget);
    float fWho = GetFacing(oTarget);
    location lWho;
    location lOld = GetLocation(OBJECT_SELF);
    effect eBlink=EffectVisualEffect(GetLocalInt(OBJECT_SELF, "OAI_BLINK_FX"));
    int iX, iY;
    while(iX==0 && iY==0)
    {
      iX = (Random(5) - 2);
      iY = (Random(5) - 2);
    }
    vWho.x += IntToFloat(iX);
    vWho.y += IntToFloat(iY);
    lWho=Location(oArea, vWho, fWho);
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eBlink, lOld);
    DelayCommand(0.5, JumpToLocation(lWho));
    DelayCommand(1.0, ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eBlink, lWho));
}

//void main() { }
