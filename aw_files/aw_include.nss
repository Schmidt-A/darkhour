//:: Pwned by Jantima on 2004 and 2005
//:: Antiworld CopyRight
#include "aps_include"
#include "inc_bs_module"
#include "criminalrecorder"
// Player Based functions
// Return true if the object login name is a GM
int GetIsGMNormalChar(object oGM);
//Return true if the object is a GM (with deity)
int GetIsGM(object oGM);
//Return True if the object is a dm or a dm possessed
int GetIsDMAW(object oDM);
//Return True if the object is a Winged God(checks the login)
int GetIsWingedGod(object oWG);
//Return number of normal players. (not including the GMs and WGs)
int GetNormalPlayers();
//Returns the rank of the GM  Junior=1 GM=2 Senior=3   0=no gm
int GetGMRank(object oGM);
//returns true if player has devestating critical
int GetHasDev(object oPC);



int JUNIOR_GM = 1;
int GM = 2;
int SENIOR_GM = 3;

// Sets a variable for the Line Up module
void SetModuleVar(string sVarName, string sValue, int iExpiration=0, string sTable="pwdata");

// Returns a variable for the Line Up module
string GetModuleVar(string sVarName, string sTable="pwdata");
//Temporary ban a Player
//Adds entry to DB to ban player
//banlength is in hours, if 0 then ban forever
//bantype: 1 = ban cdkey, 2 = ban only account (using only cdkey for now) = 48
void BanPlayer(object oDM, object oTarget, int banlength );

//Checks DB if player is banned
int IsBanned(object oPC);

//:://///////////////////////////////////////////////////
//:: Is GM normal char
//:://///////////////////////////////////////////////////
//::       checks if the selected char is a GMs normal
//::       char by checking login name
//:://///////////////////////////////////////////////////
//:: Created By: Nilas_87
//:: Created On: Dec/28/04
//:://///////////////////////////////////////////////////
int GetIsGMNormalChar(object oGM)
{
    ///Keep this so if the NWNX is not working we are still recognized
    string sName = GetPCPublicCDKey(oGM) + GetPCPlayerName(oGM);
    if(sName == "VDHYH6GPENIRO" || sName == "VDHRV7F4Jantima" || GetPCPlayerName(oGM) == "Jantima" || GetPCPlayerName(oGM) == "VvV-Aez" || GetPCPlayerName(oGM) == "riddler7")
    {
        return TRUE;
    }

    // bd table
    //int iGM = GetPersistentInt(GetObjectByTag("antiworld_npc"), "GameMaster_" + GetPCPlayerName(oGM), "AdminsGmsGods");
    return ( GetModuleVar("GameMaster_"+sName,"AdminsGmsGods") == "1" );
}

//:://///////////////////////////////////////////////////
//::GetGMRank
//:://///////////////////////////////////////////////////
//::returns the rank of the GM
//:://///////////////////////////////////////////////////
//::   Created by riddler7
//::   Created on 25/7/2006
//:://///////////////////////////////////////////////////
int GetGMRank(object oGM)
{

    string sName =  GetPCPublicCDKey(oGM) + GetPCPlayerName(oGM);

    if(sName == "VDHYH6GPENIRO" || sName == "VDHRV7F4Jantima" || GetPCPlayerName(oGM) == "Jantima")
    {
        return SENIOR_GM;
    }
    int rank = 0;
    string sPlayer;
    string sTag;
    string sTable = "AdminsGmsGods";
    sName = "GameMaster_" + sName;

        sPlayer = "~";
        sTag = "/LineUp";


    sName = SQLEncodeSpecialChars(sName);

    string sSQL = "SELECT rank FROM " + sTable + " WHERE player='" + sPlayer +
               "' AND tag='" + sTag + "' AND name='" + sName + "'";
    SQLExecDirect(sSQL);

    if (SQLFirstRow() == SQL_SUCCESS)
    {

        rank = StringToInt(SQLDecodeSpecialChars(SQLGetData(1)));
    }
    else
    {

        rank = 0;
        // If you want to convert your existing persistent data to APS, this
        // would be the place to do it. The requested variable was not found
        // in the database, you should
        // 1) query it's value using your existing persistence functions
        // 2) save the value to the database using SetPersistentString()
        // 3) return the string value here.
    }



    return rank;
}

