void main()
{
   int iOffset = GetLocalInt(OBJECT_SELF, "DM_PAA_iOffset");
   int iNewOffset = 0;

   if( (iOffset % 10) == 0)
   {   iNewOffset = iOffset - 20; }
   else
   {   iNewOffset = iOffset - (iOffset % 10) - 10; }

   SetLocalInt(OBJECT_SELF, "DM_PAA_iOffset", iNewOffset);
}
