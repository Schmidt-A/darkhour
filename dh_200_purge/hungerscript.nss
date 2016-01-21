#include "_incl_xp"
/* MODIFIED TO INCLUDE SCAVENGER CODE, AND A BUNCH OF OTHER STUFF */

/*********************************************************************
 *
 *  Hunger Script
 *
 *  Original Concept: Amoras Sparkle
 *
 *  Modified by: Chris McConnell
 *
 *  Cause PCs to carry and eat food or lose constitution until death.
 *  The script will force the player to eat at particular intervals
 *  if they have food.  Heal characters that eat food.
 *
 *  Now with scaling available.
 *  fScale = 1.0 assumes NWN default of 2 min real time = 1 hour game time
 *           2.0 assumes 4 min real time = 1 hour game time.
 *           0.01 is good for quick testing.

**********************************************************************/
//#include "nw_i0_tool"
#include "disease_inc"
int nIsHungry;
//int nRestTimer = 0;
int nLostCon;
float fScale = 2.0;  // Default scale is 1.

void AgeFood(object oPC)
{
    int nCharges;
    int nNumberSpoiled = 0;
    object oFood = GetFirstItemInInventory(oPC);
    while (GetIsObjectValid(oFood))
    {
        if (GetTag(oFood) == "Food")
        {
            nCharges = GetItemCharges(oFood);
            if (nCharges <= 1)
            {
                if (GetName(oFood) != "Purified Food")
                {
                    nNumberSpoiled += 1;
                }
                DestroyObject(oFood);
                SendMessageToPC(oPC,"Some food has spoiled.");
            }
            else
            {
                SetItemCharges(oFood,(nCharges - 1));
            }
        }
        else if (GetTag(oFood) == "SpoiledFood")
        {
            nCharges = GetItemCharges(oFood);
            if (nCharges <= 1)
            {
                DestroyObject(oFood);
            }
            else
            {
                SetItemCharges(oFood,(nCharges - 1));
            }
        }
        oFood = GetNextItemInInventory(oPC);
    }
    while (nNumberSpoiled > 0)
    {
        CreateItemOnObject("spoiledfood",oPC);
        nNumberSpoiled -= 1;
    }
}