//:://///////////////////////////////////////////////////
//::PromoteGMRank
//:://///////////////////////////////////////////////////
//::Increases the rank of the GM by 1
//:://///////////////////////////////////////////////////
//::   Created by riddler7
//::   Created on 25/7/2006
//:://///////////////////////////////////////////////////
int PromoteGMRank(object oGM)
{

    string sName =  GetPCPublicCDKey(oGM) + GetPCPlayerName(oGM);


    int rank = GetGMRank(oGM);
    int oldRank = GetLocalInt(oGM,"gmRank");

    //if (rank == 0) return -1;
    if (rank == SENIOR_GM) return -2;
    string sPlayer;
    string sTag;
    string sTable = "AdminsGmsGods";
    sName = "GameMaster_" + sName;

        sPlayer = "~";
        sTag = "/LineUp";


    sName = SQLEncodeSpecialChars(sName);

    string sSQL = "UPDATE " + sTable + " SET rank = '" + IntToString(rank+1)  + "' WHERE name = '" + sName + "'";

    SQLExecDirect(sSQL);


    if (GetGMRank(oGM) == (rank+1))
    {
        SetLocalInt(oGM,"gmRank",oldRank+1);
        return 1;
    }
    else
    {

       return 0;
        // If you want to convert your existing persistent data to APS, this
        // would be the place to do it. The requested variable was not found
        // in the database, you should
        // 1) query it's value using your existing persistence functions
        // 2) save the value to the database using SetPersistentString()
        // 3) return the string value here.
    }




}

//:://///////////////////////////////////////////////////
//::DemoteGMRank
//:://///////////////////////////////////////////////////
//::Decreases the rank of the GM by 1
//:://///////////////////////////////////////////////////
//::   Created by riddler7
//::   Created on 25/7/2006
//:://///////////////////////////////////////////////////
int DemoteGMRank(object oGM)
{

    string sName =  GetPCPublicCDKey(oGM) + GetPCPlayerName(oGM);


    int rank = GetGMRank(oGM);
    int oldRank = GetLocalInt(oGM,"gmRank");
    if (rank == 0) return -1;
    else if (rank == JUNIOR_GM) return -2;
    string sPlayer;
    string sTag;
    string sTable = "AdminsGmsGods";
    sName = "GameMaster_" + sName;

        sPlayer = "~";
        sTag = "/LineUp";


    sName = SQLEncodeSpecialChars(sName);

    string sSQL = "UPDATE " + sTable + " SET rank = '" + IntToString(rank-1)  + "' WHERE name = '" + sName + "'";

    SQLExecDirect(sSQL);

    if (GetGMRank(oGM) == (rank-1))
    {
        SetLocalInt(oGM,"gmRank",oldRank-1);
        return 1;
    }
    else
    {

       return 0;
        // If you want to convert your existing persistent data to APS, this
        // would be the place to do it. The requested variable was not found
        // in the database, you should
        // 1) query it's value using your existing persistence functions
        // 2) save the value to the database using SetPersistentString()
        // 3) return the string value here.
    }




}


//:://///////////////////////////////////////////////////
//::GetHasDev
//:://///////////////////////////////////////////////////
//::checks if player has dev crit
//:://///////////////////////////////////////////////////
//::   Created by riddler7
//::   Created on 25/7/2006
//:://///////////////////////////////////////////////////

int GetHasDev(object oPC)
{
     int nExitLoop = FALSE;
     // 955    FEAT_EPIC_DEVASTATING_CRITICAL_DWAXE
     // 996    FEAT_EPIC_DEVASTATING_CRITICAL_WHIP
     // 1075   FEAT_EPIC_DEVASTATING_CRITICAL_TRIDENT
     int nFeat = 495; //495 is the first dev. crit. feat
     while ((!nExitLoop) && (nFeat<532)) //531 is the last dev. crit. feat, repeat for all dev. crits between 495 and 531
     {
        if (GetHasFeat(nFeat, oPC) || GetHasFeat(955, oPC)  || GetHasFeat(996, oPC) || GetHasFeat(1075, oPC) )
        {
            nExitLoop = 1;
        }
        else
        {
            nFeat++;
        }
     }

    if (nExitLoop) //If a Dev. Crit. was chosen
    {
        return TRUE;
    }
    else return FALSE;

}



