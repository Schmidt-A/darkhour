//------------------------------------------------------------------
// dm_paa_destroy    destroy selected placeable (and contents)
//
// 12/02/2009        Malishara: added
//------------------------------------------------------------------


void DestroyContents(object oObject)
{  object oItem = GetFirstItemInInventory(oObject);
   while (GetIsObjectValid(oItem))
   { DestroyObject(oItem);
     oItem = GetNextItemInInventory(oObject);
   }
}

void main()
{
   object oTarget = GetLocalObject(OBJECT_SELF, "DM_PAA_oTarget");

   if (GetHasInventory(oTarget))
   { DestroyContents(oTarget); }

   DestroyObject(oTarget);

}
