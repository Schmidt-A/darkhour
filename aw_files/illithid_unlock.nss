////////////bs_bashplotdoor//////////
#include "aw_inc_doors"
void main()
{
    object oUnlocker = GetLastUnlocked();



    OpenLock(OBJECT_SELF,oUnlocker);
}
