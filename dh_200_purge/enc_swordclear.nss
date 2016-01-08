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
    object oSword = OBJECT_SELF;
    string sCellGroup = GetStringRight(GetTag(oSword), 1);
    object oSwordWP = GetWaypointByTag("WP_ENC_SWORD_" + sCellGroup);
    string sWPTag = "";
    string sSignTag = "";
    object oWP;
    object oSign;
    location lWP;
    effect eHolyStrike = EffectVisualEffect(VFX_FNF_STRIKE_HOLY);
    effect eDisjunction = EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION);


    int iEnc = 1;

    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eDisjunction, GetLocation(oSwordWP));

    while (iEnc < 13)
    { sWPTag = "WP_ENC_" + IntToString(iEnc) + sCellGroup;
      oWP = GetWaypointByTag(sWPTag);
      sSignTag = "SIGN_ENC_" + IntToString(iEnc) + sCellGroup;
      oSign = GetObjectByTag(sSignTag);
      lWP = GetLocation(oWP);

      SetName(oSign);

      DelayCommand(1.0f, ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eHolyStrike, lWP));

      ClearCell(oWP, 1.5f);
      DelayCommand(3.0f, ClearCell(oWP, 0.0f));

      iEnc++;
    }
}

