//*********************************
// Filename:  horse_include
/*
    Based on Rideable Horses by
    DG & NIC/AB rideables

    Created by Gregg Anderson
    11 / 2 / 2005

    Version 1.0b FINAL - 11/11/06

    Included as part of the Hylis PW Server
*/
//**  INCLUDES  *********************
#include "zep_inc_phenos"
#include "x0_i0_position"
#include "horse_defaults"

//**  FUNCTION DECLARATIONS  ********
void GPA_ActivateHorseIcon(object oPC, object oItem);
void GPA_SummonHorse(object oPC, object oItem);
void GPA_MountHorse(object oPC, object oMount);
void GPA_DismountHorse(object oPC);
void GPA_FallOnGround(object oPC);
int GPA_GetIsHench(object oPC, object oHorse);
void GPA_OnRest(object oPC);
void GPA_HorseOCE(object oPC);
void GPA_HorseOCL(object oPC);
object GPA_InitializeIcon(object oPC, object oIcon);
void GPA_HorseDiedInventoryMove(object oHorse);
void GPA_OnActivate(object oPC,object oItem);
object GPA_Dismount(object oPC, string sRemoveItem_ResRef="");
void GPA_OnAreaTransition(object oPC,object oMount);
void GPA_HorseHench(object oPC);
int GetNumHenchmen(object oPC);


//**  FUNCTION DEFINITIONS  ********

//////////////////////////////////////////////////////////////////
void GPA_ActivateHorseIcon(object oPC, object oItem)
/*
    A horse or pony may only be summoned up if the PC activating
    a horses corresponding Horse Icon is within a designated
    stables area.  There are three ways to trigger this response:
    1.  Put a variable on the area called "stables" and set it to 1.
    2.  Place a Trigger that the PC can enter. Found in the custom
        trigger pallette.
    3.  Have a DM give a PC the Horse Summon Override.  This is useful
        in the cases where there was a crash and PCs are no longer
        near a stables area.
*/
//////////////////////////////////////////////////////////////////
{
    int nOverride;

    if(GetItemPossessedBy(oPC,"horseoverride")!=OBJECT_INVALID)
        nOverride = 1;

    if((GetLocalInt(GetArea(oPC),"stables")==1)||(GetLocalInt(oPC,"stables")==1)||(nOverride==1))
        GPA_SummonHorse(oPC, oItem);
    else
        SendMessageToPC(oPC,HORSE_STABLES);
}  // end function


//////////////////////////////////////////////////////////////////
void GPA_SummonHorse(object oPC, object oIcon)
//////////////////////////////////////////////////////////////////
{
    string sIconTag = GetTag(oIcon);
    string sResRef = GetStringLeft(sIconTag,12) + "0";

    int nHorseSummon = GetLocalInt(oIcon,"HorseSummon");

    if(nHorseSummon == 0)
    {
        int nMaxHenchmen = GetMaxHenchmen();
        int i;
        for (i=1; i<= nMaxHenchmen; i++)
        {
            if (GetTag(GetHenchman(oPC,i)) == sIconTag)
                return;
        }  // end for loop

        location  lPC = GetLocation(oPC);
        int nObjectType = OBJECT_TYPE_CREATURE;
        object oHorse = CreateObject(nObjectType, sResRef, lPC, TRUE, sIconTag);

        SetLocalObject(oPC,"pc_mount",oHorse);
        SetLocalInt(oIcon,"HorseSummon",1);
        AddHenchman(oPC, oHorse);
    }
} // end function


//////////////////////////////////////////////////////////////////
void GPA_MountHorse(object oPC, object oMount)
//////////////////////////////////////////////////////////////////
{
    object oRightHand = GetItemInSlot(INVENTORY_SLOT_RIGHTHAND,oPC);
    object oLeftHand = GetItemInSlot(INVENTORY_SLOT_LEFTHAND,oPC);

    AssignCommand(oPC,ActionUnequipItem(oRightHand));
    AssignCommand(oPC,ActionUnequipItem(oLeftHand));

    float fWalk_Speed;
    int nAppearance = GetAppearanceType(oMount);

    switch (nAppearance)
    {
    case 1855:
        fWalk_Speed = fSPEED_PONY_SPOT;
      break;
    case 1856:
        fWalk_Speed = fSPEED_PONY_BROWN;
      break;
    case 1857:
        fWalk_Speed = fSPEED_PONY_LTBROWN;
      break;
    case 1858:
        fWalk_Speed = fSPEED_HORSE_BROWN;
      break;
    case 1859:
        fWalk_Speed = fSPEED_HORSE_WHITE;
      break;
    case 1860:
        fWalk_Speed = fSPEED_HORSE_BLACK;
      break;
    case 1861:
        fWalk_Speed = fSPEED_HORSE_NIGHTMARE;
      break;
    case 1862:
        fWalk_Speed = fSPEED_AURENTHIL;
      break;
    default:
        fWalk_Speed = 2.2;
     break;
    }

    zep_Mount(oPC, oMount, 0, fWalk_Speed, "dismount");
    RemoveHenchman(oPC, oMount);
}  // end function


