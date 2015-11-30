////////////////////////////////////////////////////////////////////////////////
//
//  Olander's AI
//  oai_inc_ai
//  by Don Anderson
//  dandersonru@msn.com
//
//  Main AI Script
//  Original script by Fallen
//
////////////////////////////////////////////////////////////////////////////////

#include "oai_inc_wlkwypnt"
#include "oai_inc_eqweapon"

//Sets the immunity flag onto a creature, so that everyone fighting it knows that it is immune.
void SetImmunity(int nCondition, int bValid = TRUE, object oWho = OBJECT_SELF);
//Gets the specific immunity flag for a creature.
int GetImmunity(int nCondition, object oWho = OBJECT_SELF);
//Checks for death protection spells that can be removed by dispell magic.
int GetHasDisspellableDeathProtections(object oTarget);
//Checks for sight protection spells that can be removed by dispell magic.
int GetHasDisspellableSightProtections(object oTarget);
//Checks for spell protections that can be removed by dispell magic.
int GetHasDisspellableSpellProtections(object oTarget);
//Checks for negative energy protection spells that can be removed by dispell magic.
int GetHasDisspellableNegativeProtections(object oTarget);
//Checks for mental protection spells that can be removed by dispell magic.
int GetHasDisspellableMentalProtections(object oTarget);
//This function is called at the beginning of a combat round to see if the
//spell that was last cast was successful or if they are immune to it.
//gives the illusion of creatures learning immunities instead of just
//knowing them (quite a bit faster as well).
int DetermineImmunities(object oLastTarget);
//Determine the best location to cast an aoe, too many calls to this in a
//combat round can cause a lockup.
//LivingEffect - on oTarget and others of oTarget's faction
//  1. Harmful if Enemies, Helpful if Friends
//  2. Helps Enemies, Harms Friends
//UndeadEffect - on oTarget and others of oTarget's faction
//  1. Harmful if Enemies, Helpful if Friends
//  2. Helps Enemies, Harms Friends
location GetBestAOELocation(object oTarget, float SpellRadius, int LivingEffect = 1, int UndeadEffect = 1, int iLookingForEnemy = TRUE);
//This is the counterpart function to GetBestAOELocation, this takes the
//location that was found and returns a location that will hit as few of
//your friends as possible.
location ConsiderFriendlyFire(location lEnemy, location lAlly, float SpellRadius);
//casts a spell at a location, used for aoe's only.
int CastSpellAtLocation(int SpellID, location lTarget, int TalentType, int SpellLevel, int ImmunityType = 0);
//causes the npc to use the best of a talent (via the bioware best function)
//used for healing potions.
int UseBestOfATalent(int iTalent, object oNPC);
//Checks to make sure the npc is NOT fighting, uses ai flags instead of
//bioware functions.
int GetIsNotFighting(object oWho = OBJECT_SELF);
//Checks if the npc is paralyzed or otherwise disabled. Used for targeting
//and checking to see if we should even run a combat round.
int GetIsThreat(object oNPC);
//Checks to see if the npc has a certain effect, one of the most widely used
//functions
int GetHasEffect(int fxType, object oNPC);
//check if we are busy doing something that should not be interrupted.
int GetIsBusy(object oNPC);
//ranks targets depending upon settings
int KillRank(object oNPC);
//Figures out who needs to be killed, uses KillRank
object DetermineEnemy(object oLastAttack, object oSpecified);
//Casts raise dead or resurrect on a target.
int CastRezOn(object oTarget);
//Finds anyone who needs to be resurrected
int DetermineAllyToRez();
//checks my hp versus the current person who needs a heal and determines
//if I should come before them
void ICouldUseAHeal();
//Get's whomever is on top of the healing queue
object DetermineAllyToHeal();
//Casts a healing spell on friend, takes into account undead and uses proper
//spells to heal them.
int HealOthers();
//use potions or spells to heal yourself.
int HealSelf(int noEnemyOverride = FALSE);
//Casts triggers as defined in the spawn file.
void CastTriggers();
//Buffs the sight of a friend, ie Ultravision or true seeing.
int BuffSightOther(object oTemp);
//Buffs with critical buffs like haste.
int BuffCriticalOther(object oTemp);
//Self buffs for protection from magic (Mantles, globes)
int BuffMagicSelf();
//Buffs the magic defense of another (resist magic)
int BuffMagicOther(object oTemp);
//Buffs with mental protections on others (mind blank)
int BuffMentalOther(object oTemp);
//Gives physical buffs to others (stoneskins)
int BuffPhysicalOther(object oTemp);
//uses self only physical buffs (premonition)
int BuffPhysicalSelf();
//Buff elemental resistance on others
int BuffElementalOther(object oTemp);
//use self only elemental buffs
int BuffElementalSelf();
//figure out and apply any buffs you need on yourself
int BuffSelf();
//figure out and apply any buffs an ally needs
int BuffUp(object oTarget);
// Return TRUE if target is enhanced with a beneficial
// spell that can be dispelled
int GetHasDispellableEnhancement(object oTarget);
// Returns TRUE if the target has any spell effect that can be targeted with
// any Spell breach. Breachs are pretty good.
int GetHasBreachableEnhancement(object oTarget);
//Check if the target has any physical protections
int HasPhysicalProtections(object oTarget = OBJECT_SELF);
//Check if target has any mental protections
int HasMentalProtections(object oTarget = OBJECT_SELF);
//Check if target has any anti-magic protections
int HasMagicProtections(object oTarget = OBJECT_SELF);
//Check if target has any elemental protections
int HasElementalProtections(object oTarget = OBJECT_SELF);
//Check if target has enhanced eyesight (natural or spell)
int HasGoodEyes(object oTarget = OBJECT_SELF);
//Set's up the grouping for group tactics and other intragroup
//communications (immunities, health, hate, etc)
void Setup_NPC_Group();
// This checks the status (and if we can cast curing spells)
// and cure conditons of allies, in range, or out of battle.
int StatusFix(object oWho = OBJECT_SELF);
//Looks for others that need cures and runs a statusfix on them.
int CureOther(int iAlsoLookElsewhere = FALSE);
//looks for others that need buffs and runs buffup on them
int BuffOther(int iAlsoLookElsewhere = FALSE);
//This doublechecks that we are hitting enough people with our aoe after
//moving it for allies.
//Caster's Ally Effect
//  1. Harm
//  2. Heal
//  3. Immune
//Caster's Enemy Effect
//  1. Harm
//  2. Heal
//  3. Immune
int ShouldICast(location lTarget, float SpellRadius, int MinimumToCast = 2, int SpellShape = SHAPE_SPELLCONE, int AllyEffect = 1, int FoeEffect = 1);

//All aoe's are given a safe and unsafe location for each spell radius size
//They will return true if they cast a spell.
int AOE_Fire(object oTarget, int iSafeAOE_VL, location lSafeAOE_VL, int iUnsafeAOE_VL, location lUnsafeAOE_VL,
                      int iSafeAOE_L, location lSafeAOE_L, int iUnsafeAOE_L, location lUnsafeAOE_L,
                      int iSafeAOE_M, location lSafeAOE_M, int iUnsafeAOE_M, location lUnsafeAOE_M,
                      int iSafeAOE_S, location lSafeAOE_S, int iUnsafeAOE_S, location lUnsafeAOE_S,
                      int iUnsafeCone, int iUnsafeCube);
int AOE_Ice(object oTarget, int iSafeAOE_VL, location lSafeAOE_VL, int iUnsafeAOE_VL, location lUnsafeAOE_VL,
                      int iSafeAOE_L, location lSafeAOE_L, int iUnsafeAOE_L, location lUnsafeAOE_L,
                      int iSafeAOE_M, location lSafeAOE_M, int iUnsafeAOE_M, location lUnsafeAOE_M,
                      int iSafeAOE_S, location lSafeAOE_S, int iUnsafeAOE_S, location lUnsafeAOE_S,
                      int iUnsafeCone, int iUnsafeCube);
int AOE_Acid(object oTarget, int iSafeAOE_VL, location lSafeAOE_VL, int iUnsafeAOE_VL, location lUnsafeAOE_VL,
                      int iSafeAOE_L, location lSafeAOE_L, int iUnsafeAOE_L, location lUnsafeAOE_L,
                      int iSafeAOE_M, location lSafeAOE_M, int iUnsafeAOE_M, location lUnsafeAOE_M,
                      int iSafeAOE_S, location lSafeAOE_S, int iUnsafeAOE_S, location lUnsafeAOE_S,
                      int iUnsafeCone, int iUnsafeCube);
int AOE_Electric(object oTarget, int iSafeAOE_VL, location lSafeAOE_VL, int iUnsafeAOE_VL, location lUnsafeAOE_VL,
                      int iSafeAOE_L, location lSafeAOE_L, int iUnsafeAOE_L, location lUnsafeAOE_L,
                      int iSafeAOE_M, location lSafeAOE_M, int iUnsafeAOE_M, location lUnsafeAOE_M,
                      int iSafeAOE_S, location lSafeAOE_S, int iUnsafeAOE_S, location lUnsafeAOE_S,
                      int iUnsafeCone, int iUnsafeCube);
int AOE_Status(object oTarget, int iSafeAOE_VL, location lSafeAOE_VL, int iUnsafeAOE_VL, location lUnsafeAOE_VL,
                      int iSafeAOE_L, location lSafeAOE_L, int iUnsafeAOE_L, location lUnsafeAOE_L,
                      int iSafeAOE_M, location lSafeAOE_M, int iUnsafeAOE_M, location lUnsafeAOE_M,
                      int iSafeAOE_S, location lSafeAOE_S, int iUnsafeAOE_S, location lUnsafeAOE_S,
                      int iUnsafeCone, int iUnsafeCube);
int AOE_Death(object oTarget, int iSafeAOE_VL, location lSafeAOE_VL, int iUnsafeAOE_VL, location lUnsafeAOE_VL,
                      int iSafeAOE_L, location lSafeAOE_L, int iUnsafeAOE_L, location lUnsafeAOE_L,
                      int iSafeAOE_M, location lSafeAOE_M, int iUnsafeAOE_M, location lUnsafeAOE_M,
                      int iSafeAOE_S, location lSafeAOE_S, int iUnsafeAOE_S, location lUnsafeAOE_S,
                      int iUnsafeCone, int iUnsafeCube);
int AOE_Other(object oTarget, int iSafeAOE_VL, location lSafeAOE_VL, int iUnsafeAOE_VL, location lUnsafeAOE_VL,
                      int iSafeAOE_L, location lSafeAOE_L, int iUnsafeAOE_L, location lUnsafeAOE_L,
                      int iSafeAOE_M, location lSafeAOE_M, int iUnsafeAOE_M, location lUnsafeAOE_M,
                      int iSafeAOE_S, location lSafeAOE_S, int iUnsafeAOE_S, location lUnsafeAOE_S,
                      int iUnsafeCone, int iUnsafeCube);
int AOE_Negative(object oTarget, int iSafeAOE_VL, location lSafeAOE_VL, int iUnsafeAOE_VL, location lUnsafeAOE_VL,
                      int iSafeAOE_L, location lSafeAOE_L, int iUnsafeAOE_L, location lUnsafeAOE_L,
                      int iSafeAOE_M, location lSafeAOE_M, int iUnsafeAOE_M, location lUnsafeAOE_M,
                      int iSafeAOE_S, location lSafeAOE_S, int iUnsafeAOE_S, location lUnsafeAOE_S,
                      int iUnsafeCone, int iUnsafeCube);

//Looks for a good place to cast an aoe and uses an AOE_* function to cast
//it. The target is who you must hit, the MinHitToCast is how many more foes
//than allies must be hit in order to cast this spell, StatusOnly is a
//special case for status casters and skips all the other spell types.
//This also takes into account spell preferences.
int CastAnAOE(object oTarget, int MinHitToCast = 2, int iStatusOnly = FALSE);

//the Single_* functions are used to cast single target spells.
int Single_Fire(object oTarget);
int Single_Ice(object oTarget);
int Single_Electric(object oTarget);
int Single_Acid(object oTarget);
int Single_Negative(object oTarget);
int Single_Death(object oTarget);
int Single_Other(object oTarget);
int DispellFoe(object oTarget);
int Single_Status(object oTarget);

//Casts a single target spell at a target, takes into account preferences.
int CastASingle(object oTarget);

//Looks for someone who is not targeting me to sneak attack, maxrange is
//how wide of an area to look in.
object SneakAttackTarget(object oFoe, float fMaxRange = 3.0);
//Determines what attack type to use when using a Ranged Weapon or passes onto Melee below.
void doFighting(object oLastTarget, object oTarget);
//Determines what kind of attacks to use.
void MeleeFighting(object oTarget);
//Chooses a target that the group will focus on, looks mostly for casters
object ChooseGroupTarget();
//Checks to see if I am under melee attack, used in group actions
int IsUnderMeleeAttack(object oWho = OBJECT_SELF);
//Choose a tactic for the group to perform.
int ChooseGroupTactics();
//Looks for enemy AOE's and dispells them if they are being annoying.
int ManageEnemyAOE();
// The dragon will launch into the air, knockdown
// all opponents who fail a Reflex Save and then
// land on one of those opponents doing damage
// up to a maximum of the Dragons HD + 10.
int DragonWingBuffet(object oFoe);
//Makes dragons use their breaths and wings every once in a while.
int SpecialDragonStuff(object oFoe);
//Casts monster abilities, currently no immunity checks
void CastMonsterAbilities(object oFoe);
//Casts a summon if we can and if we need to
int CastSummon(object oTarget, int InstantCast = FALSE);
//Polymorphs self if we have the spell
int PolymorphSelf(object oFoe);
//Breaks the illusion if the creature is illusionary. does different things
//depending on if the creature is dead or not
object BreakIllusion(object oBreaker, int iAmDead = FALSE);
//Does the Summon Hordes ability
void SummonHordes();
//Turn Undead
int DoTurnUndead(object oFoe);
//Sometimes you just have to sing!
int DoBardSong();

void ddp(string functionName, object oWhat, string sMessage = "Called.")
{  //Do Debug Print incase you were wondering
  if(!DebugMode) return;
  WriteTimestampedLogEntry(GetName(OBJECT_SELF) + "[" + ObjectToString(OBJECT_SELF) + "]: " + functionName + ": " + GetName(oWhat) + "[" + ObjectToString(oWhat) + "]: " + sMessage);
}

void SetImmunity(int nCondition, int bValid = TRUE, object oWho = OBJECT_SELF)
{
    ddp("SetImmunity", oWho);
    int nPlot = GetLocalInt(oWho, "OAI_IMMUNITY");
    if(bValid == TRUE)
    {
      nPlot = nPlot | nCondition;
      SetLocalInt(oWho, "OAI_IMMUNITY", nPlot);
    }
    else if (bValid == FALSE)
    {
      nPlot = nPlot & ~nCondition;
      SetLocalInt(oWho, "OAI_IMMUNITY", nPlot);
    }
}

int GetImmunity(int nCondition, object oWho = OBJECT_SELF)
{
    ddp("GetImmunity", oWho);
    int nPlot = GetLocalInt(oWho, "OAI_IMMUNITY");
    if((nPlot & nCondition) == nCondition)return TRUE;
    return FALSE;
}

int GetHasDisspellableDeathProtections(object oTarget)
{
    ddp("GetHasDisspellableDeathProtections", oTarget);
    effect eCheck = GetFirstEffect(oTarget);
    int iSpellID;
    while (GetIsEffectValid(eCheck))
    {
      if (GetEffectSpellId(eCheck) != -1)
      {
        iSpellID = GetEffectSpellId(eCheck);
        if(iSpellID ==  SPELL_DEATH_WARD
          || iSpellID ==  SPELL_SHADOW_SHIELD
          || iSpellID == SPELL_UNDEATHS_ETERNAL_FOE)
            return TRUE;
      }
      eCheck = GetNextEffect(oTarget);
    }
    return FALSE;
}

int GetHasDisspellableSightProtections(object oTarget)
{
    ddp("GetHasDisspellableSightProtections", oTarget);
    effect eCheck = GetFirstEffect(oTarget);
    int iSpellID;
    while (GetIsEffectValid(eCheck))
    {
      if (GetEffectSpellId(eCheck) != -1)
      {
        iSpellID = GetEffectSpellId(eCheck);
        if(iSpellID ==  EFFECT_TYPE_TRUESEEING
          || iSpellID ==  EFFECT_TYPE_ULTRAVISION)
            return TRUE;
      }
      eCheck = GetNextEffect(oTarget);
    }
    return FALSE;
}

int GetHasDisspellableSpellProtections(object oTarget)
{
    ddp("GetHasDisspellableSpellProtections", oTarget);
    effect eCheck = GetFirstEffect(oTarget);
    int iSpellID;
    while (GetIsEffectValid(eCheck))
    {
      if (GetEffectSpellId(eCheck) != -1)
      {
        iSpellID = GetEffectSpellId(eCheck);
        if(iSpellID ==  SPELL_GREATER_SPELL_MANTLE
          || iSpellID ==  SPELL_LESSER_SPELL_MANTLE
          || iSpellID ==  SPELL_SPELL_MANTLE
          || iSpellID ==  SPELL_PROTECTION_FROM_SPELLS)
            return TRUE;
      }
      eCheck = GetNextEffect(oTarget);
    }
    return FALSE;
}

int GetHasDisspellableNegativeProtections(object oTarget)
{
    ddp("GetHasDisspellableNegativeProtections", oTarget);
    effect eCheck = GetFirstEffect(oTarget);
    int iSpellID;
    while (GetIsEffectValid(eCheck))
    {
      if (GetEffectSpellId(eCheck) != -1)
      {
        iSpellID = GetEffectSpellId(eCheck);
        if(iSpellID ==  SPELL_NEGATIVE_ENERGY_PROTECTION
          || iSpellID ==  SPELL_SHADOW_SHIELD
          || iSpellID == SPELL_UNDEATHS_ETERNAL_FOE)
            return TRUE;
      }
      eCheck = GetNextEffect(oTarget);
    }
    return FALSE;
}

int GetHasDisspellableMentalProtections(object oTarget)
{
    ddp("GetHasDisspellableMentalProtections", oTarget);
    effect eCheck = GetFirstEffect(oTarget);
    int iSpellID;
    while (GetIsEffectValid(eCheck))
    {
      if (GetEffectSpellId(eCheck) != -1)
      {
        iSpellID = GetEffectSpellId(eCheck);
        if(iSpellID ==  SPELL_MIND_BLANK
          || iSpellID ==  SPELL_LESSER_MIND_BLANK
          || iSpellID ==  SPELL_CLARITY)
            return TRUE;
      }
      eCheck = GetNextEffect(oTarget);
    }
    return FALSE;
}

int DetermineImmunities(object oLastSpellTarget)
{
    ddp("DetermineImmunities", oLastSpellTarget);
    if(GetBattleCondition(OAI_I_CANNOT_LEARN)) return FALSE;
    int ImmunityToCheck = GetLocalInt(OBJECT_SELF, "OAI_LASTSPELLTYPE");
    int iLastHPChanged = (GetLocalInt(OBJECT_SELF, "OAI_LASTSPELLHP") > GetCurrentHitPoints(oLastSpellTarget));
    DeleteLocalInt(OBJECT_SELF, "OAI_LASTSPELLTYPE");
    if(ImmunityToCheck == 0
      || !GetIsObjectValid(oLastSpellTarget)
      || GetIsDead(oLastSpellTarget))
        return FALSE;
    if(GetHasDisspellableSpellProtections(oLastSpellTarget))
    {
      if(DispellFoe(oLastSpellTarget)) return TRUE;
      return FALSE;
    }
    if (ImmunityToCheck & OAI_IMMUNITY_DEATH)
    {
      if(GetHasDisspellableDeathProtections(oLastSpellTarget))
      {
        if(DispellFoe(oLastSpellTarget)) return TRUE;
      }
      else if(FortitudeSave(oLastSpellTarget, 99, SAVING_THROW_TYPE_DEATH) != 0)
      {
        SetImmunity(OAI_IMMUNITY_DEATH, TRUE, oLastSpellTarget);
      }
    }
    if (ImmunityToCheck & OAI_IMMUNITY_STUN)
    {
      if(GetHasDisspellableMentalProtections(oLastSpellTarget))
      {
        if(DispellFoe(oLastSpellTarget)) return TRUE;
      }
      else if(!GetHasEffect(EFFECT_TYPE_STUNNED, oLastSpellTarget)
        && !GetHasEffect(EFFECT_TYPE_PARALYZE, oLastSpellTarget)
        && !GetHasEffect(EFFECT_TYPE_DAZED, oLastSpellTarget)
        && !GetHasEffect(EFFECT_TYPE_DOMINATED, oLastSpellTarget))
      {
        SetImmunity(OAI_IMMUNITY_STUN, TRUE, oLastSpellTarget);
      }
    }
    if (ImmunityToCheck & OAI_IMMUNITY_DRAIN)
    {
      if(GetHasDisspellableNegativeProtections(oLastSpellTarget))
      {
        if(DispellFoe(oLastSpellTarget)) return TRUE;
      }
      else if(!GetHasEffect(EFFECT_TYPE_ABILITY_DECREASE, oLastSpellTarget)
        && !GetHasEffect(EFFECT_TYPE_NEGATIVELEVEL, oLastSpellTarget)
        && !GetHasEffect(EFFECT_TYPE_SAVING_THROW_DECREASE, oLastSpellTarget))
      {
        SetImmunity(OAI_IMMUNITY_DRAIN, TRUE, oLastSpellTarget);
      }
    }
    if (ImmunityToCheck & OAI_IMMUNITY_DOMINATE)
    {
      if(GetHasDisspellableMentalProtections(oLastSpellTarget))
      {
        if(DispellFoe(oLastSpellTarget)) return TRUE;
      }
      else if(!GetHasEffect(EFFECT_TYPE_DOMINATED, oLastSpellTarget)
        && !GetHasEffect(EFFECT_TYPE_CONFUSED, oLastSpellTarget)
        && !GetHasEffect(EFFECT_TYPE_CHARMED, oLastSpellTarget))
      {
        SetImmunity(OAI_IMMUNITY_DOMINATE, TRUE, oLastSpellTarget);
      }
    }
    if (ImmunityToCheck & OAI_IMMUNITY_PARALYZE)
    {
      if(GetHasDisspellableMentalProtections(oLastSpellTarget))
      {
        if(DispellFoe(oLastSpellTarget)) return TRUE;
      }
      else if(!GetHasEffect(EFFECT_TYPE_STUNNED, oLastSpellTarget)
        && !GetHasEffect(EFFECT_TYPE_PARALYZE, oLastSpellTarget)
        && !GetHasEffect(EFFECT_TYPE_DAZED, oLastSpellTarget)
        && !GetHasEffect(EFFECT_TYPE_DOMINATED, oLastSpellTarget))
      {
        SetImmunity(OAI_IMMUNITY_PARALYZE, TRUE, oLastSpellTarget);
      }
    }
    if (ImmunityToCheck & OAI_IMMUNITY_CURSE)
    {
      if(GetHasDisspellableNegativeProtections(oLastSpellTarget))
      {
        if(DispellFoe(oLastSpellTarget)) return TRUE;
      }
      else if(!GetHasEffect(EFFECT_TYPE_CURSE, oLastSpellTarget))
      {
        SetImmunity(OAI_IMMUNITY_CURSE, TRUE, oLastSpellTarget);
      }
    }
    if (ImmunityToCheck & OAI_IMMUNITY_POISON)
    {
      if(!GetHasEffect(EFFECT_TYPE_POISON, oLastSpellTarget))
      {
        SetImmunity(OAI_IMMUNITY_POISON, TRUE, oLastSpellTarget);
      }
    }
    if (ImmunityToCheck & OAI_IMMUNITY_FEAR)
    {
      if(GetHasDisspellableMentalProtections(oLastSpellTarget))
      {
        if(DispellFoe(oLastSpellTarget)) return TRUE;
      }
      else if(!GetHasEffect(EFFECT_TYPE_FRIGHTENED, oLastSpellTarget)
        && !GetHasEffect(EFFECT_TYPE_TURNED, oLastSpellTarget)
        && !GetHasEffect(EFFECT_TYPE_STUNNED, oLastSpellTarget)
        && !GetHasEffect(EFFECT_TYPE_PARALYZE, oLastSpellTarget)
        && !GetHasEffect(EFFECT_TYPE_DAZED, oLastSpellTarget))
      {
        SetImmunity(OAI_IMMUNITY_FEAR, TRUE, oLastSpellTarget);
      }
    }
    if (ImmunityToCheck & OAI_IMMUNITY_BLIND)
    {
      if(GetHasDisspellableSightProtections(oLastSpellTarget))
      {
        if(DispellFoe(oLastSpellTarget)) return TRUE;
      }
      else if(!GetHasEffect(EFFECT_TYPE_BLINDNESS, oLastSpellTarget)
        && !GetHasEffect(EFFECT_TYPE_DARKNESS, oLastSpellTarget)
        && !GetHasEffect(EFFECT_TYPE_DEAF, oLastSpellTarget))
      {
        SetImmunity(OAI_IMMUNITY_BLIND, TRUE, oLastSpellTarget);
      }
    }
    if (ImmunityToCheck & OAI_IMMUNITY_DAZE)
    {
      if(GetHasDisspellableMentalProtections(oLastSpellTarget))
      {
        if(DispellFoe(oLastSpellTarget)) return TRUE;
      }
      else if(!GetHasEffect(EFFECT_TYPE_STUNNED, oLastSpellTarget)
        && !GetHasEffect(EFFECT_TYPE_PARALYZE, oLastSpellTarget)
        && !GetHasEffect(EFFECT_TYPE_DAZED, oLastSpellTarget)
        && !GetHasEffect(EFFECT_TYPE_DOMINATED, oLastSpellTarget))
      {
        SetImmunity(OAI_IMMUNITY_DAZE, TRUE, oLastSpellTarget);
      }
    }
    if (ImmunityToCheck & OAI_IMMUNITY_DISEASE)
    {
      if(!GetHasEffect(EFFECT_TYPE_DISEASE, oLastSpellTarget)
        && !GetHasEffect(EFFECT_TYPE_POISON, oLastSpellTarget))
      {
        SetImmunity(OAI_IMMUNITY_DISEASE, TRUE, oLastSpellTarget);
      }
    }
    if (ImmunityToCheck & OAI_IMMUNITY_MOVEMENT)
    {
      if(!GetHasEffect(EFFECT_TYPE_MOVEMENT_SPEED_DECREASE, oLastSpellTarget)
        && !GetHasEffect(EFFECT_TYPE_ENTANGLE, oLastSpellTarget))
      {
        SetImmunity(OAI_IMMUNITY_MOVEMENT, TRUE, oLastSpellTarget);
      }
    }
    if (ImmunityToCheck & OAI_IMMUNITY_SLEEP)
    {
      if(GetHasDisspellableMentalProtections(oLastSpellTarget))
      {
        if(DispellFoe(oLastSpellTarget)) return TRUE;
      }
      else if(!GetHasEffect(EFFECT_TYPE_SLEEP, oLastSpellTarget))
      {
        SetImmunity(OAI_IMMUNITY_SLEEP, TRUE, oLastSpellTarget);
      }
    }
    if (ImmunityToCheck & OAI_IMMUNITY_SLOW)
    {
      if(!GetHasEffect(EFFECT_TYPE_SLOW, oLastSpellTarget))
      {
        SetImmunity(EFFECT_TYPE_SLOW, TRUE, oLastSpellTarget);
      }
    }
    if (ImmunityToCheck & OAI_IMMUNITY_PETRIFY)
    {
      if(!GetHasEffect(EFFECT_TYPE_PETRIFY, oLastSpellTarget))
      {
        SetImmunity(EFFECT_TYPE_PETRIFY, TRUE, oLastSpellTarget);
      }
    }

    //We did damage, no need to continue.
    if(iLastHPChanged) return FALSE;
    if (HasElementalProtections(oLastSpellTarget))
    {
      if(DispellFoe(oLastSpellTarget)) return TRUE;
      return FALSE;
    }
    if (ImmunityToCheck & OAI_IMMUNITY_FIRE) SetImmunity(OAI_IMMUNITY_FIRE, TRUE, oLastSpellTarget);
    if (ImmunityToCheck & OAI_IMMUNITY_ICE) SetImmunity(OAI_IMMUNITY_ICE, TRUE, oLastSpellTarget);
    if (ImmunityToCheck & OAI_IMMUNITY_ACID) SetImmunity(OAI_IMMUNITY_ACID, TRUE, oLastSpellTarget);
    if (ImmunityToCheck & OAI_IMMUNITY_NEGATIVE) SetImmunity(OAI_IMMUNITY_NEGATIVE, TRUE, oLastSpellTarget);
    if (ImmunityToCheck & OAI_IMMUNITY_ELECTRIC) SetImmunity(OAI_IMMUNITY_ELECTRIC, TRUE, oLastSpellTarget);
    if (ImmunityToCheck & OAI_IMMUNITY_POSITIVE) SetImmunity(OAI_IMMUNITY_POSITIVE, TRUE, oLastSpellTarget);
    return FALSE;
}

//LivingEffect - on oTarget and others of oTarget's faction
//  1. Harmful if Enemies, Helpful if Friends
//  2. Helps Enemies, Harms Friends
//UndeadEffect - on oTarget and others of oTarget's faction
//  1. Harmful if Enemies, Helpful if Friends
//  2. Helps Enemies, Harms Friends
location GetBestAOELocation(object oTarget, float SpellRadius, int LivingEffect = 1, int UndeadEffect = 1, int iLookingForEnemy = TRUE)
{
    ddp("GetBestAOELocation", oTarget);
    vector vEctor;
    vector vTemp;
    int iCount;
    location lTarget = GetLocation(oTarget);
    object oChk = GetFirstObjectInShape(SHAPE_SPHERE, SpellRadius, lTarget);
    while(GetIsObjectValid(oChk))
    {
      if(!GetIsDead(oChk) && GetIsEnemy(oChk) == iLookingForEnemy)
      {
        if(GetRacialType(oChk)==RACIAL_TYPE_UNDEAD)
        {
          if(UndeadEffect == 1)
          {
            iCount++;
            vTemp = GetPosition(oChk);
            vEctor.x += vTemp.x;
            vEctor.y += vTemp.y;
            vEctor.z += vTemp.z;
          }
        }
        else
        {
          if(LivingEffect == 1)
          {
            iCount++;
            vTemp = GetPosition(oChk);
            vEctor.x += vTemp.x;
            vEctor.y += vTemp.y;
            vEctor.z += vTemp.z;
          }
        }
      }
      oChk = GetNextObjectInShape(SHAPE_SPHERE, SpellRadius, lTarget);
    }
    if(iCount == 0)
    {
      if(iLookingForEnemy) return lTarget;
      return GetLocation(OBJECT_SELF);
    }
    vEctor.x /= iCount;
    vEctor.y /= iCount;
    vEctor.z /= iCount;
    return Location(oArea, vEctor, 0.0);
}

location ConsiderFriendlyFire(location lEnemy, location lAlly, float SpellRadius)
{
    ddp("ConsiderFriendlyFire", OBJECT_SELF);
    if(GetDistanceBetweenLocations(lEnemy, lAlly) > SpellRadius) return lEnemy;
    float fISlope;
    vector vAlly = GetPositionFromLocation(lAlly);
    vector vEnemy = GetPositionFromLocation(lEnemy);
    vector vTemp = vAlly - vEnemy;
    vTemp.x = vEnemy.x - vAlly.x;
    vTemp.y = vEnemy.y - vAlly.y;
    SpellRadius += 0.1; //put us just outside of range.
    if(vTemp.x == 0.0)
    {
      if(vAlly.y > vEnemy.y) vEnemy.y = vAlly.y - SpellRadius;
      else vEnemy.y = vAlly.y + SpellRadius;
      return Location(oArea, vEnemy, 0.0);
    }
    else if(vTemp.y == 0.0)
    {
      if(vAlly.x > vEnemy.x) vEnemy.x = vAlly.x - SpellRadius;
      else vEnemy.x = vAlly.x + SpellRadius;
      return Location(oArea, vEnemy, 0.0);
    }
    else
    {
      fISlope = vTemp.y / vTemp.x; //the inverse of the slope
      vTemp.x = sqrt(pow(SpellRadius, 2.0) / (1.0 + pow(fISlope, 2.0)));
      vTemp.y = vTemp.x * fISlope;
      if(vEnemy.x > vAlly.x) vEnemy.x = vAlly.x - vTemp.x;
      else vEnemy.x = vAlly.x + vTemp.x;
      if(vEnemy.y > vAlly.y) vEnemy.y = vAlly.y - vTemp.y;
      else vEnemy.y = vAlly.y + vTemp.y;
      return Location(oArea, vEnemy, 0.0);
    }
}

