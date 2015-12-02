// awards the disarming creature/PC 1000 XP for successfully
// disarming a trap when this script it placed in the trap's
// OnDisarm event
#include "inc_bs_module"
void main()
{
     object oPC = GetLastDisarmed();
     if (GetIsPC(oPC))
     {
     int nReward = GetTrapDetectDC(OBJECT_SELF)+GetTrapDisarmDC(OBJECT_SELF);
          SetXP(oPC, (GetXP(oPC)+ nReward) );
          GiveGoldToCreature(oPC, nReward);
     }
}

