void main()
{
    object oItem = GetInventoryDisturbItem();
    location lLoc;
    location lExit = GetLocation(GetWaypointByTag("portal_dest3"));
    if (GetTag(oItem) == "gemofshadow")
    if (GetTag(oItem) == "gemofcorruption")
    if (GetTag(oItem) == "gemofvalor")
    {
        DestroyObject(oItem);
        lLoc = GetLocation(GetWaypointByTag("GoToLimbo"));
        effect eAppear = EffectVisualEffect(VFX_FNF_SUMMON_MONSTER_3);
        ApplyEffectAtLocation(DURATION_TYPE_INSTANT,eAppear,lLoc);
        ApplyEffectAtLocation(DURATION_TYPE_INSTANT,eAppear,lExit);
        object oPortal1 = CreateObject(OBJECT_TYPE_PLACEABLE,"escapeportal3",lLoc);
        object oPortal2 = CreateObject(OBJECT_TYPE_PLACEABLE,"plc_portal",lExit);
        DelayCommand(200.0,DestroyObject(oPortal1));
        DelayCommand(200.0,DestroyObject(oPortal2));
    }
}
