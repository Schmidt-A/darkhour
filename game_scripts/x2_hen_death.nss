//::///////////////////////////////////////////////
//:: Henchman Death Script
//::
//:: NW_CH_AC7.nss
//::
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
//:: <description>
//:://////////////////////////////////////////////
//::
//:: Created By:
//:: Modified by:   Brent, April 3 2002
//::                Removed delay in respawning
//::                the henchman - caused bugs
//:: Modified November 14 2002
//::  - Henchem will now stay dead. Need to be raised
//:://////////////////////////////////////////////

//::///////////////////////////////////////////////
//:: Greater Restoration
//:: NW_S0_GrRestore.nss
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Removes all negative effects of a temporary nature
    and all permanent effects of a supernatural nature
    from the character. Does not remove the effects
    relating to Mind-Affecting spells or movement alteration.
    Heals target for 5d8 + 1 point per caster level.
*/
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: Jan 7, 2002
//:://////////////////////////////////////////////
//:: VFX Pass By: Preston W, On: June 20, 2001
#include "nw_i0_generic"
#include "nw_i0_plot"
#include "x0_i0_henchman"


void main()
{
    // * This is used by the advanced henchmen
    // * Let Brent know if it interferes with animal
    // * companions et cetera



    if (GetAssociateType(OBJECT_SELF) == ASSOCIATE_TYPE_HENCHMAN)
    {
       SetLocalInt(OBJECT_SELF, "X2_L_IJUSTDIED", 10);
       SetKilled(GetMaster());
       SetDidDie();

    }
    RemoveHenchman(GetMaster(), OBJECT_SELF);
    
       // * Custom stuff, if your henchman betrayed you
   // * they can no longer be raised
   string sTag = GetTag(OBJECT_SELF);
   int bDestroyMe = FALSE;
   if (sTag == "H2_Aribeth" && GetLocalInt(GetModule(), "bAribethBetrays") == TRUE)
   {
    bDestroyMe = TRUE;
   }
   else
   if (sTag == "x2_hen_nathyra" && GetLocalInt(GetModule(), "bNathyrraBetrays") == TRUE)
   {
    bDestroyMe = TRUE;

   }
   else
   if (sTag == "x2_hen_valen" && GetLocalInt(GetModule(), "bValenBetrays") == TRUE)
   {
    bDestroyMe = TRUE;

   }
   else
   if (sTag == "x2_hen_deekin" && GetLocalInt(GetModule(), "bDeekinBetrays") == TRUE)
   {
    bDestroyMe = TRUE;
   }

   if (bDestroyMe == TRUE)
   {
    // * For purposes of end-game narration, set whether henchmen
    // * died in final battle
    SetLocalInt(GetModule(), GetTag(OBJECT_SELF) + "_DIED", 1);
    SetIsDestroyable(FALSE, FALSE, FALSE);
   }

}


