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

    if (GetStringLength(sRecord) == 0)  { return; }

    string sFaction = FirstWord(sRecord, "|");
    sRecord = RestWords(sRecord, "|");

    if (sFaction == "")  { return; }

    object oFactionNPC = GetObjectByTag("Faction_" + sFaction);
    if (GetIsObjectValid(oFactionNPC))
    { ChangeFaction(oCreature, oFactionNPC); }

    return;
}

object FindMCSBag(string sMCS_Unit, string sName)
{   object oMCS_Unit = GetObjectByTag(sMCS_Unit);
    if (!GetIsObjectValid(oMCS_Unit)) { return OBJECT_INVALID; }

    object oMCS = GetFirstItemInInventory(oMCS_Unit);

    string sBagName;
    int iLoop = TRUE;

    while (iLoop)
    {   if (!GetIsObjectValid(oMCS))
        { iLoop = FALSE; }
        else if (GetStringLowerCase(sName) == GetStringLowerCase(SearchAndReplace(SearchAndReplace(GetName(oMCS), ",", ""), " ", "")))
        { iLoop = FALSE; }
        else
        { oMCS = GetNextItemInInventory(oMCS_Unit); }
    }

    return oMCS;
}