int CastSpellAtLocation(int SpellID, location lTarget, int TalentType, int SpellLevel, int ImmunityType = 0)
{
    ddp("CastSpellAtLocation", OBJECT_SELF, " Called, spell id: " + IntToString(SpellID));
    if(GetHasSpell(SpellID))
    {
      ddp("-CastSpellAtLocation", OBJECT_SELF, " Casting, spell id: " + IntToString(SpellID));
      ActionCastSpellAtLocation(SpellID, lTarget);
      SetLocalInt(OBJECT_SELF, "OAI_LASTSPELLTYPE", ImmunityType);
      WhatToDoAfterCasting(OBJECT_SELF, TalentType);
      return TRUE;
    }
    else
    {
      talent tSpell = GetCreatureTalentBest(TalentType, SpellLevel);
      if(GetIsTalentValid(tSpell) && GetTypeFromTalent(tSpell) == TALENT_TYPE_SPELL && GetIdFromTalent(tSpell) == SpellID)
      {
        ddp("-CastSpellAtLocation", OBJECT_SELF, " Talent Casting, spell id: " + IntToString(SpellID));
        ActionUseTalentAtLocation(tSpell, lTarget);
        SetLocalInt(OBJECT_SELF, "OAI_LASTSPELLTYPE", ImmunityType);
        WhatToDoAfterCasting(OBJECT_SELF, TalentType);
        return TRUE;
      }
    }
    return FALSE;
}

int UseBestOfATalent(int iTalent, object oNPC)
{
    ddp("UseBestOfATalent", oNPC, " Called, talent: " + IntToString(iTalent));
    talent tUse = GetCreatureTalentBest(iTalent, 20);
    if(GetIsTalentValid(tUse))
    {
      ddp("-UseBestOfATalent", oNPC, " Casting, talent: " + IntToString(iTalent));
      ActionUseTalentOnObject(tUse, oNPC);
      WhatToDoAfterCasting(oNPC, 0);
      return TRUE;
    }
    return FALSE;
}

int GetIsNotFighting(object oWho = OBJECT_SELF)
{
    if(GetBattleCondition(OAI_TRIGGER_HAS_BEEN_CAST, oWho)) return FALSE;
    if(oWho==OBJECT_SELF
      && !GetIsObjectValid(GetAttemptedAttackTarget())
      && !GetIsObjectValid(GetAttemptedSpellTarget()))
        return TRUE;
    return FALSE;
}

int GetIsThreat(object oNPC)
{
    ddp("GetIsThreat", oNPC);
    effect eCheck = GetFirstEffect(oNPC);
    int iEffect;
    while(GetIsEffectValid(eCheck))
    {
      iEffect = GetEffectType(eCheck);
      if( iEffect == EFFECT_TYPE_FRIGHTENED
        || iEffect == EFFECT_TYPE_SLEEP
        || iEffect == EFFECT_TYPE_PARALYZE
        || iEffect == EFFECT_TYPE_STUNNED
        || iEffect == EFFECT_TYPE_DAZED
        || iEffect == EFFECT_TYPE_PETRIFY
        || iEffect == EFFECT_TYPE_CUTSCENE_PARALYZE)
          return FALSE;
      eCheck = GetNextEffect(oNPC);
    }
    return TRUE;
}

int GetHasEffect(int fxType, object oNPC)
{
    ddp("GetHasEffect", oNPC, "Called, looking for: " + IntToString(fxType));
    effect fxChk = GetFirstEffect(oNPC);
    while(GetIsEffectValid(fxChk))
    {
      if(GetEffectType(fxChk) == fxType) return TRUE;
      fxChk = GetNextEffect(oNPC);
    }
    return FALSE;
}

int GetIsBusy(object oNPC)
{
    ddp("GetIsBusy", oNPC);
    int iAction = GetCurrentAction(oNPC);
    if(iAction == ACTION_PICKPOCKET
      || iAction == ACTION_OPENDOOR
      || iAction == ACTION_OPENLOCK
      || iAction == ACTION_TAUNT
      || iAction == ACTION_SETTRAP
      || iAction == ACTION_PICKUPITEM
      || iAction == ACTION_HEAL
      || iAction == ACTION_ANIMALEMPATHY)
        return TRUE;
    return FALSE;
}

int SpellKillRank(object oNPC)
{
    ddp("SpellKillRank", oNPC);
    if(!GetIsObjectValid(oNPC)) return -1000;
    if(oNPC == OBJECT_SELF || GetIsDead(oNPC) || !GetObjectSeen(oNPC)) return -900;
    if(!GetIsThreat(oNPC)) return 1;
    return ((GetCurrentHitPoints(oNPC) * OAI_SPELL_HP_MULTIPLIER) +
       (GetAC(oNPC) * OAI_SPELL_AC_MULTIPLIER) -
       ((GetFortitudeSavingThrow(oNPC) + GetReflexSavingThrow(oNPC) +
         GetWillSavingThrow(oNPC)) * OAI_SPELL_SAVES_MULTIPLIER) + 500) /
       (GetIsObjectValid(GetMaster(oNPC)) + 1);
}

object DetermineSpellEnemy(object oLastAttack, object oSpecified)
{
    object oTarget = GetNearestCreature(CREATURE_TYPE_REPUTATION, REPUTATION_TYPE_ENEMY, OBJECT_SELF, 1, CREATURE_TYPE_PERCEPTION, PERCEPTION_SEEN, CREATURE_TYPE_IS_ALIVE, TRUE);
    ddp("DetermineSpellEnemy", oTarget);
    object oAttacker = GetLastDamager(); //who attacked me last.
    object oPain = GetLocalObject(OBJECT_SELF, "OAI_I_HATE_");
    object oVeride = GetLocalObject(OBJECT_SELF, "OAI_OVERRIDE_TARGET");
    int iCounter = 2;
    object oTemp = GetNearestCreature(CREATURE_TYPE_REPUTATION, REPUTATION_TYPE_ENEMY, OBJECT_SELF, iCounter, CREATURE_TYPE_PERCEPTION, PERCEPTION_SEEN, CREATURE_TYPE_IS_ALIVE, TRUE);

    while(GetIsObjectValid(oTemp) && iCounter < 4)
    {
      if(SpellKillRank(oTemp) > SpellKillRank(oTarget)) oTarget = oTemp;
      iCounter++;
      oTemp = GetNearestCreature(CREATURE_TYPE_REPUTATION, REPUTATION_TYPE_ENEMY, OBJECT_SELF, iCounter, CREATURE_TYPE_PERCEPTION, PERCEPTION_SEEN, CREATURE_TYPE_IS_ALIVE, TRUE);
    }
    ddp("-DetermineSpellEnemy", oTarget, "After Loop");

    if(SpellKillRank(oLastAttack) > SpellKillRank(oTarget)) oTarget = oLastAttack;
    if(SpellKillRank(oSpecified) > SpellKillRank(oTarget)) oTarget = oSpecified;
    if(SpellKillRank(oAttacker) > SpellKillRank(oTarget)) oTarget = oAttacker;
    if((SpellKillRank(oPain) * OAI_HATE_MULTIPLIER) > SpellKillRank(oTarget)) oTarget = oPain;
    if(GetIsDead(oPain)) DeleteLocalObject(OBJECT_SELF, "OAI_I_HATE_");
    if(SpellKillRank(oVeride) > 0)
    {
      if(d2() == 1) DeleteLocalObject(OBJECT_SELF, "OAI_OVERRIDE_TARGET");
      SetLocalObject(OBJECT_SELF, "OAI_LASTTARGET", oVeride);
      ddp("-DetermineSpellEnemy", oVeride, "Override");
      return oVeride;
    }
    SetLocalObject(OBJECT_SELF, "OAI_LASTTARGET", oTarget);

    if(SpellKillRank(oTarget) < 0)
    {
      if(GetIsObjectValid(oSpecified) && oSpecified != OBJECT_SELF)
      {
        SetLocalObject(OBJECT_SELF, "OAI_LASTTARGET", oSpecified);
        ddp("-DetermineSpellEnemy", oSpecified, "Specified.");
        return oSpecified;
      }
      DeleteLocalObject(OBJECT_SELF, "OAI_LASTTARGET");
      ddp("-DetermineSpellEnemy", OBJECT_SELF, "no target found.");
      return OBJECT_INVALID;
    }
    ddp("-DetermineSpellEnemy", oTarget, "Targeted.");
    return oTarget;
}

int KillRank(object oNPC)
{
    ddp("KillRank", oNPC);
    if(!GetIsObjectValid(oNPC)) return 90000;
    if(oNPC == OBJECT_SELF || GetIsDead(oNPC) || !GetObjectSeen(oNPC)) return 80000;
    if(!GetIsThreat(oNPC)) return 70000;
    return ((GetCurrentHitPoints(oNPC) * OAI_HP_MULTIPLIER) +
       (GetAC(oNPC) * OAI_AC_MULTIPLIER) +
       (FloatToInt(GetDistanceToObject(oNPC)) * OAI_DISTANCE_MULTIPLIER)) *
       (GetIsObjectValid(GetMaster(oNPC)) + 1);
}

object DetermineEnemy(object oLastAttack, object oSpecified)
{
    object oTarget = GetNearestCreature(CREATURE_TYPE_REPUTATION, REPUTATION_TYPE_ENEMY, OBJECT_SELF, 1, CREATURE_TYPE_PERCEPTION, PERCEPTION_SEEN, CREATURE_TYPE_IS_ALIVE, TRUE);
    ddp("DetermineEnemy", oTarget);
    object oAttacker = GetLastDamager();
    object oPain = GetLocalObject(OBJECT_SELF, "OAI_I_HATE_");
    object oVeride = GetLocalObject(OBJECT_SELF, "OAI_OVERRIDE_TARGET");
    int iCounter = 2;
    object oTemp = GetNearestCreature(CREATURE_TYPE_REPUTATION, REPUTATION_TYPE_ENEMY, OBJECT_SELF, iCounter, CREATURE_TYPE_PERCEPTION, PERCEPTION_SEEN, CREATURE_TYPE_IS_ALIVE, TRUE);

    while(GetIsObjectValid(oTemp) && iCounter < 4 && GetDistanceToObject(oTemp) < 5.0)
    {
      if(KillRank(oTemp) < KillRank(oTarget)) oTarget = oTemp;
      iCounter++;
      oTemp = GetNearestCreature(CREATURE_TYPE_REPUTATION, REPUTATION_TYPE_ENEMY, OBJECT_SELF, iCounter, CREATURE_TYPE_PERCEPTION, PERCEPTION_SEEN, CREATURE_TYPE_IS_ALIVE, TRUE);
    }
    ddp("DetermineEnemy", oTarget, "After loop");

    if(KillRank(oLastAttack) < KillRank(oTarget)) oTarget = oLastAttack;
    if(KillRank(oSpecified) < KillRank(oTarget)) oTarget = oSpecified;
    if(KillRank(oAttacker) < KillRank(oTarget)) oTarget = oAttacker;
    if(KillRank(oPain) < (KillRank(oTarget) * OAI_HATE_MULTIPLIER)) oTarget = oPain;
    if(GetIsDead(oPain)) DeleteLocalObject(OBJECT_SELF, "OAI_I_HATE_");
    if(KillRank(oVeride) < 80000)
    {
      if(d2() == 1) DeleteLocalObject(OBJECT_SELF, "OAI_OVERRIDE_TARGET");
      SetLocalObject(OBJECT_SELF, "OAI_LASTTARGET", oVeride);
      ddp("-DetermineEnemy", oVeride, "Override");
      return oVeride;
    }
    SetLocalObject(OBJECT_SELF, "OAI_LASTTARGET", oTarget);

    if(KillRank(oTarget) > 70000)
    {
      if(GetIsObjectValid(oSpecified) && oSpecified != OBJECT_SELF)
      {
        SetLocalObject(OBJECT_SELF, "OAI_LASTTARGET", oSpecified);
        ddp("-DetermineEnemy", oSpecified, "Specified");
        return oSpecified;
      }
      DeleteLocalObject(OBJECT_SELF, "OAI_LASTTARGET");
      ddp("-DetermineEnemy", OBJECT_SELF, "No Target");
      return OBJECT_INVALID;
    }
    ddp("-DetermineEnemy", oTarget, "Targets");
    return oTarget;
}

int CastRezOn(object oTarget)
{
    ddp("CastRezOn", oTarget);

    if(DoCastSpellAtObject(SPELL_RESURRECTION, oTarget, 7, 14, 0, 0, FALSE, TRUE))
    {
      if(d2() == 1) ActionDoCommand(PlayVoiceChat(VOICE_CHAT_THANKS, oTarget));
      ActionDoCommand(ExecuteScript("f_entercombat", oTarget));
      return TRUE;
    }
    if(DoCastSpellAtObject(SPELL_RAISE_DEAD, oTarget, 7, 10, 0, FALSE, TRUE))
    {
      if(d2() == 1) ActionDoCommand(PlayVoiceChat(VOICE_CHAT_THANKS, oTarget));
      ActionDoCommand(ExecuteScript("oai_entercombat", oTarget));
      return TRUE;
    }
    return FALSE;
}

int DetermineAllyToRez()
{
    if(!GetStatusCondition(OAI_I_CAN_RAISE_DEAD)) return FALSE;
    ddp("DetermineAllyToRez", OBJECT_SELF);
    object oAlly = GetLocalObject(OBJECT_SELF, "OAI_RAISE_TARGET");
    DeleteLocalObject(OBJECT_SELF, "OAI_RAISE_TARGET");
    if(GetIsObjectValid(oAlly)
      && GetDistanceToObject(oAlly) < 30.0
      && !GetLocalInt(oAlly, "OAI_REALLY_DEAD"))
    {
      if(CastRezOn(oAlly)) return TRUE;
      SetStatusCondition(OAI_I_CAN_RAISE_DEAD, FALSE);
      return FALSE;
    }
    oAlly = GetNearestCreature(CREATURE_TYPE_REPUTATION, REPUTATION_TYPE_FRIEND, OBJECT_SELF, 1, CREATURE_TYPE_IS_ALIVE, FALSE);
    if(GetIsObjectValid(oAlly)
      && GetDistanceToObject(oAlly) < 30.0
      && !GetLocalInt(oAlly, "OAI_REALLY_DEAD"))
    {
      if(CastRezOn(oAlly)) return TRUE;
      SetStatusCondition(OAI_I_CAN_RAISE_DEAD, FALSE);
    }
    return FALSE;
}

void ICouldUseAHeal()
{
    ddp("ICouldUseAHeal", OBJECT_SELF);
    SpeakString("OAI_HEAL_PLEASE", TALKVOLUME_SILENT_TALK);
    if(GetCurrentHitPoints(OBJECT_SELF) * 10 < GetMaxHitPoints(OBJECT_SELF) && d2()==1) PlayVoiceChat(VOICE_CHAT_NEARDEATH);
}

object DetermineAllyToHeal()
{
    ddp("DetermineAllyToHeal", OBJECT_SELF);
    object oAlly = GetLocalObject(OBJECT_SELF, "OAI_HEAL_TARGET");
    DeleteLocalObject(OBJECT_SELF, "OAI_HEAL_TARGET");
    if(GetIsObjectValid(oAlly) && !GetIsDead(oAlly) && GetDistanceToObject(oAlly) < 30.0) return oAlly;
    return OBJECT_INVALID;
}

int HealOthers()
{
    int iCanHealLiving = GetStatusCondition(OAI_I_CAN_HEAL_LIVING);
    int iCanHealUndead = GetStatusCondition(OAI_I_CAN_HEAL_UNDEAD);
    if (!iCanHealLiving && !iCanHealUndead) return FALSE;
    ddp("HealOthers", OBJECT_SELF);

    object oTarget = DetermineAllyToHeal();
    location lTarget;
    if(GetIsObjectValid(oTarget))
    {
      ddp("-HealOthers", oTarget, "Target");
      if(GetRacialType(oTarget)==RACIAL_TYPE_UNDEAD)
      {
        if (!iCanHealUndead) return FALSE;
        if(HasSpell(SPELL_NATURES_BALANCE, 1, 16))
        {
          lTarget = GetBestAOELocation(oTarget, 5.0, 1, 1, FALSE);
          if(ShouldICast(lTarget, 5.0, 2, SHAPE_SPHERE, 2))
          {
            if(CastSpellAtLocation(SPELL_NATURES_BALANCE, lTarget, 1, 16)) return TRUE;
          }
        }
        if(HasSpell(SPELL_CIRCLE_OF_DOOM, 1, 10))
        {
          lTarget = GetBestAOELocation(oTarget, 3.33, 2, 1, FALSE);
          if(ShouldICast(lTarget, 3.33, 2, SHAPE_SPHERE, 2))
          {
            if(CastSpellAtLocation(SPELL_CIRCLE_OF_DOOM, lTarget, 1, 10)) return TRUE;
          }
        }
        if(HasSpell(SPELL_NEGATIVE_ENERGY_BURST, 1, 6))
        {
          lTarget = GetBestAOELocation(oTarget, 6.67, 2, 1, FALSE);
          if(ShouldICast(lTarget, 6.67, 2, SHAPE_SPHERE, 2))
          {
            if(CastSpellAtLocation(SPELL_NEGATIVE_ENERGY_BURST, lTarget, TALENT_CATEGORY_HARMFUL_AREAEFFECT_DISCRIMINANT, 6)) return TRUE;
          }
        }
        if(DoCastSpellAtObject(SPELL_HARM, oTarget, TALENT_CATEGORY_HARMFUL_TOUCH, 14, 0, FALSE, TRUE)) return TRUE;
        if(DoCastSpellAtObject(SPELL_INFLICT_CRITICAL_WOUNDS, oTarget, TALENT_CATEGORY_HARMFUL_TOUCH, 8, 0, FALSE, TRUE)) return TRUE;
        if(DoCastSpellAtObject(SPELL_INFLICT_SERIOUS_WOUNDS, oTarget, TALENT_CATEGORY_HARMFUL_TOUCH, 6, 0, FALSE, TRUE)) return TRUE;
        if(DoCastSpellAtObject(SPELL_NEGATIVE_ENERGY_BURST, oTarget, TALENT_CATEGORY_HARMFUL_AREAEFFECT_DISCRIMINANT, 6, 0, FALSE, TRUE)) return TRUE;
        if(DoCastSpellAtObject(SPELL_INFLICT_MODERATE_WOUNDS, oTarget, TALENT_CATEGORY_HARMFUL_TOUCH, 6, 0, FALSE, TRUE)) return TRUE;
        if(DoCastSpellAtObject(SPELL_INFLICT_LIGHT_WOUNDS, oTarget, TALENT_CATEGORY_HARMFUL_TOUCH, 4, 0, FALSE, TRUE)) return TRUE;
        if(DoCastSpellAtObject(SPELL_NEGATIVE_ENERGY_RAY, oTarget, TALENT_CATEGORY_HARMFUL_RANGED, 4, 0, FALSE, TRUE)) return TRUE;
        if(DoCastSpellAtObject(SPELL_INFLICT_MINOR_WOUNDS, oTarget, TALENT_CATEGORY_HARMFUL_TOUCH, 2, 0, FALSE, TRUE)) return TRUE;
        SetStatusCondition(OAI_I_CAN_HEAL_UNDEAD, FALSE);
      }
      else
      {
        if (!iCanHealLiving) return FALSE;
        if(HasSpell(SPELL_MASS_HEAL, 4, 16))
        {
          lTarget = GetBestAOELocation(oTarget, 3.33, 2, 1, FALSE);
          if(ShouldICast(lTarget, 3.33, 2, SHAPE_SPHERE, 2, 3))
          {
            if(CastSpellAtLocation(SPELL_MASS_HEAL, lTarget, 4, 16)) return TRUE;
          }
        }
        if(HasSpell(SPELL_NATURES_BALANCE, 1, 16) || HasSpell(SPELL_HEALING_CIRCLE, 4, 10))
        {
          lTarget = GetBestAOELocation(oTarget, 5.0, 1, 1, FALSE);
          if(ShouldICast(lTarget, 5.0, 2, SHAPE_SPHERE, 2))
          {
            if(CastSpellAtLocation(SPELL_NATURES_BALANCE, lTarget, 1, 16)) return TRUE;
            if(CastSpellAtLocation(SPELL_HEALING_CIRCLE, lTarget, 4, 10)) return TRUE;
          }
        }
        if(DoCastSpellAtObject(SPELL_REGENERATE, oTarget, 10, 12, 0, FALSE, TRUE)) return TRUE;
        if(UseBestOfATalent(TALENT_CATEGORY_BENEFICIAL_HEALING_TOUCH, oTarget)) return TRUE;
        if(UseBestOfATalent(TALENT_CATEGORY_BENEFICIAL_HEALING_AREAEFFECT, oTarget)) return TRUE;
        SetStatusCondition(OAI_I_CAN_HEAL_LIVING, FALSE);
      }
    }
    ddp("-HealOthers", oTarget, "Failed");
    return FALSE;
}

int HealSelf(int noEnemyOverride = FALSE)
{
    if (!noEnemyOverride && (GetCurrentHitPoints() * 2) > GetMaxHitPoints()) return FALSE;
    ddp("HealSelf", OBJECT_SELF);
    if(GetStatusCondition(OAI_I_HAVE_HEALING_POTIONS))
    {
      if(UseBestOfATalent(TALENT_CATEGORY_BENEFICIAL_HEALING_POTION, OBJECT_SELF)) return TRUE;
      if(UseBestOfATalent(TALENT_CATEGORY_BENEFICIAL_HEALING_TOUCH, OBJECT_SELF)) return TRUE;
      SetStatusCondition(OAI_I_HAVE_HEALING_POTIONS, FALSE);
    }
    ICouldUseAHeal();
    ddp("-HealSelf", OBJECT_SELF, "Failed.");
    return FALSE;
}

