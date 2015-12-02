//::///////////////////////////////////////////////
//:: Name merm_transfrm_hb
//:://////////////////////////////////////////////
/*
    Heartbeat script for Blighted Treant to turn in and out of a tree

    For this script to work, a string variable sResRef must be set no the
        transforming creature. It should be set to the resref of the placeable
        into which the creature should transform
        A string variable also named sResRef should be set on the placeable
        as a default creature to transform the placeable into for placed objects
    This script should be placed in the OnHeartbeat event of both the placeable
        and the creatures
*/
//:://////////////////////////////////////////////
//:: Created By: Mermut
//:: Created On: March 17, 2004
//:: Modified By: Mermut
//:: Modified On: June 24, 2004
//:: Modification: Generalized to apply to all placeable/creature/placeable
//::                sets
//:://////////////////////////////////////////////
void CreateCreature(object oPC, object oPlaceable)
{
    string sResRef = GetLocalString(oPlaceable, "sResRef");
    object oCreature = CreateObject(OBJECT_TYPE_CREATURE, sResRef, GetLocation(oPlaceable));
    DelayCommand(0.1, AssignCommand(oCreature, ActionAttack(oPC)));
    effect eMind = EffectVisualEffect(VFX_IMP_HOLY_AID);
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eMind, oCreature);
}

void CreatePlaceable(object oCreature, string sResRef)
{
    string sPlaceable = GetLocalString(oCreature, "sResRef");
    object oPlaceable = CreateObject(OBJECT_TYPE_PLACEABLE, sPlaceable, GetLocation(oCreature));
    SetLocalString(oPlaceable, "sResRef", sResRef);
}

void main()
{
    object oTransformer = OBJECT_SELF;
    string sResRef = GetResRef(oTransformer);
    object oPC = GetNearestCreature(CREATURE_TYPE_PLAYER_CHAR, PLAYER_CHAR_IS_PC);

    if (GetObjectType(oTransformer) == OBJECT_TYPE_CREATURE) // action for blighted treant creature
    {
        if (GetIsObjectValid(oPC) == FALSE || GetDistanceToObject(oPC) > 15.0)
        {
            CreatePlaceable(oTransformer, sResRef);
            SetPlotFlag(oTransformer, FALSE);
            DestroyObject(oTransformer);
        }
    }
    else if (GetObjectType(oTransformer) == OBJECT_TYPE_PLACEABLE) // action for blighted treant placeable
    {
        if (GetIsObjectValid(oPC) == TRUE && GetDistanceToObject(oPC) < 7.0)
        {
            CreateCreature(oPC, oTransformer);
            SetPlotFlag(oTransformer, FALSE);
            DestroyObject(oTransformer);
        }
    }
}
