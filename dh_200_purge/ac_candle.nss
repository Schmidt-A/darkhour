void main()
{
    object oItem = GetItemActivated();
    object oPC = GetItemActivator();
    location lLoc = GetLocation(oPC);
    int nBurn = GetLocalInt(oItem,"burn");

    DestroyObject(oItem);

    AssignCommand(oPC, ActionPlayAnimation(ANIMATION_LOOPING_GET_LOW, 1.0, 1.5));
    object oPCan = CreateObject(OBJECT_TYPE_PLACEABLE, "zn_pcandle", lLoc);
    SetLocalInt(oPCan,"burn",nBurn);
    effect eLight = EffectVisualEffect(VFX_DUR_LIGHT_ORANGE_5);
    ApplyEffectToObject(DURATION_TYPE_PERMANENT,eLight,oPCan);
}