//////////////////////////////////////////////////////////////////
void GPA_DismountHorse(object oPC)
//////////////////////////////////////////////////////////////////
{
    object oMount = GPA_Dismount(oPC, "dismount");

    if(oMount != OBJECT_INVALID)
    {
        string sIconTag = GetTag(oMount);
        string sResRef = GetStringLeft(sIconTag,12) + "0";

        RemoveHenchman(oPC,oMount);
        AssignCommand(oMount,SetIsDestroyable(TRUE,FALSE,FALSE));
        DestroyObject(oMount);
        DeleteLocalObject(oPC,"pc_mount");

        int nObjectType = OBJECT_TYPE_CREATURE;
        location locPC = GetLocation(oPC);
        object oHorse = CreateObject(nObjectType, sResRef, locPC, TRUE, sIconTag);

        SetLocalObject(oPC,"pc_mount",oHorse);
        AddHenchman(oPC,oHorse);
    }
}  // end function


//////////////////////////////////////////////////////////////////
int GPA_GetIsHench(object oPC, object oHorse)
//////////////////////////////////////////////////////////////////
{
    int nMaxHenchmen = GetMaxHenchmen();
    int i;
    for (i==1;i<=nMaxHenchmen; i++)
    {
        if (GetHenchman(oPC,i) == oHorse)
            return TRUE;
    } // end for

    return FALSE;
} // end function


//////////////////////////////////////////////////////////////////
void GPA_OnRest(object oPC)
// Wrapper Function for the On Rest Event, add additional
// actions you want on dismount here.
//////////////////////////////////////////////////////////////////
{
    GPA_DismountHorse(oPC);
}  // end function


//////////////////////////////////////////////////////////////////
void GPA_HorseOCE(object oPC)        // On Client Enter
//////////////////////////////////////////////////////////////////
{
    GPA_DismountHorse(oPC);
} // end function



//////////////////////////////////////////////////////////////////
void GPA_ClearHorse(object oPC, object oHorse)
//////////////////////////////////////////////////////////////////
{
    DeleteLocalObject(oPC,"pc_mount");
    AssignCommand(oHorse,SetIsDestroyable(TRUE,FALSE,FALSE));
    DestroyObject(oHorse);

    object oBag = GetLocalObject(oPC,"PC_Bag");
    if(oBag != OBJECT_INVALID)
    {
        DeleteLocalInt(oPC, "PC_Saddle");

        object oItem = GetFirstItemInInventory(oBag);
        while( oItem != OBJECT_INVALID )
        {
            DestroyObject(oItem);

            oItem = GetNextItemInInventory(oBag);
        }

        DestroyObject(oBag);
    }
}


//////////////////////////////////////////////////////////////////
void GPA_HorseOCL(object oPC)
//////////////////////////////////////////////////////////////////
{
    string sTag;

    object oIcon = GetFirstItemInInventory(oPC);
    while(oIcon != OBJECT_INVALID)
    {
        sTag = GetTag(oIcon);

        if((FindSubString(sTag,"blckhorse")!=-1)||(FindSubString(sTag,"brwnhorse") != -1)||
            (FindSubString(sTag,"whtehorse") != -1)||(FindSubString(sTag,"whitepony") != -1)||
            (FindSubString(sTag,"pintopony") != -1)||(FindSubString(sTag,"brownpony") != -1)||
            (FindSubString(sTag,"aurenthil") != -1)||(FindSubString(sTag,"nightmare") != -1))
        {
            DeleteLocalInt(oIcon,"HorseSummon");
        }

        oIcon = GetNextItemInInventory(oPC);
    }  // end while

    object oHorse = GetLocalObject(oPC,"pc_mount");
    if(oHorse != OBJECT_INVALID)  // Horse In Party
    {
        RemoveHenchman(oPC,oHorse);
        GPA_ClearHorse(oPC, oHorse);
    }
    else
    {
        oHorse = GPA_Dismount(oPC,"dismount");
        if(oHorse != OBJECT_INVALID)    // Mounted
        {
            RemoveHenchman(oPC,oHorse);
            GPA_ClearHorse(oPC,oHorse);
        }
        else                            // Not Mounted, Not In Party
        {
            oHorse = GetObjectByTag(sTag,1);
            if(GetObjectType(oHorse) == OBJECT_TYPE_CREATURE)
            {
                GPA_ClearHorse(oPC,oHorse);
            }
            else
            {
                oHorse = GetObjectByTag(sTag,2);
                if(GetObjectType(oHorse) == OBJECT_TYPE_CREATURE)
                {
                    GPA_ClearHorse(oPC,oHorse);
                }
            }
        }
    }
}  // end function