//:://///////////////////////////////////////////////////
//:: is GM
//:://///////////////////////////////////////////////////
//::       checks if the selected char is a GM
//:://///////////////////////////////////////////////////
//:: Created By: Nilas_87
//:: Created On: Dec/28/04
//:://///////////////////////////////////////////////////
int GetIsGM(object oGM)
{
    return ((GetDeity(oGM) == "GM") && GetIsGMNormalChar(oGM));
}
//:://///////////////////////////////////////////////////
//:: is DM
//:://///////////////////////////////////////////////////
//::       checks if the selected char is a DM
//:://///////////////////////////////////////////////////
//:: Created By: Nilas_87
//:: Created On: Dec/28/04
//:://///////////////////////////////////////////////////
int GetIsDMAW(object oDM)
{
    return (GetIsDM(oDM) == TRUE || GetIsDMPossessed(oDM) == TRUE);
}
//:://///////////////////////////////////////////////////
//:: Is Winged God
//:://///////////////////////////////////////////////////
//::       checks if the selected char is a WInged God
//::
//:://///////////////////////////////////////////////////
//:: Created By: Nilas_87
//:: Created On: Jan/05/05
//:://///////////////////////////////////////////////////
int GetIsWingedGod(object oWG)
{
    string sName = GetPCPublicCDKey(oWG) + GetPCPlayerName(oWG);
    ///Keep this so if the NWNX is not working we are still recognized
    if(sName == "VDHYH6GPENIRO" || sName == "VDHRV7F4Jantima" || sName == "VDK7DJY6Nilas_87")
    {
        return TRUE;
    }

    // bd table
    //int iWG = GetPersistentInt(GetObjectByTag("antiworld_npc"), "WingedGod_" + GetPCPlayerName(oWG), "AdminsGmsGods");
    return ( GetModuleVar("WingedGod_"+sName,"AdminsGmsGods") == "1");
}
//:://///////////////////////////////////////////////////
//:: Is Admin
//:://///////////////////////////////////////////////////
//::       Admins are special
int GetIsAdmin(object oPC);
//::
//:://///////////////////////////////////////////////////
//:: Created By: Jantima
//:: Created On: Jan/05/05
//:://///////////////////////////////////////////////////
int GetIsAdmin(object oPC)
{
    string sName = GetPCPublicCDKey(oPC) + GetPCPlayerName(oPC);
    //int iAdmin = GetPersistentInt(GetObjectByTag("antiworld_npc"), "Admin_" + GetPCPlayerName(oPC), "AdminsGmsGods");
    if(sName == "VDHYH6GPENIRO" || sName == "VDHRV7F4Jantima" || sName == "VDK7DJY6Nilas_87" || GetPCPlayerName(oPC) == "Jantima")
    {
        return TRUE;
    }
    return (GetModuleVar("Admin_"+sName,"AdminsGmsGods") == "1" );
}


