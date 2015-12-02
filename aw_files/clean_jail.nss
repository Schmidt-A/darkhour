//////On exit of an area ///////
// Library for walkways (need to pass it this way to get access to ClearActiosn in x0_i0_assoc
#include "x0_i0_walkway"
#include "inc_bs_module"

 // Destroys all gold on ground
 void CleanUpGoldOnGround();
 void CleanUpGoldOnGround()
{
        int nNth;
        object oGold = GetObjectByTag("NW_IT_GOLD001", nNth);
        while (GetIsObjectValid(oGold))
        {
            //PrintString("NOTICE: CleanUpGoldOnGround: " + IntToString(GetItemStackSize(oGold)) + " GP");
            SendMessageToAllDMs("NOTICE: CleanUpGoldOnGround: " + IntToString(GetItemStackSize(oGold)) + " GP");
            DestroyObject(oGold);
            nNth++;
            oGold = GetObjectByTag("NW_IT_GOLD001", nNth);
        }
 }

void main()
{

object oJailKeeper = GetObjectByTag("JailKeeper");

object oItem = GetFirstObjectInArea(OBJECT_SELF);
while(GetIsObjectValid(oItem))
   {
   if (GetObjectType(oItem) == OBJECT_TYPE_ALL)
      {
          if (GetBaseItemType(oItem) ==  BASE_ITEM_GOLD)
          {
             //DestroyObject(oItem);
             AssignCommand(oJailKeeper,ActionPickUpItem(oItem));
             AssignCommand(oJailKeeper,ActionSpeakString("Soon I'll be Rich!"));
          }
          else
          {
             AssignCommand(oJailKeeper,ActionPickUpItem(oItem));
          }

          if (GetObjectType(oItem) == OBJECT_TYPE_ITEM && !GetPlotFlag(oItem))
          {
              DestroyObject(oItem);
          }
      }
      if (GetTag(oItem) == "NW_IT_GOLD001")
      {
             AssignCommand(oJailKeeper,ActionPickUpItem(oItem));
             AssignCommand(oJailKeeper,ActionSpeakString("Soon I'll be Rich!"));
             AssignCommand(oJailKeeper,WalkWayPoints());
      }

   oItem = GetNextObjectInArea();
   }

   //if the NPC does nothing...
   DelayCommand(4.0,CleanUpGoldOnGround());

}
