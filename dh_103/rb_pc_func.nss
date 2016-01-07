#include "_incl_xp"
// Bruce Nielson
// 7/19/2002
// Description: This is a collection of functions that will be helpful
// throughout the campaign.


// Prototypes

// Description: GetIsRealPC - Returns TRUE if the object passed
// is a "real" PC - that is, if it's a character in the PC list.
// This will return TRUE for any character that is the PC's primary
// character, but will return FALSE if the player is currently possessing
// a familiar.
// As such this function returns TRUE if it's the Player's "PC"
// (i.e. player character) rather then if it's the player himself.
// I find this function often more useful then the built in (GetIsPC)
// which should only be used if you want to know if that character
// is currently possessed by a player.
int GetIsRealPC(object oObject=OBJECT_SELF);

// GetFirstRealPC: Finds the First PC in the PC list (no DMs)
// returns object_invalid if none found.
// This will be the Player's character (PC), who may or may not be an
// actual player (i.e. the player may currently be possessing a familiar)
object GetFirstRealPC();

// GetNearestReal: Find the Nearest Real PC to oTarget
// (see GetIsRealPC for description of what a "Real PC" is)
object GetNearestRealPC(object oTarget = OBJECT_SELF, int bMessageDM=TRUE);

// GetFirstDM: Returns the first DM in the game.
// If there is no DM in the game then it returns OBJECT_INVALID
object GetFirstDM();

// GiveXPToParty: Give a specified amount of XP to the party of
// a specified PC. If bSplitXP TRUE then split the XP
// up before awarding it. Otherwise, just give everyone
// the full amount specified
void GiveXPToParty(int iXPAmount, object oPC, int bSplitXP = FALSE);

// AddToJournal: This new and improved AddToJournal function
// helps take care of XP and finds the nearest PC if you don't
// specify a creature. See also "CheckJournal"
void AddToJournal(string szPlotID, int nState, int bGiveXP=FALSE, object oCreature=OBJECT_INVALID, int bAllPartyMembers=TRUE, int bAllPlayers=FALSE, int bAllowOverrideHigher=FALSE);

// CheckJournal: This function returns the highest
// journal entry that has been set for a given journal tag
// if the journal tag was set through the AddToJournal function.
// This is useful for check to see if certain plot points
// have occured yet.
int CheckJournal(string szPlotID);

// GetSkillName: Returns a string wih the name of a given
// skill if you pass the appropriate skill constant
string GetSkillName(int iSkill);

// SkillRoll: This function does a skill check and returns the
// final die roll amount. Returns 0 if the target doesn't
// have the skill and -1 if the target isn't valid.
int SkillRoll(int iSkill, object oTarget=OBJECT_SELF);

// SkillCheck: This function does a skill check against a given DC
// returns TRUE if the check succeeded else returns FALSE.
// returns FALSE if the target is invalid.
int SkillCheck(int iDC, int iSkill, object oTarget=OBJECT_SELF);

// GetAbilityName: Returns a string wih the name of a given
// ability if you pass the appropriate ability constant
string GetAbilityName(int iAbility);

// AbilityRoll: This function does an Ability check and returns
// the final result. Returns -1 if target isn't valid.
int AbilityRoll(int iAbility, object oTarget=OBJECT_SELF);

// AbilityCheck: This function does an Ability check against a given DC
// returns TRUE if the check succeeded else returns FALSE.
// returns FALSE if the target is invalid.
int AbilityCheck(int iDC, int iAbility, object oTarget=OBJECT_SELF);


// GetSavingThrowName: Returns a string wih the name of a given
// saving roll type if you pass the appropriate save constant for
string GetSavingThrowName(int iSaveType);


// SavingRoll: This function makes a saving roll and returns
// the final result. Returns -1 if target isn't valid.
int SavingRoll(int iSaveType, object oTarget=OBJECT_SELF);


// SendMessageToPlayer: Sends a message to a PC but blind
// copies all DMs. Can also be used to send a message to all players
// or to a player's party.
void SendMessageToPlayer(object oPlayer, string sMessage, int bAllParty=FALSE, int bAllPlayers=FALSE, int bOverHead=FALSE);

// SendMessageBroadcast: Sends a message to all PCs withing
// a certain distance from a given location.
// If a DC is include for iListenCheckDC then a player within the
// required distance will only receive the broadcast if they make a
// listen check for the given value DC.
void SendMessageBroadcast(location oLocation, string sMessage, float fRange, int iListenCheckDC = 0, int bOverHead=FALSE);

