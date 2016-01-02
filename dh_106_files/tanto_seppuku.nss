void main()
{
    object oItem = GetItemActivated();
    object oUser = GetItemActivator();
    string sItem = GetTag(oItem);

    if (sItem == "SeppukuTanto")
    {
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectCutsceneImmobilize(),oUser,5.0);
        AssignCommand(oUser,ActionPlayAnimation(ANIMATION_LOOPING_MEDITATE,1.0,5.0));
        DelayCommand(5.0,ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectDeath(),oUser));
        DelayCommand(5.0,ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_COM_BLOOD_LRG_RED),oUser));
        AssignCommand(oUser,SpeakString("*Seppuku*"));
    }
}