void CastTriggers()
{
    int iX;
    int HowMany = 0;
    int iCounter = 0;
    int iRandomMode;
    if(GetBattleCondition(OAI_TRIGGER_HAS_BEEN_CAST)) return;
    SetBattleCondition(OAI_TRIGGER_HAS_BEEN_CAST);
    ddp("CastTriggers", OBJECT_SELF);

    //Battlecries!
    switch (Random(12))
    {
      case 0: PlayVoiceChat(VOICE_CHAT_BATTLECRY1); break;
      case 1: PlayVoiceChat(VOICE_CHAT_BATTLECRY2); break;
      case 2: PlayVoiceChat(VOICE_CHAT_BATTLECRY3); break;
      case 3: PlayVoiceChat(VOICE_CHAT_ATTACK); break;
    }

    //Setting the following variable automatically casts the auras
    SetBattleCondition(OAI_CAST_AURAS_NOW);
    if(GetBattleCondition(OAI_FAST_BUFF_SUMMON)) iCounter = CastSummon(OBJECT_SELF, TRUE);
    if(GetBattleCondition(OAI_FAST_BUFF_COMPLETE))
    {
      iRandomMode=FALSE;
      HowMany=1;
      iCounter = 0;
    }
    else if(GetBattleCondition(OAI_FAST_BUFF_RANDOM))
    {
      iRandomMode=TRUE;
      iX = Random(30) + 1;
      HowMany = ((Random(MyHD) + 1) / OAI_RANDOM_BUFF_DIVISOR);
    }
    while (iCounter < HowMany)
    {
      iCounter++;
      if(iRandomMode)iX = Random(98);
      switch (iX)
      {
        case 0: if(DoCastSpellAtObject(SPELLABILITY_INTENSITY_1, OBJECT_SELF, 0, 0, 0, TRUE, TRUE)) if(iRandomMode) break;
        case 1: if(DoCastSpellAtObject(SPELLABILITY_FEROCITY_1, OBJECT_SELF, 0, 0, 0, TRUE, TRUE)) if(iRandomMode) break;
        case 2: if(DoCastSpellAtObject(SPELLABILITY_RAGE_3, OBJECT_SELF, 0, 0, 0, TRUE, TRUE)) if(iRandomMode) break;
        case 3: if(DoCastSpellAtObject(SPELLABILITY_INTENSITY_2, OBJECT_SELF, 0, 0, 0, TRUE, TRUE)) if(iRandomMode) break;
        case 4: if(DoCastSpellAtObject(SPELLABILITY_FEROCITY_2, OBJECT_SELF, 0, 0, 0, TRUE, TRUE)) if(iRandomMode) break;
        case 5: if(DoCastSpellAtObject(SPELLABILITY_RAGE_4, OBJECT_SELF, 0, 0, 0, TRUE, TRUE)) if(iRandomMode) break;
        case 6: if(DoCastSpellAtObject(SPELLABILITY_INTENSITY_3, OBJECT_SELF, 0, 0, 0, TRUE, TRUE)) if(iRandomMode) break;
        case 7: if(DoCastSpellAtObject(SPELLABILITY_FEROCITY_3, OBJECT_SELF, 0, 0, 0, TRUE, TRUE)) if(iRandomMode) break;
        case 8: if(DoCastSpellAtObject(SPELLABILITY_RAGE_5, OBJECT_SELF, 0, 0, 0, TRUE, TRUE)) if(iRandomMode) break;
        case 9: if(DoCastSpellAtObject(SPELL_AID, OBJECT_SELF, 0, 0, 0, TRUE, TRUE)) if(iRandomMode) break;
        case 10: if(DoCastSpellAtObject(SPELL_BARKSKIN, OBJECT_SELF, 0, 0, 0, TRUE, TRUE)) if(iRandomMode) break;
        case 11: if(DoCastSpellAtObject(SPELL_BLESS, OBJECT_SELF, 0, 0, 0, TRUE, TRUE)) if(iRandomMode) break;
        case 12: if(DoCastSpellAtObject(SPELL_BULLS_STRENGTH, OBJECT_SELF, 0, 0, 0, TRUE, TRUE)) if(iRandomMode) break;
        case 13: if(DoCastSpellAtObject(SPELL_CATS_GRACE, OBJECT_SELF, 0, 0, 0, TRUE, TRUE)) if(iRandomMode) break;
        case 14: if(DoCastSpellAtObject(SPELL_CLAIRAUDIENCE_AND_CLAIRVOYANCE, OBJECT_SELF, 0, 0, 0, TRUE, TRUE)) if(iRandomMode) break;
        case 15: if(DoCastSpellAtObject(SPELL_CLARITY, OBJECT_SELF, 0, 0, 0, TRUE, TRUE)) if(iRandomMode) break;
        case 16: if(DoCastSpellAtObject(SPELL_DARKVISION, OBJECT_SELF, 0, 0, 0, TRUE, TRUE)) if(iRandomMode) break;
        case 17: if(DoCastSpellAtObject(SPELL_DEATH_WARD, OBJECT_SELF, 0, 0, 0, TRUE, TRUE)) if(iRandomMode) break;
        case 18: if(DoCastSpellAtObject(SPELL_EAGLE_SPLEDOR, OBJECT_SELF, 0, 0, 0, TRUE, TRUE)) if(iRandomMode) break;
        case 19: if(DoCastSpellAtObject(SPELL_ELEMENTAL_SHIELD, OBJECT_SELF, 0, 0, 0, TRUE, TRUE)) if(iRandomMode) break;
        case 20: if(DoCastSpellAtObject(SPELL_ENDURANCE, OBJECT_SELF, 0, 0, 0, TRUE, TRUE)) if(iRandomMode) break;
        case 21: if(DoCastSpellAtObject(SPELL_ENDURE_ELEMENTS, OBJECT_SELF, 0, 0, 0, TRUE, TRUE)) if(iRandomMode) break;
        case 22: if(DoCastSpellAtObject(SPELL_ENERGY_BUFFER, OBJECT_SELF, 0, 0, 0, TRUE, TRUE)) if(iRandomMode) break;
        case 23: if(DoCastSpellAtObject(SPELL_ETHEREAL_VISAGE, OBJECT_SELF, 0, 0, 0, TRUE, TRUE)) if(iRandomMode) break;
        case 24: if(DoCastSpellAtObject(SPELL_FOXS_CUNNING, OBJECT_SELF, 0, 0, 0, TRUE, TRUE)) if(iRandomMode) break;
        case 25: if(DoCastSpellAtObject(SPELL_FREEDOM_OF_MOVEMENT, OBJECT_SELF, 0, 0, 0, TRUE, TRUE)) if(iRandomMode) break;
        case 26: if(DoCastSpellAtObject(SPELL_GHOSTLY_VISAGE, OBJECT_SELF, 0, 0, 0, TRUE, TRUE)) if(iRandomMode) break;
        case 27: if(DoCastSpellAtObject(SPELL_GLOBE_OF_INVULNERABILITY, OBJECT_SELF, 0, 0, 0, TRUE, TRUE)) if(iRandomMode) break;
        case 28: if(DoCastSpellAtObject(SPELL_GREATER_BULLS_STRENGTH, OBJECT_SELF, 0, 0, 0, TRUE, TRUE)) if(iRandomMode) break;
        case 29: if(DoCastSpellAtObject(SPELL_GREATER_CATS_GRACE, OBJECT_SELF, 0, 0, 0, TRUE, TRUE)) if(iRandomMode) break;
        case 30: if(DoCastSpellAtObject(SPELL_GREATER_EAGLE_SPLENDOR, OBJECT_SELF, 0, 0, 0, TRUE, TRUE)) if(iRandomMode) break;
        case 31: if(DoCastSpellAtObject(SPELL_GREATER_ENDURANCE, OBJECT_SELF, 0, 0, 0, TRUE, TRUE)) if(iRandomMode) break;
        case 32: if(DoCastSpellAtObject(SPELL_GREATER_FOXS_CUNNING, OBJECT_SELF, 0, 0, 0, TRUE, TRUE)) if(iRandomMode) break;
        case 33: if(DoCastSpellAtObject(SPELL_GREATER_OWLS_WISDOM, OBJECT_SELF, 0, 0, 0, TRUE, TRUE)) if(iRandomMode) break;
        case 34: if(DoCastSpellAtObject(SPELL_GREATER_SPELL_MANTLE, OBJECT_SELF, 0, 0, 0, TRUE, TRUE)) if(iRandomMode) break;
        case 35: if(DoCastSpellAtObject(SPELL_HASTE, OBJECT_SELF, 0, 0, 0, TRUE, TRUE)) if(iRandomMode) break;
        case 36: if(DoCastSpellAtObject(SPELL_IMPROVED_INVISIBILITY, OBJECT_SELF, 0, 0, 0, TRUE, TRUE)) if(iRandomMode) break;
        case 37: if(DoCastSpellAtObject(SPELL_INVISIBILITY, OBJECT_SELF, 0, 0, 0, TRUE, TRUE)) if(iRandomMode) break;
        case 38: if(DoCastSpellAtObject(SPELL_INVISIBILITY_SPHERE, OBJECT_SELF, 0, 0, 0, TRUE, TRUE)) if(iRandomMode) break;
        case 39: if(DoCastSpellAtObject(SPELL_LESSER_SPELL_MANTLE, OBJECT_SELF, 0, 0, 0, TRUE, TRUE)) if(iRandomMode) break;
        case 40: if(DoCastSpellAtObject(SPELL_LIGHT, OBJECT_SELF, 0, 0, 0, TRUE, TRUE)) if(iRandomMode) break;
        case 41: if(DoCastSpellAtObject(SPELL_MAGE_ARMOR, OBJECT_SELF, 0, 0, 0, TRUE, TRUE)) if(iRandomMode) break;
        case 42: if(DoCastSpellAtObject(SPELL_MASS_HASTE, OBJECT_SELF, 0, 0, 0, TRUE, TRUE)) if(iRandomMode) break;
        case 43: if(DoCastSpellAtObject(SPELL_MIND_BLANK, OBJECT_SELF, 0, 0, 0, TRUE, TRUE)) if(iRandomMode) break;
        case 44: if(DoCastSpellAtObject(SPELL_MINOR_GLOBE_OF_INVULNERABILITY, OBJECT_SELF, 0, 0, 0, TRUE, TRUE)) if(iRandomMode) break;
        case 45: if(DoCastSpellAtObject(SPELL_NEGATIVE_ENERGY_PROTECTION, OBJECT_SELF, 0, 0, 0, TRUE, TRUE)) if(iRandomMode) break;
        case 46: if(DoCastSpellAtObject(SPELL_OWLS_WISDOM, OBJECT_SELF, 0, 0, 0, TRUE, TRUE)) if(iRandomMode) break;
        case 47: if(DoCastSpellAtObject(SPELL_PRAYER, OBJECT_SELF, 0, 0, 0, TRUE, TRUE)) if(iRandomMode) break;
        case 48: if(DoCastSpellAtObject(SPELL_PREMONITION, OBJECT_SELF, 0, 0, 0, TRUE, TRUE)) if(iRandomMode) break;
        case 49: if(DoCastSpellAtObject(SPELL_PROTECTION__FROM_CHAOS, OBJECT_SELF, 0, 0, 0, TRUE, TRUE)) if(iRandomMode) break;
        case 50: if(DoCastSpellAtObject(SPELL_PROTECTION_FROM_ELEMENTS, OBJECT_SELF, 0, 0, 0, TRUE, TRUE)) if(iRandomMode) break;
        case 51: if(DoCastSpellAtObject(SPELL_PROTECTION_FROM_EVIL, OBJECT_SELF, 0, 0, 0, TRUE, TRUE)) if(iRandomMode) break;
        case 52: if(DoCastSpellAtObject(SPELL_PROTECTION_FROM_GOOD, OBJECT_SELF, 0, 0, 0, TRUE, TRUE)) if(iRandomMode) break;
        case 53: if(DoCastSpellAtObject(SPELL_PROTECTION_FROM_LAW, OBJECT_SELF, 0, 0, 0, TRUE, TRUE)) if(iRandomMode) break;
        case 54: if(DoCastSpellAtObject(SPELL_PROTECTION_FROM_SPELLS, OBJECT_SELF, 0, 0, 0, TRUE, TRUE)) if(iRandomMode) break;
        case 55: if(DoCastSpellAtObject(SPELL_REGENERATE, OBJECT_SELF, 0, 0, 0, TRUE, TRUE)) if(iRandomMode) break;
        case 56: if(DoCastSpellAtObject(SPELL_RESISTANCE, OBJECT_SELF, 0, 0, 0, TRUE, TRUE)) if(iRandomMode) break;
        case 57: if(DoCastSpellAtObject(SPELL_SANCTUARY, OBJECT_SELF, 0, 0, 0, TRUE, TRUE)) if(iRandomMode) break;
        case 58: if(DoCastSpellAtObject(SPELL_SEE_INVISIBILITY, OBJECT_SELF, 0, 0, 0, TRUE, TRUE)) if(iRandomMode) break;
        case 59: if(DoCastSpellAtObject(SPELL_SHADOW_SHIELD, OBJECT_SELF, 0, 0, 0, TRUE, TRUE)) if(iRandomMode) break;
        case 60: if(DoCastSpellAtObject(SPELL_SHIELD_OF_LAW, OBJECT_SELF, 0, 0, 0, TRUE, TRUE)) if(iRandomMode) break;
        case 61: if(DoCastSpellAtObject(SPELL_SPELL_MANTLE, OBJECT_SELF, 0, 0, 0, TRUE, TRUE)) if(iRandomMode) break;
        case 62: if(DoCastSpellAtObject(SPELL_SPELL_RESISTANCE, OBJECT_SELF, 0, 0, 0, TRUE, TRUE)) if(iRandomMode) break;
        case 63: if(DoCastSpellAtObject(SPELL_SPHERE_OF_CHAOS, OBJECT_SELF, 0, 0, 0, TRUE, TRUE)) if(iRandomMode) break;
        case 64: if(DoCastSpellAtObject(SPELL_STONESKIN, OBJECT_SELF, 0, 0, 0, TRUE, TRUE)) if(iRandomMode) break;
        case 65: if(DoCastSpellAtObject(SPELL_TRUE_SEEING, OBJECT_SELF, 0, 0, 0, TRUE, TRUE)) if(iRandomMode) break;
        case 66: if(DoCastSpellAtObject(SPELL_VIRTUE, OBJECT_SELF, 0, 0, 0, TRUE, TRUE)) if(iRandomMode) break;
        case 67: if(DoCastSpellAtObject(SPELLABILITY_BATTLE_MASTERY, OBJECT_SELF, 0, 0, 0, TRUE, TRUE)) if(iRandomMode) break;
        case 68: if(DoCastSpellAtObject(SPELLABILITY_BARBARIAN_RAGE, OBJECT_SELF, 0, 0, 0, TRUE, TRUE)) if(iRandomMode) break;
        case 69: if(DoCastSpellAtObject(SPELLABILITY_DIVINE_PROTECTION, OBJECT_SELF, 0, 0, 0, TRUE, TRUE)) if(iRandomMode) break;
        case 70: if(DoCastSpellAtObject(SPELLABILITY_DIVINE_STRENGTH, OBJECT_SELF, 0, 0, 0, TRUE, TRUE)) if(iRandomMode) break;
        case 71: if(DoCastSpellAtObject(SPELLABILITY_DIVINE_TRICKERY, OBJECT_SELF, 0, 0, 0, TRUE, TRUE)) if(iRandomMode) break;
        case 72: if(DoCastSpellAtObject(SPELLABILITY_EMPTY_BODY, OBJECT_SELF, 0, 0, 0, TRUE, TRUE)) if(iRandomMode) break;
        case 73: if(DoCastSpellAtObject(SPELLABILITY_MUMMY_BOLSTER_UNDEAD, OBJECT_SELF, 0, 0, 0, TRUE, TRUE)) if(iRandomMode) break;
        case 74: if(DoCastSpellAtObject(SPELLABILITY_ROGUES_CUNNING, OBJECT_SELF, 0, 0, 0, TRUE, TRUE)) if(iRandomMode) break;
        case 75: if(DoCastSpellAtObject(SPELL_HOLY_AURA, OBJECT_SELF, 0, 0, 0, TRUE, TRUE)) if(iRandomMode) break;
        case 76: if(DoCastSpellAtObject(SPELL_UNHOLY_AURA, OBJECT_SELF, 0, 0, 0, TRUE, TRUE)) if(iRandomMode) break;
        case 77: if(DoCastSpellAtObject(SPELL_AURA_OF_VITALITY, OBJECT_SELF, 0, 0, 0, TRUE, TRUE)) if(iRandomMode) break;
        case 78: if(DoCastSpellAtObject(SPELL_WOUNDING_WHISPERS, OBJECT_SELF, 0, 0, 0, TRUE, TRUE)) if(iRandomMode) break;
        case 79: if(DoCastSpellAtObject(SPELL_DIVINE_FAVOR, OBJECT_SELF, 0, 0, 0, TRUE, TRUE)) if(iRandomMode) break;
        case 80: if(DoCastSpellAtObject(SPELL_ENDURE_ELEMENTS, OBJECT_SELF, 0, 0, 0, TRUE, TRUE)) if(iRandomMode) break;
        case 81: if(DoCastSpellAtObject(SPELL_SHIELD_OF_FAITH, OBJECT_SELF, 0, 0, 0, TRUE, TRUE)) if(iRandomMode) break;
        case 82: if(DoCastSpellAtObject(SPELL_ENTROPIC_SHIELD, OBJECT_SELF, 0, 0, 0, TRUE, TRUE)) if(iRandomMode) break;
        case 83: if(DoCastSpellAtObject(SPELL_CONTINUAL_FLAME, OBJECT_SELF, 0, 0, 0, TRUE, TRUE)) if(iRandomMode) break;
        case 84: if(DoCastSpellAtObject(SPELL_ETHEREALNESS, OBJECT_SELF, 0, 0, 0, TRUE, TRUE)) if(iRandomMode) break;
        case 85: if(DoCastSpellAtObject(SPELL_UNDEATHS_ETERNAL_FOE, OBJECT_SELF, 0, 0, 0, TRUE, TRUE)) if(iRandomMode) break;
        case 86: if(DoCastSpellAtObject(SPELL_CAMOFLAGE, OBJECT_SELF, 0, 0, 0, TRUE, TRUE)) if(iRandomMode) break;
        case 87: if(DoCastSpellAtObject(SPELL_ONE_WITH_THE_LAND, OBJECT_SELF, 0, 0, 0, TRUE, TRUE)) if(iRandomMode) break;
        case 88: if(DoCastSpellAtObject(SPELL_BLOOD_FRENZY, OBJECT_SELF, 0, 0, 0, TRUE, TRUE)) if(iRandomMode) break;
        case 89: if(DoCastSpellAtObject(SPELL_MASS_CAMOFLAGE, OBJECT_SELF, 0, 0, 0, TRUE, TRUE)) if(iRandomMode) break;
        case 90: if(DoCastSpellAtObject(SPELL_AURAOFGLORY, OBJECT_SELF, 0, 0, 0, TRUE, TRUE)) if(iRandomMode) break;
        case 91: if(DoCastSpellAtObject(SPELL_SHIELD, OBJECT_SELF, 0, 0, 0, TRUE, TRUE)) if(iRandomMode) break;
        case 92: if(DoCastSpellAtObject(SPELL_TRUE_STRIKE, OBJECT_SELF, 0, 0, 0, TRUE, TRUE)) if(iRandomMode) break;
        case 93: if(DoCastSpellAtObject(SPELL_DISPLACEMENT, OBJECT_SELF, 0, 0, 0, TRUE, TRUE)) if(iRandomMode) break;
        case 94: if(DoCastSpellAtObject(SPELL_DIVINE_MIGHT, OBJECT_SELF, 0, 0, 0, TRUE, TRUE)) if(iRandomMode) break;
        case 95: if(DoCastSpellAtObject(SPELL_DIVINE_SHIELD, OBJECT_SELF, 0, 0, 0, TRUE, TRUE)) if(iRandomMode) break;
        case 96: if(DoCastSpellAtObject(SPELL_TYMORAS_SMILE, OBJECT_SELF, 0, 0, 0, TRUE, TRUE)) if(iRandomMode) break;
        case 97: if(DoCastSpellAtObject(SPELL_SHADOW_EVADE, OBJECT_SELF, 0, 0, 0, TRUE, TRUE)) if(iRandomMode) break;
      } //end switch
    } //end while
    if(!HasPhysicalProtections()) SetBattleCondition(OAI_I_NEED_BUFF_PHYSICAL);
    if(!HasMentalProtections()) SetBattleCondition(OAI_I_NEED_BUFF_MENTAL);
    if(!HasMagicProtections()) SetBattleCondition(OAI_I_NEED_BUFF_MAGIC);
    if(!HasElementalProtections()) SetBattleCondition(OAI_I_NEED_BUFF_ELEMENTAL);
    //vision is low priority, only check half the time...
    if(d2()==1 && !HasGoodEyes()) SetBattleCondition(OAI_I_NEED_BUFF_SIGHT);
}

int BuffSightOther(object oTemp)
{
    ddp("BuffSightOther", oTemp);
    if(DoCastSpellAtObject(SPELL_TRUE_SEEING, oTemp, 6, 12)) return TRUE;
    if(DoCastSpellAtObject(SPELL_SEE_INVISIBILITY, oTemp, 7, 4)) return TRUE;
    if(DoCastSpellAtObject(SPELL_CLAIRAUDIENCE_AND_CLAIRVOYANCE, oTemp, 6, 6)) return TRUE;
    if(DoCastSpellAtObject(SPELL_CONTINUAL_FLAME, oTemp, 4, 1)) return TRUE;
    if(DoCastSpellAtObject(SPELL_LIGHT, oTemp, 6, 1)) return TRUE;
    return FALSE;
}

int BuffCriticalOther(object oTemp)
{
    ddp("BuffCriticalOther", oTemp);
    if(DoCastSpellAtObject(SPELL_MASS_HASTE, oTemp, 12, 12, 0, FALSE, TRUE)) return TRUE;
    if(DoCastSpellAtObject(SPELL_HASTE, oTemp, 9, 6, 0, FALSE, TRUE)) return TRUE;
    if(DoCastSpellAtObject(SPELL_UNDEATHS_ETERNAL_FOE, oTemp, 9, 18, 0, FALSE, TRUE)) return TRUE;
    if(DoCastSpellAtObject(SPELL_DEATH_WARD, oTemp, 9, 10, 0, FALSE, TRUE)) return TRUE;
    return FALSE;
}

int BuffMagicSelf()
{
    ddp("BuffMagicSelf", OBJECT_SELF);
    if(DoCastSpellAtObject(SPELL_GREATER_SPELL_MANTLE, OBJECT_SELF, 12, 18, 0, FALSE, TRUE)) return TRUE;
    if(DoCastSpellAtObject(SPELL_PROTECTION_FROM_SPELLS, OBJECT_SELF, 12, 14, 0, FALSE, TRUE)) return TRUE;
    if(DoCastSpellAtObject(SPELL_SPELL_MANTLE, OBJECT_SELF, 12, 14, 0, FALSE, TRUE)) return TRUE;
    if(DoCastSpellAtObject(SPELL_GLOBE_OF_INVULNERABILITY, OBJECT_SELF, 12, 12, 0, FALSE, TRUE)) return TRUE;
    if(DoCastSpellAtObject(SPELL_LESSER_SPELL_MANTLE, OBJECT_SELF, 12, 10, 0, FALSE, TRUE)) return TRUE;
    if(DoCastSpellAtObject(SPELL_MINOR_GLOBE_OF_INVULNERABILITY, OBJECT_SELF, 12, 8, 0, FALSE, TRUE)) return TRUE;
    return FALSE;
}

int BuffMagicOther(object oTemp)
{
    ddp("BuffMagicOther", oTemp);
    if(DoCastSpellAtObject(SPELL_RESISTANCE, oTemp, 13, 10, 0, FALSE, TRUE)) return TRUE;
    if(GetRacialType(oTemp)!=RACIAL_TYPE_UNDEAD)
    {
      if(DoCastSpellAtObject(SPELL_NEGATIVE_ENERGY_PROTECTION, oTemp, 12, 6, 0, FALSE, TRUE)) return TRUE;
    }
    return FALSE;
}

int BuffMentalOther(object oTemp)
{
  ddp("BuffMentalOther", oTemp);
  if(DoCastSpellAtObject(SPELL_MIND_BLANK, oTemp, 9, 16, 0, FALSE, TRUE)) return TRUE;
  if(DoCastSpellAtObject(SPELL_LESSER_MIND_BLANK, oTemp, 9, 10, 0, FALSE, TRUE)) return TRUE;
  if(GetFactionEqual(oTemp)) if(DoCastSpellAtObject(SPELL_CLARITY, oTemp, 7, 6, 0, FALSE, TRUE)) return TRUE;
  return FALSE;
}

int BuffPhysicalOther(object oTemp)
{
    ddp("BuffPhysicalOther", oTemp);
    if(DoCastSpellAtObject(SPELL_AURA_OF_VITALITY, oTemp, 8, 14, 0, FALSE, TRUE)) return TRUE;
    if(DoCastSpellAtObject(SPELL_STONESKIN, oTemp, 13, 8, 0, FALSE, TRUE)) return TRUE;
    if(DoCastSpellAtObject(SPELL_IMPROVED_INVISIBILITY, oTemp, 9, 8, 0, FALSE, TRUE)) return TRUE;
    if(DoCastSpellAtObject(SPELL_AID, oTemp, 9, 6, 0, FALSE, TRUE)) return TRUE;
    if(DoCastSpellAtObject(SPELL_BARKSKIN, oTemp, 13, 4, 0, FALSE, TRUE)) return TRUE;
    if(DoCastSpellAtObject(SPELL_SHIELD_OF_FAITH, oTemp, 13, 2, 0, FALSE, TRUE)) return TRUE;
    if(DoCastSpellAtObject(SPELL_MAGE_ARMOR, oTemp, 13, 1, 0, FALSE, TRUE)) return TRUE;
    if(DoCastSpellAtObject(SPELL_REGENERATE, oTemp, 10, 14, 0, FALSE, TRUE)) return TRUE;
    if(DoCastSpellAtObject(SPELL_PRAYER, oTemp, 8, 6, 0, FALSE, TRUE)) return TRUE;
    if(DoCastSpellAtObject(SPELL_BLESS, oTemp, 9, 1, 0, FALSE, TRUE)) return TRUE;
    return FALSE;
}

int BuffPhysicalSelf()
{
    ddp("BuffPhysicalSelf", OBJECT_SELF);
    if(DoCastSpellAtObject(SPELL_PREMONITION, OBJECT_SELF, 12, 16, 0, FALSE, TRUE)) return TRUE;
    if(DoCastSpellAtObject(SPELL_GREATER_STONESKIN, OBJECT_SELF, 12, 12, 0, FALSE, TRUE)) return TRUE;
    if(DoCastSpellAtObject(SPELL_SHADOW_SHIELD, OBJECT_SELF, 12, 14, 0, FALSE, TRUE)) return TRUE;
    if(DoCastSpellAtObject(SPELL_ETHEREAL_VISAGE, OBJECT_SELF, 10, 12, 0, FALSE, TRUE)) return TRUE;
    if(DoCastSpellAtObject(SPELL_DISPLACEMENT, OBJECT_SELF, 9, 6, 0, FALSE, TRUE)) return TRUE;
    if(DoCastSpellAtObject(SPELL_GHOSTLY_VISAGE, OBJECT_SELF, 12, 4, 0, FALSE, TRUE)) return TRUE;
    if(DoCastSpellAtObject(SPELL_ELEMENTAL_SHIELD, OBJECT_SELF, 12, 10, 0, FALSE, TRUE)) return TRUE;
    if(DoCastSpellAtObject(SPELL_WAR_CRY, OBJECT_SELF, 1, 8, 0, FALSE, TRUE)) return TRUE;
    if(DoCastSpellAtObject(SPELL_DIVINE_POWER, OBJECT_SELF, 10, 8, 0, FALSE, TRUE)) return TRUE;
    if(DoCastSpellAtObject(SPELL_WOUNDING_WHISPERS, OBJECT_SELF, 12, 6, 0, FALSE, TRUE)) return TRUE;
    if(DoCastSpellAtObject(SPELL_TRUE_STRIKE, OBJECT_SELF, 9, 4, 0, FALSE, TRUE)) return TRUE;
    if(DoCastSpellAtObject(SPELL_SHIELD, OBJECT_SELF, 13, 2, 0, FALSE, TRUE)) return TRUE;
    if(DoCastSpellAtObject(SPELL_ENTROPIC_SHIELD, OBJECT_SELF, 13, 2, 0, FALSE, TRUE)) return TRUE;
    if(DoCastSpellAtObject(SPELL_DIVINE_FAVOR, OBJECT_SELF, 9, 2, 0, FALSE, TRUE)) return TRUE;
    if(DoCastSpellAtObject(SPELL_BLOOD_FRENZY, OBJECT_SELF, 9, 4, 0, FALSE, TRUE)) return TRUE;
    return FALSE;
}

int BuffElementalOther(object oTemp)
{
    ddp("BuffElementalOther", oTemp);
    if(DoCastSpellAtObject(SPELL_PROTECTION_FROM_ELEMENTS, oTemp, 13, 6, 0, FALSE, TRUE)) return TRUE;
    if(DoCastSpellAtObject(SPELL_RESIST_ELEMENTS, oTemp, 13, 4, 0, FALSE, TRUE)) return TRUE;
    if(DoCastSpellAtObject(SPELL_ENDURE_ELEMENTS, oTemp, 13, 2, 0, FALSE, TRUE)) return TRUE;
    return FALSE;
}

int BuffElementalSelf()
{
    ddp("BuffElementalSelf", OBJECT_SELF);
    if(DoCastSpellAtObject(SPELL_ENERGY_BUFFER, OBJECT_SELF, 12, 10, 0, FALSE, TRUE)) return TRUE;
    if(DoCastSpellAtObject(SPELL_ELEMENTAL_SHIELD, OBJECT_SELF, 12, 10, 0, FALSE, TRUE)) return TRUE;
    return FALSE;
}

int BuffSelf()
{
    ddp("BuffSelf", OBJECT_SELF);
    if(GetBattleCondition(OAI_I_NEED_BUFF_PHYSICAL) && GetStatusCondition(OAI_I_CAN_BUFF_PHYSICAL))
    if(BuffPhysicalSelf())
    {
      SetBattleCondition(OAI_I_NEED_BUFF_PHYSICAL, FALSE);
      return TRUE;
    }
    else if(BuffPhysicalOther(OBJECT_SELF))
    {
      SetBattleCondition(OAI_I_NEED_BUFF_PHYSICAL, FALSE);
      return TRUE;
    }
    else SetStatusCondition(OAI_I_CAN_BUFF_PHYSICAL, FALSE);

    if(GetBattleCondition(OAI_I_NEED_BUFF_MAGIC) && GetStatusCondition(OAI_I_CAN_BUFF_MAGIC))
    if(BuffMagicSelf())
    {
      SetBattleCondition(OAI_I_NEED_BUFF_MAGIC, FALSE);
      return TRUE;
    }
    else if(BuffMagicOther(OBJECT_SELF))
    {
      SetBattleCondition(OAI_I_NEED_BUFF_MAGIC, FALSE);
      return TRUE;
    }
    else SetStatusCondition(OAI_I_CAN_BUFF_MAGIC, FALSE);

    if(GetBattleCondition(OAI_I_NEED_BUFF_ELEMENTAL) && GetStatusCondition(OAI_I_CAN_BUFF_ELEMENTAL))
    if(BuffElementalSelf())
    {
      SetBattleCondition(OAI_I_NEED_BUFF_ELEMENTAL, FALSE);
      return TRUE;
    }
    else if(BuffElementalOther(OBJECT_SELF))
    {
      SetBattleCondition(OAI_I_NEED_BUFF_ELEMENTAL, FALSE);
      return TRUE;
    }
    else SetStatusCondition(OAI_I_CAN_BUFF_ELEMENTAL, FALSE);

    if(GetBattleCondition(OAI_I_NEED_BUFF_MENTAL) && GetStatusCondition(OAI_I_CAN_BUFF_MENTAL))
    if(BuffMentalOther(OBJECT_SELF))
    {
      SetBattleCondition(OAI_I_NEED_BUFF_MENTAL, FALSE);
      return TRUE;
    }
    else SetStatusCondition(OAI_I_CAN_BUFF_MENTAL, FALSE);

    if(GetBattleCondition(OAI_I_NEED_BUFF_SIGHT) && GetStatusCondition(OAI_I_CAN_BUFF_SIGHT))
    if(BuffSightOther(OBJECT_SELF))
    {
      SetBattleCondition(OAI_I_NEED_BUFF_SIGHT, FALSE);
      return TRUE;
    }
    else SetStatusCondition(OAI_I_CAN_BUFF_SIGHT, FALSE);
    return FALSE;
}

int BuffUp(object oTarget)
{
    ddp("BuffUp", oTarget);
    if(GetBattleCondition(OAI_I_NEED_BUFF_PHYSICAL, oTarget) && GetStatusCondition(OAI_I_CAN_BUFF_PHYSICAL))
    {
      if(BuffPhysicalOther(oTarget))
      {
        SetBattleCondition(OAI_I_NEED_BUFF_PHYSICAL, FALSE, oTarget);
        return TRUE;
      }
      else SetStatusCondition(OAI_I_CAN_BUFF_PHYSICAL, FALSE);
    }

    if(GetBattleCondition(OAI_I_NEED_BUFF_MAGIC, oTarget) && GetStatusCondition(OAI_I_CAN_BUFF_MAGIC))
    {
      if(BuffMagicOther(oTarget))
      {
        SetBattleCondition(OAI_I_NEED_BUFF_MAGIC, FALSE, oTarget);
        return TRUE;
      }
      else SetStatusCondition(OAI_I_CAN_BUFF_MAGIC, FALSE);
    }

    if(GetBattleCondition(OAI_I_NEED_BUFF_ELEMENTAL, oTarget) && GetStatusCondition(OAI_I_CAN_BUFF_ELEMENTAL))
    {
      if(BuffElementalOther(oTarget))
      {
        SetBattleCondition(OAI_I_NEED_BUFF_ELEMENTAL, FALSE, oTarget);
        return TRUE;
      }
      else SetStatusCondition(OAI_I_CAN_BUFF_ELEMENTAL, FALSE);
    }

    if(GetBattleCondition(OAI_I_NEED_BUFF_MENTAL, oTarget) && GetStatusCondition(OAI_I_CAN_BUFF_MENTAL))
    {
      if(BuffMentalOther(oTarget))
      {
        SetBattleCondition(OAI_I_NEED_BUFF_MENTAL, FALSE, oTarget);
        return TRUE;
      }
      else SetStatusCondition(OAI_I_CAN_BUFF_MENTAL, FALSE);
    }

    if(GetBattleCondition(OAI_I_NEED_BUFF_SIGHT, oTarget) && GetStatusCondition(OAI_I_CAN_BUFF_SIGHT))
    {
      if(BuffSightOther(oTarget))
      {
        SetBattleCondition(OAI_I_NEED_BUFF_SIGHT, FALSE, oTarget);
        return TRUE;
      }
      else SetStatusCondition(OAI_I_CAN_BUFF_SIGHT, FALSE);
    }
    return FALSE;
}

int GetHasDispellableEnhancement(object oTarget)
{
    ddp("GetHasDispellableEnhancement", oTarget);
    effect eCheck = GetFirstEffect(oTarget);
    int iSpellID;
    while (GetIsEffectValid(eCheck))
    {
      if (GetEffectSpellId(eCheck) != -1)
      {
        iSpellID = GetEffectSpellId(eCheck);
        if(iSpellID ==  SPELL_AID ||
           iSpellID ==  SPELL_AURAOFGLORY ||
           iSpellID ==  SPELL_AURA_OF_VITALITY ||
           iSpellID ==  SPELL_AMPLIFY ||
           iSpellID ==  SPELL_AWAKEN ||
           iSpellID ==  SPELL_AURA_OF_VITALITY ||
           iSpellID ==  SPELL_BANE ||
           iSpellID ==  SPELL_BARKSKIN ||
           iSpellID ==  SPELL_BATTLETIDE ||
           iSpellID ==  SPELL_BLESS ||
           iSpellID ==  SPELL_BLOOD_FRENZY ||
           iSpellID ==  SPELL_BULLS_STRENGTH ||
           iSpellID ==  SPELL_CATS_GRACE ||
           iSpellID ==  SPELL_CAMOFLAGE ||
           iSpellID ==  SPELL_CLARITY ||
           iSpellID ==  SPELL_DEATH_WARD ||
           iSpellID ==  SPELL_DISPLACEMENT ||
           iSpellID ==  SPELL_DIVINE_FAVOR ||
           iSpellID ==  SPELL_DIVINE_MIGHT ||
           iSpellID ==  SPELL_DIVINE_POWER ||
           iSpellID ==  SPELL_DIVINE_SHIELD ||
           iSpellID ==  SPELL_EAGLE_SPLEDOR ||
           iSpellID ==  SPELL_ELEMENTAL_SHIELD ||
           iSpellID ==  SPELL_ENDURE_ELEMENTS ||
           iSpellID ==  SPELL_ENERGY_BUFFER ||
           iSpellID ==  SPELL_ENERGY_DRAIN ||
           iSpellID ==  SPELL_ENERVATION ||
           iSpellID ==  SPELL_ENTROPIC_SHIELD ||
           iSpellID ==  SPELL_ETHEREAL_VISAGE ||
           iSpellID ==  SPELL_ETHEREALNESS ||
           iSpellID ==  SPELL_EXPEDITIOUS_RETREAT ||
           iSpellID ==  SPELL_FEAR ||
           iSpellID ==  SPELL_FEEBLEMIND ||
           iSpellID ==  SPELL_FREEDOM_OF_MOVEMENT ||
           iSpellID ==  SPELL_GHOSTLY_VISAGE ||
           iSpellID ==  SPELL_GLOBE_OF_INVULNERABILITY ||
           iSpellID ==  SPELL_GREATER_BULLS_STRENGTH ||
           iSpellID ==  SPELL_GREATER_CATS_GRACE ||
           iSpellID ==  SPELL_GREATER_EAGLE_SPLENDOR ||
           iSpellID ==  SPELL_GREATER_ENDURANCE ||
           iSpellID ==  SPELL_GREATER_FOXS_CUNNING ||
           iSpellID ==  SPELL_GREATER_MAGIC_FANG ||
           iSpellID ==  SPELL_GREATER_OWLS_WISDOM ||
           iSpellID ==  SPELL_GREATER_SPELL_MANTLE ||
           iSpellID ==  SPELL_GREATER_STONESKIN ||
           iSpellID ==  SPELL_HOLY_AURA ||
           iSpellID ==  SPELL_LESSER_SPELL_MANTLE ||
           iSpellID ==  SPELL_MAGE_ARMOR ||
           iSpellID ==  SPELL_MAGIC_CIRCLE_AGAINST_CHAOS ||
           iSpellID ==  SPELL_MAGIC_CIRCLE_AGAINST_EVIL ||
           iSpellID ==  SPELL_MAGIC_CIRCLE_AGAINST_GOOD ||
           iSpellID ==  SPELL_MAGIC_FANG ||
           iSpellID ==  SPELL_MASS_CAMOFLAGE ||
           iSpellID ==  SPELL_MASS_HASTE ||
           iSpellID ==  SPELL_MINOR_GLOBE_OF_INVULNERABILITY ||
           iSpellID ==  SPELL_NEGATIVE_ENERGY_PROTECTION ||
           iSpellID ==  SPELL_ONE_WITH_THE_LAND ||
           iSpellID ==  SPELL_PREMONITION ||
           iSpellID ==  SPELL_PROTECTION_FROM_ELEMENTS ||
           iSpellID ==  SPELL_PROTECTION_FROM_EVIL ||
           iSpellID ==  SPELL_PROTECTION_FROM_GOOD ||
           iSpellID ==  SPELL_PROTECTION_FROM_SPELLS ||
           iSpellID ==  SPELL_REGENERATE ||
           iSpellID ==  SPELL_RESIST_ELEMENTS ||
           iSpellID ==  SPELL_SANCTUARY ||
           iSpellID ==  SPELL_SEE_INVISIBILITY ||
           iSpellID ==  SPELL_SHADOW_SHIELD ||
           iSpellID ==  SPELL_SHAPECHANGE ||
           iSpellID ==  SPELL_SHIELD ||
           iSpellID ==  SPELL_SHIELD_OF_FAITH ||
           iSpellID ==  SPELL_SPELL_MANTLE ||
           iSpellID ==  SPELL_SPELL_RESISTANCE ||
           iSpellID ==  SPELL_STONESKIN ||
           iSpellID ==  SPELL_TENSERS_TRANSFORMATION ||
           iSpellID ==  SPELL_TRUE_SEEING ||
           iSpellID ==  SPELL_TRUE_STRIKE ||
           iSpellID ==  SPELL_UNDEATHS_ETERNAL_FOE ||
           iSpellID ==  SPELL_WAR_CRY ||
           iSpellID ==  SPELL_WOUNDING_WHISPERS)
         return TRUE;
      }
      eCheck = GetNextEffect(oTarget);
    }
    return FALSE;
}

