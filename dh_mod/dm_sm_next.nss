void main()
{
   location lTarget = GetLocation(OBJECT_SELF);
   object oWidget = GetLocalObject(OBJECT_SELF, "DM_SM_oWidget");
   int iOffset = GetLocalInt(OBJECT_SELF, "DM_SM_iOffset");
   int iLoop = 0;
   object oTarget = OBJECT_SELF;
   int iHaveThisProp = FALSE;

   while( iLoop < 10)
   {
      DeleteLocalObject(OBJECT_SELF, "DM_SM_oPlaceable" + IntToString(iLoop));
      iLoop++;
   }

   iLoop = 0;
   while( (iLoop < 10) & (GetIsObjectValid(oTarget) ))
   {
      oTarget = GetNearestObjectToLocation(OBJECT_TYPE_PLACEABLE, lTarget, iOffset+1);

      if( GetIsObjectValid(oTarget) )
      {  iOffset++;
         iHaveThisProp = GetLocalInt(oWidget, "iProp" + ObjectToString(oTarget));
         if( !iHaveThisProp)
         {   SetLocalObject(OBJECT_SELF, "DM_SM_oPlaceable" + IntToString(iLoop), oTarget);
             SetCustomToken(11020 + iLoop, GetName(oTarget));
             iLoop++;
         }
      }
   }

   SetLocalInt(OBJECT_SELF, "DM_SM_iOffset", iOffset);
   oTarget = GetNearestObjectToLocation(OBJECT_TYPE_PLACEABLE, lTarget, iOffset+1);
   SetLocalObject(OBJECT_SELF, "DM_SM_oMore", oTarget);
}