//:://///////////////////////////////////////////////////
//:: GetTotalPlayers()
//:://///////////////////////////////////////////////////
//::       Returns the current amount of players.
//::       Excludes winged Gods and GMs.
//:://///////////////////////////////////////////////////
//:: Created By: Nilas_87
//:: Created On: Jan/31/05
//:://///////////////////////////////////////////////////
int GetNormalPlayers()
{
    object oPC = GetFirstPC();
    int nPlayers = 0;
    while (GetIsObjectValid(oPC))
    {
        if(GetIsWingedGod(oPC) == FALSE && GetIsGMNormalChar(oPC) == FALSE)
        {
            nPlayers = nPlayers +1;
        }
        oPC = GetNextPC();
    }
    return nPlayers;
}
//:://///////////////////////////////////////////////////
//:: RestoreAppearanceFromRace()
//:://///////////////////////////////////////////////////
//:: due to restore appearance not working after halloween :P :( ///////////
//:: DMs GMs and Gods are not Restored
//:://///////////////////////////////////////////////////
void RestoreAppearanceFromRace(object oPC, int bForce = FALSE);
void RestoreAppearanceFromRace(object oPC, int bForce = FALSE)
{
 if((!GetIsWingedGod(oPC) && !GetIsGMNormalChar(oPC) && !GetIsAdmin(oPC)) || bForce)
   {
  //DEBUG
  FloatingTextStringOnCreature(" running Restore Appearance From Race ",oPC);

   int nAppearance = GetRacialType(oPC);
   /* RACIAL_TYPE_ELF
   RACIAL_TYPE_GNOME
   RACIAL_TYPE_HALFELF
   RACIAL_TYPE_HALFLING
   RACIAL_TYPE_HALFORC
   RACIAL_TYPE_HUMAN
   RACIAL_TYPE_DWARF
   */
switch  (nAppearance)
  {
  case RACIAL_TYPE_ELF:
  SetCreatureAppearanceType(oPC, APPEARANCE_TYPE_ELF);
  break;
  case RACIAL_TYPE_GNOME:
  SetCreatureAppearanceType(oPC, APPEARANCE_TYPE_GNOME);
  break;
  case RACIAL_TYPE_HALFELF:
  SetCreatureAppearanceType(oPC,APPEARANCE_TYPE_HALF_ELF );
  break;
  case RACIAL_TYPE_HALFLING:
  SetCreatureAppearanceType(oPC,APPEARANCE_TYPE_HALFLING );
  break;
  case RACIAL_TYPE_HALFORC:
  SetCreatureAppearanceType(oPC,APPEARANCE_TYPE_HALF_ORC );
 break;
  case RACIAL_TYPE_HUMAN:
  SetCreatureAppearanceType(oPC, APPEARANCE_TYPE_HUMAN);
  break;
  case RACIAL_TYPE_DWARF:
  SetCreatureAppearanceType(oPC, APPEARANCE_TYPE_DWARF);
  break;
  default:
  SetCreatureAppearanceType(oPC,APPEARANCE_TYPE_HUMAN );
  break;
  }
 }
}
//:://///////////////////////////////////////////////////
//:: AdminsOnEnter()
//:://///////////////////////////////////////////////////
//::
//:://///////////////////////////////////////////////////
void AdminsOnEnter(object oPC);
void AdminsOnEnter(object oPC)
{
    ///// Dm char special ////
    if (GetPCPlayerName(oPC) == "Jantima" || GetIsAdmin(oPC))  // Jantima
    {
        if (GetItemPossessedBy( oPC,"TheOneRod")== OBJECT_INVALID)      CreateItemOnObject("theonerod", oPC);
        if (GetItemPossessedBy( oPC,"admin_rod")== OBJECT_INVALID)      CreateItemOnObject("theadminsrod", oPC);
        if (GetItemPossessedBy( oPC,"balance_teams")== OBJECT_INVALID)  CreateItemOnObject("balance_teams", oPC);
        if (GetItemPossessedBy( oPC,"removewingtail")== OBJECT_INVALID) CreateItemOnObject("removewingtail", oPC);
        if (GetItemPossessedBy( oPC,"destroyitem")== OBJECT_INVALID) CreateItemOnObject("destroyitem", oPC);
        if (GetItemPossessedBy( oPC,"getresref_item")== OBJECT_INVALID) CreateItemOnObject("getresref_item", oPC);
        if (GetItemPossessedBy( oPC,"ragcheckdecrease")== OBJECT_INVALID) CreateItemOnObject("ragcheckdecrease", oPC);
        if (GetItemPossessedBy( oPC,"specialitem")== OBJECT_INVALID) CreateItemOnObject("specialitem", oPC);
     }

    if (GetPCPlayerName(oPC) == "Tovero_on_Sorrel-Paint Rain")  //Eniro
    {
        if (GetItemPossessedBy( oPC,"TheOneRod")== OBJECT_INVALID)      CreateItemOnObject("theonerod", oPC);
    }
    if (GetPCPlayerName(oPC) == "ENIRO")  //Eniro
    {
        if (GetItemPossessedBy( oPC,"TheOneRod")== OBJECT_INVALID)      CreateItemOnObject("theonerod", oPC);
        if (GetItemPossessedBy( oPC,"admin_rod")== OBJECT_INVALID)      CreateItemOnObject("theadminsrod", oPC);
    }
    if (GetPCPlayerName(oPC) == "Nilas_87")  //Nilas
    {
        if (GetItemPossessedBy( oPC,"TheOneRod")== OBJECT_INVALID)      CreateItemOnObject("theonerod", oPC);
    }
    if (GetPCPlayerName(oPC) == "Vladiat0r")  //Vladiat0r
    {
        if (GetItemPossessedBy( oPC,"balance_teams")== OBJECT_INVALID)  CreateItemOnObject("balance_teams", oPC);
    }
}

