// This script will destroy all items on the ground. Additionally it automatically
// cleans up placeable remains and player corpses after 2.4 hours.

// Code commented out entirely by Zunath on July 22, 2007
// Reason: Performance hits due to code.
// coolty3001@yahoo.com if you have questions, I'm happy to help.

void main()
{
    /*
    object oItem = GetFirstObjectInArea();
    object oInside;
    int nDecay;
    while (oItem != OBJECT_INVALID)
    {
//      if ((GetTag(oItem) == "Food") || (GetTag(oItem) == "Spoiled"))

        // Section removed by Zunath on July 22, 2007
        // Reason: Contributing to lag. Script OnUnAcquire placed to do the same thing - destroy dropped
        // item.
        if (GetObjectType(oItem) == OBJECT_TYPE_ITEM)
        {
            DestroyObject(oItem);
        }


         // Section removed by Zunath on July 22, 2007
         // Reason: Code section causing performance hits over periods of time.
         // The removal of decayed placeables does not offset the amount of lag generated
         // by removing them.

        if ((GetObjectType(oItem) == OBJECT_TYPE_PLACEABLE) && ((GetName(oItem) == "Remains") || (GetName(oItem) == "Player Corpse") || (GetName(oItem) == "Player Gear")))
        {
            nDecay = GetLocalInt(oItem,"decay") + 1;
            if (nDecay >= 1440)
            {
                oInside = GetFirstItemInInventory(oItem);
                while (oInside != OBJECT_INVALID)
                {
                    DestroyObject(oInside);
                    oInside = GetNextItemInInventory(oItem);
                }
                DestroyObject(oItem);
            }
            else
            {
                SetLocalInt(oItem,"decay",nDecay);
            }
        }

        oItem = GetNextObjectInArea();
    }
    */
}
