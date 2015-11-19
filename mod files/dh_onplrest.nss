// This script fires the rest conversation for the dark hour module.
// As soon as the PC chooses to rest, his resting is cancelled and the
// conversation pops up. This is set to NOT fire when the PC chooses to rest from
// the rest conversation.

// The script will terminate resting if the player has rested within the hour of
// his last rest session.

// Created by Zunath on August 2, 2007
// Edited by Vision on September 15, 2007 (Several times)

void main()
{
    object oPC = GetLastPCRested();
    object oRestObject = GetNearestObjectByTag("DH_RESTOBJ", oPC);
    int iRestType = GetLastRestEventType();
    int iZombieKills = 0;
    int iSurvivalTime = 0;
    int iCurrentHour = GetTimeHour();
    int iStackSize;
    string sRoleplayLevel;

//The player is not resting, and the player is trying to rest...
if (GetLocalInt(oPC, "IS_RESTING") == 0 && iRestType == REST_EVENTTYPE_REST_STARTED)
    {
        object oInventory = GetFirstItemInInventory(oPC);
        while (GetIsObjectValid(oInventory))
        {
            string sTag = GetTag(oInventory);
            iStackSize = GetItemStackSize(oInventory);
            // If the item found was a Zombie Kill, get what kind and how much
            // then store it.
            if (sTag == "ZombieKill")
            {
                iZombieKills = iZombieKills + 1 * iStackSize;
            }
            else if (sTag == "ZK10")
            {
                iZombieKills = iZombieKills + 10 * iStackSize;
            }
            else if (sTag == "ZKHUNDRED")
            {
                iZombieKills = iZombieKills + 100 * iStackSize;
            }
            else if (sTag == "ZKTHOUSAND")
            {
                iZombieKills = iZombieKills + 1000 * iStackSize;
            }
            else if (sTag == "zkxthous")
            {
                iZombieKills = iZombieKills + 10000 * iStackSize;
            }
            // If the item found was a survival time, get what kind and how
            // much then store it
            else if (sTag == "SurvivalTime")
            {
                iSurvivalTime = iSurvivalTime + 1 * iStackSize;
            }
            else if (sTag == "ST10")
            {
                iSurvivalTime = iSurvivalTime + 10 * iStackSize;
            }
            else if (sTag == "ST100")
            {
                iSurvivalTime = iSurvivalTime + 100 * iStackSize;
            }
            else if (sTag == "ST1000")
            {
                iSurvivalTime = iSurvivalTime + 1000 * iStackSize;
            }
            // If the item found was a roleplay level item, get what kind
            // and store it

            //V: I'm putting in ALT coding to color code these. Should work fine.
            //For reference, I put them in dh_onplrest, and on dh_crspeaker.
            //A master list can be found in dh_modload
            else if (sTag == "poorroleplay")
            {
                sRoleplayLevel = "<c þþ>Blue</c>";
            }
            else if (sTag == "greatroleplay")
            {
                sRoleplayLevel = "<cþ× >Gold</c>";
            }
            else if (sTag == "goodroleplay")
            {
                sRoleplayLevel = "<c þ >Green</c>";
            }
            else if (sTag == "noroleplay")
            {
                sRoleplayLevel = "<cþ  >Red</c>";
            }

            oInventory = GetNextItemInInventory(oPC);
        }
        // As far as I know, survival tokens are given once every half a day
        // So what we do here is multiply the number of tokens by 12 and that gives
        // us the number of hours the player's survived.

        //It's every 8 hours I believe, confirmed in hungerscript
        //ishungry == nEightHours-V
        string sSurvivalTime = IntToString(iSurvivalTime * 8);


        SetCustomToken(900, IntToString(iZombieKills));
        SetCustomToken(901, IntToString(iCurrentHour));
        if (iCurrentHour = 0) SetCustomToken(901, "<cþ  >DARK HOUR</c>");
        SetCustomToken(902, sSurvivalTime + " Hours");
        SetCustomToken(903, IntToString(iSurvivalTime));
        SetCustomToken(904, sRoleplayLevel);
        AssignCommand(oPC, ClearAllActions());
        AssignCommand(oPC, ActionStartConversation(oPC, "dh_rest_convo", TRUE, FALSE));
    }

//The player is beyond 5m from a bed roll but is set to rest mode...
else if (GetDistanceBetween(oRestObject, oPC) > 5.0 && GetLocalInt(oPC, "IS_RESTING") == 1)
    {
    object oInventory = GetFirstItemInInventory(oPC);
        while (GetIsObjectValid(oInventory))
        {
            string sTag = GetTag(oInventory);
            iStackSize = GetItemStackSize(oInventory);
            // If the item found was a Zombie Kill, get what kind and how much
            // then store it.
            if (sTag == "ZombieKill")
            {
                iZombieKills = iZombieKills + 1 * iStackSize;
            }
            else if (sTag == "ZK10")
            {
                iZombieKills = iZombieKills + 10 * iStackSize;
            }
            else if (sTag == "ZKHUNDRED")
            {
                iZombieKills = iZombieKills + 100 * iStackSize;
            }
            else if (sTag == "ZKTHOUSAND")
            {
                iZombieKills = iZombieKills + 1000 * iStackSize;
            }
            // If the item found was a survival time, get what kind and how
            // much then store it
            else if (sTag == "SurvivalTime")
            {
                iSurvivalTime = iSurvivalTime + 1 * iStackSize;
            }
            else if (sTag == "ST10")
            {
                iSurvivalTime = iSurvivalTime + 10 * iStackSize;
            }
            else if (sTag == "ST100")
            {
                iSurvivalTime = iSurvivalTime + 100 * iStackSize;
            }
            else if (sTag == "ST1000")
            {
                iSurvivalTime = iSurvivalTime + 1000 * iStackSize;
            }
            // If the item found was a roleplay level item, get what kind
            // and store it

            //V: I'm putting in ALT coding to color code these. Should work fine.
            //For reference, I put them in dh_onplrest, and on dh_crspeaker.
            //A master list can be found in dh_modload
            else if (sTag == "poorroleplay")
            {
                sRoleplayLevel = "<c þþ>Blue</c>";
            }
            else if (sTag == "greatroleplay")
            {
                sRoleplayLevel = "<cþ× >Gold</c>";
            }
            else if (sTag == "goodroleplay")
            {
                sRoleplayLevel = "<c þ >Green</c>";
            }
            else if (sTag == "noroleplay")
            {
                sRoleplayLevel = "<cþ  >Red</c>";
            }

            oInventory = GetNextItemInInventory(oPC);
        }
        // As far as I know, survival tokens are given once every half a day
        // So what we do here is multiply the number of tokens by 12 and that gives
        // us the number of hours the player's survived.

        //It's every 8 hours I believe, confirmed in hungerscript
        //ishungry == nEightHours-V
        string sSurvivalTime = IntToString(iSurvivalTime * 8);
        //I cannot rest because I am beyond the range of a bedroll
        SetLocalInt(oPC, "IS_RESTING", 0);
        DelayCommand(0.3, DeleteLocalInt(oPC, "IS_RESTING"));
        SetCustomToken(900, IntToString(iZombieKills));
        SetCustomToken(901, IntToString(iCurrentHour));
        if (iCurrentHour = 0) SetCustomToken(901, "<cþ  >DARK HOUR</c>");
        SetCustomToken(902, sSurvivalTime + " Hours");
        SetCustomToken(903, IntToString(iSurvivalTime));
        SetCustomToken(904, sRoleplayLevel);
        AssignCommand(oPC, ClearAllActions());
        AssignCommand(oPC, ActionStartConversation(oPC, "dh_rest_convo", TRUE, FALSE));
    }

//The player is within the range of a bedroll but has rested within the hour
else if (GetDistanceBetween(oRestObject, oPC) <= 5.0 && GetLocalInt(oPC, "REST_LIMIT") > 0)
{
object oInventory = GetFirstItemInInventory(oPC);
        while (GetIsObjectValid(oInventory))
        {
            string sTag = GetTag(oInventory);
            iStackSize = GetItemStackSize(oInventory);
            // If the item found was a Zombie Kill, get what kind and how much
            // then store it.
            if (sTag == "ZombieKill")
            {
                iZombieKills = iZombieKills + 1 * iStackSize;
            }
            else if (sTag == "ZK10")
            {
                iZombieKills = iZombieKills + 10 * iStackSize;
            }
            else if (sTag == "ZKHUNDRED")
            {
                iZombieKills = iZombieKills + 100 * iStackSize;
            }
            else if (sTag == "ZKTHOUSAND")
            {
                iZombieKills = iZombieKills + 1000 * iStackSize;
            }
            // If the item found was a survival time, get what kind and how
            // much then store it
            else if (sTag == "SurvivalTime")
            {
                iSurvivalTime = iSurvivalTime + 1 * iStackSize;
            }
            else if (sTag == "ST10")
            {
                iSurvivalTime = iSurvivalTime + 10 * iStackSize;
            }
            else if (sTag == "ST100")
            {
                iSurvivalTime = iSurvivalTime + 100 * iStackSize;
            }
            else if (sTag == "ST1000")
            {
                iSurvivalTime = iSurvivalTime + 1000 * iStackSize;
            }
            // If the item found was a roleplay level item, get what kind
            // and store it

            //V: I'm putting in ALT coding to color code these. Should work fine.
            //For reference, I put them in dh_onplrest, and on dh_crspeaker.
            //A master list can be found in dh_modload
            else if (sTag == "poorroleplay")
            {
                sRoleplayLevel = "<c þþ>Blue</c>";
            }
            else if (sTag == "greatroleplay")
            {
                sRoleplayLevel = "<cþ× >Gold</c>";
            }
            else if (sTag == "goodroleplay")
            {
                sRoleplayLevel = "<c þ >Green</c>";
            }
            else if (sTag == "noroleplay")
            {
                sRoleplayLevel = "<cþ  >Red</c>";
            }

            oInventory = GetNextItemInInventory(oPC);
        }
        // As far as I know, survival tokens are given once every half a day
        // So what we do here is multiply the number of tokens by 12 and that gives
        // us the number of hours the player's survived.

        //It's every 8 hours I believe, confirmed in hungerscript
        //ishungry == nEightHours-V
        string sSurvivalTime = IntToString(iSurvivalTime * 8);
        //I cannot rest because I have rested within the hour
        SetLocalInt(oPC, "IS_RESTING", 0);
        DelayCommand(0.3, DeleteLocalInt(oPC, "IS_RESTING"));
        SetCustomToken(900, IntToString(iZombieKills));
        SetCustomToken(901, IntToString(iCurrentHour));
        if (iCurrentHour = 0) SetCustomToken(901, "<cþ  >DARK HOUR</c>");
        SetCustomToken(902, sSurvivalTime + " Hours");
        SetCustomToken(903, IntToString(iSurvivalTime));
        SetCustomToken(904, sRoleplayLevel);
        AssignCommand(oPC, ClearAllActions());
        AssignCommand(oPC, ActionStartConversation(oPC, "dh_rest_convo", TRUE, FALSE));
}
}
