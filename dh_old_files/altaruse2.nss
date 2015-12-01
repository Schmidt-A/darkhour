void main()
{
    object oItem = GetInventoryDisturbItem();
    location lLoc;
    location lExit = GetLocation(GetWaypointByTag("portal_dest2"));
    if (GetTag(oItem) == "gemofcorruption")
    {
        DestroyObject(oItem);
        lLoc = GetLocation(GetWaypointByTag("GoToHell"));
        effect eAppear = EffectVisualEffect(VFX_FNF_IMPLOSION);
        ApplyEffectAtLocation(DURATION_TYPE_INSTANT,eAppear,lLoc);
        ApplyEffectAtLocation(DURATION_TYPE_INSTANT,eAppear,lExit);
        object oPortal1 = CreateObject(OBJECT_TYPE_PLACEABLE,"escapeportal2",lLoc);
        object oPortal2 = CreateObject(OBJECT_TYPE_PLACEABLE,"plc_portal",lExit);
        DelayCommand(15.0,DestroyObject(oPortal1));
        DelayCommand(15.0,DestroyObject(oPortal2));
    }
}
