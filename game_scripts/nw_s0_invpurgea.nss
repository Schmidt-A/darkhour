//::///////////////////////////////////////////////
//:: Invisibilty Purge: On Enter
//:: NW_S0_InvPurgeA
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
     All invisible creatures in the AOE become
     visible.
*/
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: Jan 7, 2002
//:://////////////////////////////////////////////
//::March 31: Made it so it will actually remove
//  the effects of Improved Invisibility
#include "x0_i0_spells"

#include "x2_inc_spellhook" 

void main()
{

/* 
  Spellcast Hook Code 
  Added 2003-06-20 by Georg
  If you want to make changes to all spells,
  check x2_inc_spellhook.nss to find out more
  
*/

    if (!X2PreSpellCastCode())
    {
	// If code within the PreSpellCastHook (i.e. UMD) reports FALSE, do not run this spell
        return;
    }

// End of Spell Cast Hook


    //Declare major variables
    object oTarget = GetEnteringObject();

    if (GetHasSpellEffect(SPELL_IMPROVED_INVISIBILITY, oTarget) == TRUE)
    {
        RemoveAnySpellEffects(SPELL_IMPROVED_INVISIBILITY, oTarget);
    }
    else
    if (GetHasSpellEffect(SPELL_INVISIBILITY, oTarget) == TRUE)
    {
        RemoveAnySpellEffects(SPELL_INVISIBILITY, oTarget);
    }

    effect eInvis = GetFirstEffect(oTarget);




    int bIsImprovedInvis = FALSE;
    while(GetIsEffectValid(eInvis))
    {
        if (GetEffectType(eInvis) == EFFECT_TYPE_IMPROVEDINVISIBILITY)
        {
            bIsImprovedInvis = TRUE;
        }
        //check for invisibility
        if(GetEffectType(eInvis) == EFFECT_TYPE_INVISIBILITY || bIsImprovedInvis)
        {
        	if(!GetIsReactionTypeFriendly(oTarget, GetAreaOfEffectCreator()))
        	{
                //Fire cast spell at event for the specified target
                SignalEvent(oTarget, EventSpellCastAt(GetAreaOfEffectCreator(), SPELL_INVISIBILITY_PURGE));
            }
            else
            {
                //Fire cast spell at event for the specified target
                SignalEvent(oTarget, EventSpellCastAt(GetAreaOfEffectCreator(), SPELL_INVISIBILITY_PURGE, FALSE));
            }
            //remove invisibility
            RemoveEffect(oTarget, eInvis);
            if (bIsImprovedInvis)
            {
                RemoveSpellEffects(SPELL_IMPROVED_INVISIBILITY, oTarget, oTarget);
            }
        }
        //Get Next Effect
        eInvis = GetNextEffect(oTarget);
    }
}
