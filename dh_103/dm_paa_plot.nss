void main()
{
   object oTarget = GetLocalObject(OBJECT_SELF, "DM_PAA_oTarget");
   SetPlotFlag(oTarget, GetPlotFlag(oTarget) ? FALSE : TRUE);
}