//////////////////////////////////////////////////////////////////
object GPA_InitializeIcon(object oPC, object oItem)
//////////////////////////////////////////////////////////////////
{
    if(!GetIsPC(oPC))
        return OBJECT_INVALID;

    string sResRef = GetResRef(oItem);

    int nIndex = GetCampaignInt("horses", sResRef);
    nIndex = nIndex +1;

    string sIndex;
    string sIndex1 = IntToString(nIndex);

    if(nIndex <= 9)
        sIndex = "000" + sIndex1;
    else if(nIndex <= 99)
        sIndex = "00" + sIndex1;
    else if(nIndex <= 999)
        sIndex = "0" + sIndex1;
    else if(nIndex <= 9999)
        sIndex = sIndex1;
    else
    {
        SendMessageToPC(oPC,"Horse index out of range!");
        return OBJECT_INVALID;
    }

    string sNewTag = sResRef + sIndex;
    location lLoc = GetLocation(oPC);

    object oIcon = CopyObject(oItem,lLoc,oPC,sNewTag);
    DestroyObject(oItem);
    SetCampaignInt("horses", sResRef, nIndex);

    return oIcon;
}  // end function


//////////////////////////////////////////////////////////////////
void GPA_HorseDiedInventoryMove(object oHorse)
//////////////////////////////////////////////////////////////////
{
    location lLoc = GetLocation(oHorse);
    int nObjectType = OBJECT_TYPE_PLACEABLE;
    string sResRef = "mountinventory";

    object oBag = CreateObject(nObjectType, sResRef, lLoc);

    object oItem = GetFirstItemInInventory(oHorse);
    while (GetIsObjectValid(oItem) == TRUE)
    {
        if(GetStringLeft(GetTag(oItem),2)!="pl")
            CopyItem(oItem,oBag);

        oItem = GetNextItemInInventory(GetFirstPC());
    }
}  // end function


//////////////////////////////////////////////////////////////////
void GPA_OnActivate(object oPC,object oItem)
//////////////////////////////////////////////////////////////////
{
    string sTag = GetTag(oItem);

    if((sTag == "blckhorsehvy")||(sTag == "blckhorselig")||(sTag == "blckhorserid")||
       (sTag == "brwnhorsehvy")||(sTag == "brwnhorselig")||(sTag == "brwnhorserid")||
       (sTag == "whtehorsehvy")||(sTag == "whtehorselig")||(sTag == "whtehorserid")||
       (sTag == "whiteponystd")||(sTag == "whiteponydwr")||(sTag == "whiteponywar")||
       (sTag == "pintoponystd")||(sTag == "pintoponydwr")||(sTag == "pintoponywar")||
       (sTag == "brownponystd")||(sTag == "brownponydwr")||(sTag == "brownponywar")||
       (sTag == "aurenthilstd")||(sTag == "nightmarestd"))
        {
            object oIcon = GPA_InitializeIcon(oPC, oItem);
            if (oIcon != OBJECT_INVALID)
                GPA_ActivateHorseIcon(oPC, oIcon);
            return;
        }

    if ((GetSubString(sTag,4,5) == "horse")||(GetSubString(sTag,5,4) == "pony"))
        GPA_ActivateHorseIcon(oPC, oItem);

    if(sTag == "dismount")
        GPA_DismountHorse(oPC);
}  // end function


//////////////////////////////////////////////////////////////////
object GPA_Dismount(object oPC, string sRemoveItem_ResRef="")
//  This is a modified version of zep_Dismount, where the mount
//  obect is returned as a passed variable.
//////////////////////////////////////////////////////////////////
{
    //Checks\\
    if (GetObjectType(oPC)!=OBJECT_TYPE_CREATURE){return OBJECT_INVALID;}
    int nPhenotype_C = GetPhenoType(oPC);
    if (nPhenotype_C <nMAX_PHENOTYPE_ALLOWED+1){return OBJECT_INVALID;}

    //Restore Phenotype:
    if (nPhenotype_C>nMAX_PHENOTYPE_STANDARD){DelayCommand(1.5,SetPhenoType(2,oPC));}
    else {DelayCommand(1.5,SetPhenoType(0,oPC));}

    //speed:
    zep_UnWalk_Speed(oPC);

    //Restore Mount
    object oMount = GetLocalObject(oPC, "oCEP_Mount_C"); //thus either object invalid or the mount
    effect eFX;
    float fDelay=3.0;
    if (GetIsObjectValid(oMount)==TRUE)
    {
        x1st_Effect_RemoveType(oMount,EFFECT_TYPE_CUTSCENEGHOST );

        AssignCommand(oMount, ActionJumpToObject(oPC,FALSE));
        DelayCommand(2.0, x1st_Effect_RemoveType(oMount,EFFECT_TYPE_VISUALEFFECT));
        DelayCommand(3.0,DeleteLocalObject(oPC,"oCEP_Mount_C"));
    }

    object oItem;
    ////////////////ITEM\\\\\\\\\\\\\\
    if (sRemoveItem_ResRef!="")
    {
        oItem = o1st_GetItemInInventory(oPC, "",sRemoveItem_ResRef);
        DestroyObject(oItem);
    }

    return oMount;
}


