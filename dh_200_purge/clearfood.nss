void CleanArea() {
    object oItem = GetFirstObjectInArea();
    object oInside;
    int nDecay;
    while (oItem != OBJECT_INVALID)
    {
//      if ((GetTag(oItem) == "Food") || (GetTag(oItem) == "Spoiled"))
        if (GetObjectType(oItem) == OBJECT_TYPE_ITEM)
        {
            DestroyObject(oItem);
        }
        if ((GetObjectType(oItem) == OBJECT_TYPE_PLACEABLE) && ((GetName(oItem) == "Remains") || (GetName(oItem) == "Player Corpse") || (GetName(oItem) == "Player Gear")))
        {
            nDecay = GetLocalInt(oItem,"decay") + 1;
            if (nDecay >= 48)
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
}

void main() {
    int nTicks = GetLocalInt(OBJECT_SELF, "ticks_since_clean");
    if (nTicks > 30) {
        SetLocalInt(OBJECT_SELF, "ticks_since_clean", 0);
        CleanArea();
    } else {
        SetLocalInt(OBJECT_SELF, "ticks_since_clean", nTicks + 1);
    }
}
