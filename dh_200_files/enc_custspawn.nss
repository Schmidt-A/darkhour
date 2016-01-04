// Spawn custom encounter

// Retain DMFI functionality - copy effects
void SpawnCreature(object oCreature, location lEncounter, int iRandomWalk = FALSE)
{
    object oNewCreature = CopyObject(oCreature, lEncounter);
    effect eEffect = GetFirstEffect(oCreature);
    while (GetIsEffectValid(eEffect))
    {
        ApplyEffectToObject(DURATION_TYPE_PERMANENT, eEffect, oNewCreature);
        eEffect = GetNextEffect(oCreature);
    }
    if (iRandomWalk)
    { AssignCommand(oNewCreature, ActionRandomWalk()); }
}


void main()
{
    location lEncounter = GetLocalLocation(OBJECT_SELF, "lMCS_Spawn");
    DeleteLocalLocation(OBJECT_SELF, "lMCS_Spawn");

    object oWP;
    object oNewCreature;

    if (GetLocalInt(OBJECT_SELF, "iENC_ditto") == TRUE)
    { oWP = GetLocalObject(OBJECT_SELF, "oENC_LastSpawn");
      DeleteLocalInt(OBJECT_SELF, "iENC_ditto");
    }
    else
    { string sEncounterArea = GetLocalString(OBJECT_SELF, "sEncounterArea");
      int iConvChoice = GetLocalInt(OBJECT_SELF, "iConvChoice");
      string sEncounterCell = "WP_ENC_" + IntToString(iConvChoice) + sEncounterArea;
      oWP = GetObjectByTag(sEncounterCell);
      SetLocalObject(OBJECT_SELF, "oENC_LastSpawn", oWP);
      DeleteLocalString(OBJECT_SELF, "sEncounterArea");
      DeleteLocalInt(OBJECT_SELF, "iConvChoice");
    }

    int iLoop = 1;
    object oCreature = GetNearestCreature(CREATURE_TYPE_IS_ALIVE, TRUE, oWP, iLoop);

    while (GetIsObjectValid(oCreature) && (GetDistanceBetween(oWP, oCreature) < 8.0) && (iLoop < 13))
    {   if (GetTag(GetArea(OBJECT_SELF)) == "_EncounterArea")
        { DelayCommand(1.0f, SpawnCreature(oCreature, lEncounter)); }
        else
        { SpawnCreature(oCreature, lEncounter, TRUE); }
        iLoop++;
        oCreature = GetNearestCreature(CREATURE_TYPE_IS_ALIVE, TRUE, oWP, iLoop);
    }
}
