void main()
{
    location lLoc;
    location lExit = GetLocation(GetWaypointByTag("ComingFromFugue"));
    object oPC = GetPCSpeaker();
    object oItem;

oItem = GetItemPossessedBy(oPC, "gemofvalor");

if (GetIsObjectValid(oItem))
   DestroyObject(oItem);

oItem = GetItemPossessedBy(oPC, "gemofshadow");

if (GetIsObjectValid(oItem))
   DestroyObject(oItem);

oItem = GetItemPossessedBy(oPC, "gemofcorruption");

if (GetIsObjectValid(oItem))
   DestroyObject(oItem);

    {
        lLoc = GetLocation(GetWaypointByTag("LeavingFugue"));
        effect eAppear = EffectVisualEffect(VFX_IMP_DISPEL);
        ApplyEffectAtLocation(DURATION_TYPE_INSTANT,eAppear,lLoc);
        ApplyEffectAtLocation(DURATION_TYPE_INSTANT,eAppear,lExit);
        object oPortal1 = CreateObject(OBJECT_TYPE_PLACEABLE,"escapeportal",lLoc);
        object oPortal2 = CreateObject(OBJECT_TYPE_PLACEABLE,"plc_solwhite",lExit);
        DelayCommand(200.0,DestroyObject(oPortal1));
        DelayCommand(200.0,DestroyObject(oPortal2));
    }
}