// GetNumberOfPCs: Returns the number of PCs in the module or area
// If you call the function with no parameters you'll get
// the number of PCs in the module. If you call it with
// an area then you'll get the number of PC's within the area
// passed.
int GetNumberOfPCs(object oArea=OBJECT_INVALID, int bMessageDM=TRUE);

// GetNumberOfPCsNearObject: Returns the number of PCs within
// a given range of an object
int GetNumberOfPCsNearObject(float fRange, object oTarget=OBJECT_SELF, int bMessageDM=TRUE);

// GetNumberOfPCsInParty: Returns the number of PCs in a PCs
// party (i.e. faction)
int GetNumberOfPCsInParty(object oPC, int bMessageDM=TRUE);

// GetHighestAbilityPC: Returns the PC with the highest Ability score
// over some given amount for a given area. If no PC has an
// ability score that high then returns OBJECT_INVALID
// bAllParty=TRUE will extend the search to include henchmen
object GetHighestAbilityPC(int iAbility, object oPartyMember, object oArea=OBJECT_INVALID, int iMinAbility=0, int iGender=GENDER_BOTH, int bAllParty=FALSE);


// Calls ClearAllActions for everyone in the party of oPC
void PartyClearAllActions(object oPC, int nClearCombatState=FALSE);

// Calls ActionJumpToObject for everyone in the party of oPC
void PartyActionJumpToObject(object oPC, object oToJumpTo);

// Calls ActionForceMoveToObject for everyone in the party of oPC
void PartyActionForceMoveToObject(object oPC, object oMoveTo, int bRun=FALSE, float fRange=1.0f, float fTimeout=30.0f);



// Bruce Nielson
// 10/2/2002
int GetIsRealPC(object oObject=OBJECT_SELF)
{
    object oPC = GetFirstPC();
    int bIsInPCList = FALSE;

    // object is not a valid object so it's obviously not a real PC
    if (!GetIsObjectValid(oObject)) return FALSE;

    while (GetIsObjectValid(oPC))
    {
        if(oPC == oObject)
        {
            // check to see if the object is this object in the PC list
            bIsInPCList = TRUE;
        }

        oPC = GetNextPC();
    }

    return bIsInPCList;
}






// Bruce Nielson
// 7/19/2002
object GetFirstRealPC()
{
    object oPC;
    oPC = GetFirstPC();
    while (GetIsObjectValid(oPC))
    {
        if (!GetIsDM(oPC))
            return oPC;
        oPC = GetNextPC();
    }
    return OBJECT_INVALID;
}



// Bruce Nielson
// 7/19/2002
object GetNearestRealPC(object oTarget = OBJECT_SELF, int bMessageDM=TRUE)
{
   object oPC;
   oPC = GetNearestCreature(CREATURE_TYPE_PLAYER_CHAR, PLAYER_CHAR_IS_PC, oTarget);

   while(GetIsObjectValid(oPC))
   {
       // if we found a valid PC (that isn't the DM nor a familiar) return it
       if (!GetIsDM(oPC))
       if (GetIsRealPC(oPC))
       {
            if (bMessageDM)
                SendMessageToAllDMs("Nearest PC to " + GetName(oTarget) + " is " + GetName(oPC));
            return oPC;
       }
       else
       {
            // else loop to next nearest PC
            oPC = GetNearestCreature(CREATURE_TYPE_PLAYER_CHAR, PLAYER_CHAR_IS_PC, oTarget, 2);

       }
   }
   // otherwise return an invalid object
   return OBJECT_INVALID;
}





// 11/4/2002
object GetFirstDM()
{
    object oPC = GetFirstPC();

    // loop through all real PCs until you find a DM
    while (GetIsObjectValid(oPC))
    {
        if (GetIsDM(oPC)) return oPC;
        oPC = GetNextPC();
    }
    return OBJECT_INVALID;
}




