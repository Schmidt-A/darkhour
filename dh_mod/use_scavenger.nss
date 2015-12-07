//
//  use_scavenger.nss -- This will allow the player to use the Scavenger object,
//  located under Items > Special > Custom 1.  To use, put this line into the
//  onActivateItem script for the module:
//
//      ExecuteScript("use_scavenger", GetItemActivator());
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

int DEBUG = GetLocalInt(GetModule(), "DEBUG_MODE");

//returns 0 if the item isn't valid so we can give them another
// takes in a user object and an item tag string 
int ScavengeUserItemByTag(object oUser, string sFound)
{
    object oFound = CreateItemOnObject(sFound, oUser);

    // if the item is invalid, take it out of the list and give them another one
    if (GetName(oFound) == "_") 
    {
        
        sFound = "";
        // how we do dis
        //      oFound = NULL


        if (DEBUG) 
        {
            FloatingTextStringOnCreature("OOPS THIS RESREF " + sFound + " doesn't exist! shiiit! (we gave u another tho) <3", oUser, FALSE);
        }

        //return false (0) so that we can give them a new item
        return FALSE;
    }
    else
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

        FloatingTextStringOnCreature("Found "+GetName(oFound)+"!", oUser, FALSE);

        // return true (1) so that we will finish the scavenging
        return TRUE;
    }
}


//Search Stuff Added by Demon X

// Aez redid it
// ieed to reorganize this into sub methods
void SearchStuff(object oUser, int iCount, int iDifficulty, int iTotalChance, object oSearch)
{
    if (GetIsSkillSuccessful(oUser, SKILL_SEARCH, iDifficulty)) 
    {
        int iRand = Random(iTotalChance);
        int iIterate = 0;
        int iFound = -1;
        int iAccumChance = 0;
        while (iIterate < iCount+1) 
        {

            // check where the random number falls in the generated int chance

            int iChance = GetLocalInt(oSearch, "RefChance"+IntToString(iIterate));
            if (iRand >= iAccumChance && iRand < iAccumChance+iChance) 
            {
                iFound = iIterate;
                string sFound = GetLocalString(oSearch, "Resref"+IntToString(iFound));
                
                if (ScavengeUserItemByTag(oUser, sFound)) 
                {
                    // end the loop, cuz they have their item
                    iIterate = iCount + 1;

                    if (DEBUG) 
                    {
                        FloatingTextStringOnCreature("RESREF:</c  "+GetLocalString(oSearch, "Resref"+IntToString(iFound)), oUser, FALSE);
                    }

                    
                    SetLocalInt(oSearch, "Found", GetLocalInt(oSearch, "Found")+1);
                    if (GetLocalInt(oSearch, "Found") >= 4) 
                    {  
                        SetLocalInt(oSearch, "DC", iDifficulty+1);
                        SetLocalInt(oSearch, "Found", 0);
                    }
                }
                else 
                {
                    //we need to give them a iew item

                    // is this line needed -Aez    
                    //      int iTotalChance = iTotalChance - iChance;

                    iFound = -1;
                    // stop that shit from showing up again ideally
                    SetLocalInt(oSearch, "RefChance"+IntToString(iCount), 0);

                    //also add oUser
                    //add time
                    PrintString("The resref " + sFound + " was scavenged by " + GetName(oSearch) + " at TIME");                    

                    iIterate++;
                }
            }
            else 
            {
                // the chance didn't match for this item
                // keep looping, add the chance values up
                iIterate++;
                iAccumChance += iChance;
            }
        }

        if (iFound == -1) 
        {
            //THey didn't find anything and I need to code that
            // ie something fucked up probably
            FloatingTextStringOnCreature("You searched long and hard, but to no avail.", oUser, FALSE);
        } 
    }
    else 
    {
        FloatingTextStringOnCreature("Your search turns up nothing.", oUser, FALSE);
    }
}

