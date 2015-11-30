//------------------------------------------------------------------
// dm_paa_include    include for DM Placeable Attitude Adjuster
//
// 12/02/2009        Malishara: added DestroyContents()
//                      contents of placeables are now destroyed
//                      when relocating them
//------------------------------------------------------------------

void DestroyContents(object oObject)
{  object oItem = GetFirstItemInInventory(oObject);
   while (GetIsObjectValid(oItem))
   { DestroyObject(oItem);
     oItem = GetNextItemInInventory(oObject);
   }
}

void RecreateObjectAtLocation(object oTarget, location lTargetLocation)
{
   int iPlot = GetPlotFlag(oTarget);
   int iUseable = GetUseableFlag(oTarget);
   int iRetagged = GetLocalInt(oTarget, "iRetagged");
   string sNewName = GetName(oTarget);
   string sNewTag = GetTag(oTarget);
   string sNameTag = GetLocalString(oTarget, "sNameTag");
   string sResRef = GetResRef(oTarget);
   string sDesc = GetDescription(oTarget);
   int iPlayAnimation = GetLocalInt(oTarget, "iPlayAnimation");
   int iOriginal = GetLocalInt(oTarget, "DM_PAA_iOriginal");
   location lOriginal = GetLocalLocation(oTarget, "DM_PAA_lOriginal");


   // Destroy existing placeable, create new placeable, update variables
   if (GetHasInventory(oTarget))
   { DestroyContents(oTarget); }
   DestroyObject(oTarget);

   oTarget = CreateObject(OBJECT_TYPE_PLACEABLE, sResRef, lTargetLocation, FALSE, sNewTag);
   SetPlotFlag(oTarget, iPlot);
   SetUseableFlag(oTarget, iUseable);
   SetLocalInt(oTarget, "iRetagged", iRetagged);
   SetLocalString(oTarget, "sNameTag", sNameTag);
   SetName(oTarget, sNewName);
   if (GetDescription(oTarget) != sDesc)
   { SetDescription(oTarget, sDesc); }
   SetLocalObject(OBJECT_SELF, "DM_PAA_oTarget", oTarget);
   SetLocalInt(oTarget, "DM_PAA_iOriginal", iOriginal);
   SetLocalLocation(oTarget, "DM_PAA_lOriginal", lOriginal);
   SetLocalInt(oTarget, "iPlayAnimation", iPlayAnimation);
   ExecuteScript("playanimation", oTarget);
}