//:://///////////////////////////////////////////////////
//:: GMOnEnter()
//:://///////////////////////////////////////////////////
//::
//:://///////////////////////////////////////////////////
void GMOnEnter(object oPC);
void GMOnEnter(object oPC)
{
    ///// Dm char special ////

    if (GetIsGMNormalChar(oPC))
    {

        if(!GetIsObjectValid(GetItemPossessedBy(oPC, "jumpusback")))
        {
            DelayCommand(14.0,SendMessageToPC(oPC, "<cÒ.L>Please Talk to the Archivist and take the New GM items to help you moderating the Game, thanks.</c>"));
        }


    }

    // GM special ////
    if (GetIsGM(oPC))
    {
        effect eVis = EffectVisualEffect(VFX_DUR_SANCTUARY);
        effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_POSITIVE);
        effect eTS = EffectTrueSeeing();
        effect eSanc = EffectEthereal();
        effect eLink = EffectLinkEffects(eVis, eSanc);
        eLink = EffectLinkEffects(eLink, eTS);
        eLink = EffectLinkEffects(eLink, eDur);
        eLink = SupernaturalEffect(eLink);
        ApplyEffectToObject(DURATION_TYPE_PERMANENT, eLink, oPC);
        SetImmortal(oPC,TRUE);
    }

    SetLocalInt(oPC,"gmRank",GetGMRank(oPC));
}

 //:://///////////////////////////////////////////////////
//:: SetModuleVar()
//:://///////////////////////////////////////////////////
//:: By Xargoth
//:://///////////////////////////////////////////////////

void SetModuleVar(string sVarName, string sValue, int iExpiration=0, string sTable="pwdata")
{
    string sPlayer;
    string sTag;

        sPlayer = "~";
        sTag = "/LineUp";


    sVarName = SQLEncodeSpecialChars(sVarName);
    sValue = SQLEncodeSpecialChars(sValue);

    string sSQL = "SELECT player FROM " + sTable + " WHERE player='" + sPlayer +
                  "' AND tag='" + sTag + "' AND name='" + sVarName + "'";
    SQLExecDirect(sSQL);

    if (SQLFirstRow() == SQL_SUCCESS)
    {
        // row exists
        sSQL = "UPDATE " + sTable + " SET val='" + sValue +
               "',expire=" + IntToString(iExpiration) + " WHERE player='"+ sPlayer +
               "' AND tag='" + sTag + "' AND name='" + sVarName + "'";
        SQLExecDirect(sSQL);
    }
    else
    {
        // row doesn't exist
        sSQL = "INSERT INTO " + sTable + " (player,tag,name,val,expire) VALUES" +
               "('" + sPlayer + "','" + sTag + "','" + sVarName + "','" +
               sValue + "'," + IntToString(iExpiration) + ")";
        SQLExecDirect(sSQL);
    }
}
//:://///////////////////////////////////////////////////
//::GetModuleVar()
//:://///////////////////////////////////////////////////
//::  by Xargoth
//:://///////////////////////////////////////////////////
string GetModuleVar(string sVarName, string sTable="pwdata")
{
    string sPlayer;
    string sTag;

        sPlayer = "~";
        sTag = "/LineUp";


    sVarName = SQLEncodeSpecialChars(sVarName);

    string sSQL = "SELECT val FROM " + sTable + " WHERE player='" + sPlayer +
               "' AND tag='" + sTag + "' AND name='" + sVarName + "'";
    SQLExecDirect(sSQL);

    if (SQLFirstRow() == SQL_SUCCESS)
    {

        return SQLDecodeSpecialChars(SQLGetData(1));
    }
    else
    {

        return "";
        // If you want to convert your existing persistent data to APS, this
        // would be the place to do it. The requested variable was not found
        // in the database, you should
        // 1) query it's value using your existing persistence functions
        // 2) save the value to the database using SetPersistentString()
        // 3) return the string value here.
    }
}

