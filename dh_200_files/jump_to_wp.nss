#include "_incl_location"

void main()
{
    string sWPTag = GetLocalString(OBJECT_SELF, "sWPTag");
    PortToWaypoint(sWPTag);
}
