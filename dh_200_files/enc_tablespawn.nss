#include "mali_string_fns"
#include "sparky_inc"


void main()
{
    object oPC = OBJECT_SELF;
    object oArea = GetArea(oPC);

    int iChoice = GetLocalInt(OBJECT_SELF, "iConvChoice");
    int iPage = GetLocalInt(OBJECT_SELF, "iConvPage");
    int iPageLen = 10;
    int iOffset = iPage * iPageLen;

    int iTable = iChoice + iOffset;
    string sTableNames = GetLocalString(oArea, "sList_TableNames");

    string sTableName = FetchWord(sTableNames, "|", iTable);
    location lSpawn = GetLocalLocation(oPC, "lMCS_Spawn");
    vector vSpawn = GetPositionFromLocation(lSpawn);
    string sSpawnPoint = "location:" + FloatToString(vSpawn.x) + "x" + FloatToString(vSpawn.y) + "y";
    sSpawnPoint = SearchAndReplace(sSpawnPoint, " ", "");
    int iDrop;

    SendMessageToPC(oPC, "Spawning from table " + sTableName + "...");

    switch (GetLocalInt(oPC, "iENC_Table_SpawnPoint"))
    { case 1: iDrop = ProcessV2Entry("table," + sTableName, oArea, oArea); break;
      case 2: iDrop = ProcessV2Entry("table," + sTableName, oArea, oArea, sSpawnPoint); break;
      case 3: iDrop = ProcessV2Entry("table," + sTableName, oArea, oArea, sSpawnPoint, "5.0"); break;
      case 4: iDrop = ProcessV2Entry("table," + sTableName, oArea, oArea, sSpawnPoint, "10.0"); break;
      case 5: iDrop = ProcessV2Entry("table," + sTableName, oArea, oArea, sSpawnPoint, "15.0"); break;
      case 6: iDrop = ProcessV2Entry("table," + sTableName, oArea, oArea, sSpawnPoint, "20.0"); break;
      case 7: iDrop = ProcessV2Entry("table," + sTableName, oArea, oArea, "random"); break;
      default: iDrop = ProcessV2Entry("table," + sTableName, oArea, oArea); break;
    }

    SetLocalString(oPC, "sENC_LastTableSpawn", sTableName);
    SetLocalObject(oPC, "oENC_LastSpawn", oPC);
}
