//BS_CLIENTENTER

//// Antiworld OnClient Enter /////////////// bs_cliententer //
//:: Pwned by Jantima on 2004 and 2005

//#include "inc_bs_module"
//#include "aps_include"
//#include "inc_forbidden"
#include "inc_custom"
//#include "inc_"
#include "bodypart_inc"
#include "aw_include"
#include "inc_leto"

#include "x3_inc_horse"

//unless the char logs in Jail, it will sent to welcome
void OnClientEnterJumpToWelcome(object oPC);
void OnClientEnterJumpToWelcome(object oPC)
{
    //Warning - the char who spawn in jail are not affected by the Welcome db_onenter script
    //if possible ...  we have to run this.. O_o
    if ((GetName(GetArea(oPC)) != "Jail") && (GetName(GetArea(oPC)) != "Antiworld pen"))
    {
       AssignCommand(oPC, JumpToLocation(GetLocation(GetObjectByTag("spawnpoint_inn"))));
    }
    // ??? ///  else ExecuteScript("db_onenter",GetModule());
}

void main()
{
    object oPC = GetEnteringObject();
    object oItem;



    //load horses menu for old players + fix mounted appearances for logged out while mounted players
    //ExecuteScript("x3_mod_def_enter", oPC);
    ExecuteScript("x3_mod_pre_enter",OBJECT_SELF); // Override for other skin systems
    if ((GetIsPC(oPC)||GetIsDM(oPC))&&!GetHasFeat(FEAT_HORSE_MENU,oPC))
    { // add horse menu
        HorseAddHorseMenu(oPC);
        if (GetLocalInt(GetModule(),"X3_ENABLE_MOUNT_DB"))
        { // restore PC horse status from database
            DelayCommand(2.0,HorseReloadFromDatabase(oPC,X3_HORSE_DATABASE));
        } // restore PC horse status from database
    } // add horse menu
    if (GetIsPC(oPC))
    { // more details
        // restore appearance in case you export your character in mounted form, etc.
        if (GetIsWingedGod(oPC) == TRUE)//Keep the WG's appearance.
        {
            if(HasItem(oPC, "appearancesaver") == TRUE)
            {
                string sSub = GetSubRace(oPC);
                int nAppearance = StringToInt(sSub);
                SetCreatureAppearanceType(oPC, nAppearance);
                DelayCommand(3.0f, FloatingTextStringOnCreature("Your saved appearance has been restored.", oPC));
            }
        }
        else
        {
            if (!GetSkinInt(oPC,"bX3_IS_MOUNTED")) HorseIfNotDefaultAppearanceChange(oPC);
        }
            // pre-cache horse animations for player as attaching a tail to the model
            HorsePreloadAnimations(oPC);
            DelayCommand(3.0,HorseRestoreHenchmenLocations(oPC));
    } // more details


    //::!VERY IMPORTANT NUMBER!!:://INCREASE THIS IF YOU ADD A NEW CHECK!!!! the rag number is same as the check they last passed
    int nLastVersion = 20;  //the number of the lack check - current check
    int nJournalCurrentVersion = 1;    // number not really related to the previous

    //////////////////////////////////////////////////
    //:: All OnClientEnter Checks :: New system :: itemsremoved ::  variable  :: char_checks
    //:: ACTUALLY WORKING
    //itemsremoved
    //itemsremoved1
    /////////////////////////////////////////////////
    //if they had already that item they had already the previous check
    object oVarsKeeper = GetItemPossessedBy(oPC,"itemsremoved");
    int nCheck = GetLocalInt(oVarsKeeper,"char_checks");
    // Values/checks
    //
    // updating the item
    int nWasStripped = 0;

while(nCheck < nLastVersion)
    {
    switch (nCheck)
         {
         case 0:
                {
                  if (GetIsObjectValid(GetItemPossessedBy(oPC,"itemsremoved1"))) nWasStripped = 1;
                  DestroyObject(GetItemPossessedBy(oPC,"itemsremoved"));
                  ///they get the old item destroyed and the new one created
                  DestroyObject(GetItemPossessedBy(oPC,"itemsremoved1"));
                  oVarsKeeper =  CreateItemOnObject("itemsremoved", oPC ,1);
                  //skips the HugeMerchantsRevisions() since they had the item already
                  if (nWasStripped) SetLocalInt(oVarsKeeper,"item_updated",1);
                  SetLocalInt(oVarsKeeper,"char_checks",1);
                  //DEBUG
                  FloatingTextStringOnCreature(" check 0 ",oPC);
                  break;
                 }
         case 1:
                {
                 InitializeN00b(oPC);  // added check for LETO HACKED CHARS
                 //DEBUG
                 FloatingTextStringOnCreature(" check 1 ",oPC);
                 SetLocalInt(oVarsKeeper,"char_checks",2);
                 break;
                }
         case 2:
                {
                 /// Give Antiworld custom Equipments: 'DyeKit, Re.equip'
                 //Make all this items PLOT and Undrop :) so
                 //we can do this just once:::
                 //::  oVarsKeeper  ::  variable  :: char_check
                 //::  Value = 2 [Give Antiworld custom Equipments]
                 object oDyeKit = GetItemPossessedBy(oPC,"dyekit");
                 if ( !GetIsObjectValid(oDyeKit)) oDyeKit =CreateItemOnObject("mil_dyekit001", oPC,1);
                 SetPlotFlag(oDyeKit,TRUE);
                 object oRe_Equip = GetItemPossessedBy(oPC,"re_equip");
                 if (!GetIsObjectValid(oRe_Equip)) oRe_Equip=CreateItemOnObject("re_equip", oPC,1);
                 SetPlotFlag(oRe_Equip,TRUE);
                 object oFixDarkness = GetItemPossessedBy(oPC,"fixdarkness");
                 if (!GetIsObjectValid(oFixDarkness)) oFixDarkness=CreateItemOnObject("fixdarkness", oPC,1);
                 SetPlotFlag(oFixDarkness,TRUE);
                  object oShowPeopleInRange = GetItemPossessedBy(oPC,"showpeopleinrang");
                 if (!GetIsObjectValid(oShowPeopleInRange)) oFixDarkness=CreateItemOnObject("showpeopleinr", oPC,1);
                 SetPlotFlag(oShowPeopleInRange,TRUE);
                 object oDDBugFix = GetItemPossessedBy(oPC,"ddbugfix");
                 if ( !GetIsObjectValid(oDDBugFix)) oDDBugFix =CreateItemOnObject("ddbugfix", oPC,1);
                 SetPlotFlag(oDDBugFix,TRUE);
                 //Be sure to put new items also in shops for old players, since this runs once and for noobs only
                 //:: SetLocalInt(GetItemPossessedBy(oPC,"player_skin"),"char_check",3)
                 //Run Next check if any need...
                 SetLocalInt(oVarsKeeper,"char_checks",3);
                 //DEBUG
                FloatingTextStringOnCreature(" check 2 ",oPC);
                ///NEW PLAYERS REQUIRED CHECKS FINISHED
                if (GetLocalInt(oPC,"n00b"))
                   {
                    SetLocalInt(oVarsKeeper,"char_checks",nLastVersion);
                    //DEBUG
                    FloatingTextStringOnCreature("New character: skipping all checks, automatically set to current version",oPC);
                    }
                break;
                }
         case 3:
               {
                //::  oVarsKeeper  ::  variable  :: char_check
                //::  Value = 3 [RestoreAppearanceFromRace]
                //we still want to do this always so is also on the bottom on that script
                RestoreAppearanceFromRace(oPC);
                SetLocalInt(oVarsKeeper,"char_checks",4);
                //Run Next check if any need...
                //DEBUG
                FloatingTextStringOnCreature(" check 3 ",oPC);
                break;
                }
         case 4:
               {
               ///if vas not already done, remove everything and give back gold
                //::  oVarsKeeper  ::  variable  :: char_check
                //::  Value = 4 [MerchantsRevision1]
                if (!nWasStripped)
                   {
                   DelayCommand(Random(100)/10.0+1.0, HugeMerchantsRevisions(oPC));
                   }
                //:: SetLocalInt(GetItemPossessedBy(oPC,"player_skin"),"char_check",5)
                //Run Next check if any need...
                SetLocalInt(oVarsKeeper,"char_checks",5);
                //DEBUG
                FloatingTextStringOnCreature(" check 4 ",oPC);
                break;
                }
         case 5:
                {
                // Go through player's inventory and check for forbidden items.
                // This is all contained in "inc_forbidden"
                //check for special items which have been removed or are forbidden
                DelayCommand(Random(100)/10.0+1.0, RemoveAllForbiddenItems(oPC));
                SetLocalInt(oVarsKeeper,"char_checks",6);
                //DEBUG
                FloatingTextStringOnCreature(" check 5 ",oPC);
                break;
                 }
        case 6:
                {
                 DelayCommand(Random(200)/10.0+1.0, CheckNumber6(oPC));
                 DelayCommand(Random(200)/10.0+5.0, RefillGold(oPC));
                 SetLocalInt(oVarsKeeper,"char_checks",7);
                 FloatingTextStringOnCreature(" check 6 ",oPC);
                 break;
                 }
        case 7:
                {
                /// Autofail Disabled Items Revision
                 DelayCommand(Random(200)/10.0+1.0,AutoFailDiabledRevision(oPC));
                 // !!!! NOW we can skip the 8 since is the same  exact check repeated once more !!!!
                 // so players that goes thru this only get the 7 and skip to the 9, but players which got the 7 (when it wasn't skipping the 8) and then the bug, will also run the 8
                 // so I'm gonna set to 9 instead of 8    !!
                 SetLocalInt(oVarsKeeper,"char_checks",8+1);
                 FloatingTextStringOnCreature(" check 7 ",oPC);
                 break;
                 }
        case 8:
                {
                /// AGAIN because of a BUG Autofail Disabled Items Revision
                /// this time the function only remove the items with the
                /// corresponding tag, but only if they have a universal save bonus
                 DelayCommand(Random(200)/10.0+1.0, AutoFailDiabledRevision(oPC));
                 SetLocalInt(oVarsKeeper,"char_checks",9);
                 FloatingTextStringOnCreature(" check 8 ",oPC);
                 break;
                 }
         case 9:
                {
                 //repeating the check for some bug and people with jooni's gloves
                 DelayCommand(Random(200)/10.0+1.0, CheckNumber6(oPC));
                 SetLocalInt(oVarsKeeper,"char_checks",10);
                 FloatingTextStringOnCreature(" check 9 ",oPC);
                 break;
                 }
          case 10:
                {
                 if( (GetLevelByClass(CLASS_TYPE_DWARVEN_DEFENDER) >= 1 )  || ( GetLevelByClass(CLASS_TYPE_DWARVENDEFENDER) >= 1 )  )
                    {
                     object oDDBugFix = GetItemPossessedBy(oPC,"ddbugfix");
                     if ( !GetIsObjectValid(oDDBugFix)) oDDBugFix =CreateItemOnObject("ddbugfix", oPC,1);
                     SetPlotFlag(oDDBugFix,TRUE);
                     }
                 SetLocalInt(oVarsKeeper,"char_checks",11);
                 FloatingTextStringOnCreature(" check 10 ",oPC);
                 break;
                 }
          case 11:
                {
                 /// Again because there was a bug in the script to recognize whether the items has the property, and also a cloack with a tag that wasn't listed nor expected (cloak9)
                 DelayCommand(Random(200)/10.0+1.0, AutoFailDiabledRevision(oPC));
                 SetLocalInt(oVarsKeeper,"char_checks",12);
                 FloatingTextStringOnCreature(" check 11 ",oPC);
                 break;
                 }
          case 12:
                {
                //Removing Fort +10 Rings
                RemoveFort10Ring(oPC);
                /*
                object oFring = GetItemPossessedBy(oPC,"new_fort_10");
                int countring = 0;
                while(GetIsObjectValid(oFring))
                {
                    DestroyObject(oFring);
                    countring++;
                    oFring = OBJECT_INVALID;
                    oFring = GetItemPossessedBy(oPC,"new_fort_10");
                }
                GiveGoldToCreature(oPC, 357012*countring);
                */
                SetLocalInt(oVarsKeeper,"char_checks",13);
                FloatingTextStringOnCreature(" check 12 ",oPC);
                object oUpdate = GetObjectByTag("update_12");
                DelayCommand(4.0,AssignCommand(oPC,ActionExamine(oUpdate)));
                break;
                }
          //Remove the unwanted gloves
          case 13:
                {
                //Recalling +12 disc/concentration/spellcraft gloves, defined function in inc_rules
                RemoveBadGloves(oPC);
                SetLocalInt(oVarsKeeper,"char_checks",14);
                FloatingTextStringOnCreature(" check 13 ",oPC);
                object oUpdate = GetObjectByTag("update_13");
                DelayCommand(4.0,AssignCommand(oPC,ActionExamine(oUpdate)));
                break;
                }
          //Remove Scythes
          case 14:
                {
                //Removing old scythes, defined function in inc_rules
                RemoveOldScythe(oPC);
                SetLocalInt(oVarsKeeper,"char_checks",15);
                FloatingTextStringOnCreature(" check 14 ",oPC);
                object oUpdate = GetObjectByTag("update_14");
                DelayCommand(4.0,AssignCommand(oPC,ActionExamine(oUpdate)));
                break;
                }
          //If the character has more than 5 heal rings, the extras are removed and the character is refunded
          case 15:
                {
                //Removing excess heal rings, defined function in inc_rules
                RemoveExcessHealRings(oPC);
                SetLocalInt(oVarsKeeper,"char_checks",16);
                FloatingTextStringOnCreature(" check 15 ",oPC);
                object oUpdate = GetObjectByTag("update_15");
                DelayCommand(4.0,AssignCommand(oPC,ActionExamine(oUpdate)));
                break;
                }
          case 16:
                {
                //give some gold to the PC since the starting gold amount has been increased
                GiveGoldToCreature(oPC, 4500);
                FloatingTextStringOnCreature("Since the starting gold amount has increased by 4,500, you have been given 4,500. If you cheated or were bugged and had acquired disproportionate gold compared to your XP, you might end up in jail.", oPC);
                SetLocalInt(oVarsKeeper,"char_checks",17);
                FloatingTextStringOnCreature(" check 16 ",oPC);
                break;
                }
          //Charge system
          case 17:
                {

                SetLocalInt(oVarsKeeper,"char_checks",18);
                FloatingTextStringOnCreature(" check 17 ",oPC);
                break;
                }
          case 18:
                {

                    SetLocalInt(oVarsKeeper,"char_checks",19);
                    FloatingTextStringOnCreature(" check 18 ", oPC);
                    break;
                }
          case 19:
                {
                    oItem = GetFirstItemInInventory(oPC);
                    while(oItem != OBJECT_INVALID)
                    {
                        if(GetTag(oItem) == "X0_IT_MRING012" )
                        {
                            SetItemCharges(oItem, 100);
                        }
                        oItem = GetNextItemInInventory(oPC);
                    }
                    UpdateChargeSystem(oPC);
                    SetLocalInt(oVarsKeeper,"char_checks",20);
                    FloatingTextStringOnCreature(" check 19 ", oPC);
                    break;
                }

          // NEXT CHECK WILL BE 20
          // when you uncomment and use this new check, you will need to change
          // the very important check number at start of this script to be 18
          /*
          case 18:
                {
                //Do whatever
                SetLocalInt(oVarsKeeper,"char_checks",19);
                FloatingTextStringOnCreature(" check 18 ",oPC);
                break;
                }
             */

         case 100:  //Char was deleted//
                {
                     if ( GetDeity(oPC) == "eliminaCARATTERI" && GetPCPlayerName(oPC) != "" && GetPCPlayerName(oPC) != " ")
                     {
                        //PrintString("[Playername] "+GetPCPlayerName(oPC) + " [Charname] "+GetName(oPC)+" Entered with Deity: eliminaCARATTERI");
                        SetDeity(oPC,"");
                        DelayCommand(9.0,FloatingTextStringOnCreature("<c?.?>Your Character is no more Flagged 'Deleted', to delete it, talk to the Archivist, and don't use it!</c>",oPC, FALSE));
                     }
                SetLocalInt(oVarsKeeper,"char_checks",nLastVersion);
                  //DEBUG
                FloatingTextStringOnCreature(" check 100 ",oPC);
                break;
                }
        case 200:  //DeleteBio//
                {

                //Vladiat0r 4/9/05 see inc_leto and delete_bio for related functionality
                //::  oVarsKeeper  ::  variable  :: char_check
                //::  Value = 200 [delete_bio]
                if(GetDeity(oPC) == "delete_bio")
                {
                    SendMessageToPC(oPC, "You logged in too quickly, you will be booted again. Do not return for 1 minute.");
                    QueueDeleteBio(GetObjectByTag("antiworld_npc"), oPC);

                }
                else  SetLocalInt(oVarsKeeper,"char_checks",nLastVersion);
                FloatingTextStringOnCreature(" check 200 ",oPC);
               break;
              }
         default: break;
         }
    nCheck = GetLocalInt(oVarsKeeper,"char_checks");
    }
    //:: All Checks from 1 to 100 (or 200)
    //::  Value = 1 [New character]
    //::  Value = 2 [Give Antiworld custom Equipments]
    //::  Value = 3 [RestoreAppearanceFromRace]
    //::  Value = 4 [MerchantsRevision1]
    //::  Value = 5 [Current: Nothing to do in this]
    //::  SPECIAL CASES:
    //::  Value = 100 [flagged deleted]
    //::  Value = 200 [delete_bio]   or 200+InitialValue after bio deleted remove 200 to the value.
    //:: #############################################
    //////////////////////////////////////////////////////////////////////


    //////////////////////////////////////////////////////////////////////
    //::  CHECK FOR INVALID TAG OR RESREF (CHEATED)
    //::
    //////////////////////////////////////////////////////////////////////
      if (GetTag(oPC) != "")
      {
            SendMessageToGM("<cÍ3!>"+ GetName(oPC)+ " entered with a hacked char, TagName: " + GetTag(oPC) + " -> auto booted</c>");
            BootPC(oPC);

      }
      if (GetResRef(oPC) != "")
      {
            SendMessageToGM("<cÍ3!>"+ GetName(oPC)+ " entered with a hacked char, ResRef: " + GetResRef(oPC) + " -> auto booted.</c>");
            BootPC(oPC);
      }



  /////////////////Move to Welcome ///////////
  //Delayed to prevent the default Jump to last location to run after this
  DelayCommand(3.0, OnClientEnterJumpToWelcome(oPC));

  //this may be useful to remove flag VISUAL effect to who crashed (?) with flag.
  RemoveAllEffects(oPC);
  DelayCommand(8.0,PmACDecrease(oPC));

  /// PRINT PLAYERS INFORMATIONS //
  PrintString("[Playername] "+GetPCPlayerName(oPC) + " [Charname] "+GetName(oPC)+" [CDkey] "+GetPCPublicCDKey(oPC)+" [IPAddress] " + GetPCIPAddress(oPC));
  //try to track shifters to see if they cause crashes
  //TrackShifterEnter(oPC);


  /*  ///////////GM/WG "extra slots//////////////////
    //EXAMINE  Tag = "InvisibleEXAMINEonautobooting"
    int nPlayers = GetNormalPlayers();
    int nMax = GetLocalInt(GetModule(), "MaxPlayers");
    if(nPlayers >= nMax )
    {
     if(GetIsWingedGod(oPC) == FALSE && GetIsGMNormalChar(oPC) == FALSE)
       {
        DelayCommand(5.0,AssignCommand(oPC,ActionExamine(GetObjectByTag("InvisibleEXAMINEonautobooting"))));
        DelayCommand(10.0,SendMessageToPC(oPC, "<c?.L>Sorry, the server is full of players. The remaining slots are reserved for staff and the Winged Gods. You will be booted in 10 seconds.</c>"));
        DelayCommand(12.0,SendMessageToPC(oPC, "<c?.L>Sorry, the server is full of players. The remaining slots are reserved for staff and the Winged Gods. You will be booted in 8 seconds.</c>"));
        DelayCommand(14.0,SendMessageToPC(oPC, "<c?.L>Sorry, the server is full of players. The remaining slots are reserved for staff and the Winged Gods. You will be booted in 6 seconds.</c>"));
        DelayCommand(16.0,SendMessageToPC(oPC, "<c?.L>Sorry, the server is full of players. The remaining slots are reserved for staff and the Winged Gods. You will be booted in 4 seconds.</c>"));
        DelayCommand(20.0, BootPC(oPC));
       }
    }     */

    AdminsOnEnter(oPC);

    GMOnEnter(oPC);

    //for SendMessageToGM function
    if (GetIsGMNormalChar(oPC) || GetIsDMAW(oPC))
    {
        object oMod = GetModule();
        int i;
        for (i = 0; i < 32; i++)
        {
            string sName = "GM" + IntToString(i);
            object oGM = GetLocalObject(oMod, sName);
            if (!GetIsObjectValid(oGM) || (oGM == oPC))
            {
                DeleteLocalObject(oMod, sName); //delete duplicate entries
            }
        }
        for (i = 0; i < 32; i++)
        {
            string sName = "GM" + IntToString(i);
            object oGM = GetLocalObject(oMod, sName);
            if (!GetIsObjectValid(oGM))
            {
                SetLocalObject(oMod, sName, oPC);
                break;
            }
        }
    }
/*  DEBUG SOMETHING
    if (GetIsPC(oPC))
    {
        object oMod = GetModule();
        int i;
        string sName;
        object oCurPC;
        int nCount = 1; //current PC logging in
        for (i = 0; i < 38; i++)
        {
            sName = "PC" + IntToString(i);
            oCurPC = GetLocalObject(oMod, sName);
            if (!GetIsObjectValid(oCurPC) || (oCurPC == oPC))
            {
                DeleteLocalObject(oMod, sName); //delete duplicate entries
            }
            else
            {
                nCount++;
            }
        }
        for (i = 0; i < 38; i++)
        {
            sName = "PC" + IntToString(i);
            oCurPC = GetLocalObject(oMod, sName);
            if (!GetIsObjectValid(oCurPC))
            {
                SetLocalObject(oMod, sName, oPC);
                break;
            }
        }
        int nCount2;
        oCurPC = GetFirstPC();
        while (GetIsObjectValid(oCurPC))
        {
            if (GetIsPC(oCurPC))
            {
                nCount2++;
            }
            oCurPC = GetNextPC();
        }
        if (nCount != nCount2)
        {
            WriteTimestampedLogEntry("DEBUG: [bs_cliententer] Bad count: " + IntToString(nCount) + " Count2: " + IntToString(nCount2));
        }
    }
*/
    //////// winged god special //////////
    if (GetIsWingedGod(oPC) == TRUE)
    {
        if (GetIsDMAW(oPC) == FALSE)
        {
            BroadcastMessage("<c?>A Winged God has entered the server</c>");
        }
        object oAppearancesBook = GetItemPossessedBy( oPC,"appearancelist");
        if (oAppearancesBook == OBJECT_INVALID)
        {
           object oNewBook = CreateItemOnObject("appearancelist", oPC,1);
           SetLocalInt(oNewBook,"nVersion",167);
        }
        else if (GetLocalInt(oAppearancesBook,"nVersion") != 169)
        {
            SetPlotFlag(oAppearancesBook,FALSE);
            DestroyObject(oAppearancesBook);
            object oNewBook = CreateItemOnObject("appearancelist", oPC,1);
            SetLocalInt(oNewBook,"nVersion",169);
            DelayCommand(14.0,FloatingTextStringOnCreature("<c×u¢>Your Appearances Book has been Updated.</c>",oPC,FALSE));
         }
    }
    /////////////////

    if(!GetIsDMAW(oPC))
    {
        //Initialize the goldwinnings variable
        SetLocalInt(oPC,"m_nGoldwinnings",0);
        //Initialize Player Stats
        SetLocalInt(oPC, "nTeam", 0);
        object oModule = GetModule();
        //we will change so if they log back quickly within same round their score is not reset
        if (abs(GetLocalInt(oPC, "LastTimer") - GetLocalInt(oModule, "timer")) > 50 ||
            GetLocalInt(oPC, "LastRound") != GetLocalInt(oModule, "nRound") ||
            0 == GetLocalInt(oModule, "nRound") ||
            1 == GetLocalInt(oPC, "LoopTest")
        )
        {
            SetLocalInt(oPC,"m_nKills",0);
            SetLocalInt(oPC,"m_nDeaths",0);
            SetLocalInt(oPC, "nScore", 0);
        }
        else //The LoopTest var will be deleted in the while loop, however if the loop fails for some reason, score will be reset
        {
            SetLocalInt(oPC,"LoopTest",1);
        }
        SetLocalInt(oPC, "MapVote", 0);
        //::
        SetLocalInt(oPC, "Pengy", 0); //1 if player is pengy
        SetLocalInt(oPC, "AttackEffy", 0); //Counts how many effies attacked
        SetLocalInt(oPC, "AttackImp", 0); //Counts how many imps attacked
        /////////////////////////////////////////////////////////////////////////
        if (GetPlotFlag(oPC) == TRUE)
        {
            SetPlotFlag(oPC, FALSE);
            PrintString(GetPCPlayerName(oPC) + " entered with Plot flag.");
        }


        ///// Save Equipped Weapons for Disarm ////////
        object oItem1 = GetItemInSlot( INVENTORY_SLOT_LEFTHAND,oPC);
        if(GetIsObjectValid(oItem1))   SetLocalString(oPC,"weapon1",GetTag(oItem1));
        object oItem2 = GetItemInSlot( INVENTORY_SLOT_RIGHTRING,oPC);
        if(GetIsObjectValid(oItem2))  SetLocalString(oPC,"weapon2",GetTag(oItem2));


        /// we also need to reset crafting variables
        DeleteLocalInt(oPC, "STX_CR_STARTED");
        //Check all Item for Duping  //This replaces the Remove Forbidden that is no longer run all the time
        object oItem = GetFirstItemInInventory(oPC);
        while ( GetIsObjectValid(oItem) == TRUE )
        {
            CheckDuping(oItem, oPC);
            oItem = GetNextItemInInventory(oPC);
        }
        int nCount;
        for ( nCount = 0; nCount < NUM_INVENTORY_SLOTS; nCount++ )
        {
            oItem = GetItemInSlot(nCount,oPC);
            CheckDuping(oItem, oPC);
        }

        DelayCommand(10.3,SendMessageToPC(oPC, "! Unused characters are automatically deleted after four months !"));

        DelayCommand(5.0, SetLocalInt(oPC, "DoneLogin", TRUE)); //to prevent initial onacquire check of all items
    } // !GetIsDM()

    ApplyHaste(oPC);
    ApplyTumble(oPC);

    RestoreAppearanceFromRace(oPC);

    /*
This can be added after RestoreAppearanceFromRace(oPC); line in bs_cliententer.
That still need to be tested!
*/
    //Add AC from armor
    //AC system
    /*
    Level | AC
    10-13 | +4
    14-16 | +3
    17-20 | +2
    20-23 | +1
    24-40 | +0
    */
    object oItem2;
    oItem2 = GetItemInSlot(INVENTORY_SLOT_CHEST,oPC);
    if(GetIsObjectValid(oItem2))
    {
        int iCharge;
        iCharge = GetItemCharges(oItem2);
        if((iCharge == 30) ||  //Dexer AC armor
            (iCharge == 31) ||
            (iCharge == 32) ||
            (iCharge == 33))
            {
            int iLevel;
            iLevel = GetHitDice(oPC);
            int iBonus;
            if(iLevel > 23){return;}
            else if(iLevel > 20)
                {
                    iBonus = 1;
                }
            else if(iLevel > 16)
                {
                    iBonus = 2;
                }
            else if(iLevel > 13)
                {
                    iBonus = 3;
                }
            else if(iLevel > 9)
                {
                    iBonus = 4;
                }

            ApplyEffectToObject(DURATION_TYPE_PERMANENT,SupernaturalEffect(EffectACIncrease(iBonus,AC_DODGE_BONUS )) ,oPC);
            SendMessageToPC(oPC, "Low level dexer AC bonus : +"+IntToString(iBonus));
        }
    }

    //Make Journal Entries, customize these if you wish.
    MakeJournalEntry(oPC);
    if (GetLocalInt(oVarsKeeper,"JournalVersion") < nJournalCurrentVersion )
    {
    FloatingTextStringOnCreature("<c×u¢>The Journal has been UPDATED, please read what's new</c>", oPC,FALSE);
    SetLocalInt(oVarsKeeper,"JournalVersion",nJournalCurrentVersion);
    }
    // Antiworld Persistant wings////
    SetPersistentWings(oPC);

    if (GetLocalInt(GetModule(),"ValentineDay") == 1)
    {
        DelayCommand(13.0,FloatingTextStringOnCreature("<c?.?>Welcome to Antiworld Valentine's Day Party!</c>",oPC, FALSE));
    }

    //give a mask on halloween, mask is destroyed in RemoveAllForbiddenItems in the CheckDuping that always runs and checks all items
    object halloweenItem = GetItemPossessedBy( oPC, "halloweenparty");
    if (GetLocalInt(GetModule(), "Halloween") == 1)
    {
        DelayCommand(13.0,FloatingTextStringOnCreature("<c?.?>Welcome to Antiworld Halloween Party!</c>",oPC, FALSE));
        DelayCommand(1.0 + Random(5), SetCreatureAppearanceType(oPC, APPEARANCE_TYPE_ZOMBIE_ROTTING));
        if (halloweenItem == OBJECT_INVALID)
        {
            CreateItemOnObject("halloweenparty", oPC);
        }
    }

    if (GetLocalInt(GetModule(), "Halloween") == 0)
    {
        if ( halloweenItem != OBJECT_INVALID)
        {
            DestroyObject(halloweenItem);
        }
    }

    // Initialize the GetPlayerByName function used in VCS_Engine.
    // SetLocalObject(GetModule(), "PCName_" + GetStringUpperCase(GetPCPlayerName(oPC)), oPC);
    // SetLocalString(GetModule(), "PCCName_" + GetName(oPC), GetPCPlayerName(oPC));
    if(IsBanned(oPC))
    {
    SendMessageToPC(oPC, "You have been banned from this server for a while. Check back later.");
    DelayCommand(2.0f, FloatingTextStringOnCreature("BANNED!", oPC, FALSE));
    DelayCommand(4.0f, BootPC(oPC));
    }
   object oMyst = GetItemPossessedBy(oPC,"mysteriousobject");
                 if ( !GetIsObjectValid(oMyst)) oMyst = CreateItemOnObject("mysteriousobject", oPC,1);
   SetLocalObject(oPC,"spelltracker",oMyst);
   CheckXpGoldBalance(oPC);
   SetLocalInt(oPC, "RDDLevel", GetLevelByClass(CLASS_TYPE_DRAGON_DISCIPLE));

   // FloatingTextStringOnCreature("<c?.?>New Blackguard and Assassin feats have been added, go to antiworld forums to find out more!</c>",oPC,FALSE);
}