int GetHasBreachableEnhancement(object oTarget)
{
    ddp("GetHasBreachableEnhancement", oTarget);
    effect eCheck = GetFirstEffect(oTarget);
    int iSpellID;
    while (GetIsEffectValid(eCheck))
    {
      if (GetEffectSpellId(eCheck) != -1)
      {
        iSpellID = GetEffectSpellId(eCheck);
        if(iSpellID ==  SPELL_ELEMENTAL_SHIELD ||  iSpellID ==  SPELL_ENDURE_ELEMENTS ||
           iSpellID ==  SPELL_ENERGY_BUFFER || iSpellID ==  SPELL_ETHEREAL_VISAGE ||
           iSpellID ==  SPELL_GHOSTLY_VISAGE ||iSpellID ==  SPELL_GLOBE_OF_INVULNERABILITY ||
           iSpellID ==  SPELL_GREATER_SPELL_MANTLE ||iSpellID ==  SPELL_GREATER_STONESKIN ||
           iSpellID ==  SPELL_LESSER_SPELL_MANTLE || iSpellID ==  SPELL_MAGE_ARMOR ||
           iSpellID ==  SPELL_MINOR_GLOBE_OF_INVULNERABILITY || iSpellID ==  SPELL_PREMONITION ||
           iSpellID ==  SPELL_PROTECTION_FROM_ELEMENTS || iSpellID ==  SPELL_RESIST_ELEMENTS ||
           iSpellID ==  SPELL_SPELL_MANTLE || iSpellID ==  SPELL_STONESKIN)
             return TRUE;
      }
      eCheck = GetNextEffect(oTarget);
    }
    return FALSE;
}

int HasPhysicalProtections(object oTarget = OBJECT_SELF)
{
    ddp("HasPhysicalProtections", oTarget);
    if(GetHasSpellEffect(SPELL_STONESKIN, oTarget) ||
      GetHasSpellEffect(SPELL_AID, oTarget) ||
      GetHasSpellEffect(SPELL_BARKSKIN, oTarget) ||
      GetHasSpellEffect(SPELL_MAGE_ARMOR, oTarget) ||
      GetHasSpellEffect(SPELL_AURA_OF_VITALITY, oTarget) ||
      GetHasSpellEffect(SPELL_REGENERATE, oTarget) ||
      GetHasSpellEffect(SPELL_PRAYER, oTarget) ||
      GetHasSpellEffect(SPELL_BLESS, oTarget) ||
      GetHasSpellEffect(SPELL_PREMONITION, oTarget) ||
      GetHasSpellEffect(SPELL_GREATER_STONESKIN, oTarget) ||
      GetHasSpellEffect(SPELL_SHADOW_SHIELD, oTarget) ||
      GetHasSpellEffect(SPELL_ETHEREAL_VISAGE, oTarget) ||
      GetHasSpellEffect(SPELL_GHOSTLY_VISAGE, oTarget) ||
      GetHasSpellEffect(SPELL_WAR_CRY, oTarget) ||
      GetHasSpellEffect(SPELL_DIVINE_POWER, oTarget) ||
      GetHasSpellEffect(SPELL_SHIELD_OF_FAITH, oTarget) ||
      GetHasSpellEffect(SPELL_SHIELD, oTarget) ||
      GetHasSpellEffect(SPELL_DISPLACEMENT, oTarget) ||
      GetHasSpellEffect(SPELL_ELEMENTAL_SHIELD, oTarget) ||
      GetHasFeatEffect(FEAT_DIVINE_SHIELD, oTarget) ||
      GetHasFeatEffect(FEAT_SHADOW_EVADE, oTarget) ||
      GetHasFeatEffect(FEAT_PERFECT_SELF, oTarget) ||
      GetHasFeatEffect(FEAT_DAMAGE_REDUCTION, oTarget))
        return TRUE;
    return FALSE;
}

int HasMentalProtections(object oTarget = OBJECT_SELF)
{
    ddp("HasMentalProtections", oTarget);
    if(GetHasSpellEffect(SPELL_MIND_BLANK, oTarget) ||
      GetHasSpellEffect(SPELL_LESSER_MIND_BLANK, oTarget) ||
      GetHasSpellEffect(SPELL_CLARITY, oTarget))
        return TRUE;
    return FALSE;
}

int HasMagicProtections(object oTarget = OBJECT_SELF)
{
    ddp("HasMagicProtections", oTarget);
    if(GetHasSpellEffect(SPELL_GREATER_SPELL_MANTLE, oTarget) ||
      GetHasSpellEffect(SPELL_PROTECTION_FROM_SPELLS, oTarget) ||
      GetHasSpellEffect(SPELL_SPELL_MANTLE, oTarget) ||
      GetHasSpellEffect(SPELL_GLOBE_OF_INVULNERABILITY, oTarget) ||
      GetHasSpellEffect(SPELL_LESSER_SPELL_MANTLE, oTarget) ||
      GetHasSpellEffect(SPELL_MINOR_GLOBE_OF_INVULNERABILITY, oTarget) ||
      GetHasSpellEffect(SPELL_NEGATIVE_ENERGY_PROTECTION, oTarget) ||
      GetHasSpellEffect(SPELL_RESISTANCE, oTarget))
        return TRUE;
    return FALSE;
}

int HasElementalProtections(object oTarget = OBJECT_SELF)
{
    ddp("HasElementalProtections", oTarget);
    if(GetHasSpellEffect(SPELL_PROTECTION_FROM_ELEMENTS, oTarget) ||
      GetHasSpellEffect(SPELL_RESIST_ELEMENTS, oTarget) ||
      GetHasSpellEffect(SPELL_ELEMENTAL_SHIELD, oTarget) ||
      GetHasSpellEffect(SPELL_ENDURE_ELEMENTS, oTarget) ||
      GetHasSpellEffect(SPELL_ENERGY_BUFFER, oTarget))
        return TRUE;
    return FALSE;
}

int HasGoodEyes(object oTarget = OBJECT_SELF)
{
    ddp("HasGoodEyes", oTarget);
    if(GetHasSpellEffect(SPELL_TRUE_SEEING, oTarget) ||
      GetHasSpellEffect(SPELL_SEE_INVISIBILITY, oTarget) ||
      GetHasSpellEffect(SPELL_CLAIRAUDIENCE_AND_CLAIRVOYANCE, oTarget) ||
      GetHasSpellEffect(SPELL_DARKVISION, oTarget) ||
      GetHasFeatEffect(FEAT_DARKVISION, oTarget) ||
      GetHasFeatEffect(FEAT_LOWLIGHTVISION, oTarget) ||
      GetHasSpellEffect(SPELL_CONTINUAL_FLAME, oTarget) ||
     GetHasSpellEffect(SPELL_LIGHT, oTarget))
        return TRUE;
    return FALSE;
}

int StatusFix(object oWho = OBJECT_SELF)
{
    ddp("StatusFix", oWho);
    int nDisease =   0x00000001;
    int nPoison =    0x00000002;
    int nCurse =     0x00000004;
    int nAbility =   0x00000008;
    int nDrained =   0x00000010;
    int nBlindDeaf = 0x00000020;
    int nParalsis =  0x00000040;
    int nSlow =      0x00000080;
    int nFreedom =   0x00000100;
    int nDominated = 0x00000200;
    int nSleep =     0x00000400;
    int nFear =      0x00000800;
    int nClarity =   0x00001000;
    int nPetrify =   0x00002000;

    int nType, nSum = 0;
    effect eEffect = GetFirstEffect(oWho);

    while(GetIsEffectValid(eEffect))
    {
      if(GetEffectSubType(eEffect) != SUBTYPE_SUPERNATURAL)
      {
        nType = GetEffectType(eEffect);
        if(nType == EFFECT_TYPE_DISEASE) nSum = nSum | nDisease;
        else if(nType == EFFECT_TYPE_FRIGHTENED) nSum = nSum | nFear;
        else if(nType == EFFECT_TYPE_POISON) nSum = nSum | nPoison;
        else if(nType == EFFECT_TYPE_CURSE) nSum = nSum | nCurse;
        else if(nType == EFFECT_TYPE_NEGATIVELEVEL) nSum = nSum | nDrained;
        else if(nType == EFFECT_TYPE_ABILITY_DECREASE ||
                nType == EFFECT_TYPE_AC_DECREASE ||
                nType == EFFECT_TYPE_ATTACK_DECREASE ||
                nType == EFFECT_TYPE_DAMAGE_DECREASE ||
                nType == EFFECT_TYPE_DAMAGE_IMMUNITY_DECREASE ||
                nType == EFFECT_TYPE_SAVING_THROW_DECREASE ||
                nType == EFFECT_TYPE_SPELL_RESISTANCE_DECREASE ||
                nType == EFFECT_TYPE_SKILL_DECREASE) nSum = nSum | nAbility;
        else if(nType == EFFECT_TYPE_PARALYZE) nSum = nSum | nParalsis;
        else if(nType == EFFECT_TYPE_SLOW) nSum = nSum | nSlow;
        else if(nType == EFFECT_TYPE_BLINDNESS ||
                nType == EFFECT_TYPE_DEAF) nSum = nSum | nBlindDeaf;
        else if(nType == EFFECT_TYPE_ENTANGLE ||
                nType == EFFECT_TYPE_MOVEMENT_SPEED_DECREASE) nSum = nSum | nFreedom;
        else if(nType == EFFECT_TYPE_DAZED ||
                nType == EFFECT_TYPE_CHARMED ||
                nType == EFFECT_TYPE_CONFUSED ||
                nType == EFFECT_TYPE_STUNNED) nSum = nSum | nClarity;
        else if(nType == EFFECT_TYPE_SLEEP) nSum = nSum | nSleep;
        else if(nType == EFFECT_TYPE_DOMINATED) nSum = nSum | nDominated;
        else if(nType == EFFECT_TYPE_PETRIFY) nSum = nSum | nPetrify;
      }
      eEffect = GetNextEffect(oWho);
    }

    if(nSum > 0) SetBattleCondition(OAI_I_NEED_CURE, TRUE, oWho);

    if(GetStatusCondition(OAI_I_CAN_CAST_DISPELLS) || (oWho == OBJECT_SELF && GetStatusCondition(OAI_I_HAVE_BUFFING_POTIONS)))
    {
      if(nSum != 0)
      {
        if(nSum & nFear)
        {
          if(DoCastSpellAtObject(SPELL_REMOVE_FEAR, oWho, 6, 4)) return TRUE;
        }

        if(nSum & nPetrify)
        {
          if(DoCastSpellAtObject(SPELL_STONE_TO_FLESH, oWho, 6, 4)) return TRUE;
        }

        if(nSum & (nFreedom | nParalsis))
        {
          if(DoCastSpellAtObject(SPELL_FREEDOM_OF_MOVEMENT, oWho, 9, 8)) return TRUE;
        }

        if(nSum & nParalsis)
        {
          if(DoCastSpellAtObject(SPELL_REMOVE_PARALYSIS, oWho, 7, 4)) return TRUE;
        }

        if(nSum & (nSlow | nClarity | nSleep))
        {
          if(DoCastSpellAtObject(SPELL_MIND_BLANK, oWho, 9, 16)) return TRUE;
        }

        if(nSum & (nClarity | nSleep))
        {
          if(DoCastSpellAtObject(SPELL_CLARITY, oWho, 7, 6)) return TRUE;
        }

        if(nSum & nCurse)
        {
          if(DoCastSpellAtObject(SPELL_REMOVE_CURSE, oWho, 7, 8)) return TRUE;
        }

        if(nSum & nBlindDeaf)
        {
          if(DoCastSpellAtObject(SPELL_REMOVE_BLINDNESS_AND_DEAFNESS, oWho, 6, 8)) return TRUE;
        }

        if(nSum & (nPoison | nDisease))
        {
          if(DoCastSpellAtObject(SPELL_NEUTRALIZE_POISON, oWho, 7, 8)) return TRUE;
        }

        if(nSum & nAbility)
        {
          if(DoCastSpellAtObject(SPELL_LESSER_RESTORATION, oWho, 7, 4)) return TRUE;
        }

        if(nSum & (nDrained | nParalsis | nBlindDeaf | nAbility))
        {
          if(DoCastSpellAtObject(SPELL_RESTORATION, oWho, 7, 8)) return TRUE;
        }

        if(nSum & (nCurse | nFear | nSlow | nClarity | nPoison | nDisease | nDrained | nParalsis | nBlindDeaf | nAbility | nDominated))
        {
          if(DoCastSpellAtObject(SPELL_GREATER_RESTORATION, oWho, 7, 14)) return TRUE;
        }

        if(nSum & nDisease)
        {
          if(DoCastSpellAtObject(SPELL_REMOVE_DISEASE, oWho, 7, 6)) return TRUE;
        }
      } //end sum !=0
    } //end I can cure

    if(nSum > 0)
    {
      if(!GetIsObjectValid(GetLocalObject(OBJECT_SELF, "OAI_CURE_TARGET")) || ((nSum & ~0x0000000F) > 0))
      {
        SetBattleCondition(OAI_I_NEED_CURE, TRUE, oWho);
        if(oWho == OBJECT_SELF)
        {
          SpeakString("OAI_CURE_PLEASE", TALKVOLUME_SILENT_TALK);
          switch (Random(18))
          {
            case 0: PlayVoiceChat(VOICE_CHAT_POISONED); break;
            case 1: PlayVoiceChat(VOICE_CHAT_BADIDEA); break;
            case 2: PlayVoiceChat(VOICE_CHAT_CUSS); break;
          }
        }
      }
    }
    else SetBattleCondition(OAI_I_NEED_CURE, FALSE, oWho);
    return FALSE;
}

int CureOther(int iAlsoLookElsewhere = FALSE)
{
    if(!GetStatusCondition(OAI_I_CAN_CAST_DISPELLS)) return FALSE;
    object oAlly = GetLocalObject(OBJECT_SELF, "OAI_CURE_TARGET");
    ddp("CureOther", oAlly);
    DeleteLocalObject(OBJECT_SELF, "OAI_CURE_TARGET");
    if(GetIsObjectValid(oAlly) && !GetIsDead(oAlly) && GetDistanceToObject(oAlly) < 30.0)
    {
      if(StatusFix(oAlly)) return TRUE;
    }

    if(!iAlsoLookElsewhere) return FALSE;
    int iX;
    for (iX = 1;iX < 5; iX++)
    {
      oAlly = GetNearestCreature(CREATURE_TYPE_REPUTATION, REPUTATION_TYPE_FRIEND, OBJECT_SELF, iX, CREATURE_TYPE_IS_ALIVE, TRUE, CREATURE_TYPE_PERCEPTION, PERCEPTION_SEEN);
      if(!GetIsObjectValid(oAlly) || GetDistanceToObject(oAlly) > 30.0) return FALSE;
      if(GetBattleCondition(OAI_I_NEED_CURE, oAlly))
      {
        if(StatusFix(oAlly)) return TRUE;
      }
    }
    return FALSE;
}

int BuffOther(int iAlsoLookElsewhere = FALSE)
{
    if(GetStatusCondition(OAI_I_CAN_BUFF_PHYSICAL) ||
      GetStatusCondition(OAI_I_CAN_BUFF_MENTAL) ||
      GetStatusCondition(OAI_I_CAN_BUFF_ELEMENTAL) ||
      GetStatusCondition(OAI_I_CAN_BUFF_MAGIC) ||
      GetStatusCondition(OAI_I_CAN_BUFF_SIGHT))
    {
      object oAlly = GetLocalObject(OBJECT_SELF, "OAI_BUFF_TARGET");
      ddp("BuffOther", oAlly);
      DeleteLocalObject(OBJECT_SELF, "OAI_BUFF_TARGET");
      if(GetIsObjectValid(oAlly) && !GetIsDead(oAlly) && GetDistanceToObject(oAlly) < 30.0)
      {
        if(BuffUp(oAlly)) return TRUE;
      }

      if(!iAlsoLookElsewhere) return FALSE;
      int iX;
      for (iX = 1;iX < 5; iX++)
      {
        oAlly = GetNearestCreature(CREATURE_TYPE_REPUTATION, REPUTATION_TYPE_FRIEND, OBJECT_SELF, iX, CREATURE_TYPE_IS_ALIVE, TRUE, CREATURE_TYPE_PERCEPTION, PERCEPTION_SEEN);
        if(!GetIsObjectValid(oAlly) || GetDistanceToObject(oAlly) > 30.0) return FALSE;
        if(GetBattleCondition(OAI_I_NEED_BUFF_PHYSICAL, oAlly) ||
           GetBattleCondition(OAI_I_NEED_BUFF_MENTAL, oAlly) ||
           GetBattleCondition(OAI_I_NEED_BUFF_ELEMENTAL, oAlly) ||
           GetBattleCondition(OAI_I_NEED_BUFF_MAGIC, oAlly) ||
           GetBattleCondition(OAI_I_NEED_BUFF_SIGHT, oAlly))
        {
          if(BuffUp(oAlly)) return TRUE;
        }
      }
    }
    return FALSE;
}

//Caster's Ally Effect
//  1. Harm
//  2. Heal
//  3. Immune
//Caster's Enemy Effect
//  1. Harm
//  2. Heal
//  3. Immune
int ShouldICast(location lTarget, float SpellRadius, int MinimumToCast = 2, int SpellShape = SHAPE_SPELLCONE, int AllyEffect = 1, int FoeEffect = 1)
{
    ddp("ShouldICast", OBJECT_SELF);
    object oO = GetFirstObjectInShape(SpellShape, SpellRadius, lTarget);
    while(GetIsObjectValid(oO))
    {
      if(!GetIsDead(oO) && !GetIsDM(oO) && !GetPlotFlag(oO))
      {
        if(GetIsEnemy(oO))
        {
          if(FoeEffect==1) MinimumToCast--;
          else if(FoeEffect==2) MinimumToCast++;
        }
        else
        {
          if(AllyEffect==1) MinimumToCast++;
          else if(AllyEffect==2) MinimumToCast--;
        }
      }
      oO = GetNextObjectInShape(SpellShape, SpellRadius, lTarget);
    }
    if(MinimumToCast < 1) return TRUE;
    return FALSE;
}

int AOE_Fire(object oTarget, int iSafeAOE_VL, location lSafeAOE_VL, int iUnsafeAOE_VL, location lUnsafeAOE_VL,
                      int iSafeAOE_L, location lSafeAOE_L, int iUnsafeAOE_L, location lUnsafeAOE_L,
                      int iSafeAOE_M, location lSafeAOE_M, int iUnsafeAOE_M, location lUnsafeAOE_M,
                      int iSafeAOE_S, location lSafeAOE_S, int iUnsafeAOE_S, location lUnsafeAOE_S,
                      int iUnsafeCone, int iUnsafeCube)
{
    ddp("AOE_Fire", oTarget);
    location lTarget;
    if(GetImmunity(OAI_IMMUNITY_FIRE, oTarget)) return FALSE;
    if(HasSpell(SPELL_METEOR_SWARM, 1, 18))
    {
      lTarget = GetLocation(oTarget);
      if(ShouldICast(lTarget, 10.0, 1, SHAPE_SPHERE, 3))
      {
        if(DoCastSpellAtObject(SPELL_METEOR_SWARM, OBJECT_SELF, 1, 18, OAI_IMMUNITY_FIRE, FALSE, TRUE)) return TRUE;
      }
    }
    if(HasSpell(SPELL_SUNBEAM, 1, 16))
    {
      if(iUnsafeAOE_VL)
      {
        if(CastSpellAtLocation(SPELL_SUNBEAM, lUnsafeAOE_VL, 1, 16, OAI_IMMUNITY_FIRE)) return TRUE;
      }
    }
    if(HasSpell(SPELL_FIRE_STORM, 1, 16))
    {
      lTarget = GetLocation(oTarget);
      if(ShouldICast(lTarget, 10.0, 1, SHAPE_SPHERE, 3))
      {
        if(DoCastSpellAtObject(SPELL_FIRE_STORM, OBJECT_SELF, 1, 16, OAI_IMMUNITY_FIRE, FALSE, TRUE)) return TRUE;
      }
    }
    if(HasSpell(SPELL_INCENDIARY_CLOUD, 11, 16))
    {
      if(iUnsafeAOE_L)
      {
        if(CastSpellAtLocation(SPELL_INCENDIARY_CLOUD, lUnsafeAOE_L, 11, 16, OAI_IMMUNITY_FIRE)) return TRUE;
      }
    }
    if(HasSpell(SPELL_DELAYED_BLAST_FIREBALL, 11, 14))
    {
      if(iSafeAOE_M)
      {
        if(CastSpellAtLocation(SPELL_DELAYED_BLAST_FIREBALL, lSafeAOE_M, 11, 14)) return TRUE;
      }
    }
    if(HasSpell(SPELL_PRISMATIC_SPRAY, 11, 14))
    {
      if(iUnsafeCone)
      {
        if(DoCastSpellAtObject(SPELL_PRISMATIC_SPRAY, oTarget, 11, 14, 0, FALSE, TRUE)) return TRUE;
      }
    }
    if(HasSpell(SPELL_FIREBRAND, 2, 10))
    {
      if(iSafeAOE_VL)
      {
        if(CastSpellAtLocation(SPELL_FIREBRAND, lSafeAOE_VL, 2, 10, OAI_IMMUNITY_FIRE)) return TRUE;
      }
    }
    if(HasSpell(SPELL_FLAME_STRIKE, 11, 10))
    {
      if(iUnsafeAOE_S)
      {
        if(CastSpellAtLocation(SPELL_FLAME_STRIKE, lUnsafeAOE_S, 11, 10, OAI_IMMUNITY_FIRE)) return TRUE;
      }
    }
    if(HasSpell(SPELL_WALL_OF_FIRE, 11, 10))
    {
      if(iUnsafeCube)
      {
        if(DoCastSpellAtObject(SPELL_WALL_OF_FIRE, oTarget, 11, 10, OAI_IMMUNITY_FIRE)) return TRUE;
      }
    }
    if(HasSpell(SPELL_FIREBALL, 11, 6))
    {
      if(iUnsafeAOE_L)
      {
        if(CastSpellAtLocation(SPELL_FIREBALL, lUnsafeAOE_L, 11, 6, OAI_IMMUNITY_FIRE)) return TRUE;
      }
    }
    if(HasSpell(SPELL_BURNING_HANDS, 11, 2))
    {
      if(iUnsafeCone)
      {
        if(DoCastSpellAtObject(SPELL_BURNING_HANDS, oTarget, 11, 2, OAI_IMMUNITY_FIRE)) return TRUE;
      }
    }
    return FALSE;
}

int AOE_Ice(object oTarget, int iSafeAOE_VL, location lSafeAOE_VL, int iUnsafeAOE_VL, location lUnsafeAOE_VL,
                      int iSafeAOE_L, location lSafeAOE_L, int iUnsafeAOE_L, location lUnsafeAOE_L,
                      int iSafeAOE_M, location lSafeAOE_M, int iUnsafeAOE_M, location lUnsafeAOE_M,
                      int iSafeAOE_S, location lSafeAOE_S, int iUnsafeAOE_S, location lUnsafeAOE_S,
                      int iUnsafeCone, int iUnsafeCube)
{
    ddp("AOE_Ice", oTarget);
    if(GetImmunity(OAI_IMMUNITY_ICE, oTarget)) return FALSE;
    if(HasSpell(SPELL_CONE_OF_COLD, 11, 10))
    {
      if(iUnsafeCone)
      {
        if(DoCastSpellAtObject(SPELL_CONE_OF_COLD, oTarget, 11, 10, OAI_IMMUNITY_ICE, FALSE, TRUE)) return TRUE;
      }
    }
    if(HasSpell(SPELL_ICE_STORM, 11, 10))
    {
      if(iSafeAOE_L)
      {
        if(CastSpellAtLocation(SPELL_ICE_STORM, lSafeAOE_L, 11, 10, OAI_IMMUNITY_ICE)) return TRUE;
      }
    }
    return FALSE;
}

int AOE_Acid(object oTarget, int iSafeAOE_VL, location lSafeAOE_VL, int iUnsafeAOE_VL, location lUnsafeAOE_VL,
                      int iSafeAOE_L, location lSafeAOE_L, int iUnsafeAOE_L, location lUnsafeAOE_L,
                      int iSafeAOE_M, location lSafeAOE_M, int iUnsafeAOE_M, location lUnsafeAOE_M,
                      int iSafeAOE_S, location lSafeAOE_S, int iUnsafeAOE_S, location lUnsafeAOE_S,
                      int iUnsafeCone, int iUnsafeCube)
{
    ddp("AOE_Acid", oTarget);
    if(GetImmunity(OAI_IMMUNITY_ACID, oTarget)) return FALSE;
    if(HasSpell(SPELL_STORM_OF_VENGEANCE, 1, 18))
    {
      if(iUnsafeAOE_VL)
      {
        if(CastSpellAtLocation(SPELL_STORM_OF_VENGEANCE, lUnsafeAOE_VL, 1, 18, OAI_IMMUNITY_ACID)) return TRUE;
      }
    }
    if(HasSpell(SPELL_PRISMATIC_SPRAY, 11, 14))
    {
      if(iUnsafeCone)
      {
        if(DoCastSpellAtObject(SPELL_PRISMATIC_SPRAY, oTarget, 11, 14, 0, FALSE, TRUE)) return TRUE;
      }
    }
    if(HasSpell(SPELL_ACID_FOG, 11, 12))
    {
      if(iUnsafeAOE_L)
      {
        if(CastSpellAtLocation(SPELL_ACID_FOG, lUnsafeAOE_L, 11, 12, OAI_IMMUNITY_ACID)) return TRUE;
      }
    }
    if(HasSpell(SPELL_CLOUDKILL, 11, 10))
    {
      if(iUnsafeAOE_L)
      {
        if(CastSpellAtLocation(SPELL_CLOUDKILL, lUnsafeAOE_L, 11, 10, OAI_IMMUNITY_ACID)) return TRUE;
      }
    }
    return FALSE;
}

int AOE_Electric(object oTarget, int iSafeAOE_VL, location lSafeAOE_VL, int iUnsafeAOE_VL, location lUnsafeAOE_VL,
                      int iSafeAOE_L, location lSafeAOE_L, int iUnsafeAOE_L, location lUnsafeAOE_L,
                      int iSafeAOE_M, location lSafeAOE_M, int iUnsafeAOE_M, location lUnsafeAOE_M,
                      int iSafeAOE_S, location lSafeAOE_S, int iUnsafeAOE_S, location lUnsafeAOE_S,
                      int iUnsafeCone, int iUnsafeCube)
{
    ddp("AOE_Electric", oTarget);
    if(GetImmunity(OAI_IMMUNITY_ELECTRIC, oTarget)) return FALSE;
    if(HasSpell(SPELL_STORM_OF_VENGEANCE, 1, 18))
    {
      if(iUnsafeAOE_VL)
      {
        if(CastSpellAtLocation(SPELL_STORM_OF_VENGEANCE, lUnsafeAOE_VL, 1, 18, OAI_IMMUNITY_ELECTRIC)) return TRUE;
      }
    }
    if(HasSpell(SPELL_PRISMATIC_SPRAY, 11, 14))
    {
      if(iUnsafeCone)
      {
        if(DoCastSpellAtObject(SPELL_PRISMATIC_SPRAY, oTarget, 11, 14, 0, FALSE, TRUE)) return TRUE;
      }
    }
    if(HasSpell(SPELL_CALL_LIGHTNING, 1, 6))
    {
      if(iSafeAOE_L)
      {
        if(CastSpellAtLocation(SPELL_CALL_LIGHTNING, lSafeAOE_L, 1, 6, OAI_IMMUNITY_ELECTRIC)) return TRUE;
      }
    }
    return FALSE;
}

int AOE_Status(object oTarget, int iSafeAOE_VL, location lSafeAOE_VL, int iUnsafeAOE_VL, location lUnsafeAOE_VL,
                      int iSafeAOE_L, location lSafeAOE_L, int iUnsafeAOE_L, location lUnsafeAOE_L,
                      int iSafeAOE_M, location lSafeAOE_M, int iUnsafeAOE_M, location lUnsafeAOE_M,
                      int iSafeAOE_S, location lSafeAOE_S, int iUnsafeAOE_S, location lUnsafeAOE_S,
                      int iUnsafeCone, int iUnsafeCube)
{
    ddp("AOE_Status", oTarget);
    object oMaster;
    if(HasSpell(SPELL_WORD_OF_FAITH, 1, 14))
    {
      if(iSafeAOE_VL)
      {
        SetImmunity(OAI_IMMUNITY_BLIND);
        if(CastSpellAtLocation(SPELL_WORD_OF_FAITH, lSafeAOE_VL, 1, 14)) return TRUE;
      }
    }
    if(HasSpell(SPELL_BANISHMENT, 11, 14))
    {
      oMaster = GetMaster(oTarget);
      if(GetIsObjectValid(oMaster))
      {
        if(GetAssociate(ASSOCIATE_TYPE_HENCHMAN, oMaster) != oTarget && GetDistanceToObject(oTarget) < 10.0)
        {
          if(DoCastSpellAtObject(SPELL_BANISHMENT, OBJECT_SELF, 11, 14, 0, FALSE, TRUE)) return TRUE;
        }
      }
      if(GetRacialType(oTarget) == RACIAL_TYPE_OUTSIDER && GetDistanceToObject(oTarget) < 10.0)
      {
        if(DoCastSpellAtObject(SPELL_BANISHMENT, OBJECT_SELF, 11, 14, 0, FALSE, TRUE)) return TRUE;
      }
    }
    if(HasSpell(SPELL_MASS_BLINDNESS_AND_DEAFNESS, 1, 16)
      && !GetImmunity(OAI_IMMUNITY_BLIND, oTarget))
    {
      if(iSafeAOE_S)
      {
        if(CastSpellAtLocation(SPELL_MASS_BLINDNESS_AND_DEAFNESS, lSafeAOE_S, 1, 16, OAI_IMMUNITY_BLIND)) return TRUE;
      }
    }

    if(HasSpell(SPELL_PRISMATIC_SPRAY, 11, 14))
    {
      if(iUnsafeCone)
      {
        if(DoCastSpellAtObject(SPELL_PRISMATIC_SPRAY, oTarget, 11, 14, 0, FALSE, TRUE)) return TRUE;
      }
    }
    if(HasSpell(SPELL_DIRGE, 11, 12)
      && !GetImmunity(OAI_IMMUNITY_DRAIN, oTarget))
    {
      if(iSafeAOE_M)
      {
        if(CastSpellAtLocation(SPELL_DIRGE, lSafeAOE_M, 11, 12, OAI_IMMUNITY_DRAIN)) return TRUE;
      }
    }
    if(HasSpell(SPELL_SILENCE, 1, 6))
    {
      if(iSafeAOE_S)
      {
        if(DoCastSpellAtObject(SPELL_SILENCE, oTarget, 1, 6)) return TRUE;
      }
    }
    if(iUnsafeAOE_M)
    {
      if(HasSpell(SPELL_DARKNESS, 11, 6)
        && !GetImmunity(OAI_IMMUNITY_BLIND, oTarget))
      {
          if(CastSpellAtLocation(SPELL_DARKNESS, lUnsafeAOE_M, 11, 6, OAI_IMMUNITY_BLIND)) return TRUE;
      }
      if(HasSpell(SPELL_FEAR, 1, 8)
        && !GetImmunity(OAI_IMMUNITY_FEAR, oTarget))
      {
        if(CastSpellAtLocation(SPELL_FEAR, lUnsafeAOE_M, 1, 8, OAI_IMMUNITY_FEAR)) return TRUE;
      }
      if(HasSpell(SPELL_CONFUSION, 1, 8)
        && !GetImmunity(OAI_IMMUNITY_DOMINATE, oTarget))
      {
        if(CastSpellAtLocation(SPELL_CONFUSION, lUnsafeAOE_M, 1, 8, OAI_IMMUNITY_DOMINATE)) return TRUE;
      }
      if(HasSpell(SPELL_SLEEP, 1, 2)
        && !GetImmunity(OAI_IMMUNITY_SLEEP, oTarget))
      {
        if(CastSpellAtLocation(SPELL_SLEEP, lUnsafeAOE_M, 1, 2, OAI_IMMUNITY_SLEEP)) return TRUE;
      }
      if(HasSpell(SPELL_STINKING_CLOUD, 11, 4)
        && !GetImmunity(OAI_IMMUNITY_DAZE, oTarget))
      {
        if(CastSpellAtLocation(SPELL_STINKING_CLOUD, lUnsafeAOE_M, 11, 4, OAI_IMMUNITY_DAZE)) return TRUE;
      }
      if(HasSpell(SPELL_ENTANGLE, 11, 2)
        && !GetImmunity(OAI_IMMUNITY_MOVEMENT, oTarget))
      {
        if(CastSpellAtLocation(SPELL_ENTANGLE, lUnsafeAOE_M, 11, 2, OAI_IMMUNITY_MOVEMENT)) return TRUE;
      }
    } //end of size 5.0
    if(iUnsafeAOE_L)
    {
      if(HasSpell(SPELL_SPIKE_GROWTH, 11, 6)
        && !GetImmunity(OAI_IMMUNITY_MOVEMENT, oTarget))
      {
        if(CastSpellAtLocation(SPELL_SPIKE_GROWTH, lUnsafeAOE_L, 11, 6, OAI_IMMUNITY_MOVEMENT)) return TRUE;
      }
      if(HasSpell(SPELL_WEB, 11, 4)
        && !GetImmunity(OAI_IMMUNITY_MOVEMENT, oTarget))
      {
        if(CastSpellAtLocation(SPELL_WEB, lUnsafeAOE_L, 11, 4, OAI_IMMUNITY_MOVEMENT)) return TRUE;
      }
      if(HasSpell(SPELL_GREASE, 11, 2)
        && !GetImmunity(OAI_IMMUNITY_MOVEMENT, oTarget))
      {
        if(CastSpellAtLocation(SPELL_GREASE, lUnsafeAOE_L, 11, 2, OAI_IMMUNITY_MOVEMENT)) return TRUE;
      }
      if(HasSpell(SPELL_MIND_FOG, 11, 10)
        && !GetImmunity(OAI_IMMUNITY_DRAIN, oTarget))
      {
        if(CastSpellAtLocation(SPELL_MIND_FOG, lUnsafeAOE_L, 11, 10, OAI_IMMUNITY_DRAIN)) return TRUE;
      }
    } //end of size 6.67
    if(HasSpell(SPELL_SLOW, 1, 6)
      && !GetImmunity(OAI_IMMUNITY_SLOW, oTarget))
    {
      if(iSafeAOE_VL)
      {
        if(CastSpellAtLocation(SPELL_SLOW, lSafeAOE_VL, 1, 6, OAI_IMMUNITY_SLOW)) return TRUE;
      }
    }
    if(HasSpell(SPELL_BANE, 9, 2))
    {
      if(GetDistanceToObject(oTarget) < 10.0)
      {
        if(DoCastSpellAtObject(SPELL_BANE, OBJECT_SELF, 9, 2)) return TRUE;
      }
    }
    if(HasSpell(SPELL_COLOR_SPRAY, 11, 2)
      && !GetImmunity(OAI_IMMUNITY_DAZE, oTarget))
    {
      if(iUnsafeCone)
      {
        if(DoCastSpellAtObject(SPELL_COLOR_SPRAY, oTarget, 11, 2, OAI_IMMUNITY_DAZE)) return TRUE;
      }
    }
    return FALSE;
}

