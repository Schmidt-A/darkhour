////////////////////////////////////////////////////////////////////////////////
//
//  Olander's AI
//  oai_inc_constant
//  by Don Anderson
//  dandersonru@msn.com
//
//  Main AI Script
//  Original script by Fallen
//
////////////////////////////////////////////////////////////////////////////////

#include "oai_inc_switches"

//Character Spawn constants.
//These are the master constants set on spawn to increase ai speed
//by not having to check things that they cannot do. This is also
int OAI_I_CAN_RAISE_DEAD                = 0x00000001;
int OAI_I_CAN_HEAL_LIVING               = 0x00000002;
int OAI_I_CAN_HEAL_UNDEAD               = 0x00000004;
int OAI_I_CAN_BUFF_PHYSICAL             = 0x00000008;
int OAI_I_CAN_BUFF_MENTAL               = 0x00000010;
int OAI_I_CAN_BUFF_ELEMENTAL            = 0x00000020;
int OAI_I_CAN_BUFF_MAGIC                = 0x00000040;
int OAI_I_CAN_BUFF_SIGHT                = 0x00000080;
int OAI_I_CAN_CURE_POISON               = 0x00000100;
int OAI_I_CAN_CURE_DISEASE              = 0x00000200;
int OAI_I_CAN_CAST_DISPELLS             = 0x00000400;
int OAI_I_CAN_CAST_BREACHES             = 0x00000800;
int OAI_I_CAN_CAST_AOES                 = 0x00001000;
int OAI_I_CAN_CAST_FIRE                 = 0x00002000;
int OAI_I_CAN_CAST_ICE                  = 0x00004000;
int OAI_I_CAN_CAST_ELECTRIC             = 0x00008000;
int OAI_I_CAN_CAST_ACID                 = 0x00010000;
int OAI_I_CAN_CAST_NEGATIVE             = 0x00020000;
int OAI_I_CAN_CAST_OTHER                = 0x00040000;
int OAI_I_CAN_CAST_INSTANT_DEATH        = 0x00080000;
int OAI_I_CAN_CAST_STATUS               = 0x00100000;
int OAI_I_CAN_CAST_MONSTER_ABILITIES    = 0x00200000;
int OAI_I_CAN_POLYMORPH                 = 0x00400000;
int OAI_I_CAN_SUMMON                    = 0x00800000;
int OAI_I_HAVE_HEALING_POTIONS          = 0x01000000;
int OAI_I_HAVE_BUFFING_POTIONS          = 0x02000000;
int OAI_I_HAVE_HEALING_KITS             = 0x04000000;
int OAI_I_HAVE_TRAP_KITS                = 0x08000000;
int OAI_I_HAVE_BATTLE_FEATS             = 0x10000000;
int OAI_I_CAN_FIGHT_MELEE               = 0x20000000;
int OAI_I_CAN_FIGHT_RANGED              = 0x40000000;
int OAI_I_CAN_CAST_SPELLS               = 0x80000000;

//Character Battle constants
//The first part of these constants are battle status
//notices and will be used in battle. The second part
//of this list are the constants that control how an
//npc acts in battle and what special abilities they have

int OAI_TRIGGER_HAS_BEEN_CAST           = 0x00000001;
int OAI_I_NEED_BUFF_PHYSICAL            = 0x00000002;
int OAI_I_NEED_BUFF_MENTAL              = 0x00000004;
int OAI_I_NEED_BUFF_ELEMENTAL           = 0x00000008;
int OAI_I_NEED_BUFF_MAGIC               = 0x00000010;
int OAI_I_NEED_BUFF_SIGHT               = 0x00000020;
int OAI_I_NEED_CURE                     = 0x00000040;

    //Fast Buff Switches:
            //The following 3 switches control fast buffing of NPCs and are
            //activated when the creature first enters combat. If you don't
            //want fast buffs just comment out the lines.
        //Complete is just like it sounds, the NPC will activate ALL defensive
        //spells that they have, instantly and for free. (Can make an Easy evil!)
        //Complete also has priority over Random, so if both are enabled it will
        //do a complete buff.
int OAI_FAST_BUFF_COMPLETE              = 0x00000080;
        //Random will randomly apply a number of buffs depending on the level of
        //the npc, they can be anything memorized from virtue to premonition. The
        //higher the level of the npc the more buffs they get. I prefer this.
int OAI_FAST_BUFF_RANDOM                = 0x00000100;
        //Summon will just instant summon the best companion possible when combat
        //starts, since pcs can usually have a summon following them around why not
        //an npc? I prefer to have this one on as well, it may be used alone or
        //with either of the other fast buff types.
int OAI_FAST_BUFF_SUMMON                = 0x00000200;
    //Aura switch:
        //This will make the NPC apply it's auras at spawn, otherwise they will be
        //applied at the beginning of battle (instantly and for free) I prefer
        //to have this off since auras are easy to see from far away.
