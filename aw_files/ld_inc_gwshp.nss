//::///////////////////////////////////////////////
//:: Name Greater Wild Shape Storage
//:: FileName ld_inc_gwshp.nss
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    The purpose of this series of functions
    is to compensate for a bug that remains
    unfixed to date by Bioware which causes
    morphed PC's to remorph on heartbeat and
    similar events. This is not a perfect fix
    but it at least allows players to use the
    shifter class on multiplayer servers.


//:://////////////////////////////////////////////
//:: Include this file and Place the hook below
//:: in your OnPlayerRest Event,
//:://////////////////////////////////////////////

    ClearShifterStored(GetLastPCRested());

//:://////////////////////////////////////////////
//:: Include this file and place the hook below
//:: in your OnPlayerDeath Event,
//:://////////////////////////////////////////////

    ClearShifterStored(GetLastPlayerDied());


    If you know the location of the cancel polymorph
    script you can include the above function in it as
    well. Also, if you do know where that is an email
    to shargenmepps@yahoo.com letting me know would
    be greatfully accepted.

*/
//:://////////////////////////////////////////////
//:: Created By: Lord Delekhan
//:: Created On: January 29, 2004
//:://////////////////////////////////////////////
/*
struct Worn {
    object oWeaponOld;
    object oArmorOld;
    object oRing1Old;
    object oRing2Old;
    object oAmuletOld;
    object oCloakOld;
    object oBootsOld;
    object oBeltOld;
    object oHelmetOld;
    object oShield;
};


int StoredShifterItems(object oPC);
void StoreShifterItems(object oPC);
struct Worn RestoreShifterItems(object oPC);
void ClearShifterStored(object oPC);

int StoredShifterItems(object oPC)
{
   return GetLocalInt(oPC,"Stored");
}

void StoreShifterItems(object oPC)
{
    SetLocalInt(oPC,"Stored",TRUE);
    SetLocalObject(oPC,"Weapon",GetItemInSlot(INVENTORY_SLOT_RIGHTHAND,oPC));
    SetLocalObject(oPC,"Armor",GetItemInSlot(INVENTORY_SLOT_CHEST,oPC));
    SetLocalObject(oPC,"Ring1",GetItemInSlot(INVENTORY_SLOT_LEFTRING,oPC));
    SetLocalObject(oPC,"Ring2",GetItemInSlot(INVENTORY_SLOT_RIGHTRING,oPC));
    SetLocalObject(oPC,"Amulet",GetItemInSlot(INVENTORY_SLOT_NECK,oPC));
    SetLocalObject(oPC,"Cloak",GetItemInSlot(INVENTORY_SLOT_CLOAK,oPC));
    SetLocalObject(oPC,"Boots",GetItemInSlot(INVENTORY_SLOT_BOOTS,oPC));
    SetLocalObject(oPC,"Belt",GetItemInSlot(INVENTORY_SLOT_BELT,oPC));
    SetLocalObject(oPC,"Helmet",GetItemInSlot(INVENTORY_SLOT_HEAD,oPC));
    SetLocalObject(oPC,"Shield",GetItemInSlot(INVENTORY_SLOT_LEFTHAND,oPC));
}

struct Worn RestoreShifterItems(object oPC)
{
    struct Worn Stored;
    Stored.oWeaponOld = GetLocalObject(oPC,"Weapon");
    Stored.oArmorOld = GetLocalObject(oPC,"Armor");
    Stored.oRing1Old = GetLocalObject(oPC,"Ring1");
    Stored.oRing2Old = GetLocalObject(oPC,"Ring2");
    Stored.oAmuletOld = GetLocalObject(oPC,"Amulet");
    Stored.oCloakOld = GetLocalObject(oPC,"Cloak");
    Stored.oBootsOld = GetLocalObject(oPC,"Boots");
    Stored.oBeltOld = GetLocalObject(oPC,"Belt");
    Stored.oHelmetOld = GetLocalObject(oPC,"Helmet");
    Stored.oShield = GetLocalObject(oPC,"Shield");
    return Stored;
}

void ClearShifterStored(object oPC)
{
    DeleteLocalInt(oPC,"Stored");
}
//void main(){}      */
