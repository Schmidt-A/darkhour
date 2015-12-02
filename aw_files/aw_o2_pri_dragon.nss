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
#include "x2_inc_switches"
void CreateCreature(object oPC, location lLoc,string sResRef)
{
    //string sResRef = GetLocalString(oPlaceable, "sResRef");
    object oCreature = CreateObject(OBJECT_TYPE_CREATURE, sResRef, lLoc);
    AssignCommand(oCreature, ActionPlayAnimation(ANIMATION_LOOPING_CONJURE2,1.0,1.3));
    DelayCommand(0.1, AssignCommand(oCreature, ActionAttack(oPC)));
}

void CreatePlaceable(string sResRef2, string sResRef,location lLoc)
{
    object oPlaceable = CreateObject(OBJECT_TYPE_PLACEABLE, sResRef2, lLoc);
    SetLocalString(oPlaceable, "sResRef", sResRef);
}

void main()
{
    object oTransformer = OBJECT_SELF;
    object oPC = GetNearestCreature(CREATURE_TYPE_PLAYER_CHAR, PLAYER_CHAR_IS_PC);

    if (GetObjectType(oTransformer) == OBJECT_TYPE_CREATURE) // action for blighted treant creature
    {
        if (GetIsObjectValid(oPC) == FALSE || GetDistanceToObject(oPC) > 15.0)
        {   string sResRef = GetResRef(oTransformer);
            string sRefRef2 =GetLocalString(OBJECT_SELF, "sResRef");
            float Facing = GetFacing(OBJECT_SELF);
            if (Facing >180.0) Facing = Facing - 180.0 ;
            else Facing = Facing + 180.0 ;
            location lLoc = Location(GetArea(OBJECT_SELF),GetPosition(OBJECT_SELF),Facing);
            ActionPlayAnimation(ANIMATION_FIREFORGET_VICTORY2);
            SetPlotFlag(OBJECT_SELF, FALSE);
            DestroyObject(OBJECT_SELF);
            CreatePlaceable(sRefRef2, sResRef,lLoc);
        }
    }
    else if (GetObjectType(oTransformer) == OBJECT_TYPE_PLACEABLE) // action for blighted treant placeable
    {
        if (GetIsObjectValid(oPC) == TRUE && GetDistanceToObject(oPC) < 9.0)
        {
            float Facing = GetFacing(OBJECT_SELF);
            if (Facing >180.0) Facing = Facing - 180.0 ;
            else Facing = Facing + 180.0 ;
            location lLoc = Location(GetArea(OBJECT_SELF),GetPosition(OBJECT_SELF),Facing);
             string  sResRef = GetLocalString(OBJECT_SELF, "sResRef");
            DestroyObject(oTransformer);
            effect FnFEffect = EffectVisualEffect(VFX_FNF_MYSTICAL_EXPLOSION);
            ApplyEffectAtLocation(DURATION_TYPE_INSTANT,FnFEffect,lLoc);
            CreateCreature(oPC,lLoc,sResRef);
            SetPlotFlag(oTransformer, FALSE);
        }
    }
}


