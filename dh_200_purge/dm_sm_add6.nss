void main()
{
   object oPlaceable = GetLocalObject(OBJECT_SELF, "DM_SM_oPlaceable6");
   object oWidget = GetLocalObject(OBJECT_SELF, "DM_SM_oWidget");
   int iPropIndex = GetLocalInt(oWidget, "iPropIndex");
   int iCharsUsed = GetLocalInt(oWidget, "iCharsUsed");
   int iEntryLen = 35 + GetStringLength(GetResRef(oPlaceable));

   if( GetName(oPlaceable, TRUE) != GetName(oPlaceable))
   { iEntryLen += GetStringLength(GetName(oPlaceable)); }
   if( GetLocalInt(oPlaceable, "iRetagged") == TRUE)
   { iEntryLen += GetStringLength(GetTag(oPlaceable)); }

   SetLocalInt(oWidget, "iCharsUsed", (iEntryLen + iCharsUsed));

   iPropIndex++;
   SetLocalObject(oWidget, "oProp" + IntToString(iPropIndex), oPlaceable);
   SetLocalInt(oWidget, "iProp" + ObjectToString(oPlaceable), iPropIndex);
   SetLocalInt(oWidget, "iPropIndex", iPropIndex);
}
