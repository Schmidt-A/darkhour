// This is to be used on the Rest Conversation designed for the Dark Hour module.
// When players select the option to rest, this script checks to see if the area
// has variable (int) "RESTABLE" if this equals 1, the player rests.

// Created by Zunath on August 1, 2007
// Edited by Vision on September 7, 2007 for rest limitation
// Aez refactored dis 2015

void main()
{
    object oPC = GetPCSpeaker();
    object oItem = GetItemInSlot(INVENTORY_SLOT_LEFTHAND,oPC);
    //object oScavenger = GetItemPossessedBy(oPC, "scavenger");
    object oArea = GetArea(oPC);
    int iRestType = GetLastRestEventType();
    int iRestMsg = GetLocalInt(oPC, "REST_LIMIT");
    object oRestObject = GetNearestObjectByTag("DH_RESTOBJ", oPC);

    // Player must be within 5 meters of a "DH_RESTOBJ" placeable to rest
    // If not, trigger the conversation
    //if (GetDistanceBetween(oRestObject, oPC) > 5.0)
    //{SetLocalInt(oPC, "IS_RESTING", 0);
    //DelayCommand(0.10, DeleteLocalInt(oPC, "IS_RESTING"));}
    //iRestMsg = GetLocalInt(oPC, "REST_LIMIT");
    if (GetDistanceBetween(oRestObject, oPC) <= 5.0 && oRestObject != OBJECT_INVALID)
    // && GetLocalInt(oPC, "REST_LIMIT") <= 0\\
    {

        SetLocalInt(oPC, "IS_RESTING", 1);
        //iRestMsg = GetLocalInt(oPC, "REST_LIMIT");

        // Force the player to rest
        AssignCommand(oPC, ActionRest(FALSE));
        DelayCommand(0.10, DeleteLocalInt(oPC, "IS_RESTING"));

        //Now, set the Rest Limit variable to >0. The player must wait 1 hour to rest again.
        //DelayCommand(0.10, SetLocalInt(oPC, "REST_LIMIT", 5));
        //DelayCommand(0.10, SetLocalInt(oPC, "Sleep_Switch", 1));
        //Check hungerscript
        // Export his character so it gets updated
        ExportSingleCharacter(oPC);

        // If he has a candle or torch equipped, destroy that now
        if ((GetTag(oItem) == "zn_torch") || (GetTag(oItem) == "Candle"))
        {
            DestroyObject(oItem);
        }

        // At the start of the resting event, destroy all of his ki shurikens
        if (GetLastRestEventType() == REST_EVENTTYPE_REST_STARTED)
        {
            oItem = GetItemInSlot(INVENTORY_SLOT_RIGHTHAND,oPC);
            if (GetTag(oItem) == "kishuriken")
            {
                DestroyObject(oItem);
            }
            oItem = GetFirstItemInInventory(oPC);
            while (oItem != OBJECT_INVALID)
            {
                if ((GetTag(oItem) == "kishuriken") || (GetTag(oItem) == "ForagedRemedy"))
                {
                    DestroyObject(oItem);
                }
                oItem = GetNextItemInInventory(oPC);
            }
        }

        // Then at the end, if he is a monk create a new set of shurikens
        else if (GetLastRestEventType() == REST_EVENTTYPE_REST_FINISHED)
        {
            if (GetLevelByClass(CLASS_TYPE_MONK,oPC) >= 1)
            {
                CreateItemOnObject("kishuriken",oPC,20);
            }
        }

        // Unsummon their familiars and animal companions
        effect eUnsummon = EffectVisualEffect(VFX_IMP_UNSUMMON);
        ExecuteScript("hugglesunsummon", oPC);
        ExecuteScript("roseunsummon", oPC);
        ExecuteScript("amenunsummon", oPC);
        object oFamiliar = GetAssociate(ASSOCIATE_TYPE_FAMILIAR,oPC);
        if (oFamiliar != OBJECT_INVALID)
        {
            ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eUnsummon, GetLocation(oFamiliar));
            DestroyObject(oFamiliar);
        }
        oFamiliar = GetAssociate(ASSOCIATE_TYPE_ANIMALCOMPANION,oPC);
        if (oFamiliar != OBJECT_INVALID)
        {
            ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eUnsummon, GetLocation(oFamiliar));
            DestroyObject(oFamiliar);
        }
    }
    else
    {
        //This was removed by Vision presumably -Aez
        //SendMessageToPC(oPC, "You are not tired and cannot rest. You must wait 30 minutes (Game Time) before you can rest again.");
        SendMessageToPC(oPC, "You must be near a restable object, such as a bedroll.");
    }
}
