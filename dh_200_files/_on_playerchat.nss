// _on_playerchat

#include "mali_string_fns"
#include "sparky_inc"
#include "dmts_common_inc"


string ShowVector(vector vSomewhere)
{   string sVector = FloatToString(vSomewhere.x, 0, 2) + "x "
                   + FloatToString(vSomewhere.y, 0, 2) + "y "
                   + FloatToString(vSomewhere.z, 0, 2) + "z";
    return sVector;
}

vector StringToVector(string sVector)
{     float fLocX = StringToFloat(FirstWord(sVector, "x"));
      sVector = RestWords(sVector, "x");
      float fLocY = StringToFloat(FirstWord(sVector, "y"));
      sVector = RestWords(sVector, "y");
      float fLocZ = StringToFloat(FirstWord(sVector, "z"));

      return Vector(fLocX, fLocY, fLocZ);
}

string SparkyList(object oDB, string sListWhat)
{   int iEnc = 1;
    string sEnc = "nyah";
    string sEncVar;
    string sList;

    while (sEnc != "")
    { sEncVar = sListWhat + ((iEnc < 10) ? "_0" : "_") + IntToString(iEnc);
      sEnc = GetLocalString(oDB, sEncVar);
      if (sEnc != "")
      { sList += sEncVar + " = " + sEnc + "\n"; }
      iEnc++;
    }

    if (sList == "")
    { sList = "No matching variables found."; }

    return sList;
}

