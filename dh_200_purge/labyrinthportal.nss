#include "_incl_location"

void main()
{

    object oPC = GetLastUsedBy();

    if (!GetIsPC(oPC))
    	return;

    PortToWaypoint(oPC, "LABYRINTH" + IntToString(d4()));
}

