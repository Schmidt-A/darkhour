/*

Tz-Auber's Perfect Troll Regeneration Script 1.3
By: Tz-Auber
Last Modified: 9/23/03
Developed for: 1.30/SoU

Description
-----------
This small script properly implements 3rd Edition subdual damage rules as it relates
to regeneration.  Some of the highlighted features are:
- By using the SetImmortal function, feedback for the Troll's health is properly
  displayed.
- Only uses OnHeartbeat and OnDamaged events.  No messing with OnDeath and XP
  calculations.
- Allows for quickly killing a downed Troll through a specified item (by default,
  a torch item type equipped in the off-hand) or through SoU grenade type
  weapons (Acid Flask and Alchemist Fire).
- A knockdown effect occurs when actual damage exceeds subdual damage, and it
  also simulates attacking a prone opponent.
- Allows for automatic 3E Coup de Grace attempts if the Troll is down and the equipped
  weapon is capable of doing permanent damage.

Modifications Required
----------------------
- This script must be placed in a creature's OnUserDefined event.
- The OnSpawn script must have the following SetSpawnInConditions uncommented/added:
  - NW_FLAG_HEARTBEAT_EVENT
  - NW_FLAG_DAMAGED_EVENT
  - NW_FLAG_ATTACK_EVENT
  - NW_FLAG_SPELL_CAST_AT_EVENT
- The following line must be added in the OnSpawn script at the end
  - SetImmortal(OBJECT_SELF,TRUE);
- Remove the default Troll's regeneration property by removing it's hide from the
  creature inventory (or remove the regeneration property if you want to keep
  other hide properties).

Credits
-------
I want to thank U'lias, as I used his code for a basis and starting point
(creation date 12/29/02).  His code can be found by searching the vault under
"Ulias' 3eMM D&D Style Trolls v1.3"

I would also like to thank El Magnifico Uno, one of the pioneers of Troll
regeneration code, who also provided useful critique in the development of this
work.

Version History
---------------
1.5 (8/3/06, Resonance)
    * Making the full round burning uninterruptible can also glitch PCs so that
      they are stuck until they relog, so remove that.  PCs will still play the
      bending over animation, and will still queue attacks until after that
      finishes, but if they run, they can break out of the animation immediately
      without problems.

1.4 (8/1/06, Resonance)
    * Acid, Fire, and Death Magic spells now properly act like grenades
    * Forcing the PCs to run to the target on Coup de Grace causes locks, so removed.
    * Burning the body from melee still takes a full round
    * Flame Weapon and Darkfire now make weapons count as torches
    * There is no apparent way to get Flame Weapon/Darkfire damage to
      actually count as fire damage, however -- it is always subdual.
    * Coup de Grace damage is now cumulative for setting DC
    * Factored out fire and acid death effect code

1.3 (9/23/03) - Found out that my code has just been released into the wilds of
    a PW and have received a lot of useful feedback.  New features added: support
    for 3E Coup de Grace attempts and the use of Alchemist Fire and Acid Flasks
    to fry a Troll in addition to the torch.

1.2 (9/22/03) - Hmm.. this was supposed to come sooner, but here it is.  Changed
    from a resref dependency of the burning item, to a base item type dependency.
    So any BASE_ITEM_TORCH equipped in the off-hand should work regardless of
    tags and resrefs.  Finally added debug message considerations.  I'll save
    the final spell modifications when HotU comes out, but a small placeholder
    is there in the meantime.

1.1 (7/24/03) - My implementation of subdual rules were a little messed up.  I'm now
    considering damage in excess of the limit of SetImmortal function.  Also
    added visual effect support for acid damaging weapons and tweaked with the
    fire visual effects a little.

1.0 (7/21/03) - Initial Release

*/

// Included for the RemoveSpecificEffect function
#include "nw_i0_spells"

// The amount of hitpoints (subdual damage) regenerated per round
const int REGENERATION_VALUE = 5;

// The time it takes (in full rounds) to burn a Troll
const int BURNING_TIME = 1;

// Switching debug messages on/off
const int DEBUG_OUTPUT = 0;

void BurnEffect()
{
    CreateObject(OBJECT_TYPE_PLACEABLE, "plc_weathmark", GetLocation(OBJECT_SELF), TRUE);
}