void main()
{
    object oPC = GetPCChatSpeaker();
    object oArea = GetArea(oPC);
    string sChat = GetPCChatMessage();
    object oTarget = GetLocalObject(oPC, "DM_Tool_Target");
    string sTargetLoc = GetLocalString(oPC, "DM_Tool_TargetLoc");

// If speaker is a possessed NPC, make note of that on the possessing DM
    if (GetIsDMPossessed(oPC))
    { SetLocalObject(GetMaster(oPC), "oPossessedNPC", oPC); }
    else if (GetIsDM(oPC))
    { DeleteLocalObject(oPC, "oPossessedNPC"); }


// Not a valid command
    if (GetStringLeft( sChat, 2) != "@@")
// Send it to the spy network
    { object oPlayer = GetFirstPC();
      string sSpyHeard = "(" + GetName(GetArea(oPC)) + ") " + GetName(oPC) + ": " + sChat;
      int iIsDM = 0;
      object oPossessedNPC;
      while (GetIsObjectValid(oPlayer))
      { iIsDM = (GetIsDM(oPlayer));
        oPossessedNPC = GetLocalObject(oPlayer, "oPossessedNPC");
        if (GetCampaignInt("dmfi", "dmfi_DMSpy", oPlayer) && iIsDM)
        { SendMessageToPC(oPlayer, sSpyHeard);
          if (GetMaster(oPossessedNPC) == oPlayer)
          { SendMessageToPC(oPossessedNPC, sSpyHeard); }
        }
        oPlayer = GetNextPC();
      }
    return;
    }


// It begins with @@, so let's not send it to everyone
    SetPCChatMessage();


    string sCommand = GetStringLowerCase(FirstWord(GetStringRight(sChat, GetStringLength(sChat) - 2)));
    string sParameter = RestWords(sChat);


// PC commands

    if (sCommand == "pclist")
    { ExecuteScript("zmal_pcl_list", oPC); return; }

    if ((sCommand == "time") && (sParameter == ""))
    { int iHour = GetTimeHour();
      int iMin = GetTimeMinute();
      int iSec = GetTimeSecond();

      string sTime = IntToString(iHour) + ((iMin < 10) ? ":0" : ":")
         + IntToString(iMin) + ((iSec < 10) ? ":0" : ":") + IntToString(iSec);
      SendMessageToPC(oPC, "Current time is  " + sTime);
      return;
    }


    if ( !(GetIsDM(oPC) || GetIsDMPossessed(oPC)))
    { SendMessageToPC(oPC, "ERROR: Invalid command."); return; }

// DM commands

// Commands that don't require a target


    if (sCommand == "help")
    { sParameter = GetStringLowerCase(sParameter);
      if (TestStringAgainstPattern("@@**", sParameter))
      { sParameter = RestWords(sParameter, "@@"); }
      string sHelp = "Valid commands: @@name, @@tag, @@retag, @@view, @@desc, @@app, @@deity, "
         + "@@shop, @@infinite, @@makeshop, @@copyshop, @@clone, @@dmspy, "
         + "@@copyfrom, @@copyto, @@time, @@location, @@findtag, @@sparky, "
         + "@@scribble, @@editdesc, @@swapdesc";
      if (sParameter == "name")
      { sHelp = "@@name NewName: Renames the target.\n"
              + "@@name: With no parameter, resets the name to the original."; }
      else if (sParameter == "tag")
      { sHelp = "@@tag: Displays the target's tag."; }
      else if (sParameter == "retag")
      { sHelp = "@@retag: Changes the tag of placeables and items."; }
      else if (sParameter == "view")
      { sHelp = "@@view: View the target's current description."; }
      else if (sParameter == "desc")
      { sHelp = "@@desc NewDesc: Changes the target's description.  Use %n for a carriage return.\n"
              + "@@desc: With no parameter, resets the description."; }
      else if (sParameter == "app")
      { sHelp = "@@app: Displays the target's appearance number.\n"
              + "@@app AppNumber: Change the target's appearance."; }
      else if (sParameter == "deity")
      { sHelp = "@@deity: Display the target's deity.\n"
              + "@@deity NewDeity: Change the target's deity."; }
      else if (sParameter == "time")
      { sHelp = "@@time: Displays the current time.\n"
              + "@@time hour:min:sec : Sets the current time."; }
      else if (sParameter == "dmspy")
      { sHelp = "@@dmspy: Toggles the status of the DM Spy Network, which "
              + "reports anything said anywhere on the server."; }
      else if (sParameter == "clone")
      { sHelp = "@@clone Copies: Makes the specified number of copies of the target."
              + "  Copies defaults to 1."; }
      else if (sParameter == "copyfrom")
      { sHelp = "@@copyfrom: Copies items from the first container you "
              + " target to the second container you target."; }
      else if (sParameter == "copyto")
      { sHelp = "@@copyto: Copies items from the second container you "
              + " target to the first container you target."; }
      else if (sParameter == "makeshop")
      { sHelp = "@@makeshop: Opens a new store for the target NPC."
              + "  Must already be set up with a merchant conversation.\n"
              + "@@makeshop ShopTag: Attempts to set up a shop for the targeted"
              + " NPC with the specified ShopTag.  Use with stores on the pallete.\n"
              + "(shop commands only work if the shop has a tag of the form Shop_NPCtag)"; }
      else if (sParameter == "copyshop")
      { sHelp = "@@copyshop: Copy the target NPC's shop to your current location.\n"
              + "@@copyshop NewTag: Copy the target NPC's shop, and change "
              + "its tag to NewTag.\n"
              + "(shop commands only work if the shop has a tag of the form Shop_NPCtag)"; }
      else if (sParameter == "shop")
      { sHelp = "@@shop: Open the target NPC's store.\n"
              + "(shop commands only work if the shop has a tag of the form Shop_NPCtag)"; }
      else if (sParameter == "infinite")
      { sHelp = "@@infinite: Sets a shop item to an infinite supply."; }
      else if (sParameter == "finite")
      { sHelp = "@@finite: Sets a shop item to a finite supply."; }
      else if (sParameter == "sparky")
      { sHelp = "@@sparky despawn: Removes all Sparky spawns from the area.\n"
              + "@@sparky force despawn: If the spawn script was aborted, or"
              + " creatures were spawned from the DM Encounter Spawn widget,"
              + " this command should despawn them when @@sparky despawn cannot.\n"
              + "@@sparky spawn: Removes any current Sparky spawns, and after a 2"
              + " second delay, forces the spawns to activate.\n"
              + "@@sparky list encounters: Lists the encounter variables on the current area.\n"
              + "@@sparky list table TableName: Lists the specified table.\n"
              + "@@sparky list group GroupName: Lists the specified group."
              + "After targeting a Sparky Spawn trigger, you may use these commands:\n"
              + "@@sparky trigger spawn: Removes any current Sparky spawns, and after a 2"
              + " second delay, forces the spawns on the trigger to activate.\n"
              + "@@sparky trigger list encounters: Lists the encounter variables on the trigger.\n"
              + "@@sparky trigger list table TableName: Lists the specified table.\n"
              + "@@sparky trigger list group GroupName: Lists the specified group."; }
      else if (sParameter == "location")
      { sHelp = "@@location: Shows your current coordinates and facing."; }
      else if (sParameter == "findtag")
      { sHelp = "@@findtag Tag: Displays the location (area and coordinates) of"
              + " all objects with the tag Tag.  If the object is on a creature"
              + " or in a container, the name of the creature/container will be"
              + " displayed as well."; }
      else if (sParameter == "scribble")
      { sHelp = "@@scribble Message: Writes the specified message on the floor "
              + "at the targeted location.  A stage manager widget is provided, "
              + "ready to be boxed up."; }
      else if (sParameter == "editdesc")
      { sHelp = "@@editdesc Delimiter SearchFor<Delimiter>ReplaceWith\n"
              + "Replaces all occurances of SearchFor with ReplaceWith in target's"
              + " description."; }
      else if (sParameter == "swapdesc")
      { sHelp = "@@swapdesc\nSwaps the identified and unidentified descriptions of the target."; }

      SendMessageToPC(oPC, sHelp);
      return;
    }


    if (sCommand == "location")
    { SendMessageToPC(oPC, "Your location is: " + ShowVector(GetPosition(oPC))
            + ", facing " + FloatToString(GetFacing(oPC), 0,0));
      return;
    }

    if (sCommand == "findtag")
    { object oFindee = oPC;
      object oPossessor = oPC;
      string sFindeeLocs = "";

      int iLoop = 0;
      while (GetIsObjectValid(oFindee))
      { oFindee = GetObjectByTag(sParameter, iLoop);
        if (GetIsObjectValid(oFindee))
        { oPossessor = GetItemPossessor(oFindee);
          if (GetIsObjectValid(oPossessor))
          { sFindeeLocs += "\n" + GetName(GetArea(oPossessor)) + ": "
                        + ShowVector(GetPosition(oPossessor)) + " on "
                        + GetName(oPossessor);
          }
          else
          { sFindeeLocs += "\n" + GetName(GetArea(oFindee)) + ": "
                        + ShowVector(GetPosition(oFindee));
          }
        iLoop++;
        }
      }

      if (iLoop = 0)
      { SendMessageToPC(oPC, "Nothing found."); }
      else
      { SendMessageToPC(oPC, "Locations for tag " + sParameter + ":" + sFindeeLocs); }

      return;
    }

    if (sCommand == "dmspy")
    { int iDMSpy = GetCampaignInt("dmfi", "dmfi_DMSpy", oPC);
      int iToggle = abs(iDMSpy - 1);
      SetCampaignInt("dmfi", "dmfi_DMSpy", iToggle, oPC);
      string sStatus = iToggle ? "on" : "off";
      SendMessageToPC(oPC, "DM Spy network " + sStatus + ".");
      return;
    }

    if (sCommand == "time")
    { if (sParameter != "")
      { if (TestStringAgainstPattern("*n:*n:*n", sParameter))
        { int iHour = StringToInt(FirstWord(sParameter, ":"));
          sParameter = RestWords(sParameter, ":");

          int iMin = StringToInt(FirstWord(sParameter, ":"));
          sParameter = RestWords(sParameter, ":");

          int iSec = StringToInt(FirstWord(sParameter, ":"));
          sParameter = RestWords(sParameter, ":");

          SetTime(iHour, iMin, iSec, 0);
        }
        else
        { SendMessageToPC(oPC, "ERROR: Invalid time format."); return; }
      }

      int iHour = GetTimeHour();
      int iMin = GetTimeMinute();
      int iSec = GetTimeSecond();

      string sTime = IntToString(iHour) + ((iMin < 10) ? ":0" : ":")
         + IntToString(iMin) + ((iSec < 10) ? ":0" : ":") + IntToString(iSec);
      SendMessageToPC(oPC, "Current time is  " + sTime);
      return;
    }

    if (sCommand == "sparky")
    { sParameter = GetStringLowerCase(sParameter);
      if (sParameter == "despawn")
      { SendMessageToPC(oPC, "Despawning...");
        Despawn(oArea);
        return;
      }
      if (sParameter == "force despawn")
      { SendMessageToPC(oPC, "Forcing a despawn...");
        SetLocalInt(oArea, "iSparkySpawned", TRUE);
        Despawn(oArea);
        return;
      }

      object oDB = oArea;
      if (FirstWord(sParameter) == "trigger")
      { if ( !( (GetObjectType(oTarget) == OBJECT_TYPE_TRIGGER) && (GetLocalInt(oTarget, "iSparkyTrigger")) ))
        { SendMessageToPC(oPC, "ERROR: Target is not a Sparky Spawn trigger!"); return; }

        sParameter = RestWords(sParameter);
        oDB = oTarget;
      }

      if ((sParameter == "respawn") || (sParameter == "spawn"))
      { SendMessageToPC(oPC, "Spawning...");
        Despawn(oArea);
        DelayCommand(2.0f, SpawnEncounters(oDB));
        return;
      }
      if (FirstWord(sParameter) == "list")
      { sParameter = RestWords(sParameter);
        string sListWhat = FirstWord(sParameter);
        sParameter = FirstWord(RestWords(sParameter));
        if (sListWhat == "encounters")
        { SendMessageToPC(oPC, SparkyList(oDB, "encounter")); return; }
        if ((sListWhat != "table") && (sListWhat != "group"))
        { SendMessageToPC(oPC, "ERROR: Invalid Sparky list command."); return; }
        if (sParameter == "")
        { SendMessageToPC(oPC, "ERROR: No " + GetStringLowerCase(sListWhat) + " name supplied."); return; }

        SendMessageToPC(oPC, SparkyList(oDB, GetStringLowerCase(sListWhat + "_" + sParameter)));
        return;
      }

      SendMessageToPC(oPC, "ERROR: Invalid Sparky command."); return;
    }

    if (sCommand == "areavar")
    { string sVarType = GetStringLowerCase(FirstWord(sParameter));
      string sParameter2 = RestWords(sParameter);
      string sVarName = FirstWord(sParameter2);
      sParameter2 = RestWords(sParameter2);

      if (sVarName == "")
      { SendMessageToPC(oPC, "ERROR: No variable name supplied."); return; }

      if (sVarType == "int")
      { int iValue = StringToInt(sParameter2);
        SetLocalInt(oArea, sVarName, iValue);
        SendMessageToPC(oPC, "Variable " + sVarName + " set to: " + IntToString(iValue));
        return;
      }
      if (sVarType == "float")
      { float fValue = StringToFloat(sParameter2);
        SetLocalFloat(oArea, sVarName, fValue);
        SendMessageToPC(oPC, "Variable " + sVarName + " set to: " + FloatToString(fValue));
        return;
      }
      if (sVarType == "string")
      { SetLocalString(oArea, sVarName, sParameter2);
        SendMessageToPC(oPC, "Variable " + sVarName + " set to: " + sParameter2);
        return;
      }
    }


    if ((sCommand == "scribble") || (sCommand == "scribblewall"))
    { if (sTargetLoc == "")
      { SendMessageToPC(oPC, "ERROR: Target a location first!"); return; }

      vector vStart = StringToVector(sTargetLoc);
      float fTheta = GetTheta(GetPosition(oPC), vStart);
      location lStartLoc = Location(oArea, vStart, fTheta);

      if (sParameter == "")
      { object oMarker = GetObjectByTag("ScribbleMarker_" + ObjectToString(oPC));
        if (GetIsObjectValid(oMarker))
        { DestroyObject(oMarker);
          SendMessageToPC(oPC, "Marker removed.");
        }
        else
        { SendMessageToPC(oPC, "Creating marker...");
          oMarker = CreateObject(OBJECT_TYPE_PLACEABLE, "zep_os_sar_001", lStartLoc, FALSE, "ScribbleMarker_" + ObjectToString(oPC));
          if (sCommand == "scribblewall")
          { SetLocalInt(oMarker, "iPlayAnimation", ANIMATION_PLACEABLE_CLOSE);
            ExecuteScript("playanimation", oMarker);
          }
        }
        return;
      }

      string sAlphabet_LC = "abcdefghijklmnopqrstuvwxyz";
      string sAlphabet_UC = GetStringUpperCase(sAlphabet_LC);
      string sNumbers = "0123456789";
      string sSpecial = ".,-";
      string sSpecialTag = "pdcmds";
      string sLetter;

      int iPlayAnimation = 0;
      object oMarker = GetObjectByTag("ScribbleMarker_" + ObjectToString(oPC));
      if (GetIsObjectValid(oMarker))
      { lStartLoc = GetLocation(oMarker);
        iPlayAnimation = GetLocalInt(oMarker, "iPlayAnimation");
        fTheta = GetFacing(oMarker);
        DestroyObject(oMarker);
      }
      else
      { SendMessageToPC(oPC, "WARNING: Marker not found. Using target location..."); }

      location lLoc = lStartLoc;

      object oSM_widget = CreateItemOnObject("mali_dm_stage", oPC);
      if (!GetIsObjectValid(oSM_widget))
      { SendMessageToPC(oPC, "Warning: Could not create a stage manager widget..."); }

      object oLetter;
      int iLoop;
      for (iLoop = 0; iLoop < GetStringLength(sParameter); iLoop++)
      { sLetter = GetSubString(sParameter, iLoop, 1);
        if (FindSubString(sAlphabet_LC + sNumbers, sLetter) != -1)
        { oLetter = CreateObject(OBJECT_TYPE_PLACEABLE, "zep_os_sn" + sLetter + "_001", lLoc);
          if (iPlayAnimation)
          { SetLocalInt(oLetter, "iPlayAnimation", iPlayAnimation);
            ExecuteScript("playanimation", oLetter);
          }
          lLoc = Location(oArea, GetChangedPosition(GetPositionFromLocation(lLoc), 0.25f, fTheta - 90.0f), fTheta);
          if (GetIsObjectValid(oSM_widget))
          { SetLocalObject(oSM_widget, "oProp" + IntToString(iLoop + 1), oLetter);
            SetLocalInt(oSM_widget, "iProp" + ObjectToString(oLetter), iLoop + 1);
            SetLocalInt(oSM_widget, "iPropIndex", iLoop + 1);
          }
        }
        else if (FindSubString(sAlphabet_UC, sLetter) != -1)
        { oLetter = CreateObject(OBJECT_TYPE_PLACEABLE, "zep_os_sn" + GetStringLowerCase(sLetter) + "_002", lLoc);
          if (iPlayAnimation)
          { SetLocalInt(oLetter, "iPlayAnimation", iPlayAnimation);
            ExecuteScript("playanimation", oLetter);
          }
          lLoc = Location(oArea, GetChangedPosition(GetPositionFromLocation(lLoc), 0.25f, fTheta - 90.0f), fTheta);
          if (GetIsObjectValid(oSM_widget))
          { SetLocalObject(oSM_widget, "oProp" + IntToString(iLoop + 1), oLetter);
            SetLocalInt(oSM_widget, "iProp" + ObjectToString(oLetter), iLoop + 1);
            SetLocalInt(oSM_widget, "iPropIndex", iLoop + 1);
          }
        }
        else if (FindSubString(sSpecial, sLetter) != -1)
        { oLetter = CreateObject(OBJECT_TYPE_PLACEABLE, "zep_os_s" + GetSubString(sSpecialTag, FindSubString(sSpecial, sLetter) * 2, 2) + "_001", lLoc);
          if (iPlayAnimation)
          { SetLocalInt(oLetter, "iPlayAnimation", iPlayAnimation);
            ExecuteScript("playanimation", oLetter);
          }
          lLoc = Location(oArea, GetChangedPosition(GetPositionFromLocation(lLoc), 0.25f, fTheta - 90.0f), fTheta);
          if (GetIsObjectValid(oSM_widget))
          { SetLocalObject(oSM_widget, "oProp" + IntToString(iLoop + 1), oLetter);
            SetLocalInt(oSM_widget, "iProp" + ObjectToString(oLetter), iLoop + 1);
            SetLocalInt(oSM_widget, "iPropIndex", iLoop + 1);
          }
        }
        else
        { lLoc = Location(oArea, GetChangedPosition(GetPositionFromLocation(lLoc), 0.5f, fTheta - 90.0f), fTheta); }
      }

      if (GetIsObjectValid(oSM_widget))
      { SetName(oSM_widget, "The Moving Finger");
        SetDescription(oSM_widget, "Use this stage manager widget to enscribe the following message on the floor:\n\n" + sParameter);
      }

      return;
    }

// Commands that require a target


    if (!GetIsObjectValid(oTarget))
    { SendMessageToPC(oPC, "ERROR: Invalid target!"); return; }

    string sTargetName = GetName(oTarget);


    if (sCommand == "setstring")
    { string sVarName = FirstWord(sParameter);
      sParameter = RestWords(sParameter);
      if (sParameter == "")
      { SendMessageToPC(oPC, "ERROR: No variable name supplied!"); return; }
      SetLocalString(oTarget, sVarName, sParameter);
      SendMessageToPC(oPC, "Set.");
      return;
    }

    if (sCommand == "areavar")
    { string sVarType = GetStringLowerCase(FirstWord(sParameter));
      string sParameter2 = RestWords(sParameter);
      string sVarName = FirstWord(sParameter2);

      if (sVarType != "object")
      { SendMessageToPC(oPC, "ERROR: Invalid variable type."); return; }

      SetLocalObject(oArea, sVarName, oTarget);
      SendMessageToPC(oPC, "Variable " + sVarName + " set to: " + sTargetName);
      return;
    }

    if (sCommand == "name")
    { if( GetIsDM(oTarget) || GetIsPC(oTarget))
      { SendMessageToPC(oPC, "ERROR: You can't rename a PC or DM."); return; }
      else
      { SetName(oTarget, sParameter);
        SendMessageToPC(oPC, sTargetName + "'s name set to: " + GetName(oTarget));
        return;
      }
    }

    if (sCommand == "view")
    { SendMessageToPC(oPC, sTargetName + "'s Description:\n" + GetDescription(oTarget)); return; }

    if (sCommand == "desc")
    { SetDescription(oTarget, SearchAndReplace(sParameter, "%n", "\n")); return; }

    if (sCommand == "editdesc")
    { string sDesc = GetDescription(oTarget);
      string sDelimiter = FirstWord(sParameter);
      sParameter = RestWords(sParameter);
      string sSearch = FirstWord(sParameter, sDelimiter);
      string sReplace = RestWords(sParameter, sDelimiter);

      SetDescription(oTarget, SearchAndReplace(sDesc, sSearch, sReplace));
      return;
    }

    if (sCommand == "swapdesc")
    { string sDesc = GetDescription(oTarget);
      SetDescription(oTarget, GetDescription(oTarget, FALSE, FALSE));
      SetDescription(oTarget, sDesc, FALSE);
      return;
    }

    if (sCommand == "app")
    { int iApp = StringToInt(sParameter);

      if (GetObjectType(oTarget) != OBJECT_TYPE_CREATURE)
      { SendMessageToPC(oPC, "ERROR: Invalid target. NPCs, players, or DMs only."); return; }
      if (sParameter == "")
      { SendMessageToPC(oPC, sTargetName + "'s appearance: " + IntToString(GetAppearanceType(oTarget))); return; }
      if ( ((sParameter != "0") && (iApp == 0)) || (iApp < 0) )
      { SendMessageToPC(oPC, "ERROR: Appearance must be a non-negative integer!"); return; }
      SetCreatureAppearanceType(oTarget, iApp); return;
    }

    if (sCommand == "deity")
    { if (GetObjectType(oTarget) != OBJECT_TYPE_CREATURE)
      { SendMessageToPC(oPC, "ERROR: Invalid target."); return; }
      if (sParameter == "")
      { SendMessageToPC(oPC, sTargetName + "'s deity: " + GetDeity(oTarget)); return; }
      else
      { SetDeity(oTarget, sParameter);
        SendMessageToPC(oPC, sTargetName + "'s deity set to: " + GetDeity(oTarget));
        return;
      }
    }

    if (sCommand == "tag")
    { SendMessageToPC(oPC, sTargetName + "'s tag: " + GetTag(oTarget)); return; }

    if (sCommand == "retag")
    { if (GetObjectType(oTarget) == OBJECT_TYPE_PLACEABLE)
      { location lTargetLocation = GetLocation(oTarget);
        oTarget = RecreateObjectAtLocation(oTarget, lTargetLocation, sParameter);
        SetLocalInt(oTarget, "iRetagged", TRUE);
        SetLocalObject(oPC, "DM_Tool_Target", oTarget);
        SendMessageToPC(oPC, sTargetName + "'s tag is now: " + GetTag(oTarget));
        return;
       }
       else if (GetObjectType(oTarget) == OBJECT_TYPE_ITEM)
       { object oNewItem = CopyObject(oTarget, GetLocation(oPC), oPC, sParameter);
         if (GetIsObjectValid(oNewItem))
         { DestroyObject(oTarget);
           SendMessageToPC(oPC, sTargetName + "'s tag is now: " + GetTag(oNewItem));
           SetLocalObject(oPC, "DM_Tool_Target", oNewItem);
           return; }
         else
         { SendMessageToPC(oPC, "ERROR: Item not retagged. Reason unknown."); return; }
       }
       else
       { SendMessageToPC(oPC, "ERROR: Only placeables and items may be retagged."); return; }
    }

    if (sCommand == "shop")
    { if (GetObjectType(oTarget) == OBJECT_TYPE_STORE)
      { OpenStore(oTarget, oPC); return; }
      if (GetIsPC(oTarget) || !(GetObjectType(oTarget) == OBJECT_TYPE_CREATURE))
      { SendMessageToPC(oPC, "ERROR: Not an NPC!"); return; }
      object oStore = GetNearestObjectByTag("Store_" + GetTag(oTarget), oTarget);
      if (!GetIsObjectValid(oStore) || (GetObjectType(oStore) != OBJECT_TYPE_STORE))
      { SendMessageToPC(oPC, "ERROR: Could not find store!"); return; }
      else
      { OpenStore(oStore, oPC); return; }
    }

    if (sCommand == "infinite")
    { if (GetObjectType(oTarget) != OBJECT_TYPE_ITEM)
      { SendMessageToPC(oPC, "ERROR: Must target an item!"); return; }
      else if (GetObjectType(GetItemPossessor(oTarget)) != OBJECT_TYPE_STORE)
      { SendMessageToPC(oPC, "ERROR: Must target an item in a store!"); return; }
      else
      { SetInfiniteFlag(oTarget);
        SendMessageToPC(oPC, sTargetName + " is now set infinite."); return; }
    }

    if (sCommand == "finite")
    { if (GetObjectType(oTarget) != OBJECT_TYPE_ITEM)
      { SendMessageToPC(oPC, "ERROR: Must target an item!"); return; }
      else if (GetObjectType(GetItemPossessor(oTarget)) != OBJECT_TYPE_STORE)
      { SendMessageToPC(oPC, "ERROR: Must target an item in a store!"); return; }
      else
      { SetInfiniteFlag(oTarget, FALSE);
        SendMessageToPC(oPC, sTargetName + " is now set finite."); return; }
    }

    if (sCommand == "makeshop")
    { if (GetIsPC(oTarget) || !(GetObjectType(oTarget) == OBJECT_TYPE_CREATURE))
      { SendMessageToPC(oPC, "ERROR: Not an NPC!"); return; }
      string sStoreTag = "Store_" + GetTag(oTarget);
      string sStoreResRef = sStoreTag;
      if (sParameter != "")
      { sStoreResRef = sParameter; }
      object oStore = CreateObject(OBJECT_TYPE_STORE, sStoreResRef, GetLocation(oPC), FALSE, sStoreTag);
      if (!GetIsObjectValid(oStore))
      { oStore = CreateObject(OBJECT_TYPE_STORE, "Empty_Store", GetLocation(oPC), FALSE, sStoreTag); }
      if (GetIsObjectValid(oStore))
      { SetLocalObject(oPC, "DM_Tool_Target", oStore);
        SendMessageToPC(oPC, "New target: " + GetName(oStore) + "\nTag: " + GetTag(oStore));
        return;
      }
      else
      { SendMessageToPC(oPC, "ERROR: Store not created. Reason unknown."); return; }
    }

    if (sCommand == "copyshop")
    { if (GetIsPC(oTarget) || !(GetObjectType(oTarget) == OBJECT_TYPE_CREATURE))
      { SendMessageToPC(oPC, "ERROR: Not an NPC!"); return; }
      object oStore = GetNearestObjectByTag("Store_" + GetTag(oTarget), oTarget);
      if (!GetIsObjectValid(oStore) || (GetObjectType(oStore) != OBJECT_TYPE_STORE))
      { SendMessageToPC(oPC, "ERROR: Could not find store!"); return; }
      string sStoreName = GetName(oStore);
      string sStoreTag = GetTag(oStore);
      if (!(sParameter == ""))
      { sStoreTag = sParameter; }
      object oNewStore = CreateObject(OBJECT_TYPE_STORE, "Empty_Store", GetLocation(oPC), FALSE, sStoreTag);
      if (GetIsObjectValid(oNewStore))
      { object oMerchandise = GetFirstItemInInventory(oStore);
        while (GetIsObjectValid(oMerchandise))
        { if (GetInfiniteFlag(oMerchandise))
          { CopyItem(oMerchandise, oNewStore, TRUE); }
          oMerchandise = GetNextItemInInventory(oStore);
        }
        SetName(oNewStore, sStoreName);
        SetLocalObject(oPC, "DM_Tool_Target", oNewStore);
        SendMessageToPC(oPC, "New target: " + GetName(oNewStore) + "\nTag: " + GetTag(oNewStore));
        return;
      }
      else
      { SendMessageToPC(oPC, "ERROR: Store not created. Reason unknown."); return; }
    }

    if (sCommand == "clone")
    { if ( !((GetObjectType(oTarget) == OBJECT_TYPE_ITEM) || (GetObjectType(oTarget) == OBJECT_TYPE_CREATURE)))
      { SendMessageToPC(oPC, "ERROR: You may only clone items and creatures."); return; }
      int iCopies = StringToInt(sParameter);
      if (sParameter == "")
      { iCopies = 1; }
      if (iCopies < 1)
      { SendMessageToPC(oPC, "ERROR: Number of copies must be an integer greater than zero!"); return; }
      int iLoop = 0;
      while (iLoop < iCopies)
      {   if (GetObjectType(oTarget) == OBJECT_TYPE_ITEM)
          { CopyObject(oTarget, GetLocation(oPC), oPC); }
          else
          { CopyObject(oTarget, GetLocation(oTarget)); }
          iLoop++;
      }
      return;
    }

    if ((sCommand == "copyfrom") || (sCommand == "copyto"))
    { object oSource;
      object oDest;
      object oThingie;

      if (sCommand == "copyfrom")
      { oSource = GetLocalObject(oPC, "oDM_Bag1");
        oDest = GetLocalObject(oPC, "oDM_Bag2");
      }
      else
      { oSource = GetLocalObject(oPC, "oDM_Bag2");
        oDest = GetLocalObject(oPC, "oDM_Bag1");
      }

      if (!GetIsObjectValid(oSource) || !GetIsObjectValid(oDest))
      { SendMessageToPC(oPC, "ERROR: Invalid target. Re-target both containers."); return; }
      if (!GetHasInventory(oSource) || !GetHasInventory(oDest))
      { SendMessageToPC(oPC, "ERROR: Command may only be used with containers."); return; }

      CopyContents(oSource, oDest, sParameter);

      return;
    }


// Doesn't match anything

    SendMessageToPC(oPC, "ERROR: Invalid command.");
}

