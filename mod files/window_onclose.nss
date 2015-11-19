// This script checks to see if wood and nails have been added to the window.
// If so, barricade it for 1 real life hour. Depending on your module, you may
// need to adjust this to make it longer or shorter.

// Created by Zunath on July 28, 2007

void main()
{
    object oPC = GetLastClosedBy();
    object oDatabase = GetItemPossessedBy(oPC, "database");
    object oInventory = GetFirstItemInInventory(OBJECT_SELF);
    int iNails = GetLocalInt(OBJECT_SELF, "Nails");
    int iWood = GetLocalInt(OBJECT_SELF, "Wood");
    // This line represents the amount of time before a barricade wears out.
    float fBarricadeTime = GetLocalFloat(OBJECT_SELF, "BarricadeTime");

    // No more nails and no more wood is needed, continue on with the barricade-making
    if (iNails == 0 && iWood == 0)
    {
        // Wipe the inventory of it
        while (GetIsObjectValid(oInventory))
        {
            DestroyObject(oInventory);
            oInventory = GetNextItemInInventory(OBJECT_SELF);
        }
        // Inform the player they were able to barricade the window
        SendMessageToPC(oPC, "You barricaded the window.");
        // Mark it as barricaded and don't allow it to be used.
        SetLocalInt(OBJECT_SELF, "Barricade", 1);
        SetUseableFlag(OBJECT_SELF, FALSE);
        // In one hour, make it useable again and delete the "Barricaded" status
        DelayCommand(fBarricadeTime, SetUseableFlag(OBJECT_SELF, TRUE));
        fBarricadeTime = fBarricadeTime + 0.1;
        DelayCommand(fBarricadeTime, DeleteLocalInt(OBJECT_SELF, "Barricade"));
    }
    // Window is missing some supplies, give whatever the PC dropped inside back to them
    // and let them know.
    else if (iNails != 0 || iWood != 0)
    {
        while (GetIsObjectValid(oInventory))
        {
            AssignCommand(OBJECT_SELF, ActionGiveItem(oInventory, oPC));
            oInventory = GetNextItemInInventory(OBJECT_SELF);
        }
        SendMessageToPC(oPC, "Not enough materials were placed inside of the window to barricade it.");
    }
}
