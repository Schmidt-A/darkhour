#include "nwnx_dmactions"
#include "_incl_pc_data"
#include "_incl_xp"

void main() {
    object oDM = OBJECT_SELF;
    int iAction = nGetDMActionID();

    if(iAction == DM_ACTION_GIVE_XP)
    {
        object oTarget = oGetDMAction_Target();
        int iXP = nGetDMAction_Param();

        // If they're a subrace character we have to do something special
        if(GetItemPossessedBy(oTarget, "ecl_token") != OBJECT_INVALID)
        {
            SendMessageToPC(oTarget, "XP is being removed from your character " +
                "sheet so it can be tracked on your ECL token instead.");
            SetXP(oTarget, GetXP(oTarget)-iXP);
            GiveXPToCreatureDH(oTarget, iXP);
        }

        // Format : XP_DM:[dm name] | [player account] | [character] | [xp amount] | [xp cumulative]
        // Example: XP_DM:Tweek | Aez | Meero Isesi | 100 | 3512
        string sLog = "XP_DM:" + GetName(oDM) + " | " +
                        GetPCPlayerName(oTarget) + " | " +
                        GetName(oTarget) + " | " +
                        IntToString(iXP) + " | " +
                        IntToString(GetXP(oTarget));
        WriteTimestampedLogEntry(sLog);
    }
    else if(iAction == DM_ACTION_GIVE_LEVEL)
    {
        object oTarget = oGetDMAction_Target();
        int iLevels = nGetDMAction_Param();

        // Format : LEVEL_DM:[dm name] | [player account] | [character] | [level amount]
        // Example: LEVEL_DM:Tweek | Aez | Meero Isesi | 1
        string sLog = "LEVEL_DM:" + GetName(oDM) + " | " +
                        GetPCPlayerName(oTarget) + " | " +
                        GetName(oTarget) + " | " +
                        IntToString(iLevels);
        WriteTimestampedLogEntry(sLog);
    }
    else if(iAction == DM_ACTION_GIVE_GOLD)
    {
        object oTarget = oGetDMAction_Target();
        int iGold = nGetDMAction_Param();

        // Format : GOLD_DM:[dm name] | [player account] | [character] | [gold amount]
        // Example: GOLD_DM:Tweek | Aez | Meero Isesi | 50
        string sLog = "GOLD_DM:" + GetName(oDM) + " | " +
                        GetPCPlayerName(oTarget) + " | " +
                        GetName(oTarget) + " | " +
                        IntToString(iGold);
        WriteTimestampedLogEntry(sLog);
    }
    else if(iAction == DM_ACTION_CREATE_ITEM_ON_OBJECT) {
        object oTarget = oGetDMAction_Target();
        object oItem = oGetDMAction_Target(TRUE);

        // Format : ITEM_OBJ_DM:[dm name] | [object name] | [item resref] | [item name]
        // Example: ITEM_OBJ_DM:Tweek | Community Chest | item001 | Test Item
        string sLog = "ITEM_OBJ_DM:" + GetName(oDM) + " | " +
                        GetName(oTarget) + " | " +
                        GetResRef(oItem) + " | " +
                        GetName(oItem);
        WriteTimestampedLogEntry(sLog);
    }
    else if(iAction == DM_ACTION_CREATE_ITEM_ON_AREA) {
        object oArea = oGetDMAction_Target();
        object oItem = oGetDMAction_Target(TRUE);

        // Format : ITEM_AREA_DM:[dm name] | [area resref] | [area name] | [item resref] | [item name]
        // Example: ITEM_AREA_DM:Tweek | sundes | Sundered Desolation | item001 | Test Item
        string sLog = "ITEM_AREA_DM:" + GetName(oDM) + " | " +
                        GetResRef(oArea) + " | " +
                        GetName(oArea) + " | " +
                        GetResRef(oItem) + " | " +
                        GetName(oItem);
        WriteTimestampedLogEntry(sLog);
    }
    else if(iAction == DM_ACTION_HEAL_CREATURE) {
        object oCreature = oGetDMAction_Target();

        if(GetIsPC(oCreature) && !GetIsPossessedFamiliar(oCreature))
        {
            PCDSetUnZombied(oCreature);
            PCDSetAlive(oCreature);
        }
    }
}
