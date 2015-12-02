#include "inc_bs_module"
//#include "inc_validate"
//#include "inc_forbidden"
/// This is a Libary for item based functions

//item funcyions
int GetHasLordlyUpgrade(object oPC);




//:://///////////////////////////////////////////////////
//:: Has Lordly Upgrade
//:://///////////////////////////////////////////////////
//::       checks if the selected char has the lordly upgrade
//:://///////////////////////////////////////////////////
//:: Created By: Nilas_87
//:: Created On: Dec/31/04
//:://///////////////////////////////////////////////////
int GetHasLordlyUpgrade(object oPC)
{
  object oItem = GetFirstItemInInventory(oPC);
  int nResult = 0;
 while(GetIsObjectValid(oItem))
 {
  if(GetTag(oItem) == "LordlyUpgrade")
    {
     nResult = nResult + 1;
    }
   oItem = GetNextItemInInventory(oPC);
 }

 return nResult;
}
