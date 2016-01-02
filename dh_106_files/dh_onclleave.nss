#include "nwnx_chat"

void main()
{
    object oPC = GetExitingObject();
    // nwnx_chat
    dmb_PCout(oPC);
    // Clean up crafting in case the player crashes mid-conversation.
    object oBackup = GetLocalObject(oPC, "ZEP_CR_BACKUP");
    if(oBackup != OBJECT_INVALID)
    {
        DeleteLocalObject(oPC, "ZEP_CR_BACKUP");
        RemoveEffect(oPC, EffectCutsceneParalyze());
    }
}
