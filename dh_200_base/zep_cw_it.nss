//::///////////////////////////////////////////////
//:: CEP Creature Wizard
//:: Community Expansion Pack
//:://////////////////////////////////////////////
/*
    Tag-based script to start the CEP Creature
    Wizard conversation
*/
//:://////////////////////////////////////////////
//:: Created By:   420
//:: Created On:   April 20, 2009
//:://////////////////////////////////////////////
#include "x2_inc_switches"

void main()
{

if(GetUserDefinedItemEventNumber() == X2_ITEM_EVENT_ACTIVATE)
    {
    object oPC = GetItemActivator();
    object oTarget = GetItemActivatedTarget();
    object oCW;

    //Check for a valid target
    if(GetObjectType(oTarget) == OBJECT_TYPE_CREATURE)
        {
        oCW = CreateObject(OBJECT_TYPE_CREATURE, "zep_cw_cre", GetLocation(oPC));
        ApplyEffectToObject(DURATION_TYPE_PERMANENT, SupernaturalEffect(EffectVisualEffect(VFX_DUR_CUTSCENE_INVISIBILITY)), oCW);
        ApplyEffectToObject(DURATION_TYPE_PERMANENT, SupernaturalEffect(EffectCutsceneGhost()), oCW);
        ChangeFaction(oCW, oTarget);
        SetLocalObject(oCW, "CW_Target", oTarget);
        SetPortraitResRef(oCW, GetPortraitResRef(oTarget));
        SetCustomToken(300, GetName(oTarget));
        AssignCommand(oPC, ClearAllActions(TRUE));
        AssignCommand(oPC, ActionStartConversation(oCW, "", TRUE, FALSE));
        }
    else
        {
        FloatingTextStringOnCreature("Target must be a creature.", oPC, FALSE);
        }
    }
}
