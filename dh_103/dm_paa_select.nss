void main()
{
   location lTarget = GetLocalLocation(OBJECT_SELF, "DM_PAA_lTarget");
   int iOffset = GetLocalInt(OBJECT_SELF, "DM_PAA_iOffset");
   int iLoop = 0;
   object oTarget = OBJECT_SELF;

   while( (iLoop < 10) & (GetIsObjectValid(oTarget) ))
   {
      oTarget = GetNearestObjectToLocation(OBJECT_TYPE_PLACEABLE, lTarget, iLoop+iOffset+1);

      if( GetIsObjectValid(oTarget) )
      { SetLocalObject(OBJECT_SELF, "DM_PAA_oPlaceable" + IntToString(iLoop), oTarget);
        SetCustomToken(11010 + iLoop, GetName(oTarget));
      }
      iLoop++;
   }

   SetLocalInt(OBJECT_SELF, "DM_PAA_iOffset", iLoop+iOffset);
   oTarget = GetNearestObjectToLocation(OBJECT_TYPE_PLACEABLE, lTarget, iLoop+iOffset+1);
   SetLocalObject(OBJECT_SELF, "DM_PAA_oMore", oTarget);
}
