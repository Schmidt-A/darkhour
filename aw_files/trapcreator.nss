void SF_CreateTrapAtLocation(int nTrapType, location lLoc, float fSize, string sNewTag ,
                             int nFaction, string sTrapDisarmScript, string sTrapTriggerScript)
{
    CreateTrapAtLocation(nTrapType, lLoc, fSize, sNewTag,nFaction,
                         sTrapDisarmScript, sTrapTriggerScript);
}
void main()
{
object oItem = GetItemActivated();
location lLocation = GetItemActivatedTargetLocation();
object oRogue = GetItemActivator();
int nTrapBaseType = GetLocalInt(oItem, "BaseType");
int nTrapDamageType = GetLocalInt(oItem, "DamageType");
int nTrapDC = GetSkillRank(SKILL_SET_TRAP, oRogue,FALSE);
/*
BaseType = STRONG  DEADLY
DamageType = ACID ACID_SPALSH ELECTRICAL FIRE FROST GAS HOLY NEGATIVE SONIC SPIKE TANGLE
BaseType =  EPIC
DamageType =ELECTRICAL FIRE FROST SONIC


int TRAP_BASE_TYPE_STRONG_SPIKE         = 2;    STRONG 1 SPIKE 1
int TRAP_BASE_TYPE_DEADLY_SPIKE         = 3;    DEADLY 2 SPIKE 1


int TRAP_BASE_TYPE_STRONG_HOLY          = 6;  STRONG 1 HOLY 5
int TRAP_BASE_TYPE_DEADLY_HOLY          = 7;  DEADLY 2 HOLY 5


int TRAP_BASE_TYPE_STRONG_TANGLE        = 10;    STRONG 1 TANGLE 9
int TRAP_BASE_TYPE_DEADLY_TANGLE        = 11;    DEADLY 2 TANGLE 9


int TRAP_BASE_TYPE_STRONG_ACID          = 14;   STRONG 1 ACID 13
int TRAP_BASE_TYPE_DEADLY_ACID          = 15;   DEADLY 2 ACID 13

int TRAP_BASE_TYPE_STRONG_FIRE          = 18;     FIRE 17
int TRAP_BASE_TYPE_DEADLY_FIRE          = 19;

int TRAP_BASE_TYPE_STRONG_ELECTRICAL    = 22;     ELECTRICAL 21
int TRAP_BASE_TYPE_DEADLY_ELECTRICAL    = 23;

int TRAP_BASE_TYPE_STRONG_GAS           = 26;    GAS 25
int TRAP_BASE_TYPE_DEADLY_GAS           = 27;

int TRAP_BASE_TYPE_STRONG_FROST         = 30;    FROST 29
int TRAP_BASE_TYPE_DEADLY_FROST         = 31;

int TRAP_BASE_TYPE_STRONG_NEGATIVE      = 34;     NEGATIVE 33
int TRAP_BASE_TYPE_DEADLY_NEGATIVE      = 35;

int TRAP_BASE_TYPE_STRONG_SONIC         = 38;     SONIC 37
int TRAP_BASE_TYPE_DEADLY_SONIC         = 39;

int TRAP_BASE_TYPE_STRONG_ACID_SPLASH   = 42;     ACID_SPLASH 41
int TRAP_BASE_TYPE_DEADLY_ACID_SPLASH   = 43;

int TRAP_BASE_TYPE_EPIC_ELECTRICAL      = 44;     EPIC 3
int TRAP_BASE_TYPE_EPIC_FIRE            = 45;
int TRAP_BASE_TYPE_EPIC_FROST           = 46;
int TRAP_BASE_TYPE_EPIC_SONIC           = 47;
  */
int nTrapType =   nTrapBaseType+    nTrapDamageType;
if    (  nTrapBaseType == 3  )
      switch( nTrapDamageType)
      {
         case 21 :
         nTrapType =  44;
         break;
         case 17 :
         nTrapType =  45;
         break;
         case 29 :
         nTrapType =  46;
         break;
         case 37 :
         nTrapType =  47;
         break;
       }


        AssignCommand(oRogue, ActionDoCommand(SF_CreateTrapAtLocation(nTrapType, lLocation, 2.0, "MyCreatedTrap",
                           STANDARD_FACTION_HOSTILE, "trap_disarm", "")));

//    object oTrap = CreateTrapAtLocation(nTrapType , lLocation, 2.0,"MyCreatedTrap",STANDARD_FACTION_HOSTILE ,"trap_disarm", "");
//SetTrapDetectDC(oTrap, nTrapDC);
//SetTrapDisarmDC(oTrap, nTrapDC);

// if some enemy is in range of sight, set the trap detected by them
//SetTrapDetectedBy();

}



