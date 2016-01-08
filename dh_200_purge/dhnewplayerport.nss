#include "_incl_location"

void main()
{
    object oPC = GetEnteringObject();
    if (!GetIsPC(oPC))
        return;

    if (GetItemPossessedBy(oPC, "darkhourtoken")!= OBJECT_INVALID)
        return;

    PortToWaypoint("newplayerwaypoint");
}
