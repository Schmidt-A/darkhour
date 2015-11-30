int StartingConditional()
{
    int iResult;

   object oWidget = GetLocalObject(OBJECT_SELF, "DM_SM_oWidget");

   int iMaxUses = GetLocalInt(oWidget, "iMaxUses");
   int iCurrentUses = GetLocalInt(oWidget, "iCurrentUses");
   int iSimUses = GetLocalInt(oWidget, "iSimUses");

   SetCustomToken(11030, IntToString(iCurrentUses));

   if(iMaxUses == -1)
   { SetCustomToken(11031, "Unlimited"); }
   else
   { SetCustomToken(11031, IntToString(iMaxUses)); }

   if(iSimUses == -1)
   { SetCustomToken(11032, "Unlimited"); }
   else
   { SetCustomToken(11032, IntToString(iSimUses)); }


   SetDroppableFlag(oWidget, FALSE);

    iResult = TRUE;
    return iResult;
}