//:://///////////////////////////////////////////////////
//:: FreezeUnfreeze()
//:://///////////////////////////////////////////////////
//:: Created By Jantima
//:: Original idea By Knowj
//:://///////////////////////////////////////////////////
void FreezeUnfreeze(object oPC, object oDM);
void FreezeUnfreeze(object oPC, object oDM )
{
    if (!GetIsObjectValid(oPC) || !GetIsPC(oPC) || GetIsAdmin(oPC) || GetIsDM(oPC) || GetIsDMPossessed(oPC))
    {
        FloatingTextStringOnCreature("NOOB!!", oDM);
        return;
    }
    if (GetLocalInt(oPC,"pause") == 1)
    {
        SetPlotFlag (oPC,FALSE);
        effect eEffect = GetFirstEffect(oPC);
        while (GetIsEffectValid(eEffect))
        {
            //else store the effect creator name on the player and chek for it
            if(GetEffectCreator(eEffect) == GetObjectByTag("Freezer")||
            //since we cannot assign command for the petrify effect, because of a bug it will not apply the effect
            //we cannot dispel this effect by the creator and we just do this way
              GetEffectType(eEffect) == EFFECT_TYPE_PETRIFY)
            {
                RemoveEffect(oPC, eEffect);
            }
            eEffect = GetNextEffect(oPC);
        }
        SetLocalInt(oPC, "pause", 0);
    }
    else //freeze
    {
        SetLocalInt(oPC, "pause", 1);
        object freezer = GetObjectByTag("Freezer");

        effect ePetrify = SupernaturalEffect(EffectPetrify());
        ApplyEffectToObject(DURATION_TYPE_PERMANENT,ePetrify, oPC);
        AssignCommand(freezer,ApplyEffectToObject(DURATION_TYPE_PERMANENT,SupernaturalEffect(EffectVisualEffect(VFX_DUR_GLOW_RED)), oPC));
        AssignCommand(freezer,ApplyEffectToObject(DURATION_TYPE_PERMANENT,SupernaturalEffect(EffectVisualEffect(VFX_DUR_GLOW_LIGHT_RED)), oPC));

        SetPlotFlag (oPC,TRUE);
    }
}
//:://///////////////////////////////////////////////////
//:: CheckXpGoldBalance()
//:://///////////////////////////////////////////////////
//::  By Me
//:://///////////////////////////////////////////////////
 // check the xp amount and the gold amount for the player.
 // If the gold is more than the xp move the player to jail
 //until he dont mach the xp==gold he cant take the portal to the welcome and play.
int CheckXpGoldBalance(object oPlayer);
int CheckXpGoldBalance(object oPlayer)
{
    //add a margin of error as for some reason the calcultation is out by 3 gold, 100 gold isn't going
    //to matter much
    int nMargin = 100;
    int result = 0;
    //check the xp amount and the gold amount for the player.
    //If the gold is more than the xp move the player to jail
    //until he dont mach the xp==gold he cant take the portal to the welcome and play.
    if (!GetIsDMAW(oPlayer) && !GetIsGM(oPlayer))
    {
        if (!IsInConversation(oPlayer) && GetTag(GetArea(oPlayer)) != "Jail")
        {
            int nGold = GetTotalPlayerItemCost(oPlayer)+ GetGold(oPlayer) ;
            int nXP = GetXP(oPlayer) + nMargin;
            if (nGold > nXP)
            {
                effect e1 = GetFirstEffect(oPlayer);
                int nType;
                int bRet = FALSE;
                while (GetIsEffectValid(e1) && !bRet)
                {
                    nType = GetEffectType(e1);

                    if (nType == EFFECT_TYPE_POLYMORPH)
                    {
                        bRet = TRUE;
                    }
                    e1 = GetNextEffect(oPlayer);
                }
                //check if is not polymorphed
                if (!bRet)
                {
                    //RemoveAllEffects(oPlayer);
                    result = 1;
                    //int nTeam = GetPlayerTeam(oPlayer);
                    //RemovePlayerFromTeam(nTeam,oPlayer);
                    MovePlayerToJail(oPlayer);
                    SendMessageToGM("<ckÏÍ>"+GetName(oPlayer)+" ["+GetPCPlayerName(oPlayer)+"] sent to jail for gold cheating: "+IntToString(nGold - nXP)+" excess GP</c>");
                }
            }
       }
   }
   return result;
}