int AOE_Death(object oTarget, int iSafeAOE_VL, location lSafeAOE_VL, int iUnsafeAOE_VL, location lUnsafeAOE_VL,
                      int iSafeAOE_L, location lSafeAOE_L, int iUnsafeAOE_L, location lUnsafeAOE_L,
                      int iSafeAOE_M, location lSafeAOE_M, int iUnsafeAOE_M, location lUnsafeAOE_M,
                      int iSafeAOE_S, location lSafeAOE_S, int iUnsafeAOE_S, location lUnsafeAOE_S,
                      int iUnsafeCone, int iUnsafeCube)
{
    ddp("AOE_Death", oTarget);
    if(GetImmunity(OAI_IMMUNITY_DEATH, oTarget)) return FALSE;
    if(HasSpell(SPELL_WAIL_OF_THE_BANSHEE, 1, 18))
    {
      if(iSafeAOE_VL)
      {
        if(CastSpellAtLocation(SPELL_WAIL_OF_THE_BANSHEE, lSafeAOE_VL, 1, 18, OAI_IMMUNITY_DEATH)) return TRUE;
      }
    }
    if(HasSpell(SPELL_WEIRD, 1, 18))
    {
      if(iSafeAOE_VL)
      {
        if(CastSpellAtLocation(SPELL_WEIRD, lSafeAOE_VL, 1, 18, OAI_IMMUNITY_DEATH)) return TRUE;
      }
    }
    if(HasSpell(SPELL_IMPLOSION, 11, 18))
    {
      if(iSafeAOE_S)
      {
        if(CastSpellAtLocation(SPELL_IMPLOSION, lSafeAOE_S, 11, 18, OAI_IMMUNITY_DEATH)) return TRUE;
      }
    }
    if(HasSpell(SPELL_CIRCLE_OF_DEATH, 1, 12) && GetHitDice(oTarget) < 10)
    {
      if(iSafeAOE_M)
      {
        if(CastSpellAtLocation(SPELL_CIRCLE_OF_DEATH, lSafeAOE_M, 1, 12, OAI_IMMUNITY_DEATH)) return TRUE;
      }
    }
    if(HasSpell(SPELL_POWER_WORD_KILL, 1, 12) && GetCurrentHitPoints(oTarget) < 21)
    {
      if(iSafeAOE_M)
      {
        if(CastSpellAtLocation(SPELL_POWER_WORD_KILL, lSafeAOE_M, 1, 12, OAI_IMMUNITY_DEATH)) return TRUE;
      }
    }
    if(HasSpell(SPELL_PRISMATIC_SPRAY, 11, 14))
    {
      if(iUnsafeCone)
      {
        if(DoCastSpellAtObject(SPELL_PRISMATIC_SPRAY, oTarget, 11, 14, 0, FALSE, TRUE)) return TRUE;
      }
    }
    if(HasSpell(SPELL_CLOUDKILL, 11, 10) && GetHitDice(oTarget) < 7)
    {
      if(iUnsafeAOE_L)
      {
        if(CastSpellAtLocation(SPELL_CLOUDKILL, lUnsafeAOE_L, 11, 10, OAI_IMMUNITY_DEATH)) return TRUE;
      }
    }
    return FALSE;
}

int AOE_Other(object oTarget, int iSafeAOE_VL, location lSafeAOE_VL, int iUnsafeAOE_VL, location lUnsafeAOE_VL,
                      int iSafeAOE_L, location lSafeAOE_L, int iUnsafeAOE_L, location lUnsafeAOE_L,
                      int iSafeAOE_M, location lSafeAOE_M, int iUnsafeAOE_M, location lUnsafeAOE_M,
                      int iSafeAOE_S, location lSafeAOE_S, int iUnsafeAOE_S, location lUnsafeAOE_S,
                      int iUnsafeCone, int iUnsafeCube)
{
    ddp("AOE_Other", oTarget);
    if(HasSpell(SPELL_HORRID_WILTING, 1, 14) && GetRacialType(oTarget) != RACIAL_TYPE_UNDEAD)
    {
      if(GetRacialType(OBJECT_SELF) == RACIAL_TYPE_UNDEAD)
      {
        if(iSafeAOE_L)
        {
          if(CastSpellAtLocation(SPELL_HORRID_WILTING, lSafeAOE_L, 1, 16)) return TRUE;
        }
      }
      else
      {
        if(iUnsafeAOE_L)
        {
          if(CastSpellAtLocation(SPELL_HORRID_WILTING, lUnsafeAOE_L, 1, 16)) return TRUE;
        }
      }
    }
    if(HasSpell(SPELL_SUNBURST, 1, 16))
    {
        if(GetRacialType(oTarget) == RACIAL_TYPE_UNDEAD ||
          GetAppearanceType(oTarget) == APPEARANCE_TYPE_VAMPIRE_MALE ||
          GetAppearanceType(oTarget) == APPEARANCE_TYPE_VAMPIRE_FEMALE)
        {
          if(iSafeAOE_VL)
          {
            if(CastSpellAtLocation(SPELL_SUNBURST, lSafeAOE_VL, 1, 16)) return TRUE;
          }
        }
    }
    if(HasSpell(SPELL_BOMBARDMENT, 11, 16))
    {
      if(ShouldICast(GetLocation(OBJECT_SELF), 10.0, 2, SHAPE_SPHERE, 3))
      {
        if(DoCastSpellAtObject(SPELL_BOMBARDMENT, OBJECT_SELF, 11, 16, 0, FALSE, TRUE)) return TRUE;
      }
    }
    if(HasSpell(SPELL_EARTHQUAKE, 11, 16))
    {
      if(ShouldICast(GetLocation(OBJECT_SELF), 10.0, 2, SHAPE_SPHERE, 3))
      {
        if(DoCastSpellAtObject(SPELL_EARTHQUAKE, OBJECT_SELF, 11, 16, 0, FALSE, TRUE)) return TRUE;
      }
    }
    if(HasSpell(SPELL_CREEPING_DOOM, 1, 14) && !GetHasSpellEffect(SPELL_CREEPING_DOOM, oTarget))
    {
      if(iUnsafeAOE_VL)
      {
        if(CastSpellAtLocation(SPELL_CREEPING_DOOM, lUnsafeAOE_VL, 1, 14)) return TRUE;
      }
    }
    if(HasSpell(SPELL_ISAACS_GREATER_MISSILE_STORM, 2, 12))
    {
      if(iSafeAOE_VL)
      {
        if(CastSpellAtLocation(SPELL_ISAACS_GREATER_MISSILE_STORM, lSafeAOE_VL, 2, 12)) return TRUE;
      }
    }
    if(HasSpell(SPELL_BLADE_BARRIER, 11, 12))
    {
      if(iUnsafeCube)
      {
        if(DoCastSpellAtObject(SPELL_BLADE_BARRIER, oTarget, 11, 12)) return TRUE;
      }
    }
    if(HasSpell(SPELL_SUNBURST, 1, 16))
    {
      if(iSafeAOE_VL)
      {
        if(CastSpellAtLocation(SPELL_SUNBURST, lSafeAOE_VL, 1, 16)) return TRUE;
      }
    }
    if(iUnsafeAOE_L)
    {
      if(CastSpellAtLocation(SPELL_CLOUDKILL, lUnsafeAOE_L, 11, 10)) return TRUE;
      if(CastSpellAtLocation(SPELL_ICE_STORM, lUnsafeAOE_L, 11, 10)) return TRUE;
      if(CastSpellAtLocation(SPELL_HAMMER_OF_THE_GODS, lUnsafeAOE_L, 1, 8)) return TRUE;
    }
    if(HasSpell(SPELL_ISAACS_LESSER_MISSILE_STORM, 2, 8))
    {
      if(iSafeAOE_VL)
      {
        if(CastSpellAtLocation(SPELL_ISAACS_LESSER_MISSILE_STORM, lSafeAOE_VL, 2, 8)) return TRUE;
      }
    }
    if(HasSpell(SPELL_EVARDS_BLACK_TENTACLES, 1, 8) &&
      !GetHasSpellEffect(SPELL_EVARDS_BLACK_TENTACLES, oTarget))
    {
      if(iUnsafeAOE_M)
      {
        if(CastSpellAtLocation(SPELL_EVARDS_BLACK_TENTACLES, lUnsafeAOE_M, 1, 8)) return TRUE;
      }
    }
    if(HasSpell(SPELL_SPIKE_GROWTH, 11, 6) &&
      !GetHasSpellEffect(SPELL_SPIKE_GROWTH, oTarget))
    {
      if(iUnsafeAOE_M)
      {
        if(CastSpellAtLocation(SPELL_SPIKE_GROWTH, lUnsafeAOE_M, 11, 6)) return TRUE;
      }
    }
    if(HasSpell(SPELL_SOUND_BURST, 11, 4))
    {
      if(iUnsafeAOE_S)
      {
        if(CastSpellAtLocation(SPELL_SOUND_BURST, lUnsafeAOE_S, 11, 4)) return TRUE;
      }
    }
    return FALSE;
}

int AOE_Negative(object oTarget, int iSafeAOE_VL, location lSafeAOE_VL, int iUnsafeAOE_VL, location lUnsafeAOE_VL,
                      int iSafeAOE_L, location lSafeAOE_L, int iUnsafeAOE_L, location lUnsafeAOE_L,
                      int iSafeAOE_M, location lSafeAOE_M, int iUnsafeAOE_M, location lUnsafeAOE_M,
                      int iSafeAOE_S, location lSafeAOE_S, int iUnsafeAOE_S, location lUnsafeAOE_S,
                      int iUnsafeCone, int iUnsafeCube)
{
    ddp("AOE_Negative", oTarget);
    if(GetRacialType(oTarget) == RACIAL_TYPE_UNDEAD) return FALSE;
    if(GetImmunity(OAI_IMMUNITY_NEGATIVE, oTarget)) return FALSE;
    if(GetRacialType(OBJECT_SELF) == RACIAL_TYPE_UNDEAD)
    {
      if(HasSpell(SPELL_CIRCLE_OF_DOOM, 1, 10))
      {
        if(iSafeAOE_S)
        {
          if(CastSpellAtLocation(SPELL_CIRCLE_OF_DOOM, lSafeAOE_S, 1, 10, OAI_IMMUNITY_NEGATIVE)) return TRUE;
        }
      }
      if(HasSpell(SPELL_NEGATIVE_ENERGY_BURST, 1, 6))
      {
        if(iSafeAOE_L)
        {
          if(CastSpellAtLocation(SPELL_NEGATIVE_ENERGY_BURST, lSafeAOE_L, 1, 6, OAI_IMMUNITY_NEGATIVE)) return TRUE;
        }
      }
    }
    else
    {
      if(HasSpell(SPELL_CIRCLE_OF_DOOM, 1, 10))
      {
        if(iUnsafeAOE_S)
        {
          if(CastSpellAtLocation(SPELL_CIRCLE_OF_DOOM, lUnsafeAOE_S, 1, 10, OAI_IMMUNITY_NEGATIVE)) return TRUE;
        }
      }
      if(HasSpell(SPELL_NEGATIVE_ENERGY_BURST, 1, 6))
      {
        if(iUnsafeAOE_L)
        {
          if(CastSpellAtLocation(SPELL_NEGATIVE_ENERGY_BURST, lUnsafeAOE_L, 1, 6, OAI_IMMUNITY_NEGATIVE)) return TRUE;
        }
      }
    }
    return FALSE;
}

int CastAnAOE(object oTarget, int MinHitToCast = 2, int iStatusOnly = FALSE)
{
    if(!GetStatusCondition(OAI_I_CAN_CAST_AOES)) return FALSE;
    ddp("CastAnAOE", oTarget);

    location lSafeAOE_VL;
    location lUnsafeAOE_VL;
    location lSafeAOE_L;
    location lUnsafeAOE_L;
    location lSafeAOE_M;
    location lUnsafeAOE_M;
    location lSafeAOE_S;
    location lUnsafeAOE_S;
    location lTarget = GetLocation(oTarget);
    int iSafeAOE_VL;
    int iUnsafeAOE_VL;
    int iSafeAOE_L;
    int iUnsafeAOE_L;
    int iSafeAOE_M;
    int iUnsafeAOE_M;
    int iSafeAOE_S;
    int iUnsafeAOE_S;
    int iUnsafeCone = ShouldICast(lTarget, 11.0, MinHitToCast);
    int iUnsafeCube = ShouldICast(lTarget, 3.5, MinHitToCast, SHAPE_CUBE);

    lSafeAOE_VL = GetBestAOELocation(oTarget, 10.0, 1, 1);
    iSafeAOE_VL = ShouldICast(lSafeAOE_VL, 10.0, MinHitToCast, SHAPE_SPHERE);
    lUnsafeAOE_VL = GetBestAOELocation(oTarget, 10.0, 1, 1, FALSE);
    lUnsafeAOE_VL = ConsiderFriendlyFire(lSafeAOE_VL, lUnsafeAOE_VL, 10.0);
    iUnsafeAOE_VL = ShouldICast(lUnsafeAOE_VL, 10.0, MinHitToCast, SHAPE_SPHERE);
    if(iSafeAOE_VL || iUnsafeAOE_VL)
    {
      lSafeAOE_L = GetBestAOELocation(oTarget, 6.67, 1, 1);
      iSafeAOE_L = ShouldICast(lSafeAOE_L, 6.67, MinHitToCast, SHAPE_SPHERE);
      lUnsafeAOE_L = GetBestAOELocation(oTarget, 6.67, 1, 1, FALSE);
      lUnsafeAOE_L = ConsiderFriendlyFire(lSafeAOE_L, lUnsafeAOE_L, 6.67);
      iUnsafeAOE_L = ShouldICast(lUnsafeAOE_L, 6.67, MinHitToCast, SHAPE_SPHERE);
      if(iSafeAOE_L || iUnsafeAOE_L)
      {
        lSafeAOE_M = GetBestAOELocation(oTarget, 5.0, 1, 1);
        iSafeAOE_M = ShouldICast(lSafeAOE_M, 5.0, MinHitToCast, SHAPE_SPHERE);
        lUnsafeAOE_M = GetBestAOELocation(oTarget, 5.0, 1, 1, FALSE);
        lUnsafeAOE_M = ConsiderFriendlyFire(lSafeAOE_M, lUnsafeAOE_M, 5.0);
        iUnsafeAOE_M = ShouldICast(lUnsafeAOE_M, 5.0, MinHitToCast, SHAPE_SPHERE);
        if(iSafeAOE_M || iUnsafeAOE_M)
        {
          lSafeAOE_S = GetBestAOELocation(oTarget, 3.33, 1, 1);
          iSafeAOE_S = ShouldICast(lSafeAOE_S, 3.33, MinHitToCast, SHAPE_SPHERE);
          lUnsafeAOE_S = GetBestAOELocation(oTarget, 3.33, 1, 1, FALSE);
          lUnsafeAOE_S = ConsiderFriendlyFire(lSafeAOE_S, lUnsafeAOE_S, 3.33);
          iUnsafeAOE_S = ShouldICast(lUnsafeAOE_S, 3.33, MinHitToCast, SHAPE_SPHERE);
        }
      }
    }
    else return FALSE;

    SetLocalInt(OBJECT_SELF, "OAI_LASTSPELLHP", GetCurrentHitPoints(oTarget));

    if(iStatusOnly)
    {
      if(AOE_Status(oTarget, iSafeAOE_VL, lSafeAOE_VL, iUnsafeAOE_VL, lUnsafeAOE_VL,
                             iSafeAOE_L, lSafeAOE_L, iUnsafeAOE_L, lUnsafeAOE_L,
                             iSafeAOE_M, lSafeAOE_M, iUnsafeAOE_M, lUnsafeAOE_M,
                             iSafeAOE_S, lSafeAOE_S, iUnsafeAOE_S, lUnsafeAOE_S,
                             iUnsafeCone, iUnsafeCube))
                             return TRUE;
      return FALSE;
    }

    int iFire = GetStatusCondition(OAI_I_CAN_CAST_FIRE);
    int iIce = GetStatusCondition(OAI_I_CAN_CAST_ICE);
    int iElec = GetStatusCondition(OAI_I_CAN_CAST_ELECTRIC);
    int iAcid = GetStatusCondition(OAI_I_CAN_CAST_ACID);
    int iNeg = GetStatusCondition(OAI_I_CAN_CAST_NEGATIVE);
    int iOther = GetStatusCondition(OAI_I_CAN_CAST_OTHER);
    int iDeath = GetStatusCondition(OAI_I_CAN_CAST_INSTANT_DEATH);
    int iStat = GetStatusCondition(OAI_I_CAN_CAST_STATUS);
    int iTotal = iFire + iIce + iElec + iAcid + iNeg + iOther + iDeath + iStat;
    int iX;
    int iRand;
    if(iTotal==0)
    {
        SetStatusCondition(OAI_I_CAN_CAST_AOES, FALSE);
        return FALSE;
    }
    for (iX=0; iX < 5; iX++)
    {
      iRand = Random(iTotal) + 1;
      if(iRand==iFire)
      {
        if(AOE_Fire(oTarget, iSafeAOE_VL, lSafeAOE_VL, iUnsafeAOE_VL, lUnsafeAOE_VL,
                             iSafeAOE_L, lSafeAOE_L, iUnsafeAOE_L, lUnsafeAOE_L,
                             iSafeAOE_M, lSafeAOE_M, iUnsafeAOE_M, lUnsafeAOE_M,
                             iSafeAOE_S, lSafeAOE_S, iUnsafeAOE_S, lUnsafeAOE_S,
                             iUnsafeCone, iUnsafeCube))
                             return TRUE;
      }
      else if(iRand==iFire + iIce)
      {
        if(AOE_Ice(oTarget, iSafeAOE_VL, lSafeAOE_VL, iUnsafeAOE_VL, lUnsafeAOE_VL,
                            iSafeAOE_L, lSafeAOE_L, iUnsafeAOE_L, lUnsafeAOE_L,
                            iSafeAOE_M, lSafeAOE_M, iUnsafeAOE_M, lUnsafeAOE_M,
                            iSafeAOE_S, lSafeAOE_S, iUnsafeAOE_S, lUnsafeAOE_S,
                            iUnsafeCone, iUnsafeCube))
                            return TRUE;
      }
      else if(iRand==iFire + iIce + iElec)
      {
        if(AOE_Electric(oTarget, iSafeAOE_VL, lSafeAOE_VL, iUnsafeAOE_VL, lUnsafeAOE_VL,
                                 iSafeAOE_L, lSafeAOE_L, iUnsafeAOE_L, lUnsafeAOE_L,
                                 iSafeAOE_M, lSafeAOE_M, iUnsafeAOE_M, lUnsafeAOE_M,
                                 iSafeAOE_S, lSafeAOE_S, iUnsafeAOE_S, lUnsafeAOE_S,
                                 iUnsafeCone, iUnsafeCube))
                                 return TRUE;
      }
      else if(iRand==iFire + iIce + iElec + iAcid)
      {
        if(AOE_Acid(oTarget, iSafeAOE_VL, lSafeAOE_VL, iUnsafeAOE_VL, lUnsafeAOE_VL,
                             iSafeAOE_L, lSafeAOE_L, iUnsafeAOE_L, lUnsafeAOE_L,
                             iSafeAOE_M, lSafeAOE_M, iUnsafeAOE_M, lUnsafeAOE_M,
                             iSafeAOE_S, lSafeAOE_S, iUnsafeAOE_S, lUnsafeAOE_S,
                             iUnsafeCone, iUnsafeCube))
                             return TRUE;
      }
      else if(iRand==iFire + iIce + iElec + iAcid + iNeg)
      {
        if(AOE_Negative(oTarget, iSafeAOE_VL, lSafeAOE_VL, iUnsafeAOE_VL, lUnsafeAOE_VL,
                                 iSafeAOE_L, lSafeAOE_L, iUnsafeAOE_L, lUnsafeAOE_L,
                                 iSafeAOE_M, lSafeAOE_M, iUnsafeAOE_M, lUnsafeAOE_M,
                                 iSafeAOE_S, lSafeAOE_S, iUnsafeAOE_S, lUnsafeAOE_S,
                                 iUnsafeCone, iUnsafeCube))
                                 return TRUE;
      }
      else if(iRand==iFire + iIce + iElec + iAcid + iNeg + iOther)
      {
        if(AOE_Other(oTarget, iSafeAOE_VL, lSafeAOE_VL, iUnsafeAOE_VL, lUnsafeAOE_VL,
                              iSafeAOE_L, lSafeAOE_L, iUnsafeAOE_L, lUnsafeAOE_L,
                              iSafeAOE_M, lSafeAOE_M, iUnsafeAOE_M, lUnsafeAOE_M,
                              iSafeAOE_S, lSafeAOE_S, iUnsafeAOE_S, lUnsafeAOE_S,
                              iUnsafeCone, iUnsafeCube))
                              return TRUE;
      }
      else if(iRand==iFire + iIce + iElec + iAcid + iNeg + iOther + iDeath)
      {
        if(AOE_Death(oTarget, iSafeAOE_VL, lSafeAOE_VL, iUnsafeAOE_VL, lUnsafeAOE_VL,
                              iSafeAOE_L, lSafeAOE_L, iUnsafeAOE_L, lUnsafeAOE_L,
                              iSafeAOE_M, lSafeAOE_M, iUnsafeAOE_M, lUnsafeAOE_M,
                              iSafeAOE_S, lSafeAOE_S, iUnsafeAOE_S, lUnsafeAOE_S,
                              iUnsafeCone, iUnsafeCube))
                              return TRUE;
      }
      else if(iRand==iFire + iIce + iElec + iAcid + iNeg + iOther + iDeath + iStat)
      {
        if(AOE_Status(oTarget, iSafeAOE_VL, lSafeAOE_VL, iUnsafeAOE_VL, lUnsafeAOE_VL,
                               iSafeAOE_L, lSafeAOE_L, iUnsafeAOE_L, lUnsafeAOE_L,
                               iSafeAOE_M, lSafeAOE_M, iUnsafeAOE_M, lUnsafeAOE_M,
                               iSafeAOE_S, lSafeAOE_S, iUnsafeAOE_S, lUnsafeAOE_S,
                               iUnsafeCone, iUnsafeCube))
                               return TRUE;
      }
    }
    if(iFire) if(AOE_Fire(oTarget, iSafeAOE_VL, lSafeAOE_VL, iUnsafeAOE_VL, lUnsafeAOE_VL,
                      iSafeAOE_L, lSafeAOE_L, iUnsafeAOE_L, lUnsafeAOE_L,
                      iSafeAOE_M, lSafeAOE_M, iUnsafeAOE_M, lUnsafeAOE_M,
                      iSafeAOE_S, lSafeAOE_S, iUnsafeAOE_S, lUnsafeAOE_S,
                      iUnsafeCone, iUnsafeCube)) return TRUE;
    if(iIce) if(AOE_Ice(oTarget, iSafeAOE_VL, lSafeAOE_VL, iUnsafeAOE_VL, lUnsafeAOE_VL,
                      iSafeAOE_L, lSafeAOE_L, iUnsafeAOE_L, lUnsafeAOE_L,
                      iSafeAOE_M, lSafeAOE_M, iUnsafeAOE_M, lUnsafeAOE_M,
                      iSafeAOE_S, lSafeAOE_S, iUnsafeAOE_S, lUnsafeAOE_S,
                      iUnsafeCone, iUnsafeCube)) return TRUE;
    if(iElec) if(AOE_Electric(oTarget, iSafeAOE_VL, lSafeAOE_VL, iUnsafeAOE_VL, lUnsafeAOE_VL,
                      iSafeAOE_L, lSafeAOE_L, iUnsafeAOE_L, lUnsafeAOE_L,
                      iSafeAOE_M, lSafeAOE_M, iUnsafeAOE_M, lUnsafeAOE_M,
                      iSafeAOE_S, lSafeAOE_S, iUnsafeAOE_S, lUnsafeAOE_S,
                      iUnsafeCone, iUnsafeCube)) return TRUE;
    if(iAcid) if(AOE_Acid(oTarget, iSafeAOE_VL, lSafeAOE_VL, iUnsafeAOE_VL, lUnsafeAOE_VL,
                      iSafeAOE_L, lSafeAOE_L, iUnsafeAOE_L, lUnsafeAOE_L,
                      iSafeAOE_M, lSafeAOE_M, iUnsafeAOE_M, lUnsafeAOE_M,
                      iSafeAOE_S, lSafeAOE_S, iUnsafeAOE_S, lUnsafeAOE_S,
                      iUnsafeCone, iUnsafeCube)) return TRUE;
    if(iNeg) if(AOE_Negative(oTarget, iSafeAOE_VL, lSafeAOE_VL, iUnsafeAOE_VL, lUnsafeAOE_VL,
                      iSafeAOE_L, lSafeAOE_L, iUnsafeAOE_L, lUnsafeAOE_L,
                      iSafeAOE_M, lSafeAOE_M, iUnsafeAOE_M, lUnsafeAOE_M,
                      iSafeAOE_S, lSafeAOE_S, iUnsafeAOE_S, lUnsafeAOE_S,
                      iUnsafeCone, iUnsafeCube)) return TRUE;
    if(iOther) if(AOE_Other(oTarget, iSafeAOE_VL, lSafeAOE_VL, iUnsafeAOE_VL, lUnsafeAOE_VL,
                      iSafeAOE_L, lSafeAOE_L, iUnsafeAOE_L, lUnsafeAOE_L,
                      iSafeAOE_M, lSafeAOE_M, iUnsafeAOE_M, lUnsafeAOE_M,
                      iSafeAOE_S, lSafeAOE_S, iUnsafeAOE_S, lUnsafeAOE_S,
                      iUnsafeCone, iUnsafeCube)) return TRUE;
    if(iDeath) if(AOE_Death(oTarget, iSafeAOE_VL, lSafeAOE_VL, iUnsafeAOE_VL, lUnsafeAOE_VL,
                      iSafeAOE_L, lSafeAOE_L, iUnsafeAOE_L, lUnsafeAOE_L,
                      iSafeAOE_M, lSafeAOE_M, iUnsafeAOE_M, lUnsafeAOE_M,
                      iSafeAOE_S, lSafeAOE_S, iUnsafeAOE_S, lUnsafeAOE_S,
                      iUnsafeCone, iUnsafeCube)) return TRUE;
    if(iStat) if(AOE_Status(oTarget, iSafeAOE_VL, lSafeAOE_VL, iUnsafeAOE_VL, lUnsafeAOE_VL,
                      iSafeAOE_L, lSafeAOE_L, iUnsafeAOE_L, lUnsafeAOE_L,
                      iSafeAOE_M, lSafeAOE_M, iUnsafeAOE_M, lUnsafeAOE_M,
                      iSafeAOE_S, lSafeAOE_S, iUnsafeAOE_S, lUnsafeAOE_S,
                      iUnsafeCone, iUnsafeCube)) return TRUE;
    return FALSE;
}

int Single_Fire(object oTarget)
{
    ddp("Single_Fire", oTarget);
    if(GetImmunity(OAI_IMMUNITY_FIRE, oTarget)) return FALSE;
    if(DoCastSpellAtObject(SPELL_INFERNO, oTarget, 2, 10, OAI_IMMUNITY_FIRE, FALSE, TRUE)) return TRUE;
    if(DoCastSpellAtObject(SPELL_FLAME_ARROW, oTarget, 2, 6, OAI_IMMUNITY_FIRE, FALSE, TRUE)) return TRUE;
    if(DoCastSpellAtObject(SPELL_FLAME_LASH, oTarget, 2, 4, OAI_IMMUNITY_FIRE)) return TRUE;
    return FALSE;
}

int Single_Ice(object oTarget)
{
    ddp("Single_Ice", oTarget);
    if(GetImmunity(OAI_IMMUNITY_ICE, oTarget)) return FALSE;
    if(DoCastSpellAtObject(SPELL_RAY_OF_FROST, oTarget, 11, 1, OAI_IMMUNITY_ICE)) return TRUE;
    return FALSE;
}

