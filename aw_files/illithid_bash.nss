////////////bs_bashplotdoor//////////
#include "aw_inc_doors"

void main()
{
    object oAttacker = GetLastAttacker();
    string oTarget = GetLocalString(OBJECT_SELF, "Transition Target");
    location lLoc = GetLocation(GetObjectByTag(oTarget));


    BashDoor(OBJECT_SELF,oAttacker);

}