// Find out if the weapon is burning from Flame Weapon or Darkfire
int GetIsBurning(object oItem)
{
    // Start by checking to see if it's a torch
    if(GetBaseItemType(oItem) == BASE_ITEM_TORCH) return TRUE;

    // Now check for Flame Weapon or Darkfire
    itemproperty ip = GetFirstItemProperty(oItem);
    while (GetIsItemPropertyValid(ip))
    {
        if (GetItemPropertyType(ip) ==  ITEM_PROPERTY_ONHITCASTSPELL)
        {
            if (GetItemPropertySubType(ip) == 127) return TRUE; // Darkfire
            if (GetItemPropertySubType(ip) == 124) return TRUE; // Flame Weapon
            if (GetItemPropertySubType(ip) == 301) return TRUE; //Purist Burning Blade
        }
        ip = GetNextItemProperty(oItem);
    }
    return FALSE;
}


// Returns 0 if the spell does neither fire nor acid damage
// Returns 1 if the spell does acid damage
// Returns 2 if the spell does fire damage (or both fire and acid)
// Returns 3 if the spell is death magic
// Grenades are counted as spells
int IsAcidFireDeathSpell(int nSpellID)
{
    int retval = 0;  // Default to neither fire nor acid

    switch(nSpellID)
    {
        // Check for acid spells
        case SPELL_ACID_FOG:
        case SPELL_ACID_SPLASH:
        case SPELL_CLOUDKILL:
        case SPELL_GRENADE_ACID:
        case SPELL_MELFS_ACID_ARROW:
        case SPELL_MESTILS_ACID_BREATH:
        case SPELL_MESTILS_ACID_SHEATH:
        case SPELL_STORM_OF_VENGEANCE:
            retval = 1;
            break;

        // Check for fire spells
        // Flame Weapon/Darkfire from OnHit don't count?
        case SPELL_BURNING_HANDS:
        case SPELL_COMBUST:
        case SPELL_DARKFIRE:
        case SPELL_DELAYED_BLAST_FIREBALL:
        case SPELL_EPIC_HELLBALL:
        case SPELL_FIRE_STORM:
        case SPELL_FIREBALL:
        case SPELL_FIREBRAND:
        case SPELL_FLAME_ARROW:
        case SPELL_FLAME_LASH:
        case SPELL_FLAME_STRIKE:
        case SPELL_FLAME_WEAPON:
        case SPELL_GRENADE_FIRE:
        case SPELL_INCENDIARY_CLOUD:
        case SPELL_INFERNO:
        case SPELL_METEOR_SWARM:
        case SPELL_SEARING_LIGHT:
        case SPELL_SHADES_FIREBALL:
        case SPELL_SHADES_WALL_OF_FIRE:
        case SPELL_SUNBEAM:
        case SPELL_SUNBURST:
            retval = 2;
            break;

        // Check for death magic
        case SPELL_CIRCLE_OF_DEATH:
        case SPELL_DESTRUCTION:
        case SPELL_FINGER_OF_DEATH:
        case SPELL_IMPLOSION:
        case SPELL_POWER_WORD_KILL:
        case SPELL_SLAY_LIVING:
        case SPELL_WAIL_OF_THE_BANSHEE:
        case SPELL_WORD_OF_FAITH:
            retval = 3;
            break;
    }
    return retval;
}

// Troll death effect: fire damage
void FireDeathEffect(object oTroll)
{
    effect eFlame = EffectVisualEffect(VFX_DUR_INFERNO_CHEST);  //VFX_IMP_FLAME_M
    DelayCommand(2.0, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eFlame, oTroll, 3.0));
    DelayCommand(1.5, BurnEffect());
    //object oFlame = CreateObject(OBJECT_TYPE_PLACEABLE, "plc_flamemedium", GetLocation(oTroll), TRUE);
    //DestroyObject(oFlame, 3.25);
    return;
}

// Troll death effect: acid damage
void AcidDeathEffect(object oTroll)
{
    effect eAcid = EffectVisualEffect(VFX_FNF_GAS_EXPLOSION_ACID);
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eAcid, oTroll);
    return;
}

