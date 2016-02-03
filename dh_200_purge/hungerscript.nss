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
#include "_incl_disease"
#include "_incl_xp"
#include "_incl_pc_data"

int iIsHungry;
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
    //  If food is found consume it, and increase CON by 1 point.  The iIsHungry check is to exit the loop quicker
    oFood = GetFirstItemInInventory(oPC);
    while ((iIsHungry > 0) && (nNoMore == FALSE))
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
                effect eLostCon = EffectAbilityDecrease(ABILITY_CONSTITUTION, nLostCon);
                effect eEffect = GetFirstEffect(oPC);
                while(GetIsEffectValid(eEffect))
                {
                    if(eEffect == eLostCon)
                        RemoveEffect(oPC, eEffect);
                    eEffect = GetNextEffect(oPC);
                }
            }
            //  Otherwise turn off hunger flag
            else
                iIsHungry = 0;
        }  //  End found food
        else
        {
            nNoMore = TRUE;
        }
        nBest = 99;
        oFood = GetFirstItemInInventory(oPC);
    } // End food loop
}

void PartyRingCheck(object oPC)
{
    object oLeftRing    = GetItemInSlot(INVENTORY_SLOT_LEFTRING,oPC);
    object oRightRing   = GetItemInSlot(INVENTORY_SLOT_RIGHTRING,oPC);
    string sLeftRing    = "";
    string sRightRing   = "";

    if (oLeftRing != OBJECT_INVALID)
      sLeftRing = GetTag(oLeftRing);
    if (oRightRing != OBJECT_INVALID)
      sRightRing = GetTag(oRightRing);

    if((sLeftRing != "ROTL") && (sRightRing != "ROTL")&&
    ((sLeftRing != "w_telepring") && (sRightRing != "w_telepring")))
    {
      RemoveFromParty(oPC);
    }
}

void DarkHourBellCheck(object oPC)
{
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
}

void CandleCheck(object oPC)
{
    object oCandle = GetItemInSlot(INVENTORY_SLOT_LEFTHAND,oPC);
    if ((GetTag(oCandle) == "Candle") || (GetTag(oCandle) == "zn_torch"))
    {
        int nBurn = GetLocalInt(oCandle,"burn");
        if (nBurn >= 120)
        {
            DestroyObject(oCandle);
            SendMessageToPC(oPC, "Your light source has expired.");
        }
        else
            SetLocalInt(oCandle,"burn",nBurn + 1);
    }
}

void main()
{
    object oPC = GetFirstPC();
    effect eDamage = EffectAbilityDecrease(ABILITY_CONSTITUTION, 1);  //  Intended to apply damage
    effect eKill = EffectDeath();  //  Intended to Kill PC if needed.

    int nEightHours = FloatToInt(160 * fScale);
    int nTwelveHours = FloatToInt(240 * fScale);
    int nTwentyHours = FloatToInt(400 * fScale);
    int nTwentyFourHours = FloatToInt(480 * fScale);
    int nSpeedUpHunger = FloatToInt(120 * fScale);

    // ADDED FOR SCAVENGER SCRIPT AND OTHER STUFF
    object oJunk;
    object oCounter;

    string sArea;

    while(GetIsObjectValid(oPC))
    {
        PartyRingCheck(oPC);
        DarkHourBellCheck(oPC);

        sArea = GetTag(GetArea(oPC));
        if(GetIsDM(oPC) || GetCurrentHitPoints(oPC) <= -11 ||
            sArea == "DMLounge" || sArea == "GoToFugue" ||
            sArea == "LostSoulsRoom" || sArea == "OOCStartingArea")
        {
            //return to the top of the while loop, we don't wanna run any of this shit
            oPC = GetNextPC();
            continue;
        }

        CandleCheck(oPC);
        HBDiseaseCheck(oPC);

        /* Tweek: Not refactoring any of this mess for now since we'll be
           gutting it shortly. */
        iIsHungry = GetLocalInt(oPC, "IsHungry") + 1;  // Increment hunger each pass

        if (iIsHungry == nEightHours)
        {
            PCDAddSurvivalTime(oPC);
            SendMessageToPC(oPC, "Regardless of the ravages to body and mind" +
                    " brought on by this evil island, you slowly feel yourself" +
                    " growing stronger from the experience.");
            GiveXPToCreatureDH(oPC, 12);
        }

        if ((iIsHungry == 80) || (iIsHungry == 160) || (iIsHungry == 240))
            AgeFood(oPC);

        //  Check to see if the player is hungry and lost CON (8 hours)
        if ((iIsHungry >= nEightHours ) && (nLostCon > 0))
        {
            EatFood(oPC);
            //  Warn PC if they have no food.
            if ( iIsHungry > 0 )
                SendMessageToPC(oPC,"You are hungry and require food to eat.");
        }  //  End check for iIsHungry >= 2 and nLostCon > 0
        //  Check to see if the player is hungry and no CON loss (12 hours), (20 hours)
        if ( ( (iIsHungry == nTwelveHours) || (iIsHungry >= nTwentyHours) )&& (nLostCon == 0) )
        {
            EatFood(oPC);
            //  If the PC is still hungry, after attempting to eat (12 hours), (20 hours)
            if ( (iIsHungry == nTwelveHours) || (iIsHungry >= nTwentyHours) )
                SendMessageToPC(oPC,"You are hungry and require food to eat.");
        }
        //  When CON drops below 4, PC dies (24 hours)
        if ( (iIsHungry > nTwentyFourHours) && (GetAbilityScore(oPC, ABILITY_CONSTITUTION) < 4) )
        {
            ApplyEffectToObject(DURATION_TYPE_INSTANT, eKill, oPC);
            SendMessageToPC(oPC,"You have starved to death!");
            iIsHungry = 0;
            nLostCon = 0;
        }
        //  Start taking CON away if the PC is hungry too long (24 hours)
        if ( iIsHungry > nTwentyFourHours )
        {
            //  Use Supernatural flag to prevent rest from curing.
            eDamage = SupernaturalEffect(eDamage);
            ApplyEffectToObject(DURATION_TYPE_PERMANENT, eDamage, oPC);
            nLostCon++;
            iIsHungry = nSpeedUpHunger;
            SendMessageToPC(oPC,"You are in desparate need of food!");
        }
        //  Store the values of hunger and CON on the PC
        SetLocalInt(oPC,"IsHungry",iIsHungry);
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
        oPC = GetNextPC();
    }  //  End Loop through PCs
}
