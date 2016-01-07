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

void NoDrops(object oCreature)
{   object oItem = GetFirstItemInInventory(oCreature);

    while (GetIsObjectValid(oItem))
    { if (GetDroppableFlag(oItem))
      { SetDroppableFlag(oItem, FALSE); }
      oItem = GetNextItemInInventory(oCreature);
    }

    int iLoop = 0;
    while (iLoop < 18)
    { oItem = GetItemInSlot(iLoop, oCreature);
      if (GetIsObjectValid(oItem) && GetDroppableFlag(oItem))
      { SetDroppableFlag(oItem, FALSE); }
      iLoop++;
    }

    TakeGoldFromCreature(GetGold(oCreature), oCreature, TRUE);
}


void main()
{
    object oLever = OBJECT_SELF;
    object oWP = GetWaypointByTag(SearchAndReplace(GetTag(oLever), "LVRDROPS", "WP"));
    object oItem;

    AssignCommand(oLever, ActionPlayAnimation(ANIMATION_PLACEABLE_DEACTIVATE));
    DelayCommand(1.0f, AssignCommand(oLever, ActionPlayAnimation(ANIMATION_PLACEABLE_ACTIVATE)));


    int iLoop = 1;
    object oCreature = GetNearestCreature(CREATURE_TYPE_IS_ALIVE, TRUE, oWP, iLoop);


    while (GetIsObjectValid(oCreature) && (GetDistanceBetween(oWP, oCreature) < 8.0))
    { if (!(GetIsPC(oCreature)))
      { NoDrops(oCreature); }

      iLoop++;
      oCreature = GetNearestCreature(CREATURE_TYPE_IS_ALIVE, TRUE, oWP, iLoop);
    }
}

