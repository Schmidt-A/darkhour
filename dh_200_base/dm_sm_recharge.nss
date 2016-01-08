void main()
{
   object oWidget = GetLocalObject(OBJECT_SELF, "DM_SM_oWidget");
   int iMaxUses = GetLocalInt(oWidget, "iMaxUses");
   int iCurrentUses = GetLocalInt(oWidget, "iCurrentUses");

   iCurrentUses = iCurrentUses + iMaxUses;
   SetLocalInt(oWidget, "iCurrentUses", iCurrentUses);
   SetCustomToken(11030, IntToString(iCurrentUses));
}