int Single_Electric(object oTarget)
{
    ddp("Single_Electric", oTarget);
    if(GetImmunity(OAI_IMMUNITY_ELECTRIC, oTarget)) return FALSE;
    if(DoCastSpellAtObject(SPELL_CHAIN_LIGHTNING, oTarget, 1, 12, OAI_IMMUNITY_ELECTRIC, FALSE, TRUE)) return TRUE;
    if(DoCastSpellAtObject(SPELL_LIGHTNING_BOLT, oTarget, 11, 6, OAI_IMMUNITY_ELECTRIC)) return TRUE;
    if(DoCastSpellAtObject(SPELL_ELECTRIC_JOLT, oTarget, 2, 1, OAI_IMMUNITY_ELECTRIC)) return TRUE;
    return FALSE;
}

int Single_Acid(object oTarget)
{
    ddp("Single_Acid", oTarget);
    if(GetImmunity(OAI_IMMUNITY_ACID, oTarget)) return FALSE;
    if(DoCastSpellAtObject(SPELL_MELFS_ACID_ARROW, oTarget, 2, 4, OAI_IMMUNITY_ACID, FALSE, TRUE)) return TRUE;
    if(DoCastSpellAtObject(SPELL_ACID_SPLASH, oTarget, 2, 1, OAI_IMMUNITY_ACID)) return TRUE;
    return FALSE;
}

int Single_Negative(object oTarget)
{
    ddp("Single_Negative", oTarget);
    if(GetRacialType(oTarget) == RACIAL_TYPE_UNDEAD) return FALSE;
    if(GetImmunity(OAI_IMMUNITY_NEGATIVE, oTarget)) return FALSE;
    if(DoCastSpellAtObject(SPELL_HARM, oTarget, 3, 14, OAI_IMMUNITY_NEGATIVE, FALSE, TRUE)) return TRUE;
    if(GetImmunity(OAI_IMMUNITY_DRAIN, oTarget)) return FALSE;
    if(DoCastSpellAtObject(SPELL_ENERGY_DRAIN, oTarget, 2, 18, OAI_IMMUNITY_DRAIN)) return TRUE;
    if(DoCastSpellAtObject(SPELL_INFLICT_CRITICAL_WOUNDS, oTarget, 3, 8, OAI_IMMUNITY_NEGATIVE, FALSE, TRUE)) return TRUE;
    if(DoCastSpellAtObject(SPELL_ENERVATION, oTarget, 2, 8, OAI_IMMUNITY_DRAIN)) return TRUE;
    if(DoCastSpellAtObject(SPELL_INFLICT_SERIOUS_WOUNDS, oTarget, 3, 6, OAI_IMMUNITY_NEGATIVE, FALSE, TRUE)) return TRUE;
    if(DoCastSpellAtObject(SPELL_VAMPIRIC_TOUCH, oTarget, 3, 6, OAI_IMMUNITY_NEGATIVE, FALSE, TRUE)) return TRUE;
    if(DoCastSpellAtObject(SPELL_INFLICT_MODERATE_WOUNDS, oTarget, 3, 4, OAI_IMMUNITY_NEGATIVE)) return TRUE;
    if(DoCastSpellAtObject(SPELL_RAY_OF_ENFEEBLEMENT, oTarget, 2, 2, OAI_IMMUNITY_DRAIN)) return TRUE;
    if(DoCastSpellAtObject(SPELL_INFLICT_LIGHT_WOUNDS, oTarget, 3, 2, OAI_IMMUNITY_NEGATIVE)) return TRUE;
    if(DoCastSpellAtObject(SPELL_INFLICT_MINOR_WOUNDS, oTarget, 3, 1, OAI_IMMUNITY_NEGATIVE)) return TRUE;
    return FALSE;
}

int Single_Death(object oTarget)
{
    ddp("Single_Death", oTarget);
    if(GetRacialType(oTarget) == RACIAL_TYPE_UNDEAD) return FALSE;
    if(DoCastSpellAtObject(SPELL_FINGER_OF_DEATH, oTarget, 2, 14, OAI_IMMUNITY_DEATH, FALSE, TRUE)) return TRUE;
    if(DoCastSpellAtObject(SPELL_DESTRUCTION, oTarget, 2, 14, OAI_IMMUNITY_DEATH)) return TRUE;
    if(GetImmunity(OAI_IMMUNITY_DEATH, oTarget)) return FALSE;
    if(DoCastSpellAtObject(SPELL_CIRCLE_OF_DEATH, oTarget, 1, 12, OAI_IMMUNITY_DEATH)) return TRUE;
    if(DoCastSpellAtObject(SPELL_PHANTASMAL_KILLER, oTarget, 2, 8, OAI_IMMUNITY_DEATH)) return TRUE;
    if(DoCastSpellAtObject(SPELL_SLAY_LIVING, oTarget, 2, 10, OAI_IMMUNITY_DEATH)) return TRUE;
    return FALSE;
}

int Single_Other(object oTarget)
{
    ddp("Single_Other", oTarget);
    if(DoCastSpellAtObject(SPELL_BIGBYS_CRUSHING_HAND, oTarget, 2, 18)) return TRUE;
    if(DoCastSpellAtObject(SPELL_BIGBYS_CLENCHED_FIST, oTarget, 2, 16)) return TRUE;
    if(DoCastSpellAtObject(SPELL_DROWN, oTarget, 2, 12, 0, FALSE, TRUE)) return TRUE;
    if(DoCastSpellAtObject(SPELL_QUILLFIRE, oTarget, 2, 6, 0, FALSE, TRUE)) return TRUE;
    if(DoCastSpellAtObject(SPELL_SEARING_LIGHT, oTarget, 2, 6)) return TRUE;
    if(DoCastSpellAtObject(SPELL_MAGIC_MISSILE, oTarget, 2, 2, 0, FALSE, TRUE)) return TRUE;
    return FALSE;
}

int DispellFoe(object oTarget)
{
    ddp("DispellFoe", oTarget);
    object oMaster = GetMaster(oTarget);
    if(GetIsObjectValid(oMaster))
    {
      if((GetAssociate(ASSOCIATE_TYPE_SUMMONED, oMaster) == oTarget ||
        GetAssociate(ASSOCIATE_TYPE_FAMILIAR, oMaster) == oTarget ||
        GetAssociate(ASSOCIATE_TYPE_ANIMALCOMPANION, oMaster) == oTarget ))
      {
        if(DoCastSpellAtObject(SPELL_DISMISSAL, oTarget, 11, 10, 0, FALSE, TRUE)) return TRUE;
      }
    }

    if(GetHasBreachableEnhancement(oTarget))
    {
      if(DoCastSpellAtObject(SPELL_GREATER_SPELL_BREACH, oTarget, 2, 12, 0, FALSE, TRUE)) return TRUE;
      if(DoCastSpellAtObject(SPELL_LESSER_SPELL_BREACH, oTarget, 2, 8, 0, FALSE, TRUE)) return TRUE;
    }

    if(ManageEnemyAOE()) return TRUE;

    if(GetHasDispellableEnhancement(oTarget))
    {
      if(DoCastSpellAtObject(SPELL_MORDENKAINENS_DISJUNCTION, oTarget, 11, 18, 0, FALSE, TRUE)) return TRUE;
      if(DoCastSpellAtObject(SPELL_GREATER_DISPELLING, oTarget, 2, 12, 0, FALSE, TRUE)) return TRUE;
      if(DoCastSpellAtObject(SPELL_DISPEL_MAGIC, oTarget, 2, 6, 0, FALSE, TRUE)) return TRUE;
      if(DoCastSpellAtObject(SPELL_LESSER_DISPEL, oTarget, 11, 4, 0, FALSE, TRUE)) return TRUE;
    }
    return FALSE;
}

int Single_Status(object oTarget)
{
    ddp("Single_Status", oTarget);
    if(GetCurrentHitPoints(oTarget) < 151)
    {
      if(DoCastSpellAtObject(SPELL_POWER_WORD_STUN, oTarget, 11, 14, 0, FALSE, TRUE)) return TRUE;
    }

    if(!GetImmunity(OAI_IMMUNITY_PARALYZE, oTarget))
    {
      if(DoCastSpellAtObject(SPELL_BIGBYS_GRASPING_HAND, oTarget, 2, 14, OAI_IMMUNITY_PARALYZE)) return TRUE;
    }

    if(GetLevelByClass(CLASS_TYPE_WIZARD) > 0 &&
      !GetImmunity(OAI_IMMUNITY_DRAIN, oTarget))
    {
      if(DoCastSpellAtObject(SPELL_FEEBLEMIND, oTarget, 2, 10, OAI_IMMUNITY_DRAIN, FALSE, TRUE)) return TRUE;
    }

    if(!GetImmunity(OAI_IMMUNITY_PETRIFY, oTarget))
    {
      if(DoCastSpellAtObject(SPELL_FLESH_TO_STONE, oTarget, 2, 12, OAI_IMMUNITY_PETRIFY, FALSE, TRUE)) return TRUE;
    }

    int iRace = GetRacialType(oTarget);
    if(!GetImmunity(OAI_IMMUNITY_DOMINATE, oTarget))
    {
      if(iRace==RACIAL_TYPE_UNDEAD)
      {
        if(DoCastSpellAtObject(SPELL_CONTROL_UNDEAD, oTarget, 2, 14, OAI_IMMUNITY_DOMINATE, FALSE, TRUE)) return TRUE;
      }

      if(iRace==RACIAL_TYPE_ANIMAL)
      {
        if(DoCastSpellAtObject(SPELL_DOMINATE_ANIMAL, oTarget, 2, 6, OAI_IMMUNITY_DOMINATE)) return TRUE;
        if(DoCastSpellAtObject(SPELL_CHARM_PERSON_OR_ANIMAL, oTarget, 2, 4, OAI_IMMUNITY_DOMINATE)) return TRUE;
      }
      if(iRace == RACIAL_TYPE_DWARF ||
        iRace == RACIAL_TYPE_ELF ||
        iRace == RACIAL_TYPE_GNOME ||
        iRace == RACIAL_TYPE_HALFLING ||
        iRace == RACIAL_TYPE_HUMAN ||
        iRace == RACIAL_TYPE_HALFELF ||
        iRace == RACIAL_TYPE_HALFORC)
      {
          if(DoCastSpellAtObject(SPELL_DOMINATE_PERSON, oTarget, 2, 10, OAI_IMMUNITY_DOMINATE)) return TRUE;
          if(DoCastSpellAtObject(SPELL_CHARM_PERSON_OR_ANIMAL, oTarget, 2, 4, OAI_IMMUNITY_DOMINATE)) return TRUE;
          if(DoCastSpellAtObject(SPELL_CHARM_PERSON, oTarget, 2, 2, OAI_IMMUNITY_DOMINATE)) return TRUE;
      }

      if(DoCastSpellAtObject(SPELL_DOMINATE_MONSTER, oTarget, 2, 18, OAI_IMMUNITY_DOMINATE)) return TRUE;
      if(DoCastSpellAtObject(SPELL_CHARM_MONSTER, oTarget, 2, 6, OAI_IMMUNITY_DOMINATE)) return TRUE;
    }

    if(!GetImmunity(OAI_IMMUNITY_DAZE, oTarget))
    {
      if(DoCastSpellAtObject(SPELL_BIGBYS_FORCEFUL_HAND, oTarget, 2, 12, OAI_IMMUNITY_DAZE)) return TRUE;
    }

    if(!GetImmunity(OAI_IMMUNITY_PARALYZE, oTarget))
    {
      if(iRace==RACIAL_TYPE_ANIMAL)
      {
        if(DoCastSpellAtObject(SPELL_HOLD_ANIMAL, oTarget, 2, 4, OAI_IMMUNITY_PARALYZE)) return TRUE;
      }
      if(iRace == RACIAL_TYPE_DWARF ||
        iRace == RACIAL_TYPE_ELF ||
        iRace == RACIAL_TYPE_GNOME ||
        iRace == RACIAL_TYPE_HALFLING ||
        iRace == RACIAL_TYPE_HUMAN ||
        iRace == RACIAL_TYPE_HALFELF ||
        iRace == RACIAL_TYPE_HALFORC)
      {
        if(DoCastSpellAtObject(SPELL_HOLD_PERSON, oTarget, 2, 6, OAI_IMMUNITY_PARALYZE)) return TRUE;
      }

      if(DoCastSpellAtObject(SPELL_HOLD_MONSTER, oTarget, 2, 10, OAI_IMMUNITY_PARALYZE)) return TRUE;
    }

    if(DoCastSpellAtObject(SPELL_BIGBYS_INTERPOSING_HAND, oTarget, 2, 10)) return TRUE;

    if(!GetImmunity(OAI_IMMUNITY_CURSE, oTarget))
    {
      if(DoCastSpellAtObject(SPELL_BESTOW_CURSE, oTarget, 3, 8, OAI_IMMUNITY_CURSE)) return TRUE;
    }
    if(!GetImmunity(OAI_IMMUNITY_POISON, oTarget))
    {
      if(DoCastSpellAtObject(SPELL_POISON, oTarget, 2, 8, OAI_IMMUNITY_POISON)) return TRUE;
    }
    if((d4()==1 || iRace == GetRacialType(OBJECT_SELF))
      && iRace != RACIAL_TYPE_ELEMENTAL
      && iRace != RACIAL_TYPE_UNDEAD
      && iRace != RACIAL_TYPE_VERMIN
      && iRace != RACIAL_TYPE_CONSTRUCT)
    {
      if(DoCastSpellAtObject(SPELL_TASHAS_HIDEOUS_LAUGHTER, oTarget, 2, 4)) return TRUE;
    }
    if(!GetImmunity(OAI_IMMUNITY_KNOCKDOWN, oTarget))
    {
      if(DoCastSpellAtObject(SPELL_BALAGARNSIRONHORN, oTarget, 1, 4, OAI_IMMUNITY_KNOCKDOWN)) return TRUE;
    }
    if(!GetImmunity(OAI_IMMUNITY_FEAR, oTarget))
    {
      if(DoCastSpellAtObject(SPELL_SCARE, oTarget, 11, 2, OAI_IMMUNITY_FEAR)) return TRUE;
    }
    if(!GetImmunity(OAI_IMMUNITY_BLIND, oTarget))
    {
      if(DoCastSpellAtObject(SPELL_BLINDNESS_AND_DEAFNESS, oTarget, 2, 4, OAI_IMMUNITY_BLIND)) return TRUE;
    }
    if(!GetImmunity(OAI_IMMUNITY_DRAIN, oTarget))
    {
      if(DoCastSpellAtObject(SPELL_DOOM, oTarget, 2, 2, OAI_IMMUNITY_DRAIN)) return TRUE;
    }
    if(!GetImmunity(OAI_IMMUNITY_DAZE, oTarget))
    {
      if(DoCastSpellAtObject(SPELL_DAZE, oTarget, 2, 1, OAI_IMMUNITY_DAZE)) return TRUE;
      if(DoCastSpellAtObject(SPELL_GHOUL_TOUCH, oTarget, 3, 4, OAI_IMMUNITY_DAZE)) return TRUE;
    }
    if(!GetImmunity(OAI_IMMUNITY_DISEASE, oTarget))
    {
      if(DoCastSpellAtObject(SPELL_CONTAGION, oTarget, 3, 8, OAI_IMMUNITY_DISEASE)) return TRUE; //...diseases are so worthless...
    }
    if(DoCastSpellAtObject(SPELL_FLARE, oTarget, 2, 1)) return TRUE;
    return FALSE;
}

int CastASingle(object oTarget)
{
    ddp("CastASingle", oTarget);
    int iFire = GetStatusCondition(OAI_I_CAN_CAST_FIRE);
    int iIce = GetStatusCondition(OAI_I_CAN_CAST_ICE);
    int iElec = GetStatusCondition(OAI_I_CAN_CAST_ELECTRIC);
    int iAcid = GetStatusCondition(OAI_I_CAN_CAST_ACID);
    int iNeg = GetStatusCondition(OAI_I_CAN_CAST_NEGATIVE);
    int iOther = GetStatusCondition(OAI_I_CAN_CAST_OTHER);
    int iDeath = GetStatusCondition(OAI_I_CAN_CAST_INSTANT_DEATH);
    int iStat = GetStatusCondition(OAI_I_CAN_CAST_STATUS);
    int iTotal = iFire + iIce + iElec + iAcid + iNeg + iOther + iDeath + iStat;
    int iX;
    int iRand;
    if(iTotal==0) return FALSE;
    for (iX=0; iX < 5; iX++)
    {
      iRand = Random(iTotal) + 1;
      if(iRand==iFire)
      {
        if(Single_Fire(oTarget)) return TRUE;
      }
      else if(iRand==iFire + iIce)
      {
        if(Single_Ice(oTarget)) return TRUE;
      }
      else if(iRand==iFire + iIce + iElec)
     {
        if(Single_Electric(oTarget)) return TRUE;
      }
      else if(iRand==iFire + iIce + iElec + iAcid)
      {
        if(Single_Acid(oTarget)) return TRUE;
      }
      else if(iRand==iFire + iIce + iElec + iAcid + iNeg)
      {
        if(Single_Negative(oTarget)) return TRUE;
      }
      else if(iRand==iFire + iIce + iElec + iAcid + iNeg + iOther)
      {
        if(Single_Other(oTarget)) return TRUE;
      }
      else if(iRand==iFire + iIce + iElec + iAcid + iNeg + iOther + iDeath)
      {
        if(Single_Death(oTarget)) return TRUE;
      }
      else if(iRand==iFire + iIce + iElec + iAcid + iNeg + iOther + iDeath + iStat)
      {
        if(Single_Status(oTarget)) return TRUE;
      }
    }
    if(iDeath) if(Single_Death(oTarget))    return TRUE;
    if(iOther) if(Single_Other(oTarget))    return TRUE;
    if(iStat)  if(Single_Status(oTarget))   return TRUE;
    if(iFire)  if(Single_Fire(oTarget))     return TRUE;
    if(iIce)   if(Single_Ice(oTarget))      return TRUE;
    if(iElec)  if(Single_Electric(oTarget)) return TRUE;
    if(iAcid)  if(Single_Acid(oTarget))     return TRUE;
    if(iNeg)   if(Single_Negative(oTarget)) return TRUE;
    return FALSE;
}

object SneakAttackTarget(object oFoe, float fMaxRange = 3.0)
{
    ddp("SneakAttackTarget", oFoe);
    if(GetAttackTarget(oFoe) != OBJECT_SELF) return oFoe;
    int iC=1;
    object oO = GetNearestCreature(CREATURE_TYPE_REPUTATION, REPUTATION_TYPE_ENEMY, OBJECT_SELF, 1, CREATURE_TYPE_IS_ALIVE, TRUE, CREATURE_TYPE_PERCEPTION, PERCEPTION_SEEN);
    while(GetIsObjectValid(oO) && GetDistanceToObject(oO) < fMaxRange)
    {
      if(GetAttackTarget(oO) != OBJECT_SELF) return oO;
      iC++;
      oO = GetNearestCreature(CREATURE_TYPE_REPUTATION, REPUTATION_TYPE_ENEMY, OBJECT_SELF, iC, CREATURE_TYPE_IS_ALIVE, TRUE, CREATURE_TYPE_PERCEPTION, PERCEPTION_SEEN);
    }
    SetLocalObject(OBJECT_SELF, "OAI_LASTTARGET", oFoe);
    ddp("-SneakAttackTarget", oFoe, "Targeted");
    return oFoe;
}

void doFighting(object oLastAttack, object oTarget)
{
    ddp("doFighting", oLastAttack);
    oTarget = DetermineEnemy(oLastAttack, oTarget);
    EquipAppropriateWeapons(oTarget);
    if(!GetWeaponRanged(GetItemInSlot(INVENTORY_SLOT_RIGHTHAND)))
    {
      DelayCommand(0.0, MeleeFighting(oTarget));
      return;
    }
    int iAC = GetAC(oTarget);
    int iNewBAB = MyCappedHD + 5 + Random(10);
    if(GetHasFeat(FEAT_DIVINE_SHIELD) && !GetHasSpellEffect(474))
    {
      ActionUseFeat(FEAT_DIVINE_SHIELD, OBJECT_SELF);
    }
    else if(GetHasFeat(FEAT_SHADOW_EVADE) && !GetHasSpellEffect(477))
    {
      ActionUseFeat(FEAT_SHADOW_EVADE, OBJECT_SELF);
    }
    else if(GetHasFeat(471) && !GetHasSpellEffect(477))
    {
      ActionUseFeat(471, OBJECT_SELF);
    }
    else if(GetHasFeat(468) && !GetHasSpellEffect(477))
    {
      ActionUseFeat(468, OBJECT_SELF);
    }
    else if(GetBattleCondition(OAI_BLINK_SELF))
    {
      if(Random(100) >= GetLocalInt(OBJECT_SELF, "OAI_BLINK_FAILURE")) BlinkMove();
    }
    if(GetHasFeat(FEAT_HIDE_IN_PLAIN_SIGHT))
    {
      ActionUseSkill(SKILL_HIDE, OBJECT_SELF);
    }
    if(GetLevelByClass(CLASS_TYPE_ARCANE_ARCHER) > 0)
    {
      if(GetHasFeat(454))
      {
        ActionUseFeat(454, oTarget);
        ActionAttack(oTarget);
        return;
      }
      if(GetHasFeat(453))
      {
        ActionUseFeat(453, OBJECT_SELF);
        ActionAttack(oTarget);
        return;
      }
      if(GetHasFeat(450))
      {
        ActionUseFeat(450, oTarget);
        ActionAttack(oTarget);
        return;
      }
      if(GetHasFeat(452))
      {
        ActionUseFeat(452, oTarget);
        ActionAttack(oTarget);
        return;
      }
      if(GetHasFeat(451))
      {
        ActionUseFeat(451, oTarget);
        ActionAttack(oTarget);
        return;
      }
    }
    if((iNewBAB - 1) > iAC)
    {
      if(GetHasFeat(FEAT_CALLED_SHOT) && !GetHasFeatEffect(FEAT_CALLED_SHOT, oTarget))
      {
        ActionUseFeat(FEAT_CALLED_SHOT, oTarget);
        ActionAttack(oTarget);
        return;
      }
      if(GetHasFeat(FEAT_RAPID_SHOT))
      {
        ActionUseFeat(FEAT_RAPID_SHOT, oTarget);
        ActionAttack(oTarget);
        return;
      }
    }

    switch (Random(64))
    {
      case 0: PlayVoiceChat(VOICE_CHAT_TAUNT); break;
      case 1: PlayVoiceChat(VOICE_CHAT_THREATEN); break;
      case 2: PlayVoiceChat(VOICE_CHAT_BATTLECRY1); break;
      case 3: PlayVoiceChat(VOICE_CHAT_BATTLECRY2); break;
      case 4: PlayVoiceChat(VOICE_CHAT_BATTLECRY3); break;
      case 5: PlayVoiceChat(VOICE_CHAT_GATTACK1); break;
      case 6: PlayVoiceChat(VOICE_CHAT_GATTACK2); break;
      case 7: PlayVoiceChat(VOICE_CHAT_GATTACK3); break;
    }
    ActionAttack(oTarget);
}

void MeleeFighting(object oTarget)
{
    ddp("MeleeFighting", oTarget);
    int iAC = GetAC(oTarget);
    int iNewBAB = MyCappedHD + 5 + Random(10);
    object oMyWeapon = GetItemInSlot(INVENTORY_SLOT_RIGHTHAND);
    int iHaveWeapon = GetIsObjectValid(oMyWeapon);
    int iSize = 4 * (GetCreatureSize(OBJECT_SELF) - GetCreatureSize(oTarget));
    if(GetHasFeat(FEAT_BARBARIAN_RAGE) && !GetHasSpellEffect(307) && GetLevelByClass(CLASS_TYPE_BARBARIAN) > 0)
    {
      ActionUseFeat(FEAT_BARBARIAN_RAGE, OBJECT_SELF);
    }
    else if(GetHasFeat(FEAT_DIVINE_MIGHT) && !GetHasSpellEffect(473))
    {
      ActionUseFeat(FEAT_DIVINE_MIGHT, OBJECT_SELF);
    }
    else if(GetHasFeat(FEAT_DIVINE_SHIELD) && !GetHasSpellEffect(474))
    {
      ActionUseFeat(FEAT_DIVINE_SHIELD, OBJECT_SELF);
    }
    else if(GetHasFeat(FEAT_SHADOW_EVADE) && !GetHasSpellEffect(477))
    {
      ActionUseFeat(FEAT_SHADOW_EVADE, OBJECT_SELF);
    }
    else if(GetHasFeat(471) && !GetHasSpellEffect(477))
    {
      ActionUseFeat(471, OBJECT_SELF);
    }
    else if(GetHasFeat(468) && !GetHasSpellEffect(477))
    {
      ActionUseFeat(468, OBJECT_SELF);
    }
    else if(GetHasFeat(FEAT_TYMORAS_SMILE) && !GetHasSpellEffect(478))
    {
      ActionUseFeat(FEAT_TYMORAS_SMILE, OBJECT_SELF);
    }
    else if(GetBattleCondition(OAI_BLINK_SELF))
    {
      if(Random(100) >= GetLocalInt(OBJECT_SELF, "OAI_BLINK_FAILURE")) BlinkMelee(oTarget);
    }
    if(GetHasFeat(FEAT_HIDE_IN_PLAIN_SIGHT))
    {
      ActionUseSkill(SKILL_HIDE, OBJECT_SELF);
    }
    if(GetHasFeat(FEAT_QUIVERING_PALM))
    {
      if((!iHaveWeapon ||
        GetBaseItemType(oMyWeapon) == BASE_ITEM_KAMA) &&
        GetRacialType(oTarget) != RACIAL_TYPE_CONSTRUCT &&
        GetRacialType(oTarget) != RACIAL_TYPE_UNDEAD)
        {
          // Can insta-kill. Roll is DC10 + 0.5 * monks level + wis modifier vs Fort
          if(iNewBAB >= iAC)
          {
            if((10 + (GetLevelByClass(CLASS_TYPE_MONK)/2) + GetAbilityModifier(ABILITY_WISDOM)) > GetFortitudeSavingThrow(oTarget) + 5)
            {
              ActionUseFeat(FEAT_QUIVERING_PALM, oTarget);
              ActionAttack(oTarget);
              return;
            }
          }
        }
    }
    if(GetHasFeat(FEAT_SMITE_EVIL) && GetAlignmentGoodEvil(oTarget) == ALIGNMENT_EVIL)
    {
      ActionUseFeat(FEAT_SMITE_EVIL, oTarget);
      ActionAttack(oTarget);
      return;
    }

    if(GetHasFeat(472) && GetAlignmentGoodEvil(oTarget) == ALIGNMENT_GOOD)
    {
      ActionUseFeat(FEAT_SMITE_EVIL, oTarget);
      ActionAttack(oTarget);
      return;
    }
    if(GetHasFeat(FEAT_SHADOW_DAZE) && !GetHasFeatEffect(FEAT_SHADOW_DAZE, oTarget))
    {
      ActionUseFeat(FEAT_SHADOW_DAZE, oTarget);
      ActionAttack(oTarget);
      return;
    }
    if(!GetHasFeatEffect(FEAT_KNOCKDOWN, oTarget) && !GetHasFeatEffect(FEAT_IMPROVED_KNOCKDOWN, oTarget))
    {
      if(GetHasFeat(FEAT_IMPROVED_KNOCKDOWN) && iSize > -9 && (iNewBAB + iSize) > iAC)
      {
        ActionUseFeat(FEAT_IMPROVED_KNOCKDOWN, oTarget);
        ActionAttack(oTarget);
        return;
      }
      else if(GetHasFeat(FEAT_KNOCKDOWN) && iSize > -5 && (iNewBAB + iSize) > iAC)
      {
        ActionUseFeat(FEAT_KNOCKDOWN, oTarget);
        ActionAttack(oTarget);
        return;
      }
    }
    if(!GetHasFeatEffect(FEAT_EXPERTISE, oTarget) && !GetHasFeatEffect(FEAT_IMPROVED_EXPERTISE, oTarget))
    {
      if(GetHasFeat(FEAT_IMPROVED_EXPERTISE) && (iNewBAB - 10) > iAC)
      {
        ActionUseFeat(FEAT_IMPROVED_EXPERTISE, oTarget);
        ActionAttack(oTarget);
        return;
      }
      else if(GetHasFeat(FEAT_EXPERTISE) && (iNewBAB - 5) > iAC)
      {
        ActionUseFeat(FEAT_EXPERTISE, oTarget);
        ActionAttack(oTarget);
        return;
      }
    }
    if(!OAI_DISABLE_DISARM && GetIsObjectValid(GetItemInSlot(INVENTORY_SLOT_RIGHTHAND, oTarget)))
    {
      if(GetHasFeat(FEAT_IMPROVED_DISARM) && (iNewBAB - 3) > iAC)
      {
        ActionUseFeat(FEAT_IMPROVED_DISARM, oTarget);
        ActionAttack(oTarget);
        return;
      }
      if(GetHasFeat(FEAT_DISARM) && (iNewBAB - 5) > iAC)
      {
        ActionUseFeat(FEAT_DISARM, oTarget);
        ActionAttack(oTarget);
        return;
      }
    }
    if(GetHasFeat(FEAT_CALLED_SHOT) &&
      !GetHasFeatEffect(FEAT_CALLED_SHOT,oTarget) &&
      (iNewBAB - 1) > iAC)
    {
      ActionUseFeat(FEAT_CALLED_SHOT, oTarget);
      ActionAttack(oTarget);
      return;
    }

    if(!GetHasFeatEffect(FEAT_SAP, oTarget) &&
     !GetHasFeatEffect(FEAT_STUNNING_FIST, oTarget) &&
     !iHaveWeapon)
    {
      if(GetHasFeat(FEAT_STUNNING_FIST) && (iNewBAB - 1) > iAC)
      {
        ActionUseFeat(FEAT_STUNNING_FIST, oTarget);
        ActionAttack(oTarget);
        return;
      }
      if(GetHasFeat(FEAT_SAP) && (iNewBAB - 3) > iAC)
      {
        ActionUseFeat(FEAT_SAP, oTarget);
        ActionAttack(oTarget);
        return;
      }
    }
    if(GetHasFeat(FEAT_FLURRY_OF_BLOWS) &&
      (iNewBAB - 1) > iAC &&
      (!iHaveWeapon ||
      GetBaseItemType(oMyWeapon) == BASE_ITEM_KAMA))
    {
      ActionUseFeat(FEAT_FLURRY_OF_BLOWS, oTarget);
      return;
    }
    if(GetHasFeat(FEAT_IMPROVED_POWER_ATTACK) && (iNewBAB - 9) > iAC)
    {
      ActionUseFeat(FEAT_IMPROVED_POWER_ATTACK, oTarget);
      return;
    }
    if(GetHasFeat(FEAT_POWER_ATTACK) && (iNewBAB - 4) > iAC)
    {
      ActionUseFeat(FEAT_POWER_ATTACK, oTarget);
      return;
    }
    if(!OAI_DISABLE_PICKPOCKET && GetSkillRank(SKILL_PICK_POCKET) > iAC && d2()==1)
    {
      ActionUseSkill(SKILL_PICK_POCKET, oTarget);
      ActionAttack(oTarget);
      return;
    }
    if(GetSkillRank(SKILL_TAUNT) > iAC && d2()==1)
    {
      switch (Random(20))
      {
        case 0: PlayVoiceChat(VOICE_CHAT_TAUNT); break;
        case 1: PlayVoiceChat(VOICE_CHAT_THREATEN); break;
        case 2: PlayVoiceChat(VOICE_CHAT_BATTLECRY1); break;
        case 3: PlayVoiceChat(VOICE_CHAT_BATTLECRY2); break;
        case 4: PlayVoiceChat(VOICE_CHAT_BATTLECRY3); break;
        case 5: PlayVoiceChat(VOICE_CHAT_GATTACK1); break;
        case 6: PlayVoiceChat(VOICE_CHAT_GATTACK2); break;
        case 7: PlayVoiceChat(VOICE_CHAT_GATTACK3); break;
        default: PlayVoiceChat(VOICE_CHAT_TAUNT); break;
      }
      ActionUseSkill(SKILL_TAUNT, oTarget);
      ActionAttack(oTarget);
      return;
    }
    //low priority sou feats...they do something at least =/
    if(d4()==1)
    {
      if(GetHasFeat(477))
      {
        ActionUseFeat(477, oTarget);
        ActionAttack(oTarget);
        return;
      }
      if(GetHasFeat(476))
      {
        ActionUseFeat(476, oTarget);
        ActionAttack(oTarget);
        return;
      }
      if(GetHasFeat(FEAT_HARPER_SLEEP))
      {
        ActionUseFeat(FEAT_HARPER_SLEEP, oTarget);
        ActionAttack(oTarget);
        return;
      }
      if(GetHasFeat(479))
      {
        ActionUseFeat(479, oTarget);
        ActionAttack(oTarget);
        return;
      }
    }

    if(GetHasFeat(FEAT_SNEAK_ATTACK))
    {
      ActionAttack(SneakAttackTarget(oTarget));
      return;
    }

    switch (Random(64))
    {
      case 0: PlayVoiceChat(VOICE_CHAT_TAUNT); break;
      case 1: PlayVoiceChat(VOICE_CHAT_THREATEN); break;
      case 2: PlayVoiceChat(VOICE_CHAT_BATTLECRY1); break;
      case 3: PlayVoiceChat(VOICE_CHAT_BATTLECRY2); break;
      case 4: PlayVoiceChat(VOICE_CHAT_BATTLECRY3); break;
      case 5: PlayVoiceChat(VOICE_CHAT_GATTACK1); break;
      case 6: PlayVoiceChat(VOICE_CHAT_GATTACK2); break;
      case 7: PlayVoiceChat(VOICE_CHAT_GATTACK3); break;
    }
    ActionAttack(oTarget);
}

