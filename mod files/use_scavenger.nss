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
//  NOTE:  You will need to modify the section below that calls the junksearch
//  scripts to customize it for your module.
//

void FindStuff(object oUser,int nJunkType, int nDC)
{
    if (GetIsSkillSuccessful(oUser,SKILL_SEARCH,nDC))
    {
        switch (nJunkType)
        {
            // Copy this line for each junk type; change the case # and script.
            case 1:  ExecuteScript("junksearch001",oUser); break;
            case 2:  ExecuteScript("junksearch002",oUser); break;
            case 3:  ExecuteScript("junksearch003",oUser); break;
            case 4:  ExecuteScript("junksearch004",oUser); break;
            case 5:  ExecuteScript("junksearch005",oUser); break;
            case 6:  ExecuteScript("junksearch006",oUser); break;
            case 7:  ExecuteScript("junksearch007",oUser); break;
            case 8:  ExecuteScript("junksearch008",oUser); break;
            case 9:  ExecuteScript("junksearch009",oUser); break;
            case 10:  ExecuteScript("junksearch010",oUser); break;
            case 11:  ExecuteScript("junksearch011",oUser); break;
            case 12:  ExecuteScript("junksearch012",oUser); break;
            case 13:  ExecuteScript("junksearch013",oUser); break;
            case 14:  ExecuteScript("junksearch014",oUser); break;
            case 15:  ExecuteScript("junksearch015",oUser); break;
            case 16:  ExecuteScript("junksearch016",oUser); break;
            case 17:  ExecuteScript("junksearch017",oUser); break;
            case 18:  ExecuteScript("junksearch018",oUser); break;
            case 19:  ExecuteScript("junksearch019",oUser); break;
            case 20:  ExecuteScript("junksearch020",oUser); break;
            case 21:  ExecuteScript("junksearch021",oUser); break;
            case 22:  ExecuteScript("junksearch022",oUser); break;
            case 23:  ExecuteScript("junksearch023",oUser); break;
            case 24:  ExecuteScript("junksearch024",oUser); break;
            case 25:  ExecuteScript("junksearch025",oUser); break;
            case 26:  ExecuteScript("junksearch026",oUser); break;
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
    object oTemp;
    string sItem = GetTag(oItem);

    if ((sItem == "scavenger") || (sItem == "Shamrock") || (sItem == "ExtraScavenger"))
    {
        object oJunk = GetNearestObjectByTag("SJUNK",oUser);
        int nJunkType = GetLocalInt(oJunk,"junk_type");
        //Vision: Modify Search DC's globally here.
        int nDC = GetLocalInt(oJunk,"dc") - 2;
        int nModifier = GetLocalInt(oJunk,"modifier");

        nDC += (nModifier / 60);
        if (nDC < 1)
        {
            nDC = 1;
        }

        //  If the player is 10 meters or closer to an invisible junk object, check
        //  the junk object for what type it is, and execute the appropriate script.
        //  For each type of junk (i.e., what they'll find in the area), you need
        //  to add a new case statement checking the id number that you placed on the
        //  junk object itself, and you'll need to make copies of the junksearch001
        //  script for each type as well.

        if ((GetDistanceBetween(oJunk,oUser) <= 8.0) && (GetDistanceBetween(oJunk,oUser) > 0.0))
        {
            AssignCommand(oUser,ActionPlayAnimation(ANIMATION_LOOPING_GET_LOW, 1.0, 5.0));
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectCutsceneImmobilize(),oUser,5.0);
            DelayCommand(5.0,FindStuff(oUser,nJunkType,nDC));
            SetLocalInt(oJunk,"modifier",nModifier + 20);
        }
        else
        {
            //  No junk was nearby, so your search turns up nothing.
            FloatingTextStringOnCreature("There is nothing useful in the area.",oUser,FALSE);
        }
    }
}
