// This script counts the number of wood and nail items are placed
// inside of the window container.
// Gives back excess wood and nails as well as any item that isn't wood or nails.

// Created by Zunath on July 28, 2007

void main()
{
    object oPC = GetLastDisturbed();
    object oItem = GetInventoryDisturbItem();
    int iType = GetInventoryDisturbType();
    // Get wood, and set the max nails, if they aren't set already
    int iWood = GetLocalInt(OBJECT_SELF, "Wood");
    if (GetLocalInt(OBJECT_SELF, "WoodMax") == 0)
    {SetLocalInt(OBJECT_SELF, "WoodMax", iWood);}
    // Get nails, and set the max nails if they aren't set already
    int iNails = GetLocalInt(OBJECT_SELF, "Nails");
    if (GetLocalInt(OBJECT_SELF, "NailsMax") == 0)
    {SetLocalInt(OBJECT_SELF, "NailsMax", iNails);}

    int iJustRemoved = GetLocalInt(OBJECT_SELF, "JUSTREMOVED");
    string sTag = GetTag(oItem);

    // If the player added an item
    if (iType == INVENTORY_DISTURB_TYPE_ADDED && iJustRemoved == 0)
    {
        // If nails were added
        if (sTag == "rotd_nails" && iNails > 0)
        {
            iNails = iNails - 1;
            SetLocalInt(OBJECT_SELF, "Nails", iNails);
        }
        // If Wood was added
        else if (iWood > 0 && sTag == "x2_it_cmat_oakw" || iWood > 0 && sTag == "x2_it_cmat_elmw" || iWood > 0 && sTag == "rotd_wood")
        {
            iWood = iWood - 1;
            SetLocalInt(OBJECT_SELF, "Wood", iWood);
        }
        // If the window doesn't need any more wood or nails
        else if (iWood == 0 && sTag == "rotd_wood" || iWood == 0 && sTag == "x2_it_cmat_oakw" || iWood == 0 && sTag == "x2_it_cmat_elmw" || sTag == "rotd_nails" && iNails == 0)
        {
            SetLocalInt(OBJECT_SELF, "JUSTREMOVED", 1);
            AssignCommand(OBJECT_SELF, ActionGiveItem(oItem, oPC));
            DelayCommand(0.1, DeleteLocalInt(OBJECT_SELF, "JUSTREMOVED"));
            SendMessageToPC(oPC, "You don't need any more of that material to barricade this window.");
        }
        // If the PC adds anything else to the container besides nails or wood
        else if (sTag != "rotd_wood" && sTag != "rotd_nails" && sTag != "x2_it_cmat_elmw" && sTag != "x2_it_cmat_oakw")
        {
            SetLocalInt(OBJECT_SELF, "JUSTREMOVED", 1);
            AssignCommand(OBJECT_SELF, ActionGiveItem(oItem, oPC));
            DelayCommand(0.1, DeleteLocalInt(OBJECT_SELF, "JUSTREMOVED"));
            SendMessageToPC(oPC, "You don't need that item to barricade this window.");
        }

    }

    // Otherwise, if the player removed an item
    else if (iType == INVENTORY_DISTURB_TYPE_REMOVED && iJustRemoved == 0)
    {
        // If nails were removed, increase the nails required by 1
        if (sTag == "rotd_nails")
        {
            iNails = iNails + 1;
            SetLocalInt(OBJECT_SELF, "Nails", iNails);
        }
        // If Wood was removed, increase the wood required by 1
        else if (sTag == "rotd_wood" || sTag == "x2_it_cmat_oakw" || sTag == "x2_it_cmat_elmw")
        {
            iWood = iWood + 1;
            SetLocalInt(OBJECT_SELF, "Wood", iWood);
        }
    }
    //SendMessageToPC(oPC, "DEBUG: Wood needed: " + IntToString(GetLocalInt(OBJECT_SELF, "Wood")));
    //SendMessageToPC(oPC, "DEBUG: Nails needed: " + IntToString(GetLocalInt(OBJECT_SELF, "Nails")));
    //SendMessageToPC(oPC, "DEBUG: NailsMax: " + IntToString(GetLocalInt(OBJECT_SELF, "NailsMax")));
    //SendMessageToPC(oPC, "DEBUG: WoodMax: " + IntToString(GetLocalInt(OBJECT_SELF, "WoodMax")));
}
