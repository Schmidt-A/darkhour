//Put this script OnEnter
void main()
{
    object oPC = GetEnteringObject();
    effect eSafe = EffectSanctuary(99);
    effect eProtect = EffectDamageResistance(DAMAGE_TYPE_SLASHING,10);
    if (GetIsDM(oPC) == FALSE)
    {
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eSafe,oPC,5.5);
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eProtect,oPC,5.5);
    }

    if (GetLocalInt(oPC,"finishcreate") == 1)
    {
        SetDroppableFlag(GetFirstItemInInventory(oPC),FALSE);
        DestroyObject(oPC);
    }



if (!GetIsPC(oPC)) {return; }

int DoOnce = GetLocalInt(OBJECT_SELF, GetTag(OBJECT_SELF));

if (DoOnce==TRUE) {return;}
SetLocalInt(OBJECT_SELF, GetTag(OBJECT_SELF), TRUE);
object oTarget;
oTarget = GetObjectByTag("candelabra_1");
AssignCommand(oTarget, PlayAnimation(ANIMATION_PLACEABLE_DEACTIVATE));
SetPlaceableIllumination(oTarget, FALSE);


}