void main()
{
    int nUser = GetUserDefinedEventNumber();

    if(nUser == EVENT_HEARTBEAT) // OnHeartbeat Event
    {
        // the Troll's cumulative Fire and Acid damage
        int nPermanentDamage = GetLocalInt(OBJECT_SELF, "nPermanentDamage");;
        // the Troll's original maximum hitpoints
        int nOriginalHPs = GetMaxHitPoints(OBJECT_SELF);
        // the Troll's current hitpoints
        int nCurrentHPs = GetCurrentHitPoints(OBJECT_SELF);
        // the Troll's excess damage
        int nExcessDamage = GetLocalInt(OBJECT_SELF, "nExcessDamage");

        // the maximum number of HPs that the Troll can possibly regenerate due
        // to permanent fire or acid damage
        int nMaxHPsPossible = nOriginalHPs - nPermanentDamage;

        // Debug Stuff
        if(DEBUG_OUTPUT)
        {
            SendMessageToPC(GetFirstPC(),"Current HPs = " + IntToString(nCurrentHPs));
            SendMessageToPC(GetFirstPC(),"Subdual Damage = " + IntToString(nMaxHPsPossible - nCurrentHPs));
            SendMessageToPC(GetFirstPC(),"Excess Damage = " + IntToString(nExcessDamage));
            SendMessageToPC(GetFirstPC(),"Effective HPs = " + IntToString(nCurrentHPs - nExcessDamage));
            SendMessageToPC(GetFirstPC(),"Max Possible HPs = " + IntToString(nMaxHPsPossible) + "/" + IntToString(nOriginalHPs));
            SendMessageToPC(GetFirstPC(),"-----");
        }

        // the Troll may only regenerate if its current HPs are less than its
        // maximum possible HPs left after fire and acid damage
        if(nExcessDamage >= REGENERATION_VALUE)
        {
            nExcessDamage -= REGENERATION_VALUE;
            SetLocalInt(OBJECT_SELF, "nExcessDamage", nExcessDamage);
        }
        else if(nExcessDamage > 0)
        {
            // regeneration effect (the excess difference)
            effect eHeal = EffectHeal(REGENERATION_VALUE - nExcessDamage);
            ApplyEffectToObject(DURATION_TYPE_INSTANT, eHeal, OBJECT_SELF);

            nExcessDamage = 0;
            SetLocalInt(OBJECT_SELF, "nExcessDamage", nExcessDamage);
        }
        else if (nCurrentHPs <= (nMaxHPsPossible - REGENERATION_VALUE))
        {
            // regeneration effect (5 HPs every round)
            effect eHeal = EffectHeal(REGENERATION_VALUE);
            ApplyEffectToObject(DURATION_TYPE_INSTANT, eHeal, OBJECT_SELF);
        }
        else if (nCurrentHPs <= nMaxHPsPossible)
        {
            // regeneration effect (the remainder of hitpoints)
            effect eHeal = EffectHeal(nMaxHPsPossible - nCurrentHPs);
            ApplyEffectToObject(DURATION_TYPE_INSTANT, eHeal, OBJECT_SELF);
        }

        // the Troll will now see if it can get up after it's latest beating
        // provided that the Troll is grounded
        effect eKnockdown = EffectKnockdown();
        int bDowned = GetLocalInt(OBJECT_SELF,"bDowned");
        // When current subdual damage is lower than current hit points
        if (((nMaxHPsPossible - nCurrentHPs + nExcessDamage) < nMaxHPsPossible)&&(bDowned))
        {
            RemoveSpecificEffect(GetEffectType(eKnockdown),OBJECT_SELF);
            SetLocalInt(OBJECT_SELF,"bDowned",0);
        }
    }
    else if(nUser == EVENT_DAMAGED) // OnDamaged Event
    {
        object oDamager = GetLastDamager();

        // the Troll's cumulative Permanent damage
        int nPermanentDamage = GetLocalInt(OBJECT_SELF, "nPermanentDamage");
        // the Troll's current Fire damage newly received
        int nFireDamage = GetDamageDealtByType(DAMAGE_TYPE_FIRE);
        // the Troll's current Acid damage newly received
        int nAcidDamage = GetDamageDealtByType(DAMAGE_TYPE_ACID);
        // the rest of the damage inflicted on the Troll
        int nOtherDamage = GetTotalDamageDealt() - nFireDamage - nAcidDamage;
        // the Troll's excess damage
        int nExcessDamage = GetLocalInt(OBJECT_SELF, "nExcessDamage");
        // the Troll's coup de grace cumulative damage
        int nCoupDamage = GetLocalInt(OBJECT_SELF, "nCoupDamage");
        // the Troll's current hitpoints
        int nCurrentHPs = GetCurrentHitPoints(OBJECT_SELF);
        // the Troll's previous (newly inflicted HP value)
        int nPrevHPs = GetLocalInt(OBJECT_SELF, "nPrevHPs");
        // in case this is the first time the Troll is damaged
        if(nPrevHPs == 0)
            nPrevHPs = GetMaxHitPoints(OBJECT_SELF);

        // if there is damage in excess of the previous hp value,
        // excess damage will be updated
        if(nOtherDamage > nPrevHPs)
            nExcessDamage += (nOtherDamage - nPrevHPs);

        // Now the excess damage and previous hit points will be updated
        SetLocalInt(OBJECT_SELF,"nExcessDamage",nExcessDamage);
        SetLocalInt(OBJECT_SELF,"nPrevHPs",nCurrentHPs);

        // make sure Fire damage is not less than 0
        if (nFireDamage < 0) nFireDamage = 0;
        // make sure Acid damage is not less than 0
        if (nAcidDamage < 0) nAcidDamage = 0;

        // if the Troll suffered Fire damage
        if (nFireDamage > 0)
        {
            // keep track of cumulative Fire damage
            nPermanentDamage += nFireDamage;
            // won't be counted as subdual damage
            effect eHeal = EffectHeal(nFireDamage);
            ApplyEffectToObject(DURATION_TYPE_INSTANT, eHeal, OBJECT_SELF);
        }
        // if the Troll suffered Acid damage
        if (nAcidDamage > 0)
        {
            // keep track of cumulative Acid damage
            nPermanentDamage += nAcidDamage;
            // won't be counted as subdual damage
            effect eHeal = EffectHeal(nAcidDamage);
            ApplyEffectToObject(DURATION_TYPE_INSTANT, eHeal, OBJECT_SELF);
        }

        // Apply the Permanent Damage
        SetLocalInt(OBJECT_SELF,"nPermanentDamage",nPermanentDamage);

        // the Troll's original maximum hitpoints
        int nOriginalHPs = GetMaxHitPoints(OBJECT_SELF);
        // the maximum number of HPs that the Troll can possibly regenerate due
        // to permanent fire or acid damage
        int nMaxHPsPossible = nOriginalHPs - nPermanentDamage;

        // This part will simulate an unconscience effect via knockdown
        // If the troll's subdual damage exceeds it's current hitpoints ...
        effect eKnockdown = EffectKnockdown();
        int bDowned = GetLocalInt(OBJECT_SELF,"bDowned");
        // When current subdual damage is higher than current hit points
        if ((nMaxHPsPossible < (nMaxHPsPossible - nCurrentHPs + nExcessDamage))&&(!bDowned))
        {
            ApplyEffectToObject(DURATION_TYPE_PERMANENT,eKnockdown,OBJECT_SELF);
            bDowned = 1;
            SetLocalInt(OBJECT_SELF,"bDowned",bDowned);
        }

        // Now let's check and see if the troll has attained final death
        // First we'll check whether someone is carefully burning the body
        // (will take a full round to perform)
        object oLeftHandItem = GetItemInSlot(INVENTORY_SLOT_LEFTHAND, oDamager);
        object oRightHandItem = GetItemInSlot(INVENTORY_SLOT_RIGHTHAND, oDamager);

        if( bDowned && (GetIsBurning(oLeftHandItem) || GetIsBurning(oRightHandItem)) )
        {
//            DelayCommand(0.2,SetCommandable(FALSE,oDamager));
            AssignCommand(oDamager, ClearAllActions());
            AssignCommand(oDamager, ActionPlayAnimation(ANIMATION_LOOPING_GET_LOW, 1.0, RoundsToSeconds(BURNING_TIME)));
//            AssignCommand(oDamager, ActionDoCommand(SetCommandable(TRUE,oDamager)));
            FireDeathEffect(OBJECT_SELF);
            effect eDeath = EffectDeath();
            SetImmortal(OBJECT_SELF,FALSE);
            ApplyEffectToObject(DURATION_TYPE_INSTANT, eDeath, OBJECT_SELF);
        }
        else if( bDowned && (GetLocalInt(oDamager, "VAR_IGNITESPELL") == 1))
        {
//            DelayCommand(0.2,SetCommandable(FALSE,oDamager));
            AssignCommand(oDamager, ClearAllActions());
            AssignCommand(oDamager, ActionPlayAnimation(ANIMATION_LOOPING_WORSHIP, 0.8, RoundsToSeconds(BURNING_TIME)));
//            AssignCommand(oDamager, ActionDoCommand(SetCommandable(TRUE,oDamager)));
            FireDeathEffect(OBJECT_SELF);
            effect eDeath = EffectDeath();
            SetImmortal(OBJECT_SELF,FALSE);
            ApplyEffectToObject(DURATION_TYPE_INSTANT, eDeath, OBJECT_SELF);
        }
        // Now let's check and see if the damager is capable of performing a
        // Coup de Grace attempt, and if so they will automatically perform one.
        // The Troll's save will be Fortitude of DC 10 + Permanent Damage dealt.
        else if (GetLocalInt(OBJECT_SELF,"bCoupdeGrace") && !GetLocalInt(OBJECT_SELF,"bGrenade")
            && (nFireDamage || nAcidDamage) && bDowned)
        {
            DeleteLocalInt(OBJECT_SELF,"bCoupdeGrace");
            object eSelf = OBJECT_SELF;
            location lSelf = GetLocation(eSelf);

            // DelayCommand(0.2,SetCommandable(FALSE,oDamager));
            // AssignCommand(oDamager, ClearAllActions());
            // AssignCommand(oDamager, ActionMoveToObject(eSelf,TRUE,0.1));
            // AssignCommand(oDamager, ActionPlayAnimation(ANIMATION_LOOPING_GET_LOW, 1.0, 4.5));
            // //AssignCommand(oDamager, ActionDoCommand(SetCommandable(TRUE,oDamager)));

            nCoupDamage = nCoupDamage + nFireDamage + nAcidDamage;
            if(!FortitudeSave(OBJECT_SELF,10 + nCoupDamage,
                              SAVING_THROW_TYPE_ALL, oDamager))
            {
                effect eBlood = EffectVisualEffect(VFX_COM_CHUNK_RED_SMALL);

                // AssignCommand(oDamager, ActionDoCommand(ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eBlood, lSelf)));
                // AssignCommand(oDamager, ActionDoCommand(SetCommandable(TRUE,oDamager)));

                FloatingTextStringOnCreature("Coup de Grace (success)",oDamager);

                // Fire will be favored over acid in the event they are equal
                if(nFireDamage >= nAcidDamage)
                {
                    FireDeathEffect(OBJECT_SELF);
                }
                else
                {
                    AcidDeathEffect(OBJECT_SELF);
                }
                effect eDeath = EffectDeath();
                SetImmortal(OBJECT_SELF,FALSE);
                ApplyEffectToObject(DURATION_TYPE_INSTANT, eDeath, OBJECT_SELF);
            }
            else // Fort save succeeded, store cumulative coup damage
            {
                // AssignCommand(oDamager, ActionDoCommand(SetCommandable(TRUE,oDamager)));
                SetLocalInt(OBJECT_SELF, "nCoupDamage", nCoupDamage);
                FloatingTextStringOnCreature("Coup de Grace (failure)",oDamager);
            }
        }
        // ... or if it took damage the old fashioned way ...
        // (i.e. all hitpoints exhausted due to fire and/or acid)
        else if (nMaxHPsPossible <= 0)
        {
            SetImmortal(OBJECT_SELF,FALSE);
            // Fire will be favored over acid in the event they are equal
            if(nFireDamage >= nAcidDamage)
            {
                FireDeathEffect(OBJECT_SELF);
            }
            else
            {
                AcidDeathEffect(OBJECT_SELF);
            }
            effect eDeath = EffectDeath();
            ApplyEffectToObject(DURATION_TYPE_INSTANT, eDeath, OBJECT_SELF);
        }
    }
    else if(nUser == EVENT_SPELL_CAST_AT) // OnSpellCastAt Event
    {
        int nSpellID = GetLastSpell();
        int nAcidFireDeath = IsAcidFireDeathSpell(nSpellID);

        object oCaster = GetLastSpellCaster();

        // Will consider all instant death effects, acid and fire damage from
        // both spells and grenades
        if(GetLastSpellHarmful())
        {
            if(GetLocalInt(OBJECT_SELF,"bDowned") && nAcidFireDeath)
            {
                SetLocalInt(OBJECT_SELF,"bGrenade",1);
                object eSelf = OBJECT_SELF;

                // DelayCommand(0.2,SetCommandable(FALSE,oCaster));
                // AssignCommand(oCaster, ClearAllActions());
                // AssignCommand(oCaster, ActionMoveToObject(eSelf,TRUE,0.1));
                // AssignCommand(oCaster, ActionPlayAnimation(ANIMATION_LOOPING_GET_LOW, 1.0, RoundsToSeconds(BURNING_TIME)));
                // AssignCommand(oCaster, ActionDoCommand(SetCommandable(TRUE,oCaster)));

                if(nAcidFireDeath == 2)
                {
                    FireDeathEffect(OBJECT_SELF);
                }
                else if(nAcidFireDeath == 1)
                {
                    AcidDeathEffect(OBJECT_SELF);
                }
                effect eDeath = EffectDeath();
                SetImmortal(OBJECT_SELF,FALSE);
                ApplyEffectToObject(DURATION_TYPE_INSTANT, eDeath, OBJECT_SELF);
            }
        }
        // Will consider all healing effects
        else
        {

        }
    }
    else if(nUser == EVENT_ATTACKED) // OnPhysicalAttacked Event
    {
        if(GetLocalInt(OBJECT_SELF,"bDowned"))
        {
            SetLocalInt(OBJECT_SELF,"bCoupdeGrace",1);
        }
    }
}

