void main()
{
   // Remove variables from user
   DeleteLocalObject(OBJECT_SELF, "DM_PAA_oTarget");
   DeleteLocalString(OBJECT_SELF, "DM_PAA_sResRef");
   DeleteLocalLocation(OBJECT_SELF, "DM_PAA_lTarget");
   DeleteLocalInt(OBJECT_SELF, "DM_PAA_iOffset");
   DeleteLocalObject(OBJECT_SELF, "DM_PAA_oMore");
   DeleteLocalInt(OBJECT_SELF, "DM_PAA_iDirection");
   DeleteLocalInt(OBJECT_SELF, "DM_PAA_iConvChoice");
   DeleteLocalString(OBJECT_SELF, "DM_PAA_sConvScript");

   int iLoop = 0;
   while( iLoop < 10)
   {
      DeleteLocalObject(OBJECT_SELF, "DM_PAA_oPlaceable" + IntToString(iLoop));
      iLoop++;
   }
}
