#include "stx_inc_craft"

void main() {
    object oPC =GetPCSpeaker();
    aw_StopCraft(oPC, GetLocalInt(oPC, "nModify"));
    //StX_StopCraft(oPC, FALSE);
    if (GetLocalObject(oPC,"copy") != OBJECT_INVALID)
    {
        DestroyObject( GetLocalObject(oPC,"copy"));
    }
}