/* #Defined new table:
CREATE TABLE `player_bans` (
  `cdkey` varchar(64) NOT NULL default '',
  `account` varchar(64) NOT NULL default '',
  `charname` varchar(64) NOT NULL default '',
  `banlength` int(10) NOT NULL default '48',
  `banstart` datetime NOT NULL default '0000-00-00 00:00:00',
  KEY `cdkey` (`cdkey`)
) TYPE=MyISAM;
*/
//:://///////////////////////////////////////////////////
//:: BanPlayer()
//:://///////////////////////////////////////////////////
//::  By Vladiat0r
//:: Original idea from: Xargoth
//:: edit By Jantima (added a convo to select banlenght, so merged the old script int his function)
//:://///////////////////////////////////////////////////
void BanPlayer(object oDM, object oTarget, int banlength = 48)
{

 if ( GetIsDMAW(oDM) || GetIsGMNormalChar(oDM)  )
 {
     if(GetGMRank(oDM) < GM && banlength > 48)
     {
         FloatingTextStringOnCreature("You'll be able to use this item only after you get a promotion! During your testing time, please contact an Admin or GM whenever you feel the need to use this item.",oDM, FALSE);
         return;
     }
    if( GetIsDMAW(oTarget) || GetIsAdmin(oTarget))
    {
       FloatingTextStringOnCreature("Cannot Ban an Admin or a DM.",oDM, FALSE);
       return;
    }
    if(oTarget != oDM)
    {
       string sSQL;
       sSQL="DELETE FROM player_bans WHERE cdkey='" + GetPCPublicCDKey(oTarget)+"' AND account='" + GetPCPlayerName(oTarget)+"'";
       SQLExecDirect(sSQL);

       sSQL="INSERT INTO player_bans(cdkey, account, charname, banlength, banstart) VALUES('" +
       GetPCPublicCDKey(oTarget) + "','" +
       SQLEncodeSpecialChars(GetPCPlayerName(oTarget)) + "','" +
       SQLEncodeSpecialChars(GetName(oTarget)) + "','" +
       IntToString(banlength) + "',now())";
       SQLExecDirect(sSQL);
       string BannedString ;
       if(banlength < 24)
         {
         BannedString="<cþ?þ>"+GetName(oTarget)+"["+ GetPCPlayerName(oTarget)+"</c><cþ??>] has been banned for "+ IntToString(banlength) +" Hours.</c>";
         }
       else
       {
         BannedString="<cþ?þ>"+GetName(oTarget)+"["+ GetPCPlayerName(oTarget)+"</c><cþ??>] has been banned for "+ IntToString(banlength/24) +" days.</c>";
         }

       AssignCommand(oDM, SpeakString(BannedString, TALKVOLUME_SHOUT));
       //  BanPlayer(oTarget);
       BroadcastMessage("<cþ?þ> Game Master: "+GetPCPlayerName(oDM)+" ["+GetName(oDM)+"] Banned: "+GetName(oTarget)+"["+ GetPCPlayerName(oTarget)+"</c>");
       WriteTimestampedLogEntry(GetPCPlayerName(oDM)+" ["+GetName(oDM)+"] Banned: "+GetName(oTarget)+"["+ GetPCPlayerName(oTarget));
       if(GetGMRank(oDM) < SENIOR_GM)
           {
           FloatingTextStringOnCreature("<cþ?þ>You action has beed logged!</c>", oDM);
           DelayCommand(3.0,FloatingTextStringOnCreature("<cþ?þ>Please report on the GM forum about that action!</c>", oDM));
           }
       FloatingTextStringOnCreature("<cþ?þ>"+GetName(oTarget)+" You Are BANNED for "+ IntToString(banlength) +" days!</c>",oTarget, FALSE);
       DelayCommand(4.0,FloatingTextStringOnCreature("<cþ?þ>"+GetName(oTarget)+" You Are BANNED for"+ IntToString(banlength) +" days!</c>",oTarget, FALSE));
       int nRecord = (banlength/24)+1; //so a 2 day ban will retun 3 that's the 2 day ban default entry
       //every longer (5-30 days)ban will return as a permaban (untill we update this)
       if ( nRecord >= 4) nRecord = 4;
       CriminalRecordEntry(oTarget, oDM, "", nRecord);
       DelayCommand(10.0, BootPC(oTarget));
       DeleteLocalObject(oDM,"MyTarget");

    }
    else
    {
        FloatingTextStringOnCreature("LOL, Good thing we had a check ey, else you would have banned yourself", oDM, FALSE);
    }
 }
 else
   {
   FloatingTextStringOnCreature("Only Dm/GM can use this Item",oDM, FALSE);
   DestroyObject(GetItemActivated());
   }

  /* // that was the old function
    string sSQL;
    sSQL="DELETE FROM player_bans WHERE cdkey='" + GetPCPublicCDKey(oTarget)+"' AND account='" + GetPCPlayerName(oTarget)+"'";
    SQLExecDirect(sSQL);

    sSQL="INSERT INTO player_bans(cdkey, account, charname, banlength, banstart) VALUES('" +
    GetPCPublicCDKey(oTarget) + "','" +
    SQLEncodeSpecialChars(GetPCPlayerName(oTarget)) + "','" +
    SQLEncodeSpecialChars(GetName(oTarget)) + "','" +
    IntToString(banlength) + "',now())";
    SQLExecDirect(sSQL);  */

}
//:://///////////////////////////////////////////////////
//:: IsBanned()
//:://///////////////////////////////////////////////////
//:: By Vladiat0r
//:: Original idea from: Xargoth
//:://///////////////////////////////////////////////////
int IsBanned(object oPC)
{
    // i loaded the module without nwnx and we (or i did) all was getting booted due to :
    // "You have been banned from this server for a while."  o_O

    //Vladiat0r: This happened because without nwnx SQLFetch returns SQL_SUCCESS and SQLGetData is a bunch of dots "..................."
    //Added a check that key or account match
    string sSQL;
    sSQL = "SELECT cdkey, account FROM player_bans WHERE (cdkey='" + SQLEncodeSpecialChars(GetPCPublicCDKey(oPC)) + "' OR account='" + SQLEncodeSpecialChars(GetPCPlayerName(oPC)) + "') AND " + "((banlength = 0) OR (UNIX_TIMESTAMP(now())-banlength*3600 < UNIX_TIMESTAMP(banstart)))";
    SQLExecDirect(sSQL);
    if ((SQLFetch() == SQL_SUCCESS) &&
       ((SQLGetData(1) == SQLEncodeSpecialChars(GetPCPublicCDKey(oPC))) || (SQLGetData(2) == SQLEncodeSpecialChars(GetName(oPC)))))
    {
        return TRUE;
    }
    else
    {
        return FALSE;
    }
}
//:://///////////////////////////////////////////////////
//::  RemoveFlag()   A.K.A. =  "SEND FLAG HOME"
//:://///////////////////////////////////////////////////
//::  By Jantima
//:://///////////////////////////////////////////////////
//if the player have the flag, it will be removed and sent home
//Anyway i've ADDED this script into the RemovePlayerFromTeam()
//
// if the object is a placeable it will be also destroyed
/////////////////////////
void RemoveFlag(object oHasFlag);
void RemoveFlag(object oHasFlag)
{
    int nTeam = GetPlayerTeam(oHasFlag);
    int nEnemyTeam = 3 - nTeam;
    string szEnemyHasFlag = "oHasFlag_" + IntToString(nEnemyTeam);

    if (GetLocalObject(GetModule(), szEnemyHasFlag) == oHasFlag &&
        (nEnemyTeam == TEAM_GOOD || nEnemyTeam == TEAM_EVIL))
    {
        RemoveFlagEffect(oHasFlag); //THis remove the visual effects
        //Send The Flag to The FlagHolder
        object oHomeFlagHolder = GetObjectByTag("FlagHolder_" + IntToString(nEnemyTeam));
        SetLocalObject(GetModule(), szEnemyHasFlag, oHomeFlagHolder);
        ApplyFlagEffect(oHomeFlagHolder);
    }
    //right so the evil player hold the good flag
    //but the dropped flag placeable it take the same team as the flag
    //if the object that have the flag is a placeable, destroy it.
    if (GetObjectType(oHasFlag) == OBJECT_TYPE_PLACEABLE )
       {
         string szHasFlag = "oHasFlag_" + IntToString(nTeam);
         object oHomeFlagHolder = GetObjectByTag("FlagHolder_" + IntToString(nTeam));
         SetLocalObject(GetModule(), szHasFlag, oHomeFlagHolder);
         ApplyFlagEffect(oHomeFlagHolder);
         DestroyObject(oHasFlag);
        }
}



