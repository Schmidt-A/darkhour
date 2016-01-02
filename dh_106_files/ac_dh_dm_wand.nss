void main()
{
object oDM = GetItemActivator();
object oTarget = GetSpellTargetObject();
location lLoc = GetSpellTargetLocation();
int iType = GetLocalInt(oDM, "DHDMTOOL");
if(iType == 0)
    {
    AssignCommand(oDM, ActionStartConversation(oDM, "dh_dm_wand", TRUE, FALSE));
    return;
    }
else if(iType == 1)
    {
    if(oTarget == OBJECT_INVALID || GetIsPC(oTarget) == FALSE)
        {
        SendMessageToPC(oDM, "Target was not valid.");
        }
    else
        {
        object oCrafting = GetItemPossessedBy(oTarget, "craftingitem");
        int iSkill = GetLocalInt(oCrafting, "skill");
        int iAmount = GetLocalInt(oCrafting, "crafting");
        SendMessageToPC(oDM, GetName(oTarget) + " has a total of " + IntToString(iAmount) + " CP and a crafting skill level of " + IntToString(iSkill));
        }
    }
else if(iType == 2)
    {
    if(oTarget == OBJECT_INVALID)
        {
        SendMessageToPC(oDM, "Target was not valid.");
        }
    else
        {
        SetDescription(oTarget, GetLocalString(oDM, "DHDMDESC"), TRUE);
        DeleteLocalString(oDM, "DHDMDESC");
        SendMessageToPC(oDM, GetName(oTarget) + "'(s) description has been set.");
        }
    }
else if(iType == 3)
    {
    if(oTarget == OBJECT_INVALID || GetObjectType(oTarget) != OBJECT_TYPE_ITEM)
        {
        SendMessageToPC(oDM, "Target was not valid.");
        }
    else
        {
        CopyItem(oTarget, oDM, TRUE);
        SendMessageToPC(oDM, GetName(oTarget) + " has been copied to your inventory.");
        }
    }
else if(iType == 4)
    {
    CreateObject(OBJECT_TYPE_PLACEABLE, "dh_dm_object", lLoc, FALSE, GetLocalString(oDM, "DHDMTAG"));
    SendMessageToPC(oDM, "An invisible object has been made with the tag of " + GetLocalString(oDM, "DHDMTAG") + ".");
    DeleteLocalString(oDM, "DHDMTAG");
    }
else if(iType == 5)
    {
    int iAmount = GetLocalInt(oDM, "DHDMAMNT");
    if(iAmount < 1)
        {
        SendMessageToPC(oDM, "An invalid amount was spoken.");
        DeleteLocalInt(oDM, "DHDMAMNT");
        }
    else
        {
        object oSpawner = CreateObject(OBJECT_TYPE_WAYPOINT, "dm_spawner_easy", lLoc, FALSE);
        CreateObject(OBJECT_TYPE_WAYPOINT, "dmwp_spawner_eas", lLoc, FALSE, "dmwp_spawner_easy");
        SendMessageToPC(oDM, "The spawner has been created.");
        DelayCommand(0.5, SetLocalInt(oSpawner, "noz", iAmount + 1));
        }
    }
else if(iType == 7)
    {
    int iAmount = GetLocalInt(oDM, "DHDMAMNT");
    if(iAmount < 1)
        {
        SendMessageToPC(oDM, "An invalid amount was spoken.");
        DeleteLocalInt(oDM, "DHDMAMNT");
        }
    else
        {
        object oSpawner = CreateObject(OBJECT_TYPE_PLACEABLE, "dm_spawner_sira", lLoc, FALSE);
        CreateObject(OBJECT_TYPE_WAYPOINT, "dmwp_spawner_sir", lLoc, FALSE, "dmwp_spawner_sira");
        SendMessageToPC(oDM, "The spawner has been created.");
        DelayCommand(0.5, SetLocalInt(oSpawner, "noz", iAmount + 1));
        }
    }
else if(iType == 91)
    {
    CreateObject(OBJECT_TYPE_PLACEABLE, "DHDM_G_1", lLoc, FALSE);
    }
else if(iType == 92)
    {
    CreateObject(OBJECT_TYPE_PLACEABLE, "DHDM_G_2", lLoc, FALSE);
    }
else if(iType == 101)
    {
    CreateObject(OBJECT_TYPE_PLACEABLE, "DHDM_R_1", lLoc, FALSE);
    }
else if(iType == 102)
    {
    CreateObject(OBJECT_TYPE_PLACEABLE, "DHDM_R_2", lLoc, FALSE);
    }
else if(iType == 111)
    {
    CreateObject(OBJECT_TYPE_PLACEABLE, "DHDM_B_1", lLoc, FALSE);
    }
else if(iType == 112)
    {
    CreateObject(OBJECT_TYPE_PLACEABLE, "DHDM_B_2", lLoc, FALSE);
    }
else if(iType == 10)
    {
    string sName = GetLocalString(oTarget, "PLAYER");
    string sCDK = GetLocalString(oTarget, "CDKEY");
    if(GetIsObjectValid(oTarget) == FALSE || GetHasInventory(oTarget) == FALSE || sName == "" || sCDK == "")
        {
        SendMessageToPC(oDM, "Target was either not valid or its user was not correctly set.");
        }
    else
        {
        SendMessageToPC(oDM, "The last player to use " + GetName(oTarget) + " was named " + sName + " with a CD Key of " + sCDK + ".");
        }
    }
else if(iType == 11)
    {
    string sName = GetLocalString(oTarget, "PLAYER");
    string sCDK = GetLocalString(oTarget, "CDKEY");
    if(GetIsObjectValid(oTarget) == FALSE || GetHasInventory(oTarget) == FALSE || sName == "" || sCDK == "")
        {
        SendMessageToPC(oDM, "Target was either not valid or its user was not correctly set.");
        }
    else
        {
        SetLocalInt(oDM, "DHDMTOOL2", 1);
        SetLocalString(oDM, "DHDMCDK", sCDK);
        DelayCommand(10.0, DeleteLocalInt(oDM, "DHDMTOOL2"));
        SendMessageToPC(oDM, "The last player to use " + GetName(oTarget) + " was named " + sName + " with a CD Key of " + sCDK + ".");
        SendMessageToPC(oDM, "Speak the word 'ban' if you wish to ban this player, you have 10 seconds to speak this or not.");
        }
    }
else if(iType == 12)
    {
    if(GetLockKeyTag(oTarget) == "")
        {
        SendMessageToPC(oDM, "Target was either not valid or it did not require a valid key.");
        }
    else
        {
        CreateItemOnObject("dhdm_key", oDM, 1, GetLockKeyTag(oTarget));
        }
    }
DeleteLocalInt(oDM, "DHDMTOOL");
}
