// This script will send information to the DM that activated the item
// "pc_list". If it wasn't a DM that used it, nothing will happen.

// Created by Zunath on August 2, 2007 as requested by Vision.
// Note: I'm really bad at getting colors to work, so I left them out. Malevolent
// can take a look at them and add them as needed. Sorry!

void main()
{
    object oDM = GetItemActivator();
    // If it's not a DM using this item, quit now.
    if (!GetIsDM(oDM) || GetTag(GetItemActivated()) != "dm_pc_list") {return;}
    object oPC = GetFirstPC();
    while (GetIsObjectValid(oPC))
    {
        SendMessageToPC(oDM, GetName(oPC) + ": " + GetName(GetArea(oPC)));
        oPC = GetNextPC();
    }
}