void EatFood(object oPC)
{
   object oFood;
   object oChoice;
   int nCharges;
   int nBest = 99;
   int nNoMore = FALSE;
   effect eBad;
   effect eHeal;
    //  If food is found consume it, and increase CON by 1 point.  The nIsHungry check is to exit the loop quicker
    oFood = GetFirstItemInInventory(oPC);
    while ((nIsHungry > 0) && (nNoMore == FALSE))
    {
        while (GetIsObjectValid(oFood))
        {
            if (GetTag(oFood) == "Food")
            {
                nCharges = GetItemCharges(oFood);
                if (nCharges <= nBest)
                {
                    nBest = nCharges;
                    oChoice = oFood;
                }
            }
            oFood = GetNextItemInInventory(oPC);
        }
        if (nBest < 99)
        {
            if(GetResRef(oChoice) == "exquisitefood")
                {
                ExecuteScript("cookeffect", oPC);
                }
            DestroyObject(oChoice);
            SendMessageToPC(oPC,"You have eaten a meal.");
            //  Heal the PC if they need it
            if(nLostCon > 0)
                {
                RemoveDiseasedEffects(oPC);
                }
            //  Otherwise turn off hunger flag
            else
                nIsHungry = 0;
        }  //  End found food
        else
        {
            nNoMore = TRUE;
        }
        nBest = 99;
        oFood = GetFirstItemInInventory(oPC);
    } // End food loop
}
void main()
{
    object oApplier = GetObjectByTag("Disease_Applier");
    object oPC = GetFirstPC();
    object oLeftRing;
    object oRightRing;
    string sLeftRing;
    string sRightRing;
    effect eDamage = EffectAbilityDecrease(ABILITY_CONSTITUTION, 1);  //  Intended to apply damage
    effect eKill = EffectDeath();  //  Intended to Kill PC if needed.

    int nHalfHour = FloatToInt(10 * fScale);
//    int nOneHour = FloatToInt(20 * fScale);
    int nEightHours = FloatToInt(160 * fScale);
    int nTwelveHours = FloatToInt(240 * fScale);
    int nTwentyHours = FloatToInt(400 * fScale);
    int nTwentyFourHours = FloatToInt(480 * fScale);
    int nSpeedUpHunger = FloatToInt(120 * fScale);

    // ADDED FOR SCAVENGER SCRIPT AND OTHER STUFF
    object oJunk;
    object oCounter;
    int nTotalKills;
    int nTotalFrenzy;
    int nTotalTime;
    int nTotalDisease;

    object oCandle;
    int nBurn;

//~~V: This is an attempt at forcing the time to advance using get and set functions
//...It's very simple: Get the time, set the time to what time was retrieved
//int nModuleTimer = 0;
//int nCurrentTimer;
//int nCurrentTimer2;
//int nCurrentTimer3;
//int nCurrentTimer4;
//nModuleTimer += 1;
//if (nModuleTimer>= 40)
  // {
//nCurrentTimer = GetTimeHour();
//nCurrentTimer2 = GetTimeMinute();
//nCurrentTimer3 = GetTimeSecond();
//nCurrentTimer4 = GetTimeMillisecond();
//nCurrentTimer = nCurrentTimer+1;
//SetTime(nCurrentTimer2, nCurrentTimer, nCurrentTimer3, nCurrentTimer4);
//nModuleTimer = 0;
//}
//~~
    //  Loop through all PCs
    while(GetIsObjectValid(oPC))
    {
      sLeftRing = "";
      sRightRing = "";
      oLeftRing = GetItemInSlot(INVENTORY_SLOT_LEFTRING,oPC);
      oRightRing = GetItemInSlot(INVENTORY_SLOT_RIGHTRING,oPC);
      if (oLeftRing != OBJECT_INVALID)
      {
          sLeftRing = GetTag(oLeftRing);
      }
      if (oRightRing != OBJECT_INVALID)
      {
          sRightRing = GetTag(oRightRing);
      }
      if ((sLeftRing != "ROTL") && (sRightRing != "ROTL") && ((sLeftRing != "w_telepring") && (sRightRing != "w_telepring")))
      {
          RemoveFromParty(oPC);
      }

      if ((GetTimeHour() == 0) && (GetLocalInt(oPC,"midnightbell") == 0))
      {
        AssignCommand(oPC,PlaySound("as_cv_belltower1"));
        SetLocalInt(oPC,"midnightbell",1);
      }
      if ((GetTimeHour() != 0) && (GetLocalInt(oPC,"midnightbell") == 1))
      {
        AssignCommand(oPC,PlaySound("as_cv_belltower1"));
        SetLocalInt(oPC,"midnightbell",0);

      }

      if ((GetIsDM(oPC) == FALSE) && (GetCurrentHitPoints(oPC) > -11) && (GetTag(GetArea(oPC)) != "OOCStartingArea") && (GetTag(GetArea(oPC)) != "DMLounge")
           && (GetTag(GetArea(oPC)) != "GoToFugue") && (GetTag(GetArea(oPC)) != "GoToFugue") && (GetTag(GetArea(oPC)) != "GoToFugue") && (GetTag(GetArea(oPC)) != "LostSoulsRoom"))
      {
        nTotalKills = 0;
        nTotalFrenzy = 0;
        nTotalTime = 0;
        nTotalDisease = 0;

        nIsHungry = GetLocalInt(oPC, "IsHungry") + 1;  // Increment hunger each pass
        //Sleep Switch Block
        //Cut this if out to reduce lag
        //if (GetLocalInt(oPC, "Sleep_Switch") == 0)
        //{
        //Do nothing, because we are ready to rest
        //}
//        if (GetLocalInt(oPC, "Sleep_Switch") == 1)
//        {
//        nRestTimer = 0;
//        SetLocalInt(oPC, "Sleep_Switch", 2);
//        SetLocalInt(oPC, "IS_RESTING", 0);
//        }
//        else if (nRestTimer >= nHalfHour)
//        {
//        SetLocalInt(oPC, "REST_LIMIT", 0);
//        DelayCommand(0.3, DeleteLocalInt(oPC, "REST_LIMIT"));
//        SetLocalInt(oPC, "Sleep_Switch", 0);
//        DelayCommand(0.3, DeleteLocalInt(oPC, "Sleep_Switch"));
//        DelayCommand(0.3, DeleteLocalInt(oPC, "IS_RESTING"));
//        SetPanelButtonFlash(oPC, PANEL_BUTTON_REST, TRUE);
//        nRestTimer = 0;
//        }
//        else if (GetLocalInt(oPC, "Sleep_Switch") == 2 && nRestTimer < nOneHour)
//        {
//        nRestTimer += 1;
//        }
//        //End Sleep Switch Block
//        nLostCon = GetLocalInt(oPC, "LostCon");

        oCandle = GetItemInSlot(INVENTORY_SLOT_LEFTHAND,oPC);
        if ((GetTag(oCandle) == "Candle") && (GetTag(oCandle) == "zn_torch"))
        {
            nBurn = GetLocalInt(oCandle,"burn");
            if (nBurn >= 120)
            {
                DestroyObject(oCandle);
            }
            else
            {
                SetLocalInt(oCandle,"burn",nBurn + 1);
            }
        }

        oCounter = GetFirstItemInInventory(oPC);
        while (oCounter != OBJECT_INVALID)
        {
          if (GetTag(oCounter) == "ZombieDisease")
          {
              nTotalDisease += 1;
          }
          oCounter = GetNextItemInInventory(oPC);
        }

        if ((nTotalDisease > 0) && (GetCurrentHitPoints(oPC) < GetMaxHitPoints(oPC)) && (GetCurrentHitPoints(oPC) > -11))
        {
            SetLocalInt(oPC,"heltimer",0);
            int nDisTimer = GetLocalInt(oPC,"distimer") + 1;
            if (nDisTimer >= 5)
            {
                SetLocalInt(oPC,"distimer",0);
                if (FortitudeSave(oPC,(7 + nTotalDisease),SAVING_THROW_TYPE_DISEASE) == 0)
                {
                    CreateItemOnObject("zombiedisease",oPC);
                    if (nTotalDisease >= 9)
                    {
                        CreateItemOnObject("deathtoken",oPC);
                        ExecuteScript("zombieclone",oPC);
                        AssignCommand(oPC,ActionJumpToLocation(GetLocation(GetWaypointByTag("lostsoularrive"))));
                        DelayCommand(0.3,FloatingTextStringOnCreature("Your body has become a zombie.",oPC,FALSE));
                        DelayCommand(0.5,FloatingTextStringOnCreature("You are now a lost soul.",oPC,FALSE));
                    }
                    else
                    {
                        ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_IMP_DISEASE_S),oPC);
                        FloatingTextStringOnCreature("The disease continues to spread...",oPC,FALSE);
                    }
                }
                else
                {
                    FloatingTextStringOnCreature("You resist the disease for now...",oPC,FALSE);
                }
            }
            else
            {
                SetLocalInt(oPC,"distimer",nDisTimer);
            }
        }
        if ((nTotalDisease > 0) && (GetCurrentHitPoints(oPC) >= GetMaxHitPoints(oPC)))
        {
            SetLocalInt(oPC,"distimer",0);
            int nHelTimer = GetLocalInt(oPC,"heltimer") + 1;
            if (nHelTimer >= 160)
            {
                SetLocalInt(oPC,"heltimer",0);
                if (FortitudeSave(oPC,(7 + nTotalDisease),SAVING_THROW_TYPE_DISEASE) == 1)
                {
                    object oDisease = GetItemPossessedBy(oPC,"ZombieDisease");
                    DestroyObject(oDisease);
                    RemoveDiseaseEffects(oPC);
                    if (nTotalDisease == 1)
                    {
                        FloatingTextStringOnCreature("The disease has completely passed.",oPC,FALSE);
                    }
                    else
                    {
                        FloatingTextStringOnCreature("The disease fades a little...",oPC,FALSE);
                    }
                }
                else
                {
                    FloatingTextStringOnCreature("You still feel sick for now...",oPC,FALSE);
                }
            }
            else
            {
                SetLocalInt(oPC,"heltimer",nHelTimer);
            }
        }
        if ((GetCurrentHitPoints(oPC) > 0) && (OBJECT_INVALID != GetItemPossessedBy(oPC,"DeathToken")) && (GetLocalInt(oPC,"ingame") == 1))
        {
            DestroyObject(GetItemPossessedBy(oPC,"DeathToken"));
        }

        if ((nIsHungry == 80) || (nIsHungry == 160) || (nIsHungry == 240))
        {
            AgeFood(oPC);
        }

        if (nIsHungry == nEightHours)
        {
            object oPCToken = GetItemPossessedBy(oPC, "token_pc");
            int iOldSurvivalTimes = GetLocalInt(oPCToken, "iSurvivalTimes");
            SetLocalInt(oPCToken, "iSurvivalTimes", iOldSurvivalTimes+1);
            SendMessageToPC(oPC, "Regardless of the ravages to body and mind" +
                    " brought on by this evil island, you slowly feel yourself" +
                    " growing stronger from the experience.");
            GiveXPToCreatureDH(oPC, 12);
         }

        //  Check to see if the player is hungry and lost CON (8 hours)
        if ((nIsHungry >= nEightHours ) && (nLostCon > 0))
        {
            EatFood(oPC);
            //  Warn PC if they have no food.
            if ( nIsHungry > 0 )
                SendMessageToPC(oPC,"You are hungry and require food to eat.");
        }  //  End check for nIsHungry >= 2 and nLostCon > 0
        //  Check to see if the player is hungry and no CON loss (12 hours), (20 hours)
        if ( ( (nIsHungry == nTwelveHours) || (nIsHungry >= nTwentyHours) )&& (nLostCon == 0) )
        {
            EatFood(oPC);
            //  If the PC is still hungry, after attempting to eat (12 hours), (20 hours)
            if ( (nIsHungry == nTwelveHours) || (nIsHungry >= nTwentyHours) )
                SendMessageToPC(oPC,"You are hungry and require food to eat.");
        }
        //  When CON drops below 4, PC dies (24 hours)
        if ( (nIsHungry > nTwentyFourHours) && (GetAbilityScore(oPC, ABILITY_CONSTITUTION) < 4) )
        {
            ApplyEffectToObject(DURATION_TYPE_INSTANT, eKill, oPC);
            SendMessageToPC(oPC,"You have starved to death!");
            nIsHungry = 0;
            nLostCon = 0;
        }
        //  Start taking CON away if the PC is hungry too long (24 hours)
        if ( nIsHungry > nTwentyFourHours )
        {
            //  Use Supernatural flag to prevent rest from curing.
            eDamage = SupernaturalEffect(eDamage);
            AssignCommand(oApplier, ApplyEffectToObject(DURATION_TYPE_PERMANENT, eDamage, oPC));
            nLostCon++;
            nIsHungry = nSpeedUpHunger;
            SendMessageToPC(oPC,"You are in desparate need of food!");
        }
        //  Store the values of hunger and CON on the PC
        SetLocalInt(oPC,"IsHungry",nIsHungry);
        SetLocalInt(oPC,"LostCon",nLostCon);

        // SCAVENGER CODE ADDITIONS
        oJunk = GetNearestObjectByTag("SJUNK",oPC);
        if ((GetDistanceBetween(oPC,oJunk) <= 8.0) && (GetDistanceBetween(oPC,oJunk) > 0.0))
        {
            if (GetLocalInt(oPC,"nearjunk") == 0)
            {
                FloatingTextStringOnCreature("There is searchable junk here.", oPC, FALSE);
                SetLocalInt(oPC,"nearjunk",1);
            }
        }
        else
        {
            SetLocalInt(oPC,"nearjunk",0);
        }
      }
      oPC = GetNextPC();
    }  //  End Loop through PCs
}