int OAI_CAST_AURAS_NOW                  = 0x00000400;



//Roles
//All roles will resurect the dead as top priority if they can.

//The group leader is nothing special, they just start the group actions
//scripts. If a group does not have a leader they will not act like a
//group is all. If they have more than one leader the group scripts will
//mess up.
int OAI_ROLE_GROUP_LEADER               = 0x00000800;
//If an npc has healer selected they will heal as a priority, then follow
//whatever other roles are switched on.
int OAI_ROLE_HEALER                     = 0x00001000;
//a buffer is another priority caster (second to healer). They will apply
//cures (Restorations, Remove Curse, etc) and buffs (stoneskin, true sight, etc)
//to any group members that request them.
int OAI_ROLE_BUFFER                     = 0x00002000;
//a dragon will use dragon breath attacks more often and a special wing buffet
//script that can knock down large groups of people.
int OAI_ROLE_DRAGON                     = 0x00004000;
//a status caster will attempt to put status ailments on enemies (ie. curse,
//feebleminded, poisons, etc) as a priority (only uses preference if unable to
//hit with a status attack).
int OAI_ROLE_STATUS_CASTER              = 0x00008000;
//An attack caster casts single target or safe aoe attack spells as a priority.
int OAI_ROLE_ATTACK_CASTER              = 0x00010000;
//an aoe specialist can be deadly to both sides, but is pretty good at hitting only
//enemies. The aoe code uses a bit of math to determine the best location, so
//having too many aoe specialists could slow things down even more than the aoe fx they
//cause =/
int OAI_ROLE_AOE_SPECIALIST             = 0x00020000;

/* preferences removed
//The following is the spell preference for any caster. unless their role dictates
//otherwise, they have a 2/3 chance of using this chosen field for their castings.
//You can only choose one of these.
int OAI_I_PREFER_FIRE                   = 0x00040000;
int OAI_I_PREFER_ICE                    = 0x00080000;
int OAI_I_PREFER_ELECTRIC               = 0x000C0000;
int OAI_I_PREFER_ACID                   = 0x00100000;
int OAI_I_PREFER_NEGATIVE               = 0x00140000;
int OAI_I_PREFER_OTHER                  = 0x00180000;
int OAI_I_PREFER_INSTANT_DEATH          = 0x001C0000;
int OAI_I_PREFER_STATUS                 = 0x00200000;
//left 7 expansion slots for any other preferences in the future
//0x00240000 -> 0x003C0000

//These are the attack feat preferences, same as spell prefs, only use one!
//These will also override their better judgement and use the skill anyways.
int OAI_I_PREFER_EXTRA_ATTACKS          = 0x00400000; //rapid shot, flurry of blows
int OAI_I_PREFER_STUNNING               = 0x00800000; //sap, stunning blow
int OAI_I_PREFER_POWER_ATTACK           = 0x00C00000;
int OAI_I_PREFER_KNOCKDOWN              = 0x01000000;
int OAI_I_PREFER_DISARM                 = 0x01400000;
int OAI_I_PREFER_CALLED_SHOT            = 0x01800000;
int OAI_I_PREFER_TAUNT                  = 0x01C00000;
//removed, does not work//int OAI_I_PREFER_PARRY                  = 0x02000000;
//does not work//int OAI_I_PREFER_SETTING_TRAPS          = 0x02400000;
int OAI_I_PREFER_PICKPOCKET             = 0x02800000;
int OAI_I_PREFER_SNEAK_ATTACK           = 0x02C00000;
//4 expansion slots for future feats
//0x03000000 -> 0x03C00000
*/
//Special Abilities
//These give the npc a special ability to use in battle, best for making a boss
//memorable, there are many other fun abilities in the spawn file =)

//Blink self allows the npc to change places once a round in combat,
//you can set the local int OAI_BLINK_OAILURE to the failure percent.
int OAI_BLINK_SELF                      = 0x04000000;
//Blink others will take one person per round that has hit the caster physically
//and move them somewhere nearby. It also uses the OAI_BLINK_OAILURE percent.
int OAI_BLINK_OTHERS                    = 0x08000000;
//The npc will return to their spawn point after battle.
int OAI_RETURN_TO_SPAWNPOINT            = 0x10000000;
//Causes the creature to NOT learn the immunities of the foe it is facing.
int OAI_I_CANNOT_LEARN                  = 0x20000000;

