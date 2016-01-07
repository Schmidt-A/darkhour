//::///////////////////////////////////////////////
//:: CEP Creature Wizard
//:: Community Expansion Pack
//:://////////////////////////////////////////////
/*
    Custom tool script to start the CEP Creature
    Wizard conversation. Rename to corresponding
    custom tool script. (e.g. x3_dm_tool01)
*/
//:://////////////////////////////////////////////
//:: Created By:   420
//:: Created On:   April 20, 2009
//:://////////////////////////////////////////////
#include "x2_inc_switches"

void main()
{
object oPC = OBJECT_SELF;
object oTarget = GetSpellTargetObject();
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
