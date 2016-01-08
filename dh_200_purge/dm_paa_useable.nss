void main()
{
   object oTarget = GetLocalObject(OBJECT_SELF, "DM_PAA_oTarget");
   SetUseableFlag(oTarget, GetUseableFlag(oTarget) ? FALSE : TRUE);
}
