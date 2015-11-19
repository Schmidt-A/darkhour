#include "mali_string_fns"


string RecordCreature(object oCreature)
{   string sRecord = GetResRef(oCreature) + "|";
    sRecord += SearchAndReplace(GetName(oCreature), "|", ":") + "|";
    sRecord += SearchAndReplace(GetDescription(oCreature), "|", ":") + "|";
    sRecord += IntToString(GetPortraitId(oCreature)) + "|";
    sRecord += GetPortraitResRef(oCreature) + "|";
    sRecord += IntToString(GetAppearanceType(oCreature)) + "|";
    sRecord += IntToString(GetPhenoType(oCreature)) + "|";
    sRecord += IntToString(GetCreatureTailType(oCreature)) + "|";
    sRecord += IntToString(GetCreatureWingType(oCreature)) + "|";
    sRecord += IntToString(GetCreatureBodyPart(CREATURE_PART_HEAD, oCreature)) + "|";

    int iLoop = 0;
    while (iLoop < 18)
    {  sRecord += IntToString(GetCreatureBodyPart(iLoop, oCreature)) + "|";
       iLoop++;
    }

    iLoop = 0;
    while (iLoop < 4)
    {  sRecord += IntToString(GetColor(oCreature, iLoop)) + "|";
       iLoop++;
    }

    sRecord += "<<<EOR>>>" + "|";

    return sRecord;
}


void main()
{
    string sEncounterArea = GetLocalString(OBJECT_SELF, "sEncounterArea");
    int iConvChoice = GetLocalInt(OBJECT_SELF, "iConvChoice");
    DeleteLocalInt(OBJECT_SELF, "iConvChoice");

    string sCell = IntToString(iConvChoice) + sEncounterArea;
    object oWP = GetObjectByTag("WP_ENC_" + sCell);
    object oSign = GetObjectByTag("SIGN_ENC_" + sCell);
    string sDesc = "";
    object oOrb = GetNearestObjectByTag("MCS_ORB");

    int iLoop = 1;
    object oCreature = GetNearestCreature(CREATURE_TYPE_IS_ALIVE, TRUE, oWP, iLoop);

    while (GetIsObjectValid(oCreature) && (GetDistanceBetween(oWP, oCreature) < 8.0) && (iLoop < 10))
    {   sDesc += RecordCreature(oCreature);
        iLoop++;
        oCreature = GetNearestCreature(CREATURE_TYPE_IS_ALIVE, TRUE, oWP, iLoop);
    }

    if ((iLoop - 1 ) < 1)
    { SendMessageToPC(OBJECT_SELF, "ERROR: Containment cell " + sCell + " is empty!"); }
    else
    { object oMCS = CreateItemOnObject("mali_mcs");
      SetName(oMCS, GetName(oSign));
      SetDescription(oMCS, IntToString(iLoop - 1) + "|" + sDesc, FALSE);
      effect eWrite = EffectBeam(VFX_BEAM_SILENT_EVIL, oOrb, BODY_NODE_CHEST);
      ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eWrite, OBJECT_SELF, 0.5f);
    }
}
