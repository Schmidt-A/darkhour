string FirstWord(string sString, string sDelimiter)
{ if (FindSubString(sString, sDelimiter) == -1)
  { return sString; }
  else
  { return GetStringLeft(sString, FindSubString(sString, sDelimiter)); }
}

string RestWords(string sString, string sDelimiter)
{ if (FindSubString(sString, sDelimiter) == -1)
  { return ""; }
  else
  { return GetStringRight(sString, GetStringLength(sString) - FindSubString(sString, sDelimiter) - GetStringLength(sDelimiter)); }
}

string SearchAndReplace(string sString, string sSearch, string sReplace)
{ string sNewString = "";
  int iOffset = FindSubString(sString, sSearch);
  while (iOffset != -1)
  {   sNewString += FirstWord(sString, sSearch) + sReplace;
      sString = RestWords(sString, sSearch);
      iOffset = FindSubString(sString, sSearch);
  }
  return sNewString + sString;
}

void ClearCell(object oWP, float fDelay)
{ int iLoop = 1;
  object oCreature = GetNearestCreature(CREATURE_TYPE_IS_ALIVE, TRUE, oWP, iLoop);

  while (GetIsObjectValid(oCreature) && (GetDistanceBetween(oWP, oCreature) < 8.0))
  {   DelayCommand(fDelay, DestroyObject(oCreature));
      iLoop++;
      oCreature = GetNearestCreature(CREATURE_TYPE_IS_ALIVE, TRUE, oWP, iLoop);
  }
}


void main()
{
    object oLever = OBJECT_SELF;
    object oWP = GetWaypointByTag(SearchAndReplace(GetTag(oLever), "LVRKILL", "WP"));
    object oSign = GetObjectByTag(SearchAndReplace(GetTag(oLever), "LVRKILL", "SIGN"));
    location lWP = GetLocation(oWP);
    effect ePWKill = EffectVisualEffect(VFX_FNF_PWKILL );

    SetName(oSign);

    AssignCommand(oLever, ActionPlayAnimation(ANIMATION_PLACEABLE_DEACTIVATE));
    DelayCommand(1.0f, ApplyEffectAtLocation(DURATION_TYPE_INSTANT, ePWKill, lWP));
    DelayCommand(3.0f, AssignCommand(oLever, ActionPlayAnimation(ANIMATION_PLACEABLE_ACTIVATE)));

    ClearCell(oWP, 1.5f);
    DelayCommand(3.0f, ClearCell(oWP, 0.0f));


}

