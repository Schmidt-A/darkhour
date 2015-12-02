//::///////////////////////////////////////////////

void main()
{
    object oTARGET = OBJECT_SELF;
    ActionPlayAnimation(ANIMATION_FIREFORGET_VICTORY1);
    ActionPlayAnimation(ANIMATION_LOOPING_CONJURE1,1.0,20.0);
    effect eParalyze = EffectCutsceneParalyze();
    effect eHold = EffectVisualEffect(VFX_DUR_FREEZE_ANIMATION);
    effect ePetrify = EffectVisualEffect(VFX_DUR_PETRIFY);
    SetCommandable(FALSE);
     DelayCommand(1.5,ApplyEffectToObject(DURATION_TYPE_INSTANT, eParalyze, oTARGET));
     DelayCommand(2.0,ApplyEffectToObject(DURATION_TYPE_PERMANENT, eHold, oTARGET));
     DelayCommand(2.5,ApplyEffectToObject(DURATION_TYPE_PERMANENT, ePetrify, OBJECT_SELF));
     SetPlotFlag(OBJECT_SELF, 1);
     SetLocalInt(OBJECT_SELF, "X1_L_IMMUNE_TO_DISPEL", 10);
}