// Bruce Nielson
// 7/19/2002
void GiveXPToParty(int iXPAmount, object oPC, int bSplitXP = FALSE)
{
    object oPartyMember;

    // If we are spliting the XP then determine party size
    // and determine how much to give each party member
    if (bSplitXP)
    {
        iXPAmount = (iXPAmount / GetNumberOfPCsInParty(oPC));
    }

    // award experience to party
    oPartyMember = GetFirstFactionMember(oPC, TRUE);
    while (GetIsObjectValid(oPartyMember) == TRUE)
    {
        GiveXPToCreatureDH(oPC, iXPAmount);
        oPartyMember = GetNextFactionMember(oPC, TRUE);
    }

    // Inform the DMs
    SendMessageToAllDMs("Alert: XP Given to Party of " + GetName(oPC) + ": " + IntToString(iXPAmount));
}





// Bruce Nielson
// 10/9/2002
void AddToJournal(string szPlotID, int nState, int bGiveXP=FALSE, object oCreature=OBJECT_INVALID, int bAllPartyMembers=TRUE, int bAllPlayers=FALSE, int bAllowOverrideHigher=FALSE)
{
    // if no creature was passed then just find the nearest PC
    // to whoever called this function and use that
    // (but don't let it be a DM)
    if (!GetIsObjectValid(oCreature))
        oCreature = GetNearestRealPC();
    if (!GetIsObjectValid(oCreature))
        oCreature = GetFirstRealPC();
    if (GetIsDM(oCreature))
        oCreature = OBJECT_INVALID;

    // abort if oCreature is still not valid
    if (!GetIsObjectValid(oCreature)) return;

    // Add it to the journal
    AddJournalQuestEntry(szPlotID, nState, oCreature, bAllPartyMembers, bAllPlayers, bAllowOverrideHigher);

    // hand out experience if applicable
    int iXPAmount = GetJournalQuestExperience(szPlotID);
    if (bGiveXP) GiveXPToParty(iXPAmount, oCreature);

    // Alert DM that the journal entry has changed for the party
    SendMessageToAllDMs("Alert: Journal updated. Plot ID: " + szPlotID + ". State: " + IntToString(nState));
    // and update the First DMs journal so that he can read the text
    object oDM = GetFirstDM();
    if (GetIsObjectValid(oDM)) AddJournalQuestEntry(szPlotID, nState, oDM, TRUE, FALSE, bAllowOverrideHigher);

    // Set a variable on the module so that we remember that this
    // journal entry was marked in at least one person's journal
    // and if it's the new highest entry.
    if (GetLocalInt(GetModule(), "i" + szPlotID) < nState)
        SetLocalInt(GetModule(), "i" + szPlotID, nState);
}






// Bruce Nielson
// 11/5/2002
int CheckJournal(string szPlotID)
{
    return GetLocalInt(GetModule(), "i" + szPlotID);
}







// Bruce Nielson
// 10/15/2002
int SkillRoll(int iSkill, object oTarget=OBJECT_SELF)
{
    int iSkillRank, iDieRoll, iResult;


    if (!GetIsObjectValid(oTarget)) return -1;

    if (!GetHasSkill(iSkill, oTarget)) return 0;
    iSkillRank = GetSkillRank(iSkill, oTarget);
    iDieRoll = d20();
    iResult = iDieRoll + iSkillRank;

    SendMessageToAllDMs(GetName(oTarget) + " has made skill roll of " + IntToString(iResult) + " on skill number " + IntToString(iSkill));
    return iResult;
}




// Bruce Nielson
// 10/15/2002
int SkillCheck(int iDC, int iSkill, object oTarget=OBJECT_SELF)
{
    int iResult = TRUE;

    if (!GetIsObjectValid(oTarget)) return FALSE;

    if (!GetHasSkill(iSkill, oTarget)) return FALSE;
    iResult = SkillRoll(iSkill, oTarget);
    SendMessageToAllDMs("DC of " + IntToString(iDC));

    if (iResult >= iDC)
        return TRUE;
    else
        return FALSE;
}





