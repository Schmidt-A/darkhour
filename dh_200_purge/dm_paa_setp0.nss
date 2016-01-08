void main()
{
   object oTarget = GetLocalObject(OBJECT_SELF, "DM_PAA_oPlaceable0");
   SetLocalObject(OBJECT_SELF, "DM_PAA_oTarget", oTarget);
   SetLocalLocation(OBJECT_SELF, "DM_PAA_lOriginal", GetLocation(oTarget));
}
