void main()
{
    object oItem = GetInventoryDisturbItem();
    location lLoc;
    location lExit = GetLocation(GetWaypointByTag("portal_dneutral"));
    if (GetTag(oItem) == "gemofshadow")
    {
        DestroyObject(oItem);
        lLoc = GetLocation(GetWaypointByTag("NeutralReturn"));
        effect eAppear = EffectVisualEffect(VFX_FNF_SUMMON_MONSTER_3);
        ApplyEffectAtLocation(DURATION_TYPE_INSTANT,eAppear,lLoc);
        ApplyEffectAtLocation(DURATION_TYPE_INSTANT,eAppear,lExit);
        object oPortal1 = CreateObject(OBJECT_TYPE_PLACEABLE,"fugneutral_exitportal",lLoc);
        object oPortal2 = CreateObject(OBJECT_TYPE_PLACEABLE,"plc_portal",lExit);
        DelayCommand(15.0,DestroyObject(oPortal1));
        DelayCommand(15.0,DestroyObject(oPortal2));
    }
}
