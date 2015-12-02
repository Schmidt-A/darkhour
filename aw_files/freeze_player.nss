//freeze/unfreeze player ///
#include "inc_bs_module"
#include "aw_include"
void main()
{
object oGM = GetPCSpeaker();
object oPC = GetLocalObject(oGM,"MyTarget");

//if is paused -> unpause [unfreeze]
FreezeUnfreeze(oPC,oGM );
}


