#include "_incl_location"

void main()
{
    object oPC = GetLastUsedBy();
    string sWPTag = GetLocalString(OBJECT_SELF, "sWPTag");
    PortToWaypoint(oPC, sWPTag);
}
