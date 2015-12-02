#include "item_enhancement"

void main()
{
object oPC =  GetPCSpeaker();
//in the abort script I call this only if nModify is 2 and then oPC is OBJECT_SELF
if (!GetIsObjectValid(oPC)) oPC = OBJECT_SELF;
    EnhanceAmmoFinish(oPC);

}