//////////////////////////////////////////////////////////////////
void GPA_OnAreaTransition(object oPC,object oMount)
//////////////////////////////////////////////////////////////////
{
    string sIconTag = GetTag(oMount);
    string sResRef = GetStringLeft(sIconTag,12) + "0";

    RemoveHenchman(oPC,oMount);
    AssignCommand(oMount,SetIsDestroyable(TRUE,FALSE,FALSE));
    DestroyObject(oMount);

    object oHitch = GetNearestObjectByTag("WP_Hitch");

    if(oHitch == OBJECT_INVALID)
        oHitch = GetNearestObjectByTag("hitchingpost");

    object oDoor = GetNearestObject(OBJECT_TYPE_DOOR,oPC);

    location locHitch;
    if (oHitch != OBJECT_INVALID)
    {
        locHitch = GetLocation(oHitch);
        FloatingTextStringOnCreature(HORSE_HITCH_POST,oPC,FALSE);
    }
    else
    {
        locHitch = GetBehindLocation(oDoor);
        FloatingTextStringOnCreature(HORSE_DOOR,oPC,FALSE);
    }

    int nObjectType = OBJECT_TYPE_CREATURE;
    object oHorse = CreateObject(nObjectType, sResRef, locHitch, TRUE, sIconTag);
    float fFacing = GetFacing(oHitch);
    AssignCommand(oHorse,SetFacing(fFacing));
    DeleteLocalObject(oPC,"pc_mount");
}


//////////////////////////////////////////////////////////////////
void GPA_MoveHench(object oPC, object oHench)
//////////////////////////////////////////////////////////////////
{
    object oHitch = GetNearestObjectByTag("WP_Hitch");
    if(oHitch == OBJECT_INVALID)
        oHitch = GetNearestObjectByTag("hitchingpost");

    object oDoor = GetNearestObject(OBJECT_TYPE_DOOR,oPC);

    location locHitch;
    if (oHitch != OBJECT_INVALID)
    {
        locHitch = GetLocation(oHitch);
        FloatingTextStringOnCreature(HORSE_HITCH_POST,oPC,FALSE);
    }
    else
    {
        locHitch = GetBehindLocation(oDoor);
        FloatingTextStringOnCreature(HORSE_DOOR,oPC,FALSE);
    }

    string sIconTag = GetTag(oHench);
    string sResRef = GetStringLeft(sIconTag,12) + "0";
    int nObjectType = OBJECT_TYPE_CREATURE;

    RemoveHenchman(oPC,oHench);
    AssignCommand(oHench,SetIsDestroyable(TRUE,FALSE,FALSE));
    DestroyObject(oHench);

    object oHorse = CreateObject(nObjectType, sResRef, locHitch, TRUE, sIconTag);
    DeleteLocalObject(oPC,"pc_mount");
}


//////////////////////////////////////////////////////////////////
void GPA_HorseHench(object oPC)
//////////////////////////////////////////////////////////////////
{
    object oHench;
    int nAppearance;

    int nMaxHenchmen = GetMaxHenchmen();
    int i;
    for (i==1;i<=nMaxHenchmen; i++)
    {
        oHench = GetHenchman(oPC,i);
        nAppearance = GetAppearanceType(oHench);

        if((nAppearance > 1854)&&(nAppearance < 1862))
            GPA_MoveHench(oPC, oHench);
    } // end for
}  // end function


//////////////////////////////////////////////////////////////////
int GetNumHenchmen(object oPC)
//////////////////////////////////////////////////////////////////
{
    if (!GetIsPC(oPC)) return -1;

    int nLoop, nCount;
    for (nLoop=1; nLoop<=GetMaxHenchmen(); nLoop++)
    {
        if (GetIsObjectValid(GetHenchman(oPC, nLoop)))
        nCount++;
    }

    return nCount;
}  // end function
