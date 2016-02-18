//
//  dh_scavenge.nss -- This will allow the player to use the Scavenger object,
//  located under Items > Special > Custom 1.  To use, put this line into the
//  onActivateItem script for the module:
//
//      ExecuteScript("dh_scavenge", GetItemActivator());
//
//  Alternatively, you can just put it directly as the onActivateItem script.
//  To place searchable areas around, place the invisible junk object ('SJUNK',
//  under Placeable Objects > Special > Custom 1) in each area that you want to
//  be searchable (it will cover a 10-meter radius from the object), and set a
//  variable on that object (right-click in the toolset and select 'Variables')
//  called 'junk_type', with the value being the index of the junk being found.
//
//  iOTE:  You will ieed to modify the section below that calls the junksearch
//  scripts to customize it for your module.

#include "_incl_probability"

//Search Stuff Added by Demon X

// Aez redid it
// ieed to reorganize this into sub methods
void SearchStuff(object oPC, object oSearch)
{
    int iDifficulty = GetLocalInt(oSearch, "DC");
    if (GetIsSkillSuccessful(oPC, SKILL_SEARCH, iDifficulty)) 
    {
        object oFound = CreateRandomLocalRef(oSearch, OBJECT_TYPE_ITEM, oPC, GetLocation(oPC));
        if (GetIsObjectValid(oFound))
        {
            // the item is valid, so let's give the right stuff to them
            if (GetBaseItemType(oFound) == BASE_ITEM_ARROW ||
                    GetBaseItemType(oFound) == BASE_ITEM_BOLT ||
                    GetBaseItemType(oFound) == BASE_ITEM_BULLET ||
                    GetBaseItemType(oFound) == BASE_ITEM_DART ||
                    GetBaseItemType(oFound) == BASE_ITEM_THROWINGAXE) 
            {
                SetItemStackSize(oFound, 10+d6(1));
            }
            FloatingTextStringOnCreature("Found "+GetName(oFound)+"!", oPC, FALSE);

            //Increasing the DC for next time
            SetLocalInt(oSearch, "Found", GetLocalInt(oSearch, "Found")+1);
            if (GetLocalInt(oSearch, "Found") >= 4) 
            {  
                SetLocalInt(oSearch, "DC", iDifficulty+1);
                SetLocalInt(oSearch, "Found", 0);
            }
        }
        else
        {
            //THey didn't find anything and I need to code that
            // ie something fucked up probably
            FloatingTextStringOnCreature("You searched long and hard, but to no avail.", oPC, FALSE);
        }    
    }
    else 
    {
        FloatingTextStringOnCreature("Your search turns up nothing.", oPC, FALSE);
    }
}

void FindStuff(object oPC, int iJunkType, int iDC) 
{
    if (GetIsSkillSuccessful(oPC, SKILL_SEARCH, iDC)) 
    {
        switch (iJunkType) 
        {
            // Copy this line for each junk type; change the case # and script.
            case 1:  ExecuteScript("junksearch001", oPC); break;
            case 2:  ExecuteScript("junksearch002", oPC); break;
            case 3:  ExecuteScript("junksearch003", oPC); break;
            case 4:  ExecuteScript("junksearch004", oPC); break;
            case 5:  ExecuteScript("junksearch005", oPC); break;
            case 6:  ExecuteScript("junksearch006", oPC); break;
            case 7:  ExecuteScript("junksearch007", oPC); break;
            case 8:  ExecuteScript("junksearch008", oPC); break;
            case 9:  ExecuteScript("junksearch009", oPC); break;
            case 10:  ExecuteScript("junksearch010", oPC); break;
            case 11:  ExecuteScript("junksearch011", oPC); break;
            case 12:  ExecuteScript("junksearch012", oPC); break;
            case 13:  ExecuteScript("junksearch013", oPC); break;
            case 14:  ExecuteScript("junksearch014", oPC); break;
            case 15:  ExecuteScript("junksearch015", oPC); break;
            case 16:  ExecuteScript("junksearch016", oPC); break;
            case 17:  ExecuteScript("junksearch017", oPC); break;
            case 18:  ExecuteScript("junksearch018", oPC); break;
            case 19:  ExecuteScript("junksearch019", oPC); break;
            case 20:  ExecuteScript("junksearch020", oPC); break;
            case 21:  ExecuteScript("junksearch021", oPC); break;
            case 22:  ExecuteScript("junksearch022", oPC); break;
            case 23:  ExecuteScript("junksearch023", oPC); break;
            case 24:  ExecuteScript("junksearch024", oPC); break;
            case 25:  ExecuteScript("junksearch025", oPC); break;
            case 26:  ExecuteScript("junksearch026", oPC); break;
            case 27:  ExecuteScript("junksearch027", oPC); break;
            case 28:  ExecuteScript("junksearch028", oPC); break;
            case 29:  ExecuteScript("junksearch029", oPC); break;
            case 30:  ExecuteScript("junksearch030", oPC); break;
        }
    } 
    else 
    {
        FloatingTextStringOnCreature("Your search turns up nothing.",oPC,FALSE);
    }
}

void main() 
{
    object oItem = GetItemActivated();
    object oPC = GetItemActivator();
    // in dh_scavonenter, the trigger object sets itself as the CanSearch key on the PC entering the area
    // oSearch is that trigger object
    object oSearch = GetLocalObject(oPC, "CanSearch");
    object oTemp;
    string sItem = GetTag(oItem);

    if ((sItem == "scavenger") || (sItem == "Shamrock") || (sItem == "ExtraScavenger")) 
    {
        object oJunk = GetNearestObjectByTag("SJUNK", oPC);
        int iJunkType = GetLocalInt(oJunk, "junk_type");
        int iDC = GetLocalInt(oJunk, "dc") - 2;
        int iModifier = GetLocalInt(oJunk, "modifier");

        iDC += (iModifier / 60);
        if (iDC < 1) 
        {
          iDC = 1;
        }

        //  If the player is 10 meters or closer to an invisible junk object, check
        //  the junk object for what type it is, and execute the appropriate script.
        //  For each type of junk (i.e., what they'll find in the area), you need
        //  to add a new case statement checking the id number that you placed on the
        //  junk object itself, and you'll need to make copies of the junksearch001
        //  script for each type as well.

        if ((GetDistanceBetween(oJunk, oPC) <= 8.0) && (GetDistanceBetween(oJunk, oPC) > 0.0)) 
        {
            AssignCommand(oPC, ActionPlayAnimation(ANIMATION_LOOPING_GET_LOW, 1.0, 5.0));
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectCutsceneImmobilize(), oPC, 5.0);
            DelayCommand(5.0, FindStuff(oPC, iJunkType, iDC));
            SetLocalInt(oJunk, "modifier", iModifier + 20);

        } 
        else if (oSearch!=OBJECT_INVALID) 
        {
            // if the trigger object exists
            AssignCommand(oPC, ActionPlayAnimation(ANIMATION_LOOPING_GET_LOW, 1.0, 5.0));
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectCutsceneImmobilize(), oPC, 5.0);
            DelayCommand(5.0, SearchStuff(oPC, oSearch));
        }
        else 
        {
            //  no junk was nearby, so your search turns up nothing.
            FloatingTextStringOnCreature("There is nothing useful in the area.", oPC, FALSE);
        }
    }
}