//Actions for learning, used whenever a spell or talent that does a certain type
//of action is used. Gives the appearence of enemies 'learning' your
//immunities instead of just 'knowing' them. Also allows the cpu to determine
//things that there are no functions for (ie electrical resist)
int OAI_IMMUNITY_FIRE                   = 0x00000001;
int OAI_IMMUNITY_ICE                    = 0x00000002;
int OAI_IMMUNITY_ACID                   = 0x00000004;
int OAI_IMMUNITY_NEGATIVE               = 0x00000008;
int OAI_IMMUNITY_ELECTRIC               = 0x00000010;
int OAI_IMMUNITY_POSITIVE               = 0x00000020;
int OAI_IMMUNITY_DEATH                  = 0x00000040;
int OAI_IMMUNITY_STUN                   = 0x00000080;
int OAI_IMMUNITY_DRAIN                  = 0x00000100;
int OAI_IMMUNITY_DOMINATE               = 0x00000200;
int OAI_IMMUNITY_PARALYZE               = 0x00000400;
int OAI_IMMUNITY_CURSE                  = 0x00000800;
int OAI_IMMUNITY_POISON                 = 0x00001000;
int OAI_IMMUNITY_FEAR                   = 0x00002000;
int OAI_IMMUNITY_BLIND                  = 0x00004000;
int OAI_IMMUNITY_DAZE                   = 0x00008000;
int OAI_IMMUNITY_DISEASE                = 0x00010000;
int OAI_IMMUNITY_MOVEMENT               = 0x00020000;
int OAI_IMMUNITY_SLEEP                  = 0x00040000;
int OAI_IMMUNITY_SLOW                   = 0x00080000;
int OAI_IMMUNITY_KNOCKDOWN              = 0x00100000;
int OAI_IMMUNITY_PETRIFY                = 0x00200000;

//These are the original neverwinter constants that are supported by this ai
//Master Constants
int NW_FLAG_SPECIAL_CONVERSATION        = 0x00000001;
int NW_FLAG_STEALTH                     = 0x00000004;
int NW_FLAG_SEARCH                      = 0x00000008;
int NW_FLAG_PERCIEVE_EVENT              = 0x00000200;
int NW_FLAG_ATTACK_EVENT                = 0x00000400;
int NW_FLAG_DAMAGED_EVENT               = 0x00000800;
int NW_FLAG_SPELL_CAST_AT_EVENT         = 0x00001000;
int NW_FLAG_DISTURBED_EVENT             = 0x00002000;
int NW_FLAG_END_COMBAT_ROUND_EVENT      = 0x00004000;
int NW_FLAG_ON_DIALOGUE_EVENT           = 0x00008000;
int NW_FLAG_RESTED_EVENT                = 0x00010000;
int NW_FLAG_DEATH_EVENT                 = 0x00020000;
int NW_FLAG_SPECIAL_COMBAT_CONVERSATION = 0x00040000;
int NW_FLAG_AMBIENT_ANIMATIONS          = 0x00080000;
int NW_FLAG_HEARTBEAT_EVENT             = 0x00100000;
int NW_FLAG_IMMOBILE_AMBIENT_ANIMATIONS = 0x00200000;
int NW_FLAG_DAY_NIGHT_POSTING           = 0x00400000;
int NW_FLAG_AMBIENT_ANIMATIONS_AVIAN    = 0x00800000;
int NW_FLAG_SLEEPING_AT_NIGHT           = 0x02000000;


//here are the switches(and variables needed) so a dm can set things up how they want.
object oArea=GetArea(OBJECT_SELF); //used for various checks
//string sGroupID = IntToString(GetLocalInt(OBJECT_SELF, "fai_group_id")); //used for queues
int MyHD = GetHitDice(OBJECT_SELF); //used for various comparisons
int MyCappedHD = (MyHD > 20) ? 20 : MyHD;

int OAI_AC_MULTIPLIER = OAI_AC_Multiplier_Default;
int OAI_HP_MULTIPLIER = OAI_HP_Multiplier_Default;
int OAI_DISTANCE_MULTIPLIER = OAI_Distance_Multiplier_Default;
int OAI_HATE_MULTIPLIER = OAI_Hate_Multiplier_Default;
int OAI_SPELL_AC_MULTIPLIER = OAI_Spell_AC_Multiplier_Default;
int OAI_SPELL_HP_MULTIPLIER = OAI_Spell_HP_Multiplier_Default;
int OAI_SPELL_SAVES_MULTIPLIER = OAI_Spell_Saves_Multiplier_Default;
int OAI_RANDOM_BUFF_DIVISOR = OAI_Random_Buff_Divisor_Default;
int OAI_GROUP_POWER_BONUS = OAI_Group_Power_Bonus_Default;
int OAI_GROUP_ACTION_CHANCE = OAI_Group_Action_Chance_Default;
int OAI_PREFERED_SPELL_RANGE = OAI_Prefered_Spell_Range_Default;
int OAI_RUN_OR_FIGHT_HITDICE = OAI_Run_or_Fight_Hitdice_Default;

//void main (){}
