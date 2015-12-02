//////On exit of an area ///////
void main()
{
object oItem = GetFirstObjectInArea(OBJECT_SELF);
   while(GetIsObjectValid(oItem))
   {
       if (GetObjectType(oItem) == OBJECT_TYPE_ITEM && !GetPlotFlag(oItem))
       {
          DestroyObject(oItem);
       }
       oItem = GetNextObjectInArea();
   }

    int nNth;
    object oGold = GetObjectByTag("NW_IT_GOLD001", nNth);
    while (GetIsObjectValid(oGold))
    {
        //PrintString("NOTICE: CleanUpGoldOnGround: " + IntToString(GetItemStackSize(oGold)) + " GP");
        DestroyObject(oGold);
        nNth++;
        oGold = GetObjectByTag("NW_IT_GOLD001", nNth);
    }

}