int IsUnderMeleeAttack(object oWho = OBJECT_SELF)
{
    ddp("IsUnderMeleeAttack", oWho);
    int iC = 1;
    object oFoe = GetNearestCreature(CREATURE_TYPE_REPUTATION, REPUTATION_TYPE_ENEMY, oWho, iC, CREATURE_TYPE_IS_ALIVE, TRUE);
    while(GetIsObjectValid(oFoe) && GetDistanceBetween(oWho, oFoe) < 3.0)
    {
      iC++;
      if(GetAttackTarget(oFoe) == oWho) return TRUE;
      oFoe = GetNearestCreature(CREATURE_TYPE_REPUTATION, REPUTATION_TYPE_ENEMY, oWho, iC, CREATURE_TYPE_IS_ALIVE, TRUE);
    }
    return FALSE;
}

int ManageEnemyAOE()
{
    ddp("ManageEnemyAOE", OBJECT_SELF);
    object oAOE = GetNearestObject(OBJECT_TYPE_AREA_OF_EFFECT);
    if(!GetIsObjectValid(oAOE) || GetDistanceToObject(oAOE) > 40.0) return FALSE;
    object oO = GetAreaOfEffectCreator(oAOE);
    if(GetIsObjectValid(oO) && !GetIsEnemy(oO))
    {
      oAOE = GetNearestObject(OBJECT_TYPE_AREA_OF_EFFECT, OBJECT_SELF, 2);
      if(!GetIsObjectValid(oAOE) || GetDistanceToObject(oAOE) > 40.0) return FALSE;
      object oO = GetAreaOfEffectCreator(oAOE);
      if(GetIsObjectValid(oO) && !GetIsEnemy(oO))
      {
        oAOE = GetNearestObject(OBJECT_TYPE_AREA_OF_EFFECT, OBJECT_SELF, 3);
        if(!GetIsObjectValid(oAOE) || GetDistanceToObject(oAOE) > 40.0) return FALSE;
        object oO = GetAreaOfEffectCreator(oAOE);
        if(GetIsObjectValid(oO) && !GetIsEnemy(oO)) return FALSE;
      }
    }
    location lTarget = GetLocation(oAOE);
    if(CastSpellAtLocation(SPELL_GUST_OF_WIND, lTarget, 2, 6)) return TRUE;
    if(CastSpellAtLocation(SPELL_MORDENKAINENS_DISJUNCTION, lTarget, 11, 18)) return TRUE;
    if(CastSpellAtLocation(SPELL_GREATER_DISPELLING, lTarget, 2, 12)) return TRUE;
    if(CastSpellAtLocation(SPELL_DISPEL_MAGIC, lTarget, 2, 6)) return TRUE;
    if(CastSpellAtLocation(SPELL_LESSER_DISPEL, lTarget, 11, 4)) return TRUE;
    return FALSE;
}

int DragonWingBuffet(object oFoe)
{
    ddp("DragonWingBuffet", oFoe);
    if(GetCreatureSize(oFoe) == CREATURE_SIZE_HUGE ||
       GetDistanceToObject(oFoe) > RADIUS_SIZE_GARGANTUAN) return FALSE;

    effect eKnockDown = EffectKnockdown();
    int nDamage = Random(GetHitDice(OBJECT_SELF)) + 11;
    int nDC = GetHitDice(OBJECT_SELF);
    effect eDam = EffectDamage(nDamage, DAMAGE_TYPE_BLUDGEONING);
    effect eVis = EffectVisualEffect(VFX_IMP_PULSE_WIND);
    float fDelay;
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, OBJECT_SELF);
    eVis = EffectVisualEffect(VFX_FNF_SCREEN_SHAKE);
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, OBJECT_SELF);
    location lSelf = GetLocation(OBJECT_SELF);
    effect eAppear = EffectAppear();
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eAppear, OBJECT_SELF);
    object oTarget = GetFirstObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_GARGANTUAN, lSelf);
    while(GetIsObjectValid(oTarget))
    {
      fDelay = GetDistanceToObject(oTarget)/20.0;
      if(!GetIsFriend(oTarget))
      {
        if(GetCreatureSize(oTarget) < CREATURE_SIZE_HUGE)
        {
          if(!ReflexSave(oTarget, nDC))
          {
            DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget));
            DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eDam, oTarget));
            DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eKnockDown, oTarget, 6.0));
          }
        }
      }
      oTarget = GetNextObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_GARGANTUAN, lSelf);
    }
    if(GetIsObjectValid(oFoe) && !GetIsDead(oFoe))
    {
      DelayCommand(0.5, ActionAttack(oFoe));
      return TRUE;
    }
    oFoe = GetNearestCreature(CREATURE_TYPE_REPUTATION, REPUTATION_TYPE_ENEMY, OBJECT_SELF, 1, CREATURE_TYPE_IS_ALIVE, TRUE, CREATURE_TYPE_PERCEPTION, PERCEPTION_SEEN);
    if(GetIsObjectValid(oFoe) && !GetIsDead(oFoe)) DelayCommand(0.5, ActionAttack(oFoe));
    return TRUE;
}

int SpecialDragonStuff(object oFoe)
{
    ddp("SpecialDragonStuff", oFoe);
    int iBreath = GetLocalInt(OBJECT_SELF, "OAI_DRAGONS_BREATH");
    int iWing = GetLocalInt(OBJECT_SELF, "OAI_WING_BUFFET");
    iWing++;
    iBreath++;
    SetLocalInt(OBJECT_SELF, "OAI_DRAGONS_BREATH", iBreath);
    SetLocalInt(OBJECT_SELF, "OAI_WING_BUFFET", iWing);
    if(iBreath > Random(3))
    {
      talent tBreath = GetCreatureTalentRandom(TALENT_CATEGORY_DRAGONS_BREATH);
      if(GetIsTalentValid(tBreath) &&
        !GetHasSpellEffect(GetIdFromTalent(tBreath), oFoe))
      {
        ActionUseTalentOnObject(tBreath, oFoe);
        ActionAttack(oFoe);
        SetLocalInt(OBJECT_SELF, "OAI_DRAGONS_BREATH", 0);
        return TRUE;
      }
    }
    if(iWing > (2 + Random(3)))
    {
      if(DragonWingBuffet(oFoe))
      {
        SetLocalInt(OBJECT_SELF, "OAI_WING_BUFFET", 0);
        return TRUE;
      }
    }
    return FALSE;
}

void CastMonsterAbilities(object oFoe)
{
    ddp("CastMonsterAbilities", oFoe);
    if(d4()==1)
    {
      if(DoCastSpellAtObject(SPELLABILITY_INTENSITY_3, OBJECT_SELF, 16, 10, 0, FALSE, TRUE)) return;
      if(DoCastSpellAtObject(SPELLABILITY_RAGE_5, OBJECT_SELF, 16, 10, 0, FALSE, TRUE)) return;
      if(DoCastSpellAtObject(SPELLABILITY_FEROCITY_3, OBJECT_SELF, 16, 10, 0, FALSE, TRUE)) return;
      if(DoCastSpellAtObject(SPELLABILITY_INTENSITY_2, OBJECT_SELF, 16, 8, 0, FALSE, TRUE)) return;
      if(DoCastSpellAtObject(SPELLABILITY_RAGE_4, OBJECT_SELF, 16, 8, 0, FALSE, TRUE)) return;
      if(DoCastSpellAtObject(SPELLABILITY_FEROCITY_2, OBJECT_SELF, 16, 8, 0, FALSE, TRUE)) return;
      if(DoCastSpellAtObject(SPELLABILITY_INTENSITY_1, OBJECT_SELF, 16, 6, 0, FALSE, TRUE)) return;
      if(DoCastSpellAtObject(SPELLABILITY_RAGE_3, OBJECT_SELF, 16, 6, 0, FALSE, TRUE)) return;
      if(DoCastSpellAtObject(SPELLABILITY_FEROCITY_1, OBJECT_SELF, 16, 6, 0, FALSE, TRUE)) return;
      if(DoCastSpellAtObject(SPELLABILITY_MUMMY_BOLSTER_UNDEAD, OBJECT_SELF, 8, 10, 0, FALSE, TRUE)) return;
      if(DoCastSpellAtObject(SPELLABILITY_LESSER_BODY_ADJUSTMENT, OBJECT_SELF, 5, 4, 0, FALSE, TRUE)) return;
    }

    talent tBreath = GetCreatureTalentRandom(TALENT_CATEGORY_DRAGONS_BREATH);
    if(GetIsTalentValid(tBreath) &&
      !GetHasSpellEffect(GetIdFromTalent(tBreath), oFoe) &&
      !GetBattleCondition(OAI_ROLE_DRAGON))
    {
      ActionUseTalentOnObject(tBreath, oFoe);
      ActionAttack(oFoe);
      return;
    }

    int iFoeRace = GetRacialType(oFoe);
    int iFoeIntBased = (GetLevelByClass(CLASS_TYPE_WIZARD, oFoe) > 1);
    int iFoeWisBased = ((GetLevelByClass(CLASS_TYPE_MONK, oFoe) +
                   GetLevelByClass(CLASS_TYPE_DRUID, oFoe) +
                   GetLevelByClass(CLASS_TYPE_CLERIC, oFoe)) > 1);
    int iFoeChaBased = ((GetLevelByClass(CLASS_TYPE_BARD, oFoe) +
                   GetLevelByClass(CLASS_TYPE_SORCERER, oFoe)) > 1);
    int iFoeGoodEvil = GetAlignmentGoodEvil(oFoe);
    int iFoeLawChaos = GetAlignmentLawChaos(oFoe);
    int iPulse = (GetDistanceToObject(oFoe) < RADIUS_SIZE_LARGE);
    int iHowl = (GetDistanceToObject(oFoe) < RADIUS_SIZE_COLOSSAL);
    int iCone = ShouldICast(GetLocation(oFoe), 10.0, 1);

    if(iPulse)
    {
      if(DoCastSpellAtObject(SPELLABILITY_BREATH_PETRIFY, OBJECT_SELF, 2, 10, OAI_IMMUNITY_PETRIFY, FALSE, FALSE, 8)) return;
      if(DoCastSpellAtObject(SPELLABILITY_PULSE_DEATH, OBJECT_SELF, 11, 14, 0, FALSE, FALSE, 5)) return;
      if(DoCastSpellAtObject(SPELLABILITY_PULSE_LEVEL_DRAIN, OBJECT_SELF, 11, 14, 0, FALSE, FALSE, 4)) return;
      if(iFoeWisBased)
      {
        if(DoCastSpellAtObject(SPELLABILITY_PULSE_ABILITY_DRAIN_WISDOM, OBJECT_SELF, 1, 12, 0, FALSE, TRUE)) return;
      }
      if(iFoeIntBased)
      {
        if(DoCastSpellAtObject(SPELLABILITY_PULSE_ABILITY_DRAIN_INTELLIGENCE, OBJECT_SELF, 1, 12, 0, FALSE, TRUE)) return;
      }
      if(iFoeChaBased)
      {
        if(DoCastSpellAtObject(SPELLABILITY_PULSE_ABILITY_DRAIN_CHARISMA, OBJECT_SELF, 1, 12, 0, FALSE, TRUE)) return;
      }
      if(DoCastSpellAtObject(SPELLABILITY_PULSE_ABILITY_DRAIN_CONSTITUTION, OBJECT_SELF, 1, 12, 0, FALSE, FALSE, 3)) return;
      if(DoCastSpellAtObject(SPELLABILITY_PULSE_ABILITY_DRAIN_STRENGTH, OBJECT_SELF, 1, 12, 0, FALSE, FALSE, 3)) return;
      if(DoCastSpellAtObject(SPELLABILITY_PULSE_ABILITY_DRAIN_DEXTERITY, OBJECT_SELF, 1, 12, 0, FALSE, FALSE, 3)) return;
      if(iFoeRace != RACIAL_TYPE_UNDEAD)
      {
        if(DoCastSpellAtObject(SPELLABILITY_PULSE_NEGATIVE, OBJECT_SELF, 11, 10, 0, FALSE, FALSE, 4)) return;
      }
      if(DoCastSpellAtObject(SPELLABILITY_PULSE_HOLY, OBJECT_SELF, 11, 10, 0, FALSE, FALSE, 3)) return;
      if(DoCastSpellAtObject(SPELLABILITY_PULSE_POISON, OBJECT_SELF, 1, 10, 0, FALSE, FALSE, 3)) return;
      if(DoCastSpellAtObject(SPELLABILITY_PULSE_LIGHTNING, OBJECT_SELF, 11, 10, 0, FALSE, FALSE, 3)) return;
      if(DoCastSpellAtObject(SPELLABILITY_PULSE_COLD, OBJECT_SELF, 11, 10, 0, FALSE, FALSE, 3)) return;
      if(DoCastSpellAtObject(SPELLABILITY_PULSE_FIRE, OBJECT_SELF, 11, 10, 0, FALSE, FALSE, 3)) return;
      if(DoCastSpellAtObject(SPELLABILITY_PULSE_DROWN, OBJECT_SELF, 1, 8, 0, FALSE, FALSE, 5)) return;
      if(DoCastSpellAtObject(SPELLABILITY_PULSE_DISEASE, OBJECT_SELF, 1, 10)) return;
      if(DoCastSpellAtObject(SPELLABILITY_PULSE_SPORES, OBJECT_SELF, 1, 8)) return;
      if(DoCastSpellAtObject(SPELLABILITY_PULSE_WHIRLWIND, OBJECT_SELF, 1, 8)) return;
    }
    if(iHowl)
    {
      if(DoCastSpellAtObject(SPELLABILITY_HOWL_DEATH, OBJECT_SELF, 11, 14, 0, FALSE, FALSE, 5)) return;
      if(DoCastSpellAtObject(SPELLABILITY_HOWL_STUN, OBJECT_SELF, 11, 12, 0, FALSE, FALSE, 4)) return;
      if(DoCastSpellAtObject(SPELLABILITY_HOWL_CONFUSE, OBJECT_SELF, 11, 12, 0, FALSE, FALSE, 3)) return;
      if(DoCastSpellAtObject(SPELLABILITY_HOWL_FEAR, OBJECT_SELF, 11, 10, 0, FALSE, FALSE, 3)) return;
      if(DoCastSpellAtObject(SPELLABILITY_HOWL_PARALYSIS, OBJECT_SELF, 11, 10, 0, FALSE, FALSE, 3)) return;
      if(DoCastSpellAtObject(SPELLABILITY_HOWL_SONIC, OBJECT_SELF, 11, 10, 0, FALSE, FALSE, 3)) return;
      if(DoCastSpellAtObject(SPELLABILITY_HOWL_DOOM, OBJECT_SELF, 11, 8, 0, FALSE, FALSE, 3)) return;
      if(DoCastSpellAtObject(SPELLABILITY_HOWL_DAZE, OBJECT_SELF, 11, 8, 0, FALSE, FALSE, 2)) return;
    }
    if(iFoeGoodEvil == ALIGNMENT_GOOD)
    {
      if(DoCastSpellAtObject(SPELLABILITY_GAZE_DESTROY_GOOD, oFoe, 11, 10, 0, FALSE, TRUE)) return;
    }
    else if(iFoeGoodEvil == ALIGNMENT_EVIL)
    {
      if(DoCastSpellAtObject(SPELLABILITY_GAZE_DESTROY_EVIL, oFoe, 11, 10, 0, FALSE, TRUE)) return;
    }
    if(iFoeLawChaos == ALIGNMENT_LAWFUL)
    {
      if(DoCastSpellAtObject(SPELLABILITY_GAZE_DESTROY_LAW, oFoe, 11, 10, 0, FALSE, TRUE)) return;
    }
    else if(iFoeLawChaos == ALIGNMENT_CHAOTIC)
    {
      if(DoCastSpellAtObject(SPELLABILITY_GAZE_DESTROY_CHAOS, oFoe, 11, 10, 0, FALSE, TRUE)) return;
    }
    if(iCone)
    {
      if(DoCastSpellAtObject(SPELLABILITY_GAZE_PETRIFY, oFoe, 2, 10, 0, FALSE, FALSE, 7)) return;
      if(DoCastSpellAtObject(SPELLABILITY_GAZE_DEATH, oFoe, 11, 12, 0, FALSE, FALSE, 5)) return;
      if(DoCastSpellAtObject(SPELLABILITY_GAZE_DOMINATE, oFoe, 11, 12, 0, FALSE, FALSE, 5)) return;
      if(DoCastSpellAtObject(SPELLABILITY_GAZE_PARALYSIS, oFoe, 11, 10, 0, FALSE, FALSE, 4)) return;
      if(DoCastSpellAtObject(SPELLABILITY_GAZE_STUNNED, oFoe, 11, 10, 0, FALSE, FALSE, 4)) return;
      if(DoCastSpellAtObject(SPELLABILITY_GAZE_FEAR, oFoe, 11, 10, 0, FALSE, FALSE, 4)) return;
      if(DoCastSpellAtObject(SPELLABILITY_CONE_POISON, oFoe, 11, 12, 0, FALSE, FALSE, 4)) return;
      if(DoCastSpellAtObject(SPELLABILITY_GOLEM_BREATH_GAS, oFoe, 11, 10, 0, FALSE, FALSE, 3)) return;
      if(DoCastSpellAtObject(SPELLABILITY_GAZE_CONFUSION, oFoe, 11, 10, 0, FALSE, FALSE, 4)) return;
      if(DoCastSpellAtObject(SPELLABILITY_CONE_SONIC, oFoe, 11, 10, 0, FALSE, FALSE, 3)) return;
      if(DoCastSpellAtObject(SPELLABILITY_CONE_LIGHTNING, oFoe, 11, 10, 0, FALSE, FALSE, 3)) return;
      if(DoCastSpellAtObject(SPELLABILITY_CONE_ACID, oFoe, 11, 10, 0, FALSE, FALSE, 3)) return;
      if(DoCastSpellAtObject(SPELLABILITY_CONE_COLD, oFoe, 11, 10, 0, FALSE, FALSE, 3)) return;
      if(DoCastSpellAtObject(SPELLABILITY_CONE_FIRE, oFoe, 11, 10, 0, FALSE, FALSE, 3)) return;
      if(DoCastSpellAtObject(SPELLABILITY_CONE_DISEASE, oFoe, 11, 10)) return;
      if(DoCastSpellAtObject(SPELLABILITY_GAZE_CHARM, oFoe, 11, 10, 0, FALSE, FALSE, 2)) return;
      if(DoCastSpellAtObject(SPELLABILITY_GAZE_DOOM, oFoe, 11, 8, 0, FALSE, FALSE, 2)) return;
      if(DoCastSpellAtObject(SPELLABILITY_GAZE_DAZE, oFoe, 11, 8, 0, FALSE, FALSE, 1)) return;
      if(DoCastSpellAtObject(SPELLABILITY_KRENSHAR_SCARE, oFoe, 1, 4)) return;
      if(DoCastSpellAtObject(SPELLABILITY_HELL_HOUND_FIREBREATH, oFoe, 11, 2)) return;
    }
    if(DoCastSpellAtObject(SPELLABILITY_TOUCH_PETRIFY, oFoe, TALENT_CATEGORY_HARMFUL_TOUCH, 10, 0, FALSE, FALSE, 5)) return;
    if(DoCastSpellAtObject(SPELLABILITY_BOLT_DEATH, oFoe, 2, 10, 0, FALSE, FALSE, 5)) return;
    if(DoCastSpellAtObject(SPELLABILITY_BOLT_LEVEL_DRAIN, oFoe, 2, 12, 0, FALSE, FALSE, 5)) return;
    if(DoCastSpellAtObject(SPELLABILITY_BOLT_DOMINATE, oFoe, 2, 12, 0, FALSE, FALSE, 5)) return;
    if(iFoeWisBased)
    {
      if(DoCastSpellAtObject(SPELLABILITY_BOLT_ABILITY_DRAIN_WISDOM, oFoe, 2, 8, 0, FALSE, TRUE)) return;
    }
    if(iFoeIntBased)
    {
      if(DoCastSpellAtObject(SPELLABILITY_BOLT_ABILITY_DRAIN_INTELLIGENCE, oFoe, 2, 8, 0, FALSE, TRUE)) return;
    }
    if(iFoeChaBased)
    {
      if(DoCastSpellAtObject(SPELLABILITY_BOLT_ABILITY_DRAIN_CHARISMA, oFoe, 2, 8, 0, FALSE, TRUE)) return;
    }
    if(DoCastSpellAtObject(SPELLABILITY_MANTICORE_SPIKES, oFoe, 2, 10, 0, FALSE, FALSE, 2)) return;
    if(DoCastSpellAtObject(SPELLABILITY_BOLT_STUN, oFoe, 2, 10)) return;
    if(DoCastSpellAtObject(SPELLABILITY_BOLT_PARALYZE, oFoe, 2, 10, 0, FALSE, FALSE, 2)) return;
    if(DoCastSpellAtObject(SPELLABILITY_BOLT_POISON, oFoe, 2, 10, 0, FALSE, FALSE, 3)) return;
    if(DoCastSpellAtObject(SPELLABILITY_BOLT_ABILITY_DRAIN_STRENGTH, oFoe, 2, 8, 0, FALSE, FALSE, 4)) return;
    if(DoCastSpellAtObject(SPELLABILITY_BOLT_ABILITY_DRAIN_CONSTITUTION, oFoe, 2, 8, 0, FALSE, FALSE, 4)) return;
    if(DoCastSpellAtObject(SPELLABILITY_BOLT_ABILITY_DRAIN_DEXTERITY, oFoe, 2, 8, 0, FALSE, FALSE, 3)) return;
    if(DoCastSpellAtObject(SPELLABILITY_BOLT_KNOCKDOWN, oFoe, 2, 6, 0, FALSE, FALSE, 5)) return;
    if(DoCastSpellAtObject(SPELLABILITY_BOLT_SHARDS, oFoe, 2, 8)) return;
    if(DoCastSpellAtObject(SPELLABILITY_BOLT_ACID, oFoe, 2, 8, 0, FALSE, FALSE, 3)) return;
    if(DoCastSpellAtObject(SPELLABILITY_BOLT_COLD, oFoe, 2, 8, 0, FALSE, FALSE, 3)) return;
    if(DoCastSpellAtObject(SPELLABILITY_BOLT_FIRE, oFoe, 2, 8, 0, FALSE, FALSE, 3)) return;
    if(DoCastSpellAtObject(SPELLABILITY_BOLT_LIGHTNING, oFoe, 2, 8, 0, FALSE, FALSE, 3)) return;
    if(DoCastSpellAtObject(SPELLABILITY_BOLT_CONFUSE, oFoe, 2, 8, 0, FALSE, FALSE, 4)) return;
    if(DoCastSpellAtObject(SPELLABILITY_BOLT_SLOW, oFoe, 2, 8, 0, FALSE, FALSE, 4)) return;
    if(DoCastSpellAtObject(SPELLABILITY_BOLT_WEB, oFoe, 2, 8, 0, FALSE, FALSE, 4)) return;
    if(DoCastSpellAtObject(SPELLABILITY_BOLT_DAZE, oFoe, 2, 10, 0, FALSE, FALSE, 3)) return;
    if(DoCastSpellAtObject(SPELLABILITY_BOLT_DISEASE, oFoe, 2, 8)) return;
    if(DoCastSpellAtObject(SPELLABILITY_BOLT_CHARM, oFoe, 2, 8, 0, FALSE, FALSE, 2)) return;
    if(DoCastSpellAtObject(SPELLABILITY_MEPHIT_SALT_BREATH, oFoe, 2, 6)) return;
    if(DoCastSpellAtObject(SPELLABILITY_MEPHIT_STEAM_BREATH, oFoe, 2, 6)) return;

    if(DoCastSpellAtObject(SPELLABILITY_INTENSITY_3, OBJECT_SELF, 16, 10, 0, FALSE, TRUE)) return;
    if(DoCastSpellAtObject(SPELLABILITY_FEROCITY_3, OBJECT_SELF, 16, 10, 0, FALSE, TRUE)) return;
    if(DoCastSpellAtObject(SPELLABILITY_INTENSITY_2, OBJECT_SELF, 16, 8, 0, FALSE, TRUE)) return;
    if(DoCastSpellAtObject(SPELLABILITY_FEROCITY_2, OBJECT_SELF, 16, 8, 0, FALSE, TRUE)) return;
    if(DoCastSpellAtObject(SPELLABILITY_INTENSITY_1, OBJECT_SELF, 16, 6, 0, FALSE, TRUE)) return;
    if(DoCastSpellAtObject(SPELLABILITY_FEROCITY_1, OBJECT_SELF, 16, 6, 0, FALSE, TRUE)) return;
    if(DoCastSpellAtObject(SPELLABILITY_MUMMY_BOLSTER_UNDEAD, OBJECT_SELF, 8, 10, 0, FALSE, TRUE)) return;
    if(DoCastSpellAtObject(SPELLABILITY_LESSER_BODY_ADJUSTMENT, OBJECT_SELF, 5, 4, 0, FALSE, TRUE)) return;

    if(d2()==1)
    {
      SetStatusCondition(OAI_I_CAN_CAST_MONSTER_ABILITIES, FALSE);
      DelayCommand(0.0, doFighting(oFoe, oFoe));
    }
}

int CastSummon(object oTarget, int InstantCast = FALSE)
{
    ddp("CastSummon", oTarget);
    if(GetIsObjectValid(GetAssociate(ASSOCIATE_TYPE_SUMMONED))) return FALSE;
    if(GetDistanceToObject(oTarget) > 10.0) oTarget = OBJECT_SELF;
    if(DoCastSpellAtObject(SPELL_ELEMENTAL_SWARM, oTarget, 15, 18, 0, InstantCast, TRUE)) return TRUE;
    if(HasSpell(SPELL_GATE, 15, 18))
    {
      if((oTarget != OBJECT_SELF && !InstantCast) || GetStandardFactionReputation(STANDARD_FACTION_HOSTILE) > 89)
      {
        if(DoCastSpellAtObject(SPELL_GATE, oTarget, 15, 18, 0, InstantCast, TRUE)) return TRUE;
      }
    }
    if(DoCastSpellAtObject(SPELL_SUMMON_CREATURE_IX, oTarget, 15, 18, 0, InstantCast, TRUE)) return TRUE;
    if(DoCastSpellAtObject(SPELL_CREATE_GREATER_UNDEAD, oTarget, 15, 16, 0, InstantCast, TRUE)) return TRUE;
    if(DoCastSpellAtObject(SPELL_SUMMON_CREATURE_VIII, oTarget, 15, 16, 0, InstantCast, TRUE)) return TRUE;
    if(DoCastSpellAtObject(SPELL_MORDENKAINENS_SWORD, oTarget, 15, 14, 0, InstantCast, TRUE)) return TRUE;
    if(GetHasFeat(FEAT_SUMMON_SHADOW) && !InstantCast)
    {
      ActionUseFeat(FEAT_SUMMON_SHADOW, OBJECT_SELF);
      return TRUE;
    }
    if(DoCastSpellAtObject(SPELL_GREATER_PLANAR_BINDING, oTarget, 15, 16, 0, InstantCast, TRUE)) return TRUE;
    if(DoCastSpellAtObject(SPELL_SUMMON_CREATURE_VII, oTarget, 15, 14, 0, InstantCast, TRUE)) return TRUE;
    if(GetHasFeat(475) && !InstantCast)
    {
      ActionUseFeat(475, OBJECT_SELF);
      return TRUE;
    }
    if(DoCastSpellAtObject(SPELL_PLANAR_ALLY, oTarget, 15, 12, 0, InstantCast, TRUE)) return TRUE;
    if(GetHasFeat(474) && !InstantCast)
    {
      ActionUseFeat(474, OBJECT_SELF);
      return TRUE;
    }
    if(DoCastSpellAtObject(SPELL_CREATE_UNDEAD, oTarget, 15, 12, 0, InstantCast, TRUE)) return TRUE;
    if(DoCastSpellAtObject(SPELL_SUMMON_CREATURE_VI, oTarget, 15, 12, 0, InstantCast, TRUE)) return TRUE;
    if(DoCastSpellAtObject(SPELL_PLANAR_BINDING, oTarget, 15, 12, 0, InstantCast, TRUE)) return TRUE;
    if(DoCastSpellAtObject(SPELLABILITY_SUMMON_SLAAD, oTarget, 15, 10, 0, InstantCast, TRUE)) return TRUE;
    if(DoCastSpellAtObject(SPELLABILITY_SUMMON_CELESTIAL, oTarget, 15, 10, 0, InstantCast, TRUE)) return TRUE;
    if(DoCastSpellAtObject(SPELLABILITY_SUMMON_TANARRI, oTarget, 15, 10, 0, InstantCast, TRUE)) return TRUE;
    if(DoCastSpellAtObject(SPELLABILITY_SUMMON_MEPHIT, oTarget, 15, 10, 0, InstantCast, TRUE)) return TRUE;
    if(DoCastSpellAtObject(SPELL_LESSER_PLANAR_BINDING, oTarget, 15, 10, 0, InstantCast)) return TRUE;
    if(DoCastSpellAtObject(SPELL_SUMMON_CREATURE_V, oTarget, 15, 10, 0, InstantCast)) return TRUE;
    if(DoCastSpellAtObject(SPELL_SUMMON_CREATURE_IV, oTarget, 15, 8, 0, InstantCast)) return TRUE;
    if(DoCastSpellAtObject(SPELL_SUMMON_CREATURE_III, oTarget, 15, 6, 0, InstantCast)) return TRUE;
    if(DoCastSpellAtObject(SPELL_SUMMON_CREATURE_II, oTarget, 15, 4, 0, InstantCast)) return TRUE;
    if(DoCastSpellAtObject(SPELLABILITY_NEGATIVE_PLANE_AVATAR, oTarget, 10, 2, 0, InstantCast)) return TRUE;
    if(DoCastSpellAtObject(SPELL_SUMMON_CREATURE_I, oTarget, 15, 2, 0, InstantCast)) return TRUE;
    if(!InstantCast) SetStatusCondition(OAI_I_CAN_SUMMON, FALSE);
    return FALSE;
}