// Bruce Nielson
// 2/17/2003
string GetSkillName(int iSkill)
{
    switch(iSkill)
    {
        case SKILL_ANIMAL_EMPATHY:
            return "ANIMAL EMPATHY";

        case SKILL_CONCENTRATION:
            return "CONCENTRATION";

        case SKILL_DISABLE_TRAP:
            return "DISABLE TRAP";

        case SKILL_DISCIPLINE:
            return "DISCIPLINE";

        case SKILL_HEAL:
            return "HEAL";

        case SKILL_HIDE:
            return "HIDE";

        case SKILL_LISTEN:
            return "LISTEN";

        case SKILL_LORE:
            return "LORE";

        case SKILL_MOVE_SILENTLY:
            return "MOVE SILENTLY";

        case SKILL_OPEN_LOCK:
            return "OPEN LOCK";

        case SKILL_PARRY:
            return "PARRY";

        case SKILL_PERFORM:
            return "PERFORM";

        case SKILL_PERSUADE:
            return "PERSUADE";

        case SKILL_PICK_POCKET:
            return "PICK POCKET";

        case SKILL_SEARCH:
            return "SEARCH";

        case SKILL_SET_TRAP:
            return "SET TRAP";

        case SKILL_SPELLCRAFT:
            return "SPELLCRAFT";

        case SKILL_SPOT:
            return "SPOT";

        case SKILL_TAUNT:
            return "TAUNT";

        case SKILL_USE_MAGIC_DEVICE:
            return "USE MAGIC DEVICE";

    }
    return "Invalid Skill";
}





// Bruce Nielson
// 12/1/2002
string GetAbilityName(int iAbility)
{
    switch(iAbility)
    {
        case ABILITY_CHARISMA:
            return "Charisma";

        case ABILITY_CONSTITUTION:
            return "Constitution";

        case ABILITY_DEXTERITY:
            return "Dexterity";

        case ABILITY_INTELLIGENCE:
            return "Intelligence";

        case ABILITY_STRENGTH:
            return "Strength";

        case ABILITY_WISDOM:
            return "Wisdom";

    }
    return "Invalid Ability";
}





// Bruce Nielson
// 10/15/2002
int AbilityRoll(int iAbility, object oTarget=OBJECT_SELF)
{
    int iAbilityMod, iDieRoll, iResult;

    if (!GetIsObjectValid(oTarget)) return -1;

    iAbilityMod = GetAbilityModifier(iAbility, oTarget);
    iDieRoll = d20();
    iResult = iDieRoll + iAbilityMod;

    SendMessageToAllDMs(GetName(oTarget) + " has made an ability roll of " + IntToString(iResult) + " on the " + GetAbilityName(iAbility) + " skill.");
    return iResult;
}





// Bruce Nielson
// 10/15/2002
int AbilityCheck(int iDC, int iAbility, object oTarget=OBJECT_SELF)
{
    if (!GetIsObjectValid(oTarget)) return FALSE;

    int iResult = AbilityRoll(iAbility, oTarget);
    SendMessageToAllDMs("DC of " + IntToString(iDC) + " for " + GetName(oTarget) );

    if (iResult >= iDC)
        return TRUE;
    else
        return FALSE;
}





// Bruce Nielson
// 2/17/2003
string GetSavingThrowName(int iSaveType)
{
    switch(iSaveType)
    {
        case SAVING_THROW_FORT:
            return "Fortitude";

        case SAVING_THROW_REFLEX:
            return "Reflex";

        case SAVING_THROW_WILL:
            return "Will";

    }
    return "Invalid Save Type";
}





// Bruce Nielson
// 2/17/2003
int SavingRoll(int iSaveType, object oTarget=OBJECT_SELF)
{
    int iSaveMod, iDieRoll, iResult;

    if (!GetIsObjectValid(oTarget)) return -1;

    switch(iSaveType)
    {
        case SAVING_THROW_FORT:
            iSaveMod = GetFortitudeSavingThrow(oTarget);
        break;


        case SAVING_THROW_REFLEX:
            iSaveMod = GetReflexSavingThrow(oTarget);
        break;


        case SAVING_THROW_WILL:
            iSaveMod = GetWillSavingThrow(oTarget);
        break;
    }
    iDieRoll = d20();
    iResult = iDieRoll + iSaveMod;

    SendMessageToAllDMs(GetName(oTarget) + " has made an saving roll of " + IntToString(iResult) + " on the " + GetSavingThrowName(iSaveType) + ".");
    return iResult;

}






