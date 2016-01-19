#include "nwnx_events"

void main()
{
    int iEventType = GetEventType();

    switch(iEventType)
    {
        case EVENT_TYPE_PICKPOCKET:
            object oPC = OBJECT_SELF;
            object oTarget = GetLocalObject(OBJECT_SELF, "NWNX!EVENTS!TARGET");
            BypassEvent();
            WriteTimestampedLogEntry("PICKPOCKET: " + GetName(oPC) +
                                     "(" + GetPCPlayerName(oPC) + ")" +
                                     " tried to steal from " +
                                     GetName(oTarget) +
                                     "(" + GetPCPlayerName(oTarget) + ")");
            FloatingTextStringOnCreature("PvP Pickpocketing is currently disabled.", oPC, FALSE);
            break;
    }
}