int PolymorphSelf(object oFoe)
{
    ddp("PolymorphSelf", oFoe);
    if(DoCastSpellAtObject(SPELL_SHAPECHANGE, OBJECT_SELF, 10, 18, 0, FALSE, TRUE)) { ActionAttack(oFoe); return TRUE; }
    if(GetHasFeat(FEAT_ELEMENTAL_SHAPE) && !GetHasSpellEffect(319))
    {
      ActionUseFeat(FEAT_ELEMENTAL_SHAPE, OBJECT_SELF);
      ActionAttack(oFoe);
      return TRUE;
    }
    if(DoCastSpellAtObject(SPELL_TENSERS_TRANSFORMATION, OBJECT_SELF, 10, 12, 0, FALSE, TRUE)) { ActionAttack(oFoe); return TRUE; }
    if(GetHasFeat(FEAT_WILD_SHAPE) && !GetHasSpellEffect(320))
    {
      ActionUseFeat(FEAT_WILD_SHAPE, OBJECT_SELF);
      ActionAttack(oFoe);
      return TRUE;
    }
    if(DoCastSpellAtObject(SPELL_POLYMORPH_SELF, OBJECT_SELF, 10, 14, 0, FALSE, TRUE)) { ActionAttack(oFoe); return TRUE; }
    SetStatusCondition(OAI_I_CAN_POLYMORPH, FALSE);
    return FALSE;
}

object BreakIllusion(object oBreaker, int iAmDead = FALSE)
{
    ddp("BreakIllusion", oBreaker, "<--Breaker");
    string sReal = GetLocalString(OBJECT_SELF, "OAI_REAL_SELF");
    string sName = GetName(OBJECT_SELF);
    string sNameToo;
    effect eFX = EffectVisualEffect(VFX_DUR_ETHEREAL_VISAGE);
    location lHere = GetLocation(OBJECT_SELF);
    object oPC;
    ClearAllActions(TRUE);
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, eFX, OBJECT_SELF);

    SetIsDestroyable(TRUE,FALSE,FALSE);
    int nAmtGold = GetGold(OBJECT_SELF);
    if(nAmtGold) TakeGoldFromCreature(nAmtGold, OBJECT_SELF, TRUE);
    DestroyObject(GetItemInSlot(INVENTORY_SLOT_ARMS, OBJECT_SELF));
    DestroyObject(GetItemInSlot(INVENTORY_SLOT_ARROWS, OBJECT_SELF));
    DestroyObject(GetItemInSlot(INVENTORY_SLOT_BELT, OBJECT_SELF));
    DestroyObject(GetItemInSlot(INVENTORY_SLOT_BOLTS, OBJECT_SELF));
    DestroyObject(GetItemInSlot(INVENTORY_SLOT_BOOTS, OBJECT_SELF));
    DestroyObject(GetItemInSlot(INVENTORY_SLOT_BULLETS, OBJECT_SELF));
    DestroyObject(GetItemInSlot(INVENTORY_SLOT_CLOAK, OBJECT_SELF));
    DestroyObject(GetItemInSlot(INVENTORY_SLOT_HEAD, OBJECT_SELF));
    DestroyObject(GetItemInSlot(INVENTORY_SLOT_LEFTRING, OBJECT_SELF));
    DestroyObject(GetItemInSlot(INVENTORY_SLOT_NECK, OBJECT_SELF));
    DestroyObject(GetItemInSlot(INVENTORY_SLOT_RIGHTRING, OBJECT_SELF));
    DestroyObject(GetItemInSlot(INVENTORY_SLOT_CHEST, OBJECT_SELF));
    object oLootEQ = GetFirstItemInInventory(OBJECT_SELF);
    while(GetIsObjectValid(oLootEQ))
    {
      DestroyObject(oLootEQ);
      oLootEQ = GetNextItemInInventory(OBJECT_SELF);
    }
    SetIsDestroyable(TRUE,FALSE,FALSE);
    DestroyObject(OBJECT_SELF);
    SetIsDestroyable(TRUE,FALSE,FALSE);
    DestroyObject(OBJECT_SELF);
    SetIsDestroyable(TRUE,FALSE,FALSE);
    DestroyObject(OBJECT_SELF);
    SetIsDestroyable(TRUE,FALSE,TRUE);
    DestroyObject(OBJECT_SELF);

    if(GetStringLength(sReal) > 1)
    {
      object oNew = CreateObject(OBJECT_TYPE_CREATURE, sReal, lHere);
      if(GetIsEnemy(oBreaker)) SetIsTemporaryEnemy(oBreaker, oNew);
      if(iAmDead)
      {
        eFX=EffectDamage(GetMaxHitPoints(oNew) * 4);
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eFX, oNew);
        oPC = GetFirstFactionMember(oBreaker, TRUE);
        while(GetIsObjectValid(oPC))
        {
          if(GetArea(oPC) == oArea) FloatingTextStringOnCreature("The illusionary " + sName + " fades away, its creator is dead upon the ground.", oPC, FALSE);
          oPC = GetNextFactionMember(oBreaker, TRUE);
        }
        return oNew;
      }
      else
      {
        if(d2()==1) PlayVoiceChat(VOICE_CHAT_BADIDEA, oNew);
        ExecuteScript("f_entercombat", oNew);
        oPC = GetFirstFactionMember(oBreaker, TRUE);
        while(GetIsObjectValid(oPC))
        {
          if(GetArea(oPC) == oArea)
          {
            if(oPC == oBreaker)
            {
              FloatingTextStringOnCreature("You realized " + sName + " was merely an illusion, causing it to melt away.", oPC, FALSE);
            }
            else
            {
              FloatingTextStringOnCreature(GetName(oBreaker) + " realized " + sName + " is merely an illusion, causing it to melt away.", oPC, FALSE);
            }
          }
          oPC = GetNextFactionMember(oBreaker, TRUE);
        }
        return OBJECT_INVALID;
      }
    }
    oPC = GetFirstFactionMember(oBreaker, TRUE);
    while(GetIsObjectValid(oPC))
    {
      if(GetArea(oPC) == oArea) FloatingTextStringOnCreature("The illusionary " + sName + " fades away, leaving nothing behind.", oPC, FALSE);
      oPC = GetNextFactionMember(oBreaker, TRUE);
    }
    return OBJECT_INVALID;
}

void SummonHordes()
{
    ddp("SummonHordes", OBJECT_SELF);
    string sResRef = GetLocalString(OBJECT_SELF, "OAI_SUMMON");
    if(GetStringLength(sResRef) < 1) return;
    if(Random(100) < GetLocalInt(OBJECT_SELF, "OAI_SUMMON_FAILURE")) return;
    int iX, iY;
    vector vMe = GetPosition(OBJECT_SELF);
    while(iX==0 && iY==0)
    {
      iX = (Random(3) - 1) * 15;
      iY = (Random(3) - 1) * 15;
    }
    vMe.x += IntToFloat(iX);
    vMe.y += IntToFloat(iY);
    location lNew = Location(oArea, vMe, GetFacing(OBJECT_SELF));
    object oNew = CreateObject(OBJECT_TYPE_CREATURE, sResRef, lNew);
    ExecuteScript("oai_entercombat", oNew);
}

int DoTurnUndead(object oFoe)
{
    ddp("DoTurnUndead", oFoe);
    if(GetHasFeat(FEAT_TURN_UNDEAD))
    {
      if(GetHasEffect(EFFECT_TYPE_TURNED, oFoe) || MyHD <= GetHitDice(oFoe) || GetDistanceToObject(oFoe) > 7.0)
        return FALSE;

      int iElemental = GetHasFeat(FEAT_AIR_DOMAIN_POWER) || GetHasFeat(FEAT_EARTH_DOMAIN_POWER) || GetHasFeat(FEAT_FIRE_DOMAIN_POWER) || GetHasFeat(FEAT_FIRE_DOMAIN_POWER);
      int iVermin = GetHasFeat(FEAT_PLANT_DOMAIN_POWER) || GetHasFeat(FEAT_ANIMAL_COMPANION);
      int iConstruct = GetHasFeat(FEAT_DESTRUCTION_DOMAIN_POWER);
      int iOutsider = GetHasFeat(FEAT_GOOD_DOMAIN_POWER) || GetHasFeat(FEAT_EVIL_DOMAIN_POWER);
      if(GetRacialType(oFoe) != RACIAL_TYPE_UNDEAD)
      {
        if(!iElemental || GetRacialType(oFoe) != RACIAL_TYPE_ELEMENTAL)
        {
          if(!iVermin || GetRacialType(oFoe) != RACIAL_TYPE_VERMIN)
          {
            if(!iVermin || GetRacialType(oFoe) != RACIAL_TYPE_VERMIN)
            {
              if(!iOutsider || GetRacialType(oFoe) != RACIAL_TYPE_OUTSIDER)
              {
                if(!iConstruct || GetRacialType(oFoe) != RACIAL_TYPE_CONSTRUCT) return FALSE;
              }
            }
          }
        }
      }
      ActionUseFeat(FEAT_TURN_UNDEAD, OBJECT_SELF);
      return TRUE;
    }
    return FALSE;
}

int DoBardSong()
{
    ddp("DoBardSong", OBJECT_SELF);
    if(GetHasFeat(FEAT_BARD_SONGS) && !GetHasSpellEffect(411))
    {
      ActionUseFeat(FEAT_BARD_SONGS, OBJECT_SELF);
      return TRUE;
    }
    return FALSE;
}

object ChooseGroupTarget()
{
    ddp("ChooseGroupTarget", OBJECT_SELF);
    object oTarget = GetNearestCreature(CREATURE_TYPE_REPUTATION, REPUTATION_TYPE_ENEMY, OBJECT_SELF, 1, CREATURE_TYPE_IS_ALIVE, TRUE, CREATURE_TYPE_CLASS, CLASS_TYPE_CLERIC);
    if(!GetIsObjectValid(oTarget) || GetDistanceToObject(oTarget) > 30.0)
    {
      oTarget = GetNearestCreature(CREATURE_TYPE_REPUTATION, REPUTATION_TYPE_ENEMY, OBJECT_SELF, 1, CREATURE_TYPE_IS_ALIVE, TRUE, CREATURE_TYPE_CLASS, CLASS_TYPE_DRUID);
      if(!GetIsObjectValid(oTarget) || GetDistanceToObject(oTarget) > 30.0)
      {
        oTarget = GetNearestCreature(CREATURE_TYPE_REPUTATION, REPUTATION_TYPE_ENEMY, OBJECT_SELF, 1, CREATURE_TYPE_IS_ALIVE, TRUE, CREATURE_TYPE_CLASS, CLASS_TYPE_WIZARD);
        if(!GetIsObjectValid(oTarget) || GetDistanceToObject(oTarget) > 30.0)
        {
          oTarget = GetNearestCreature(CREATURE_TYPE_REPUTATION, REPUTATION_TYPE_ENEMY, OBJECT_SELF, 1, CREATURE_TYPE_IS_ALIVE, TRUE, CREATURE_TYPE_CLASS, CLASS_TYPE_SORCERER);
          if(!GetIsObjectValid(oTarget) || GetDistanceToObject(oTarget) > 30.0)
          {
            oTarget = GetNearestCreature(CREATURE_TYPE_REPUTATION, REPUTATION_TYPE_ENEMY, OBJECT_SELF, 1, CREATURE_TYPE_IS_ALIVE, TRUE, CREATURE_TYPE_CLASS, CLASS_TYPE_BARD);
            if(!GetIsObjectValid(oTarget) || GetDistanceToObject(oTarget) > 20.0)
            {
              oTarget = GetLocalObject(OBJECT_SELF, "OAI_I_HATE_");
              if(!GetIsObjectValid(oTarget) || GetIsDead(oTarget) || GetDistanceToObject(oTarget) > 20.0)
              {
                DeleteLocalObject(OBJECT_SELF, "OAI_I_HATE_");
                return OBJECT_INVALID;
              }
            }
          }
        }
      }
    }
    ddp("-ChooseGroupTarget", oTarget, "Target");
    return oTarget;
}

int ChooseGroupTactics()
{
    ddp("ChooseGroupTactics", OBJECT_SELF);
    int iFearFactor = GetLocalInt(OBJECT_SELF, "OAI_FEAR_FACTOR");
    int iAllyCount = 1;
    int iAllyPower = FloatToInt(GetChallengeRating(OBJECT_SELF)) + OAI_GROUP_POWER_BONUS - iFearFactor;
    int iFoeCount = 0;
    int iFoePower = 0;
    if(iFearFactor > 0) SetLocalInt(OBJECT_SELF, "OAI_FEAR_FACTOR", (iFearFactor - 1));
    object oLowHealthAlly = OBJECT_SELF;
    object oLowHealthFoe;
    object oTarget = GetNearestCreature(CREATURE_TYPE_REPUTATION, REPUTATION_TYPE_FRIEND, OBJECT_SELF, 1, CREATURE_TYPE_IS_ALIVE, TRUE, CREATURE_TYPE_PERCEPTION, PERCEPTION_SEEN);
    while(GetIsObjectValid(oTarget))
    {
      if(GetCurrentHitPoints(oTarget) < GetCurrentHitPoints(oLowHealthAlly)) oLowHealthAlly = oTarget;
      iAllyCount++;
      iAllyPower += FloatToInt(GetChallengeRating(oTarget));
      oTarget = GetNearestCreature(CREATURE_TYPE_REPUTATION, REPUTATION_TYPE_FRIEND, OBJECT_SELF, iAllyCount, CREATURE_TYPE_IS_ALIVE, TRUE, CREATURE_TYPE_PERCEPTION, PERCEPTION_SEEN);
    }

    oTarget = GetNearestCreature(CREATURE_TYPE_REPUTATION, REPUTATION_TYPE_ENEMY, OBJECT_SELF, 1, CREATURE_TYPE_IS_ALIVE, TRUE, CREATURE_TYPE_PERCEPTION, PERCEPTION_SEEN);
    oLowHealthFoe = oTarget;
    while(GetIsObjectValid(oTarget))
    {
      if(GetCurrentHitPoints(oTarget) < GetCurrentHitPoints(oLowHealthFoe)) oLowHealthFoe = oTarget;
      iFoeCount++;
      iFoePower += GetHitDice(oTarget);
      oTarget = GetNearestCreature(CREATURE_TYPE_REPUTATION, REPUTATION_TYPE_ENEMY, OBJECT_SELF, iFoeCount, CREATURE_TYPE_IS_ALIVE, TRUE, CREATURE_TYPE_PERCEPTION, PERCEPTION_SEEN);
    }
    if(iFoeCount == 0) return FALSE;

    if((iAllyPower * 2) < iFoePower)
    {
      iFearFactor = 1;
      oTarget = GetNearestCreature(CREATURE_TYPE_REPUTATION, REPUTATION_TYPE_FRIEND, OBJECT_SELF, (iAllyCount + iFearFactor), CREATURE_TYPE_IS_ALIVE, TRUE);
      while(GetIsObjectValid(oTarget) && !GetIsNotFighting(oTarget))
      {
        iFearFactor++;
        oTarget = GetNearestCreature(CREATURE_TYPE_REPUTATION, REPUTATION_TYPE_FRIEND, OBJECT_SELF, (iAllyCount + iFearFactor), CREATURE_TYPE_IS_ALIVE, TRUE);
      }

      //Action 1 is flee to target
      if(GetIsObjectValid(oTarget) &&
        GetDistanceToObject(oTarget) > 20.0 &&
        GetDistanceToObject(oTarget) < 80.0)
      {
        SetLocalInt(OBJECT_SELF, "OAI_GROUP_ACTION", 5);
        SetLocalObject(OBJECT_SELF, "OAI_GROUP_TARGET", oTarget);
        SpeakString("OAI_FLEE_TO_TARGET", TALKVOLUME_SILENT_TALK);
        ClearAllActions(TRUE);
        ActionMoveToObject(oTarget, TRUE);
        //ActionDoCommand(DetermineCombatRound());
        return TRUE;
      }
    }
    else if(iAllyPower < iFoePower && iAllyCount > 2)
    {
      iFearFactor = 1;
      oTarget = GetNearestCreature(CREATURE_TYPE_REPUTATION, REPUTATION_TYPE_FRIEND, OBJECT_SELF, (iAllyCount + iFearFactor), CREATURE_TYPE_IS_ALIVE, TRUE);
      while(GetIsObjectValid(oTarget) && !GetIsNotFighting(oTarget))
      {
        iFearFactor++;
        oTarget = GetNearestCreature(CREATURE_TYPE_REPUTATION, REPUTATION_TYPE_FRIEND, OBJECT_SELF, (iAllyCount + iFearFactor), CREATURE_TYPE_IS_ALIVE, TRUE);
      }

       //Action 2 is run to target, tell them about whatever you were fighting and head back
      if(GetIsObjectValid(oTarget) &&
        GetDistanceToObject(oTarget) > 20.0 &&
        GetDistanceToObject(oTarget) < 80.0)
      {
        ClearAllActions(TRUE);
        ActionMoveToObject(oTarget, TRUE);
        ActionSpeakString("OAI_ENTERING_BATTLE_ATTACK_MY_TARGET", TALKVOLUME_SILENT_TALK);
        //ActionDoCommand(DetermineCombatRound());
        return TRUE;
      }
    }
    if(Random(100) >= OAI_GROUP_ACTION_CHANCE) return FALSE;

    //Go for the Caster
    if(Random(10) == 1)
    {
      oTarget = ChooseGroupTarget();
      if(!GetIsObjectValid(oTarget)) return FALSE;
      if(iAllyCount > iFoeCount)
      {
        SetLocalObject(OBJECT_SELF, "OAI_GROUP_TARGET", oTarget);
        SpeakString("OAI_PULL_AWAY_MELEE_ATTACK_CASTERS", TALKVOLUME_SILENT_TALK);
        if(IsUnderMeleeAttack(OBJECT_SELF))
        {
          ClearAllActions();
          ActionMoveAwayFromObject(oTarget, TRUE);
        }
        else
        {
          SetLocalObject(OBJECT_SELF, "OAI_OVERRIDE_TARGET", oTarget);
        }
      }
      else
      {
        SetLocalObject(OBJECT_SELF, "OAI_GROUP_TARGET", oTarget);
        SetLocalObject(OBJECT_SELF, "OAI_OVERRIDE_TARGET", oTarget);
        SpeakString("OAI_ASSIST_ME_ON_CASTER", TALKVOLUME_SILENT_TALK);
      }
    }

    //Attack the Weakest Link
    else
    {
      if(iAllyCount < iFoeCount)
      {
        SetLocalObject(OBJECT_SELF, "OAI_GROUP_TARGET", oLowHealthFoe);
        SetLocalObject(OBJECT_SELF, "OAI_I_HATE_", oLowHealthFoe);
        SpeakString("OAI_KILL_THE_WEAKLINGS", TALKVOLUME_SILENT_TALK);
      }
      else
      {
        SetLocalObject(OBJECT_SELF, "OAI_GROUP_TARGET", oLowHealthAlly);
        oLowHealthAlly = GetNearestCreature(CREATURE_TYPE_REPUTATION, REPUTATION_TYPE_ENEMY, oLowHealthAlly, (Random(4) + 1), CREATURE_TYPE_IS_ALIVE, TRUE, CREATURE_TYPE_PERCEPTION, PERCEPTION_SEEN);
        SetLocalObject(OBJECT_SELF, "OAI_I_HATE_", oLowHealthAlly);
        SpeakString("OAI_PROTECT_THIS_FOOL", TALKVOLUME_SILENT_TALK);
      }
    }
    return FALSE;
}

void DetermineCombatRound(object oSpecified = OBJECT_SELF, int bEndOfCombatRoundCall = FALSE)
{
    object oLastTarget = GetLocalObject(OBJECT_SELF, "OAI_LASTTARGET");
    object oGTarget = GetLocalObject(OBJECT_SELF, "OAI_GROUP_TARGET");
    object oFoe = GetNearestCreature(CREATURE_TYPE_REPUTATION, REPUTATION_TYPE_ENEMY, OBJECT_SELF, 1, CREATURE_TYPE_IS_ALIVE, TRUE, CREATURE_TYPE_PERCEPTION, PERCEPTION_SEEN);
    int HaveEnemy = GetIsObjectValid(oFoe);
    int iCurrentAction = GetLocalInt(OBJECT_SELF, "OAI_GROUP_ACTION");
    if(!HaveEnemy) oFoe = OBJECT_SELF;
    ddp("DetermineCombatRound", oFoe);
    if(!bEndOfCombatRoundCall && !GetIsNotFighting()) return;
    SetLocalInt(OBJECT_SELF, "OAI_BATTLE_TIMER", 2);
    if(GetIsDead(OBJECT_SELF)) return;
    if(!GetCommandable(OBJECT_SELF)) return;
    if(!GetIsThreat(OBJECT_SELF)) return;
    if(GetIsBusy(OBJECT_SELF)) return;
    if(!GetLocalInt(OBJECT_SELF, "OAI_NOT_LEADER"))
    {
      SpeakString("OAI_I_AM_LEADER", TALKVOLUME_SILENT_TALK);
      SetBattleCondition(OAI_ROLE_GROUP_LEADER);
    }
    ClearAllActions();
    if(!GetBattleCondition(OAI_TRIGGER_HAS_BEEN_CAST) && HaveEnemy)
    {
      if(GetLocalInt(OBJECT_SELF, "OAI_ILLUSION_DC") > 0)
      {
        if(WillSave(oFoe, GetLocalInt(OBJECT_SELF, "OAI_ILLUSION_DC")))
        {
          BreakIllusion(oFoe);
          return;
         }
      }
      CastTriggers();
    }
    //rezzing is the highest priority of all...
    if(DetermineAllyToRez()) return;

    //next comes timestop, group, and special ability functions
    if(HaveEnemy && !GetHasSpellEffect(SPELL_TIME_STOP))
    {
      SummonHordes();
      if(DoCastSpellAtObject(SPELL_TIME_STOP, OBJECT_SELF, 1, 18, 0, FALSE, TRUE)) return;
      if(GetBattleCondition(OAI_ROLE_GROUP_LEADER)) if(ChooseGroupTactics()) return;
    }

    //self healing is, of course, next.
    if(HealSelf(!HaveEnemy)) return;

    //Half the time we will check our own status and see if we need a cure.
    if(d2()==1 || GetBattleCondition(OAI_I_NEED_CURE) || !HaveEnemy)
    {
      if(StatusFix(OBJECT_SELF)) return;
    }

    //if the role of healer is chosen then it takes priority over other roles.
    if(GetBattleCondition(OAI_ROLE_HEALER) || !HaveEnemy)
    {
      if(HealOthers()) return; //First priority, can we heal others?
    }

    //Attack Functions, so we must have an enemy!
    if(HaveEnemy)
    {
      SpeakString("OAI_ENTERING_BATTLE_ATTACK_MY_TARGET", TALKVOLUME_SILENT_TALK);
      if(!GetHasEffect(EFFECT_TYPE_POLYMORPH, OBJECT_SELF))
      {
        if(DetermineImmunities(oLastTarget)) return; //this is what makes them 'learn' =)
        if(DoBardSong()) return;
        if(d2()==1) if(BuffSelf()) return; //do I need a buff? 50/50 chance!
        if(DoTurnUndead(oFoe)) return;
        oFoe = DetermineSpellEnemy(oLastTarget, oSpecified);
        //this should not be able to happen since we are within the enemy found loop
        //better safe than sorry though...
        if(!GetIsObjectValid(oFoe)) return;
        if(GetStatusCondition(OAI_I_CAN_SUMMON)) if(CastSummon(oFoe)) return;
        if(GetBattleCondition(OAI_ROLE_DRAGON))
        {
          if(SpecialDragonStuff(oFoe)) return;
        }
        if(GetStatusCondition(OAI_I_CAN_CAST_MONSTER_ABILITIES) && d2()==1)
        {
          DelayCommand(0.0, CastMonsterAbilities(oFoe));
          return;
        }
        if(GetBattleCondition(OAI_ROLE_BUFFER))
        {
          ddp("-DetermineCombatRound", oFoe, "Role: Buffer");
          if(CureOther(TRUE)) return; //anyone need a status cure?
          if(BuffOther(TRUE)) return; //does anyone else need a buff?
        }
        if(GetBattleCondition(OAI_ROLE_STATUS_CASTER))
        {
          ddp("-DetermineCombatRound", oFoe, "Role: Status");
          if(DispellFoe(oFoe)) return;
          if(CastAnAOE(oFoe, 1, TRUE)) return;
          if(Single_Status(oFoe)) return;
          if(CastASingle(oFoe)) return;
          if(CastAnAOE(oFoe, 1)) return;
          if(HealOthers()) return;
          if(CureOther()) return; //anyone need a status cure?
          if(BuffOther()) return; //does anyone else need a buff?
          if(GetStatusCondition(OAI_I_CAN_CAST_MONSTER_ABILITIES))
          {
            DelayCommand(0.0, CastMonsterAbilities(oFoe));
            return;
          }
        }
        if(GetBattleCondition(OAI_ROLE_AOE_SPECIALIST))
        {
          ddp("-DetermineCombatRound", oFoe, "Role: AOE");
          if(CastAnAOE(oFoe, 1)) return;
          if(d4()==1)
          {
            if(DispellFoe(oFoe)) return;
          }
            if(CastASingle(oFoe)) return;
            if(HealOthers()) return;
            if(CureOther()) return; //anyone need a status cure?
            if(BuffOther()) return; //does anyone else need a buff?
            if(GetStatusCondition(OAI_I_CAN_CAST_MONSTER_ABILITIES))
            {
              DelayCommand(0.0, CastMonsterAbilities(oFoe));
              return;
            }
          }
          if(GetBattleCondition(OAI_ROLE_ATTACK_CASTER))
          {
            ddp("-DetermineCombatRound", oFoe, "Role: Attack Caster");
            if(d2()==1)
            {
              if(DispellFoe(oFoe)) return;
            }
            if(CastASingle(oFoe)) return;
            if(CastAnAOE(oFoe, 1)) return;
            if(HealOthers()) return;
            if(CureOther()) return; //anyone need a status cure?
            if(BuffOther()) return; //does anyone else need a buff?
            if(GetStatusCondition(OAI_I_CAN_CAST_MONSTER_ABILITIES))
            {
              DelayCommand(0.0, CastMonsterAbilities(oFoe));
              return;
            }
          }
          if(GetStatusCondition(OAI_I_CAN_CAST_SPELLS) && d4()==1)
          {
            switch (Random(7))
            {
              case 0: if(CastAnAOE(oFoe, 2)) return;
              case 1: if(CastAnAOE(oFoe, 1)) return;
              case 2: if(DispellFoe(oFoe)) return;
              case 3: if(HealOthers()) return;
              case 4: if(CureOther()) return; //anyone need a status cure?
              case 5: if(BuffOther()) return; //does anyone else need a buff?
              default: if(CastASingle(oFoe)) return;
            }
          }
          if(GetStatusCondition(OAI_I_CAN_POLYMORPH))
          {
            if(PolymorphSelf(oFoe)) return;
          }
        } //end not polymorphed
      DelayCommand(0.0, doFighting(oLastTarget, oSpecified)); //there can be no failure for melee fighting...
      return;
      } //end HaveEnemy
    ddp("-DetermineCombatRound", OBJECT_SELF, "No Combat.");

    //do this in heartbeat as a counterpoint
    //SetBattleCondition(OAI_TRIGGER_HAS_BEEN_CAST, FALSE); //reset to cast triggers again
    //SetLocalInt(OBJECT_SELF, "OAI_NO_COMBAT_NOW", FALSE);
    //Cleanup in prep for next battle...
    DeleteLocalInt(OBJECT_SELF, "OAI_LASTSPELLTYPE");
    DeleteLocalObject(OBJECT_SELF, "OAI_LASTTARGET");
    DeleteLocalObject(OBJECT_SELF, "OAI_GROUP_TARGET");
    DeleteLocalObject(OBJECT_SELF, "OAI_HEAL_TARGET");
    DeleteLocalObject(OBJECT_SELF, "OAI_CURE_TARGET");
    DeleteLocalObject(OBJECT_SELF, "OAI_OVERRIDE_TARGET");
    DeleteLocalObject(OBJECT_SELF, "OAI_I_HATE_");

    //Battle is over so lets leave any aoe we are in.
    HaveEnemy = 1;
    oFoe = GetNearestObject(OBJECT_TYPE_AREA_OF_EFFECT);
    while(GetIsObjectValid(oFoe) && GetDistanceToObject(oFoe) < 10.0)
    {
      if(GetAreaOfEffectCreator(oFoe) != OBJECT_SELF || !GetHasEffect(EFFECT_TYPE_AREA_OF_EFFECT, GetAreaOfEffectCreator(oFoe)))
      {
        ActionMoveAwayFromObject(oFoe, TRUE, 11.0);
        return;
      }
      HaveEnemy++;
      oFoe = GetNearestObject(OBJECT_TYPE_AREA_OF_EFFECT, OBJECT_SELF, HaveEnemy);
    }

    //if we are in darkness, move out of the effect...
    if(GetHasEffect(EFFECT_TYPE_DARKNESS, OBJECT_SELF))
    {
      vector vWho = GetPosition(OBJECT_SELF);
      vWho.x += IntToFloat(Random(3) * 10);
      vWho.y += IntToFloat(Random(3) * 10);
      ActionMoveToLocation(Location(oArea, vWho, 0.0), TRUE);
      return;
    }
    else if(GetHasEffect(EFFECT_TYPE_BLINDNESS, OBJECT_SELF))
    {
      switch(Random(8))
      {
        case 0: PlayVoiceChat(VOICE_CHAT_HELP); break;
        case 1: PlayVoiceChat(VOICE_CHAT_NO); break;
      }
      ActionRandomWalk();
      return;
    }

    //lastly, if we are not stupid, or certain races run
    //to allies after battle.
    HaveEnemy = GetRacialType(OBJECT_SELF);
    if(HaveEnemy != RACIAL_TYPE_ANIMAL && HaveEnemy != RACIAL_TYPE_VERMIN &&
      HaveEnemy != RACIAL_TYPE_MAGICAL_BEAST && HaveEnemy != RACIAL_TYPE_DRAGON &&
      HaveEnemy != RACIAL_TYPE_CONSTRUCT && HaveEnemy != RACIAL_TYPE_BEAST &&
      HaveEnemy != RACIAL_TYPE_ABERRATION &&
      GetAbilityScore(OBJECT_SELF, ABILITY_INTELLIGENCE) > 7)
    {
      oFoe = GetNearestCreature(CREATURE_TYPE_REPUTATION, REPUTATION_TYPE_FRIEND, OBJECT_SELF, 1, CREATURE_TYPE_IS_ALIVE, TRUE);
      if(GetIsObjectValid(oFoe))
      {
        if(GetDistanceToObject(oFoe) > 12.0)
        { //get close enough for shouts and support, also group up if your the only one left
          ActionMoveToObject(oFoe, TRUE, 6.0);
        }
        else if(GetDistanceToObject(oFoe) < 4.0)
        { //get out of packed aoe range...
          ActionMoveAwayFromObject(oFoe, TRUE, 6.0);
        }
      }
    }

    //leave trigger reset to heartbeat...give a small breather for those rezzing
    //SetBattleCondition(OAI_TRIGGER_HAS_BEEN_CAST, FALSE); //reset triggers
    if(GetSpawnInCondition(NW_FLAG_SEARCH)) ActionUseSkill(SKILL_SEARCH, OBJECT_SELF);
    if(GetSpawnInCondition(NW_FLAG_STEALTH)) ActionUseSkill(SKILL_HIDE, OBJECT_SELF);
    if(GetBattleCondition(OAI_RETURN_TO_SPAWNPOINT)) ActionForceMoveToLocation(GetLocalLocation(OBJECT_SELF, "OAI_SPAWN_LOCATION"));

    WalkWayPoints();
    ddp("-DetermineCombatRound", OBJECT_SELF, "Exiting");
}

//void main() {}