// Bruce Nielson
// 10/16/2002
void SendMessageToPlayer(object oPlayer, string sMessage, int bAllParty=FALSE, int bAllPlayers=FALSE, int bOverHead=FALSE)
{
    if (bAllParty == FALSE && bAllPlayers == FALSE)
    {
        // send message to one player
        SendMessageToPC(oPlayer, sMessage);
        if (bOverHead)
            AssignCommand(oPlayer, SpeakString(sMessage));
        SendMessageToAllDMs("To " + GetName(oPlayer) + ": " + sMessage);
    }
    else if (bAllParty == TRUE)
    {
        // send message to all members of the party
        object oPartyMember;
        oPartyMember = GetFirstFactionMember(oPlayer, TRUE);
        while (GetIsObjectValid(oPartyMember) == TRUE)
        {
            SendMessageToPC(oPartyMember, sMessage);
            if (bOverHead)
                AssignCommand(oPlayer, SpeakString(sMessage));
            oPartyMember = GetNextFactionMember(oPlayer, TRUE);
        }
        SendMessageToAllDMs("To " + GetName(oPlayer) + "'s Party: " + sMessage);
    }
    else
    {
        // send message to all players of any party
        object oPC;
        oPC = GetFirstPC();
        while (GetIsObjectValid(oPC) == TRUE)
        {
            SendMessageToPC(oPC, sMessage);
            if (bOverHead)
                AssignCommand(oPlayer, SpeakString(sMessage));
            GetNextPC();
        }
        SendMessageToAllDMs("To All Players: " + sMessage);
    }
}





// Bruce Nielson
// 11/6/2002
void SendMessageBroadcast(location oLocation, string sMessage, float fRange, int iListenCheckDC = 0, int bOverHead=FALSE)
{
    // send message to all players of any party
    object oPC;
    oPC = GetFirstPC();
    int bSomeoneHeard = FALSE;

    while (GetIsObjectValid(oPC) == TRUE)
    {
        float fDistance = GetDistanceBetweenLocations(oLocation, GetLocation(oPC));
        if (!GetIsDM(oPC))
            if (fDistance <= fRange && fDistance >= 0.0)
            {
                // someone either heard the broadcast
                // or would have if they had made their listen check
                bSomeoneHeard = TRUE;

                if (iListenCheckDC == 0)
                {
                    SendMessageToPC(oPC, sMessage);
                    if (bOverHead)
                        AssignCommand(oPC, SpeakString(sMessage));
                }
                else if (SkillCheck(iListenCheckDC, SKILL_LISTEN, oPC))
                {
                    SendMessageToPC(oPC, sMessage);
                    if (bOverHead)
                        AssignCommand(oPC, SpeakString(sMessage));

                    // tell DM who specifically heard the broadcast
                    SendMessageToAllDMs(GetName(oPC) + " made listen check");
                }
            }
        oPC = GetNextPC();
    }

    // tell DM a broadcast was sent
    if (bSomeoneHeard)
        SendMessageToAllDMs("To Players within " + FloatToString(fRange) + "of specified location: " + sMessage);
}





// Bruce Nielson
// 10/19/2002
int GetNumberOfPCs(object oArea=OBJECT_INVALID, int bMessageDM=TRUE)
{
    object oPC = GetFirstPC();
    int iCount = 0;

    // if the area passed is invalid then return
    // the number of all PCs
    if (!GetIsObjectValid(oArea))
    {
        while (GetIsObjectValid(oPC))
        {
            if (!GetIsDM(oPC)) iCount++;
            oPC = GetNextPC();
        }

        if (bMessageDM)
            SendMessageToAllDMs("There are " + IntToString(iCount) + " PCs in the game.");
    }
    // else find only those in the area
    else
    {
        while (GetIsObjectValid(oPC))
        {
            if (!GetIsDM(oPC))
                if(GetArea(oPC) == oArea)
                    iCount++;
            oPC = GetNextPC();
        }

        if (iCount > 0 && bMessageDM)
        {
            SendMessageToAllDMs("There are " + IntToString(iCount) + " PCs  in Area " + GetName(oArea));
            //SendMessageToPC(GetFirstPC(),"There are " + IntToString(iCount) + " PCs  in Area " + GetName(oArea));
        }
    }

    return iCount;
}






// Bruce Nielson
// 10/19/2002
int GetNumberOfPCsNearObject(float fRange, object oTarget=OBJECT_SELF, int bMessageDM=TRUE)
{
    object oPC = GetFirstPC();
    int iCount = 0;
    int bSomeoneNear = FALSE;

    while (GetIsObjectValid(oPC))
    {
        if (!GetIsDM(oPC))
        {
            float fDistance = GetDistanceBetween(oTarget, oPC);

            if (fDistance <= fRange && fDistance >= 0.0)
            {
                iCount++;
                bSomeoneNear = TRUE;
            }
        }
        oPC = GetNextPC();
    }

    // alert DM if someone was near
    if (bSomeoneNear && bMessageDM)
        SendMessageToAllDMs("There are " + IntToString(iCount) + " PCs  within " + FloatToString(fRange) + " of " + GetName(oTarget));

    return iCount;
}




