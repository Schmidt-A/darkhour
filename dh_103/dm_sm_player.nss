int StartingConditional()
{
    int iResult;

   object oWidget = GetLocalObject(OBJECT_SELF, "DM_SM_oWidget");

   int iMaxUses = GetLocalInt(oWidget, "iMaxUses");
   int iCurrentUses = GetLocalInt(oWidget, "iCurrentUses");
   int iSimUses = GetLocalInt(oWidget, "iSimUses");
   int iCurrentSets = GetLocalInt(oWidget, "iCurrentSets");

   if(iMaxUses == -1)
   { SetCustomToken(11030, "Unlimited");
     SetCustomToken(11031, "uses"); }
   else if(iMaxUses == 1)
   { SetCustomToken(11030, IntToString(iCurrentUses) + " of " + IntToString(iMaxUses));
     SetCustomToken(11031, "use"); }
   else
   { SetCustomToken(11030, IntToString(iCurrentUses) + " of " + IntToString(iMaxUses));
     SetCustomToken(11031, "uses"); }

   if(iSimUses == -1)
   { SetCustomToken(11032, "Unlimited"); }
   else
   { SetCustomToken(11032, IntToString(iSimUses)); }

   SetCustomToken(11033, IntToString(iCurrentSets));

    iResult = iMaxUses;
    return iResult;
}
