void main()
{
    object oDoor = GetObjectByTag("SpireRoofDoor");
    ActionPlayAnimation(ANIMATION_PLACEABLE_ACTIVATE);
    ActionPlayAnimation(ANIMATION_PLACEABLE_DEACTIVATE);
    ActionOpenDoor(oDoor);
    object oGiant = GetNearestObjectByTag("dh_zombie_giant");
    ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectResurrection(),oGiant);
    ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectHeal(GetMaxHitPoints(oGiant)),oGiant);
    ApplyEffectToObject(DURATION_TYPE_INSTANT,SupernaturalEffect(ExtraordinaryEffect(EffectVisualEffect(VFX_DUR_BLUR))),oGiant);
    ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_HOWL_MIND),oGiant);
}