// Bruce Nielson
// 11/4/2002
int GetNumberOfPCsInParty(object oPC, int bMessageDM=TRUE)
{
    object oPartyMember = GetFirstFactionMember(oPC, TRUE);
    int iCount = 0;

    while (GetIsObjectValid(oPartyMember))
    {
        // debug
        // SendMessageToPC(GetFirstPC(), "Faction Member: " + GetName(oPartyMember)+" / "+GetTag(oPartyMember));
        if (!GetIsDM(oPC)) iCount++;
        oPartyMember = GetNextFactionMember(oPC, TRUE);
    }

    if (bMessageDM)
        SendMessageToAllDMs("There are " + IntToString(iCount) + " PCs in " + GetName(oPC) + "'s party.");
    // SendMessageToPC(GetFirstPC(), "There are " + IntToString(iCount) + " PCs in " + GetName(oPC) + "'s party.");
    return iCount;

}






// Bruce Nielson
// 11/30/2002
object GetHighestAbilityPC(int iAbility, object oPartyMember, object oArea=OBJECT_INVALID, int iMinAbility=0, int iGender=GENDER_BOTH, int bAllParty=FALSE)
{
    object oPC;
    object oTopPC = OBJECT_INVALID;
    int iTopAbility = 0;
    int iCurrentAbility = 0;

    // either start with the first PC or first party member depending on All party flag
    if (bAllParty)
        oPC = GetFirstFactionMember(oPartyMember);
    else
        oPC = GetFirstPC();

    while (GetIsObjectValid(oPC))
    {
        if (!GetIsDM(oPC))
            if(GetArea(oPC) == oArea || oArea == OBJECT_INVALID)
            {
                iCurrentAbility = GetAbilityScore(oPC, iAbility);
                if (iCurrentAbility >= iMinAbility)
                    if (iCurrentAbility > iTopAbility)
                        if (iGender == GENDER_BOTH ||
                            iGender == GetGender(oPC))
                {
                    iTopAbility = iCurrentAbility;
                    oTopPC = oPC;
                }
            }
        if (bAllParty)
            oPC = GetNextFactionMember(oPC, FALSE);
        else
            oPC = GetNextPC();
    }
    SendMessageToAllDMs("Highest " + GetAbilityName(iAbility) + " PC in " + GetName(oArea) + " is " + GetName(oTopPC));

    return oTopPC;
}




// Bruce Nielson
// 4/30/2003
void PartyClearAllActions(object oPC, int nClearCombatState=FALSE)
{
    object oPartyMember;

    oPartyMember = GetFirstFactionMember(oPC, TRUE);
    while (GetIsObjectValid(oPartyMember) == TRUE)
    {
        AssignCommand(oPartyMember, ClearAllActions(nClearCombatState));
        oPartyMember = GetNextFactionMember(oPC, TRUE);
    }
}


// Bruce Nielson
// 4/30/2003
void PartyActionJumpToObject(object oPC, object oToJumpTo)
{
    object oPartyMember;

    oPartyMember = GetFirstFactionMember(oPC, TRUE);
    while (GetIsObjectValid(oPartyMember) == TRUE)
    {
        if (oPartyMember != oToJumpTo)
            AssignCommand(oPartyMember, ActionJumpToObject(oToJumpTo));
        oPartyMember = GetNextFactionMember(oPC, TRUE);
    }
}



// Bruce Nielson
// 4/30/2003
void PartyActionForceMoveToObject(object oPC, object oMoveTo, int bRun=FALSE, float fRange=1.0f, float fTimeout=30.0f)
{
    object oPartyMember;

    oPartyMember = GetFirstFactionMember(oPC, TRUE);
    while (GetIsObjectValid(oPartyMember) == TRUE)
    {
        AssignCommand(oPartyMember, ActionForceMoveToObject(oMoveTo, bRun, fRange, fTimeout));
        oPartyMember = GetNextFactionMember(oPC, TRUE);
    }
}

