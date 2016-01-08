void main()
{
   int iLoop = 0;

   while( iLoop < 10 )
   {
      DeleteLocalObject(OBJECT_SELF, "DM_PAA_oPlaceable" + IntToString(iLoop));
      iLoop++;
   }

}
