// --------------------------------------------------------
// Sparky Spawner   on_enter
//
// original version by Sparky1479
// recode and expansion by Malishara
// --------------------------------------------------------

#include "sparky_inc"
#include "X0_I0_PARTYWIDE"


void main()
{
    object oPC = GetEnteringObject();
    object oArea = OBJECT_SELF;
    int iDisabled = GetLocalInt(oArea, "iSparkyDisabled");
    int iAlreadySpawned = GetLocalInt(oArea, "iSparkySpawned");

    if (!GetIsPC(oPC))
    { return; }

    if (GetIsDM(oPC))
    { SendMessageToPC(oPC, "Sparky spawns are " + (iDisabled ? "OFF" : "ON"));
      return;
    }

    if (iAlreadySpawned || iDisabled)
    { return; }

    int iSparkyPartyLvls = GetFactionAverageLevel(oPC) * (GetNumberPartyMembers(oPC) - 1);
    SetLocalInt(oArea, "iSparkyPartyLvls", iSparkyPartyLvls);
    SpawnEncounters(oArea);
}

