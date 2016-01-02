void main()
{
    object oItem = GetInventoryDisturbItem();
    location lLoc;
    location lExit = GetLocation(GetWaypointByTag("portal_destination"));
    if (GetTag(oItem) == "gemofvalor")
    {
        DestroyObject(oItem);
        lLoc = GetLocation(GetWaypointByTag("GoToHeaven"));
        effect eAppear = EffectVisualEffect(VFX_FNF_STRIKE_HOLY);
        ApplyEffectAtLocation(DURATION_TYPE_INSTANT,eAppear,lLoc);
        ApplyEffectAtLocation(DURATION_TYPE_INSTANT,eAppear,lExit);
        object oPortal1 = CreateObject(OBJECT_TYPE_PLACEABLE,"escapeportal",lLoc);
        object oPortal2 = CreateObject(OBJECT_TYPE_PLACEABLE,"plc_portal",lExit);
        DelayCommand(15.0,DestroyObject(oPortal1));
        DelayCommand(15.0,DestroyObject(oPortal2));
    }
}
