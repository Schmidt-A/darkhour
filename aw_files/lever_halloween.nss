#include "aw_include"

void main()
{
    object oPC = GetLastUsedBy();
    ///NO Spam check!!!!/////
    if (GetLocalInt(OBJECT_SELF,"InUse") == 1)
    {
        return;
    }

    int nHalloweenIs = GetLocalInt(GetModule(), "Halloween");
    if (nHalloweenIs == TRUE) //true == 1 so it's ON
    {
        SetLocalInt(OBJECT_SELF,"InUse",1);
        SQLExecDirect("UPDATE Settings SET value='0' WHERE name='HALLOWEEN'");
        SetLocalInt(GetModule(),"Halloween",0); //set it to off
        //nHalloweenIs = FALSE;
        FloatingTextStringOnCreature("Halloween is OFF...",oPC);
        ////////////////Function: remove hallloween item /////////
        object oPC = GetFirstPC();
        while ( GetIsPC(oPC) == TRUE  )
        {
            DelayCommand(1.0 + Random(5), RestoreAppearanceFromRace(oPC, TRUE));
            object oItem = GetItemPossessedBy( oPC,"halloweenparty");
            if (oItem != OBJECT_INVALID)
            {
                SetPlotFlag(oItem, FALSE);
                DelayCommand(3.0, DestroyObject(oItem));
            }
            oPC = GetNextPC();
        }
    ///////////////////////////
        FloatingTextStringOnCreature("All halloween Items are removed from players, and appearance restored.",oPC);
        ActionPlayAnimation(ANIMATION_PLACEABLE_DEACTIVATE);
        PlaySound("as_sw_lever1");
        DelayCommand(20.0,SetLocalInt(OBJECT_SELF,"InUse",0));
        object oEvilFlagHolder = GetObjectByTag("FlagHolder_2");
        SetCreatureAppearanceType(oEvilFlagHolder, APPEARANCE_TYPE_HUMAN);
        object oGoodFlagHolder = GetObjectByTag("FlagHolder_1");
        SetCreatureAppearanceType(oGoodFlagHolder,APPEARANCE_TYPE_HUMAN);
        object oGrim = GetObjectByTag("grimreaper",0);
        SetPlotFlag(oGrim,FALSE);
        DelayCommand(2.0,DestroyObject(oGrim));
    }
    else if (nHalloweenIs == FALSE) //false == 0 so it's OFF
    {
        SetLocalInt(OBJECT_SELF,"InUse",1);
        SQLExecDirect("UPDATE Settings SET value='1' WHERE name='HALLOWEEN'");
        SetLocalInt(GetModule(),"Halloween",1);  //activate//
        //nHalloweenIs = TRUE;
        FloatingTextStringOnCreature("Halloween is ON",oPC);
        ////////////////Function: give hallloween item /////////
        object oPC = GetFirstPC();
        while ( GetIsPC(oPC) == TRUE  )
        {
            object oItem = GetItemPossessedBy( oPC,"halloweenparty");
            if (oItem == OBJECT_INVALID)
            {
                oItem = CreateItemOnObject("halloweenparty",oPC);
            }
            DelayCommand(1.0 + Random(20), SetCreatureAppearanceType(oPC, APPEARANCE_TYPE_ZOMBIE_ROTTING));
            oPC = GetNextPC();
        }

        ///////////////////////////
        FloatingTextStringOnCreature("All players has been rewarded with an halloween Item to wear costumes!",oPC);

        ActionPlayAnimation(ANIMATION_PLACEABLE_ACTIVATE);
        PlaySound("as_sw_lever1");
        DelayCommand(20.0,SetLocalInt(OBJECT_SELF,"InUse",0));
        object oEvilFlagHolder = GetObjectByTag("FlagHolder_2");
        SetCreatureAppearanceType(oEvilFlagHolder, APPEARANCE_TYPE_ZOMBIE_WARRIOR_1);
        object oGoodFlagHolder = GetObjectByTag("FlagHolder_1");
        SetCreatureAppearanceType(oGoodFlagHolder, APPEARANCE_TYPE_YUAN_TI_CHIEFTEN);


    }
    //SetLocalInt(GetModule(), "Halloween", nHalloweenIs);
}
