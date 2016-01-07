#include "NW_I0_GENERIC"

int TorchCheck (object oPC);
int PCIsLooking(object oPC);

void main()
{
    int nUD = GetUserDefinedEventNumber();
    effect eAfraid = EffectVisualEffect(VFX_COM_HIT_DIVINE);

    if ((nUD == 1001) && (GetTag(OBJECT_SELF) != "ZN_ZOMBIEB"))
    {
        int nCount = 1;
        object oCampfire = GetNearestObjectByTag("Campfire");
        if (GetDistanceBetween(OBJECT_SELF,oCampfire) <= 3.0 && GetIsObjectValid(oCampfire))
            {
                //If the creature is within 10 meters of a PC seen
                //carrying a torch, it moves until it is 10 meters
                //away, then turns back around to fight again.
                ClearAllActions();
                ApplyEffectToObject(DURATION_TYPE_INSTANT,eAfraid,OBJECT_SELF);
                ActionMoveAwayFromObject(oCampfire,FALSE,5.0);
                ActionDoCommand(SetCommandable(TRUE,OBJECT_SELF));
                ActionDoCommand(DetermineCombatRound());
                SetCommandable(FALSE,OBJECT_SELF);
            }
        //Creature searches for a PC that it can see and is
        //bearing a torch.
        object oPC = GetNearestCreature(CREATURE_TYPE_PLAYER_CHAR,PLAYER_CHAR_IS_PC, OBJECT_SELF,nCount, CREATURE_TYPE_PERCEPTION, PERCEPTION_SEEN);
        while (GetIsObjectValid(oPC))
        {
            if (TorchCheck(oPC) >= 0 &&
                GetDistanceBetween(OBJECT_SELF,oPC) <= 5.0 &&
                PCIsLooking(oPC))
            {
                //If the creature is within 10 meters of a PC seen
                //carrying a torch, it moves until it is 10 meters
                //away, then turns back around to fight again.
                ClearAllActions();
                ApplyEffectToObject(DURATION_TYPE_INSTANT,eAfraid,OBJECT_SELF);
                ActionMoveAwayFromObject(oPC,FALSE,5.0);
                ActionDoCommand(SetCommandable(TRUE,OBJECT_SELF));
                ActionDoCommand(DetermineCombatRound());
                SetCommandable(FALSE,OBJECT_SELF);
            }
            nCount++;
            oPC = GetNearestCreature(CREATURE_TYPE_PLAYER_CHAR,PLAYER_CHAR_IS_PC, OBJECT_SELF,nCount, CREATURE_TYPE_PERCEPTION, PERCEPTION_SEEN);
        }
    }
}

int TorchCheck (object oPC)
{
    int nTCheck;
    string sTag = GetTag(GetItemInSlot(INVENTORY_SLOT_LEFTHAND,oPC));
    string sTagLow = GetStringLowerCase(sTag);
    nTCheck = FindSubString(sTagLow,"torch");
    return nTCheck;
}

int PCIsLooking(object oPC)
{
    // make all angles Integer, since we do not need floating point precision
    int nPCFacing = FloatToInt( GetFacing(oPC) ); // angle PC is facing
    int nPosition = FloatToInt( VectorToAngle( GetPosition(OBJECT_SELF)-GetPosition(oPC) ) ); // angle to NPC from PC
    int nViewingAngle = 60; // VIEWING ANGLE to either side of forward facing
    int nAngle = abs( nPCFacing - nPosition ); // difference in angles
    if ( nAngle > 180 ) nAngle = 360-nAngle; // compensate for large differences (result of 0, 360 being same angle)
    if ( nAngle <= nViewingAngle ) // check whether NPC is within PC "viewing angle"
    {
        return TRUE;
    }
    else
    {
        return FALSE;
    }
}