void FindStuff(object oUser, int iJunkType, int iDC) 
{
    if (GetIsSkillSuccessful(oUser, SKILL_SEARCH, iDC)) 
    {
        switch (iJunkType) 
        {
            // Copy this line for each junk type; change the case # and script.
            case 1:  ExecuteScript("junksearch001", oUser); break;
            case 2:  ExecuteScript("junksearch002", oUser); break;
            case 3:  ExecuteScript("junksearch003", oUser); break;
            case 4:  ExecuteScript("junksearch004", oUser); break;
            case 5:  ExecuteScript("junksearch005", oUser); break;
            case 6:  ExecuteScript("junksearch006", oUser); break;
            case 7:  ExecuteScript("junksearch007", oUser); break;
            case 8:  ExecuteScript("junksearch008", oUser); break;
            case 9:  ExecuteScript("junksearch009", oUser); break;
            case 10:  ExecuteScript("junksearch010", oUser); break;
            case 11:  ExecuteScript("junksearch011", oUser); break;
            case 12:  ExecuteScript("junksearch012", oUser); break;
            case 13:  ExecuteScript("junksearch013", oUser); break;
            case 14:  ExecuteScript("junksearch014", oUser); break;
            case 15:  ExecuteScript("junksearch015", oUser); break;
            case 16:  ExecuteScript("junksearch016", oUser); break;
            case 17:  ExecuteScript("junksearch017", oUser); break;
            case 18:  ExecuteScript("junksearch018", oUser); break;
            case 19:  ExecuteScript("junksearch019", oUser); break;
            case 20:  ExecuteScript("junksearch020", oUser); break;
            case 21:  ExecuteScript("junksearch021", oUser); break;
            case 22:  ExecuteScript("junksearch022", oUser); break;
            case 23:  ExecuteScript("junksearch023", oUser); break;
            case 24:  ExecuteScript("junksearch024", oUser); break;
            case 25:  ExecuteScript("junksearch025", oUser); break;
            case 26:  ExecuteScript("junksearch026", oUser); break;
            case 27:  ExecuteScript("junksearch027", oUser); break;
            case 28:  ExecuteScript("junksearch028", oUser); break;
            case 29:  ExecuteScript("junksearch029", oUser); break;
            case 30:  ExecuteScript("junksearch030", oUser); break;
        }
    } 
    else 
    {
        FloatingTextStringOnCreature("Your search turns up nothing.",oUser,FALSE);
    }
}

void main() 
{
    object oItem = GetItemActivated();
    object oUser = GetItemActivator();
    // in dh_scavonenter, the trigger object sets itself as the CanSearch key on the PC entering the area
    // oSearch is that trigger object
    object oSearch = GetLocalObject(oUser, "CanSearch");
    object oTemp;
    string sItem = GetTag(oItem);

    if ((sItem == "scavenger") || (sItem == "Shamrock") || (sItem == "ExtraScavenger")) 
    {
        object oJunk = GetNearestObjectByTag("SJUNK", oUser);
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

        if ((GetDistanceBetween(oJunk, oUser) <= 8.0) && (GetDistanceBetween(oJunk, oUser) > 0.0)) 
        {
            AssignCommand(oUser, ActionPlayAnimation(ANIMATION_LOOPING_GET_LOW, 1.0, 5.0));
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectCutsceneImmobilize(), oUser, 5.0);
            DelayCommand(5.0, FindStuff(oUser, iJunkType, iDC));
            SetLocalInt(oJunk, "modifier", iModifier + 20);

        } 
        else if (oSearch!=OBJECT_INVALID) 
        {
            // if the trigger object exists
            AssignCommand(oUser, ActionPlayAnimation(ANIMATION_LOOPING_GET_LOW, 1.0, 5.0));
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectCutsceneImmobilize(), oUser, 5.0);

            // It checks all the resrefs on the trigger object (ResRef1-??)
            // What is the max?? -Aez

            // Will iteratre over the RefChance float for each resref
            int iCount = 1;
            int iTotalChance = 0;
            string sResref = GetLocalString(oSearch, "Resref"+IntToString(iCount));
            while (sResref != "") 
            {
                iCount++;
                sResref = GetLocalString(oSearch, "Resref"+IntToString(iCount));
                int iRefChance = GetLocalInt(oSearch, "RefChance"+IntToString(iCount));
                if (iRefChance == 0) 
                {
                    //default ref chance if people forget to add one for any given item
                    iRefChance = 50;
                    SetLocalInt(oSearch, "RefChance"+IntToString(iCount), iRefChance);
                }
                else if (iRefChance == -1)
                {
                    iRefChance = 0;
                }
                iTotalChance += iRefChance;
            }
            iCount--;
            int iDifficulty = GetLocalInt(oSearch, "DC");
            DelayCommand(5.0, SearchStuff(oUser, iCount, iDifficulty, iTotalChance, oSearch));
        
        }
        else 
        {
            //  no junk was nearby, so your search turns up nothing.
            FloatingTextStringOnCreature("There is nothing useful in the area.", oUser, FALSE);
        }
    }
}
