//I made this new script that fires when a player selects 'Cancel'
//while upgrading an ammunition maker because, prior to this, 'Cancel'
//caused the upgrade to be applied and the player would be charged for it. /Moff
#include "item_enhancement"

void main()
{
object oPC =  GetPCSpeaker();
//in the abort script I call this only if nModify is 2 and then oPC is OBJECT_SELF
if (!GetIsObjectValid(oPC)) oPC = OBJECT_SELF;
    EnhanceAmmoCancel(oPC);

}
