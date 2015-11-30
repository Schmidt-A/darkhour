void main()
// This is the script for the item "Desolate Recall." It is supposed to port
// the user to Sundered Desolation when used.

{
    object oItem = GetItemActivated();
    object oUser = GetItemActivator();
    string sItem = GetTag(oItem);
    object oTarget = GetItemActivatedTarget();
    if (sItem == "desolaterecall")
    {
            {
                location lLoc = GetLocation(GetWaypointByTag("ZHOBUSSTART"));
                effect eVanish = EffectVisualEffect(VFX_FNF_PWSTUN);
                ApplyEffectAtLocation(DURATION_TYPE_INSTANT,eVanish,GetLocation(oUser));
                DelayCommand(1.0,AssignCommand(oUser,JumpToLocation(lLoc)));
                if(GetIsPC(oTarget) == TRUE)
                    {
                    ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectDispelMagicAll(40), oUser);
                    ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectDispelMagicAll(40), oTarget);
                    ApplyEffectAtLocation(DURATION_TYPE_INSTANT,eVanish,GetLocation(oTarget));
                    DelayCommand(1.0,AssignCommand(oTarget,JumpToLocation(lLoc)));
                    }
            }
     }
}
