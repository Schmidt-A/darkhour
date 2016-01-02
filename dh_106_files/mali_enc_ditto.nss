#include "x2_inc_switches"
#include "mali_string_fns"
#include "sparky_inc"


void SpawnTable(object oPC)
{   string sTableName = GetLocalString(oPC, "sENC_LastTableSpawn");
    location lSpawn = GetLocalLocation(oPC, "lMCS_Spawn");
    vector vSpawn = GetPositionFromLocation(lSpawn);
    string sSpawnPoint = "location:" + FloatToString(vSpawn.x) + "x" + FloatToString(vSpawn.y) + "y";
    sSpawnPoint = SearchAndReplace(sSpawnPoint, " ", "");
    int iDrop;
    object oArea = GetArea(oPC);

    ExecuteScript("bee_enc_tables", oArea);
    SendMessageToPC(oPC, "Spawning from table " + sTableName + "...");

    switch (GetLocalInt(oPC, "iENC_Table_SpawnPoint"))
    { case 1: iDrop = ProcessV2Entry("table," + sTableName, oArea, oArea); break;
      case 2: iDrop = ProcessV2Entry("table," + sTableName, oArea, oArea, sSpawnPoint); break;
      case 3: iDrop = ProcessV2Entry("table," + sTableName, oArea, oArea, sSpawnPoint, "5.0"); break;
      case 4: iDrop = ProcessV2Entry("table," + sTableName, oArea, oArea, sSpawnPoint, "10.0"); break;
      case 5: iDrop = ProcessV2Entry("table," + sTableName, oArea, oArea, sSpawnPoint, "15.0"); break;
      case 6: iDrop = ProcessV2Entry("table," + sTableName, oArea, oArea, sSpawnPoint, "20.0"); break;
      case 7: iDrop = ProcessV2Entry("table," + sTableName, oArea, oArea, "random"); break;
      default: iDrop = ProcessV2Entry("table," + sTableName, oArea, oArea, sSpawnPoint); break;
    }
}

void main()
{
    int nEvent = GetUserDefinedItemEventNumber();       //Which event triggered this
    object oPC;                                     //The player character using the item
    object oItem;                                   //The item being used
    object oTarget;                                 //The target of the spell
    location lTarget;
    object oLastSpawn;


    //Set the return value for the item event script
    // * X2_EXECUTE_SCRIPT_CONTINUE - continue calling script after executed script is done
    // * X2_EXECUTE_SCRIPT_END - end calling script after executed script is done
    int nResult = X2_EXECUTE_SCRIPT_END;

    if (nEvent == X2_ITEM_EVENT_ACTIVATE)
    { oPC = GetItemActivator();
      oItem = GetItemActivated();
      oTarget = GetItemActivatedTarget();
      lTarget = (GetIsObjectValid(oTarget) ? GetLocation(oTarget) : GetItemActivatedTargetLocation());

      SetLocalLocation(oPC, "lMCS_Spawn", lTarget);
      oLastSpawn = GetLocalObject(oPC, "oENC_LastSpawn");


      switch (GetObjectType(GetLocalObject(oPC, "oENC_LastSpawn")))
        {   case OBJECT_TYPE_WAYPOINT:
               SetLocalInt(oPC, "iENC_ditto", TRUE);
               ExecuteScript("enc_custspawn", oPC);
               break;
            case OBJECT_TYPE_ITEM:
               SetLocalInt(oPC, "iENC_ditto", TRUE);
               ExecuteScript("mcs_release", oPC);
               break;
            case OBJECT_TYPE_CREATURE:
               if (oLastSpawn == oPC)
               { SpawnTable(oPC); break; }
            default:
               SendMessageToPC(oPC, "ERROR: Last spawn invalid, or missing!");
               break;
        }
    }

    //Pass the return value back to the calling script
    SetExecutedScriptReturnValue(nResult);
}

