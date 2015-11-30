#include "mali_string_fns"

void RestoreCreature(object oCreature, string sRecord)
{   string sField = FirstWord(sRecord, "|");
    sRecord = RestWords(sRecord, "|");
    if (GetName(oCreature) != sField)
    { SetName(oCreature, sField); }

    sField = FirstWord(sRecord, "|");
    sRecord = RestWords(sRecord, "|");
    if (GetDescription(oCreature) != sField)
    { SetDescription(oCreature, sField); }

    int iField = StringToInt(FirstWord(sRecord, "|"));
    sRecord = RestWords(sRecord, "|");
    if (iField != PORTRAIT_INVALID)
    { SetPortraitId(oCreature, iField);
      sRecord = RestWords(sRecord, "|");
    }
    else
    { sField = FirstWord(sRecord, "|");
      SetPortraitResRef(oCreature, sField);
    }

    iField = StringToInt(FirstWord(sRecord, "|"));
    sRecord = RestWords(sRecord, "|");
    if (GetAppearanceType(oCreature) != iField)
    { SetCreatureAppearanceType(oCreature, iField); }

    iField = StringToInt(FirstWord(sRecord, "|"));
    sRecord = RestWords(sRecord, "|");
    if (GetPhenoType(oCreature) != iField)
    { SetPhenoType(iField, oCreature); }

    iField = StringToInt(FirstWord(sRecord, "|"));
    sRecord = RestWords(sRecord, "|");
    if (GetCreatureTailType(oCreature) != iField)
    { SetCreatureTailType(iField, oCreature); }

    iField = StringToInt(FirstWord(sRecord, "|"));
    sRecord = RestWords(sRecord, "|");
    if (GetCreatureWingType(oCreature) != iField)
    { SetCreatureWingType(iField, oCreature); }

    iField = StringToInt(FirstWord(sRecord, "|"));
    sRecord = RestWords(sRecord, "|");
    if (GetCreatureBodyPart(CREATURE_PART_HEAD, oCreature) != iField)
    { SetCreatureBodyPart(CREATURE_PART_HEAD, iField, oCreature); }

    int iLoop = 0;
    while (iLoop < 18)
    {  iField = StringToInt(FirstWord(sRecord, "|"));
       sRecord = RestWords(sRecord, "|");
       if (GetCreatureBodyPart(iLoop, oCreature) != iField)
       { SetCreatureBodyPart(iLoop, iField, oCreature); }
       iLoop++;
    }

    iLoop = 0;
    while (iLoop < 4)
    {  iField = StringToInt(FirstWord(sRecord, "|"));
       sRecord = RestWords(sRecord, "|");
       if (GetColor(oCreature, iLoop) != iField)
       { SetColor(oCreature, iLoop, iField); }
       iLoop++;
    }

    return;
}


void main()
{
    object oMCS;
    if (GetLocalInt(OBJECT_SELF, "iENC_ditto") == TRUE)
    { oMCS = GetLocalObject(OBJECT_SELF, "oENC_LastSpawn");
      DeleteLocalInt(OBJECT_SELF, "iENC_ditto");
    }
    else
    { oMCS = GetLocalObject(OBJECT_SELF, "oMCS_Device");
      SetLocalObject(OBJECT_SELF, "oENC_LastSpawn", oMCS);
    }

    string sDesc = GetDescription(oMCS, FALSE, FALSE);
    string sRecord;
    object oCreature;
    object oNewCreature;
    location lSpawn = GetLocalLocation(OBJECT_SELF, "lMCS_Spawn");
    DeleteLocalLocation(OBJECT_SELF, "lMCS_Spawn");
    location lHoldingCell = GetLocation(GetWaypointByTag("MCS_CELL"));

    int iCreatures = StringToInt(FirstWord(sDesc, "|"));
    sDesc = RestWords(sDesc, "|");

    int iLoop = 0;
    while (iLoop < iCreatures)
    { oCreature = CreateObject(OBJECT_TYPE_CREATURE, FirstWord(sDesc, "|"), lHoldingCell);
      sDesc = RestWords(sDesc, "|");
      sRecord = FirstWord(sDesc, "<<<EOR>>>|");
      sDesc = RestWords(sDesc, "<<<EOR>>>|");

      RestoreCreature(oCreature, sRecord);

      oNewCreature = CopyObject(oCreature, lSpawn);
      AssignCommand(oNewCreature, ActionRandomWalk());
      DestroyObject(oCreature);
      iLoop++;
    }

}
