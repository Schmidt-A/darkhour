////////////////////////////////////////////////////////////////////////////////
//
//  Olander's AI
//  oai_inc_switches
//  by Don Anderson
//  dandersonru@msn.com
//
//  Main AI Switches
//  Original script by Fallen
//
////////////////////////////////////////////////////////////////////////////////

//Debug will flood your logs and allow
//anyone to use the ai terminal(if installed and placed in area).
int DebugMode = FALSE;
int OAI_SPAWN_CACHE = TRUE;//OnSpawn cache. Saves Spawn info for reoccuring enemies
int OAI_SPAWN_USE_RESREFS = TRUE;//Use the ResRef or Tag for cacheing (TRUE is ResRef)
int OAI_DISABLE_DISARM = FALSE;//Disable the Disarm Feat (TRUE is Yes)
int OAI_DISABLE_PICKPOCKET = FALSE;//Disable Pickpocketing the Player's (TRUE is Yes)

//:****************************************************************************/
//: MELEE TARGET DETERMINATION CONSTANTS
/*
These determine which target a creature will attack during a battle.
The chosen target is the one with the LOWEST total of AC, HP, and Distance.
*/
int OAI_AC_Multiplier_Default = 4;//Target creatures AC is multiplied by this amount.Default is 4.
int OAI_HP_Multiplier_Default = 1;//Target creatures HP is multiplied by this amount.Default is 1.
int OAI_Distance_Multiplier_Default = 2;//Target creatures Distance is multiplied by this amount.Default is 2.

//: MELEE TARGET DETERMINATION CONSTANTS
//:****************************************************************************/

//:****************************************************************************/
//: SPELL TARGET DETERMINATION CONSTANTS
/*
These determine which target a creature will attack during a battle.
The chosen target is the one with the LOWEST total of AC, HP, and Lowest Saves.
*/
int OAI_Spell_AC_Multiplier_Default = 3;//Target creatures AC is multiplied by this amount.Default is 3.
int OAI_Spell_HP_Multiplier_Default = 1;//Target creatures HP is multiplied by this amount.Default is 1.
int OAI_Spell_Saves_Multiplier_Default = 3;//Target creatures Distance is multiplied by this amount.Default is 3.

//: SPELL TARGET DETERMINATION CONSTANTS
//:****************************************************************************/

//:****************************************************************************/
//: MISC CONSTANTS
//This affects both melee and spell targeting

int OAI_Hate_Multiplier_Default = 2;//The chance of switching targets to someone who has damaged them
                                    //alot or that is set as a group focus target. Default is 2.

//This will let you change how many random buffs a creature gets, it is
//calculated as the creatures hit dice divided by this. Set to -1 for no
//random buffs in any situation (even if flagged for them). default is 3.
//WARNING!!! ANY CREATURE USING RANDOM BUFFS WILL BE BROKEN IF THIS IS
//           SET TO ZERO!!!!
int OAI_Random_Buff_Divisor_Default = 3;

//The higher the group power bonus the less chance the group has of retreating
//to allies, feel free to set it to a negative value if you want them to run
//away alot.
int OAI_Group_Power_Bonus_Default = 3;

//The group action chance is the chance of doing one of the special group
//actions per round. The default is 10%.
int OAI_Group_Action_Chance_Default = 10;

//The prefered spell range opens up an extra levels of spells that an NPC will
//always use in battle, it is done by the level you need to be to cast it instead
//of spell level so if it is a level 18 wizard (can cast level 9 spells) and the
//range is set to 5 then spells that can be cast at level 13 and above will
//always be cast and lower level spells will have a chance of failing depending
//on how low a level they are. The default is 5.
int OAI_Prefered_Spell_Range_Default = 5;

//Run or fight hitdice is for after a spell has been cast, if their max hitpoints
//are less than this value times their hitdice they will run away from the
//battle after casting, if it is greater than and there is an enemy nearby they
//will attack it. The default is 5 so wizards and sorcerers will run while
//clerics and druids will fight. (only affects caster roles)
int OAI_Run_or_Fight_Hitdice_Default = 5;

//: MISC CONSTANTS
//:****************************************************************************/

//void main () {}
