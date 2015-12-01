void DoRecreate(object oChest)
    {
    string sTag = GetTag(oChest);
    string sResRef = GetResRef(oChest);
    int nType = GetObjectType(oChest);
    location lLoc = GetLocation(oChest);
    DestroyObject(oChest);
    CreateObject(nType, sResRef, lLoc, FALSE, sTag);
    }
void main()
    {
    object oPC = GetItemActivator();
    object oItem = GetItemActivated();
    object oTarget = GetItemActivatedTarget();
    //if(GetIsDM(oPC) == TRUE)
        //{
        if((GetObjectType(oTarget) != OBJECT_TYPE_PLACEABLE) | (GetHasInventory(oTarget) == FALSE))
            {
            FloatingTextStringOnCreature("<c¥  >This tool will only work on placeable containers.</c>", oPC);
            return;
            }
        if(GetIsOpen(oTarget))
            {
//            if(!GetIsObjectValid(GetFirstItemInInventory(oTarget)))
//                {
//                DoRecreate(oTarget);
//                FloatingTextStringOnCreature("<c þ >The transfer chest has been fixed!</c>", oPC);
//                }else
//                    {
//                    FloatingTextStringOnCreature("<c¥  >You must empty a chest before unsticking it!</c>", oPC);
//                    return;
//                    }
            object oInv = GetFirstItemInInventory(oTarget);
            object oTemp = CreateObject(OBJECT_TYPE_PLACEABLE, "tempchest", GetLocation(oPC));
            while(GetIsObjectValid(oInv) == TRUE)
                {
                CopyItem(oInv, oTemp, TRUE);
                DestroyObject(oInv);
                oInv = GetNextItemInInventory(oTarget);
                }
                string sTag = GetTag(oTarget);
                string sResRef = GetResRef(oTarget);
                int nType = GetObjectType(oTarget);
                location lLoc = GetLocation(oTarget);
                DestroyObject(oTarget);
                object oNew = CreateObject(nType, sResRef, lLoc, FALSE, sTag);
                oInv = GetFirstItemInInventory(oTemp);
                while(GetIsObjectValid(oInv) == TRUE)
                    {
                    CopyItem(oInv, oNew, TRUE);
                    DestroyObject(oInv);
                    oInv = GetNextItemInInventory(oTemp);
                    }
                DestroyObject(oTemp);
            }else
                {
                FloatingTextStringOnCreature("<c¥  >The transfer chest was not stuck.</c>", oPC);
                return;
                }
        //}else
            //{
            //DestroyObject(oItem);
            //SendMessageToPC(oPC, "<c¥  >This wand is for DM use only and has been removed.</c>");
            //}
    }
