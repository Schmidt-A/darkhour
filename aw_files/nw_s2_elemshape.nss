//::///////////////////////////////////////////////
//:: Elemental Shape
//:: NW_S2_ElemShape
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Allows the Druid to change into elemental forms.
*/
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: Jan 22, 2002
//:://////////////////////////////////////////////
//:: Modified By: Iznoghoud - January 19 2004
/*
What this script changes:
Allows druid elemental shapes to get stacking item properties carried over correctly
just like shifters.
See Iznoghoud's x2_s2_gwildshp script for an in-detail description.
Added fix for a Bioware Bug: Druids now get elder wildshapes at level 20 and above,
not just when exactly level 20.
*/
//:://////////////////////////////////////////////

#include "ws_inc_shifter"
void main()
{
int nRound = GetLocalInt(GetModule(), "nRound");
if (nRound < 999)
{
    //Declare major variables
    int nSpell = GetSpellId();
    object oTarget = GetSpellTargetObject();
    effect eVis = EffectVisualEffect(VFX_IMP_POLYMORPH);
    effect ePoly;
    int nPoly;
    int nMetaMagic = GetMetaMagicFeat();
    int nDuration = GetCasterLevel(OBJECT_SELF);
    int bElder = FALSE;
    //Enter Metamagic conditions
    if (nMetaMagic == METAMAGIC_EXTEND)
    {
        nDuration = nDuration *2; //Duration is +100%
    }
    if(GetLevelByClass(CLASS_TYPE_DRUID) >= 20)
    {
        bElder = TRUE;
    }
    //Determine Polymorph subradial type
    if(bElder == FALSE)
    {
        if(nSpell == 397)
        {
            nPoly = POLYMORPH_TYPE_HUGE_FIRE_ELEMENTAL;
        }
        else if (nSpell == 398)
        {
            nPoly = POLYMORPH_TYPE_HUGE_WATER_ELEMENTAL;
        }
        else if (nSpell == 399)
        {
            nPoly = POLYMORPH_TYPE_HUGE_EARTH_ELEMENTAL;
        }
        else if (nSpell == 400)
        {
            nPoly = POLYMORPH_TYPE_HUGE_AIR_ELEMENTAL;
        }
    }
    else
    {
        if(nSpell == 397)
        {
            nPoly = POLYMORPH_TYPE_ELDER_FIRE_ELEMENTAL;
        }
        else if (nSpell == 398)
        {
            nPoly = POLYMORPH_TYPE_ELDER_WATER_ELEMENTAL;
        }
        else if (nSpell == 399)
        {
            nPoly = POLYMORPH_TYPE_ELDER_EARTH_ELEMENTAL;
        }
        else if (nSpell == 400)
        {
            nPoly = POLYMORPH_TYPE_ELDER_AIR_ELEMENTAL;
        }
    }

    int bWeapon;
    int bArmor;
    int bItems;
    int bCopyGlovesToClaws = FALSE;

    bWeapon = StringToInt(Get2DAString("polymorph","MergeW",nPoly)) == 1;

    if ( WS_ALWAYS_COPY_ARMOR_PROPS )
        bArmor = TRUE;
    else
        bArmor  = StringToInt(Get2DAString("polymorph","MergeA",nPoly)) == 1;

    if ( WS_ALWAYS_COPY_ITEM_PROPS )
        bItems = TRUE;
    else
        bItems  = StringToInt(Get2DAString("polymorph","MergeI",nPoly)) == 1;

    // Send message to PC about which items get merged to this form
    string sMerge;
    sMerge = "Merged: "; // <c~¬þ>: This is a color code that makes the text behind it sort of light blue.
    if(bArmor) sMerge += "<cazþ>Armor, Helmet, Shield";
    if(bItems) sMerge += ",</c> <caþa>Rings, Amulet, Cloak, Boots, Belt, Bracers";
    if( bWeapon || WS_COPY_WEAPON_PROPS_TO_UNARMED == 1 )
        sMerge += ",</c> <cþAA>Weapon";
    else if ( WS_COPY_WEAPON_PROPS_TO_UNARMED == 2 )
        sMerge += ",</c> <cþAA>Gloves to unarmed attacks";
    else if (WS_COPY_WEAPON_PROPS_TO_UNARMED == 3 )
        sMerge += ",</c> <cþAA>Weapon (if you had one equipped) or gloves to unarmed attacks";
    else
        sMerge += ",</c> <cþAA>No weapon or gloves to unarmed attacks";
    SendMessageToPC(oTarget,sMerge + ".</c>");

    // Store which items should transfer to this polymorph type. (For exportallchar scripts)
    SetLocalInt(oTarget, "GW_PolyID", nPoly);
    SetLocalInt(oTarget, "GW_bWeapon", bWeapon );
    SetLocalInt(oTarget, "GW_bArmor", bArmor );
    SetLocalInt(oTarget, "GW_bItems", bItems );

    //--------------------------------------------------------------------------
    // Store the old objects so we can access them after the character has
    // changed into his new form
    //--------------------------------------------------------------------------
    object oWeaponOld;
    object oArmorOld;
    object oRing1Old ;
    object oRing2Old;
    object oAmuletOld;
    object oCloakOld ;
    object oBootsOld  ;
    object oBeltOld   ;
    object oHelmetOld;
    object oShield ;
    object oBracerOld;
    object oHideOld;
    //Assume the normal shape doesn't have a creature skin object.
    //If using a subracesystem or something else that places a skin on the normal shape
    //another condition is needed to decide whether or not to store current items.
    //One way could be to scan all effects to see whether one is a polymorph effect.
    int nPolyed = GetIsObjectValid(GetItemInSlot(INVENTORY_SLOT_CARMOUR,OBJECT_SELF));
    // If there is a creature armor see if it is a creature hide put
    // on the unpolymorphed player by scanning for a polymorph effect.
    if ( nPolyed )
        nPolyed = ( ScanForPolymorphEffect(OBJECT_SELF) != -2 );
    if(! nPolyed)
    {
        //if not polymorphed get items worn and store on player.
        oWeaponOld = GetItemInSlot(INVENTORY_SLOT_RIGHTHAND,OBJECT_SELF);
        oArmorOld  = GetItemInSlot(INVENTORY_SLOT_CHEST,OBJECT_SELF);
        oRing1Old  = GetItemInSlot(INVENTORY_SLOT_LEFTRING,OBJECT_SELF);
        oRing2Old  = GetItemInSlot(INVENTORY_SLOT_RIGHTRING,OBJECT_SELF);
        oAmuletOld = GetItemInSlot(INVENTORY_SLOT_NECK,OBJECT_SELF);
        oCloakOld  = GetItemInSlot(INVENTORY_SLOT_CLOAK,OBJECT_SELF);
        oBootsOld  = GetItemInSlot(INVENTORY_SLOT_BOOTS,OBJECT_SELF);
        oBeltOld   = GetItemInSlot(INVENTORY_SLOT_BELT,OBJECT_SELF);
        oHelmetOld = GetItemInSlot(INVENTORY_SLOT_HEAD,OBJECT_SELF);
        oShield    = GetItemInSlot(INVENTORY_SLOT_LEFTHAND,OBJECT_SELF);
        oBracerOld  = GetItemInSlot(INVENTORY_SLOT_ARMS,OBJECT_SELF);
        oHideOld = GetItemInSlot(INVENTORY_SLOT_CARMOUR,OBJECT_SELF);
        SetLocalObject(OBJECT_SELF,"GW_OldWeapon",oWeaponOld);
        SetLocalObject(OBJECT_SELF,"GW_OldArmor",oArmorOld);
        SetLocalObject(OBJECT_SELF,"GW_OldRing1",oRing1Old);
        SetLocalObject(OBJECT_SELF,"GW_OldRing2",oRing2Old);
        SetLocalObject(OBJECT_SELF,"GW_OldAmulet",oAmuletOld);
        SetLocalObject(OBJECT_SELF,"GW_OldCloak",oCloakOld);
        SetLocalObject(OBJECT_SELF,"GW_OldBoots",oBootsOld);
        SetLocalObject(OBJECT_SELF,"GW_OldBelt",oBeltOld);
        SetLocalObject(OBJECT_SELF,"GW_OldHelmet",oHelmetOld);
        SetLocalObject(OBJECT_SELF,"GW_OldBracer",oBracerOld);
        SetLocalObject(OBJECT_SELF,"GW_OldHide",oHideOld);
        if (GetIsObjectValid(oShield))
        {
            if (GetBaseItemType(oShield) !=BASE_ITEM_LARGESHIELD &&
                GetBaseItemType(oShield) !=BASE_ITEM_SMALLSHIELD &&
                GetBaseItemType(oShield) !=BASE_ITEM_TOWERSHIELD)
            {
                oShield = OBJECT_INVALID;
            }
        }
        SetLocalObject(OBJECT_SELF,"GW_OldShield",oShield);

    }
    else
    {
        //if already polymorphed use items stored earlier.
        oWeaponOld =     GetLocalObject(OBJECT_SELF,"GW_OldWeapon");
        oArmorOld  =     GetLocalObject(OBJECT_SELF,"GW_OldArmor");
        oRing1Old  =     GetLocalObject(OBJECT_SELF,"GW_OldRing1");
        oRing2Old  =     GetLocalObject(OBJECT_SELF,"GW_OldRing2");
        oAmuletOld =     GetLocalObject(OBJECT_SELF,"GW_OldAmulet");
        oCloakOld  =     GetLocalObject(OBJECT_SELF,"GW_OldCloak");
        oBootsOld  =     GetLocalObject(OBJECT_SELF,"GW_OldBoots");
        oBeltOld   =     GetLocalObject(OBJECT_SELF,"GW_OldBelt");
        oHelmetOld =     GetLocalObject(OBJECT_SELF,"GW_OldHelmet");
        oShield    =     GetLocalObject(OBJECT_SELF,"GW_OldShield");
        oBracerOld =     GetLocalObject(OBJECT_SELF,"GW_OldBracer");
        oHideOld   =     GetLocalObject(OBJECT_SELF,"GW_OldHide");
    }

    //--------------------------------------------------------------------------
    // Here the actual polymorphing is done
    //--------------------------------------------------------------------------
    ePoly = EffectPolymorph(nPoly);
    //--------------------------------------------------------------------------
    // Iznoghoud: Link the stackable properties as permanent bonuses to the
    // Polymorph effect, instead of putting them on the creature hide. They will
    // properly disappear as soon as the polymorph is ended.
    //--------------------------------------------------------------------------
    ePoly = AddStackablePropertiesToPoly ( oTarget, ePoly, bWeapon, bItems, bArmor, oArmorOld, oRing1Old, oRing2Old, oAmuletOld, oCloakOld, oBracerOld, oBootsOld, oBeltOld, oHelmetOld, oShield, oWeaponOld, oHideOld);
    ePoly = ExtraordinaryEffect(ePoly);
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, OBJECT_SELF);
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, ePoly, OBJECT_SELF, HoursToSeconds(nDuration));
    //Fire cast spell at event for the specified target
    SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELLABILITY_ELEMENTAL_SHAPE, FALSE));
    //--------------------------------------------------------------------------
    // This code handles the merging of item properties
    //--------------------------------------------------------------------------
    object oWeaponNew = GetItemInSlot(INVENTORY_SLOT_RIGHTHAND,OBJECT_SELF);
    object oArmorNew = GetItemInSlot(INVENTORY_SLOT_CARMOUR,OBJECT_SELF);
    object oClawLeft = GetItemInSlot(INVENTORY_SLOT_CWEAPON_L,OBJECT_SELF);
    object oClawRight = GetItemInSlot(INVENTORY_SLOT_CWEAPON_R,OBJECT_SELF);
    object oBite = GetItemInSlot(INVENTORY_SLOT_CWEAPON_B,OBJECT_SELF);
    //--------------------------------------------------------------------------
    // ...Weapons
    //--------------------------------------------------------------------------
    if (bWeapon)
    {
        //----------------------------------------------------------------------
        // GZ: 2003-10-20
        // Sorry, but I was forced to take that out, it was confusing people
        // and there were problems with updating the stats sheet.
        //----------------------------------------------------------------------
        /* if (!GetIsObjectValid(oWeaponOld))
        {
            //------------------------------------------------------------------
            // If we had no weapon equipped before, remove the old weapon
            // to allow monks to change into unarmed forms by not equipping any
            // weapon before polymorphing
            //------------------------------------------------------------------
            DestroyObject(oWeaponNew);
        }
        else*/
        {
            //------------------------------------------------------------------
            // Merge item properties...
            //------------------------------------------------------------------
            WildshapeCopyWeaponProperties(oTarget, oWeaponOld, oWeaponNew);
        }
    }
    else {
        switch ( WS_COPY_WEAPON_PROPS_TO_UNARMED )
        {
        case 1: // Copy over weapon properties to claws/bite
            WildshapeCopyNonStackProperties(oWeaponOld,oClawLeft, TRUE);
            WildshapeCopyNonStackProperties(oWeaponOld,oClawRight, TRUE);
            WildshapeCopyNonStackProperties(oWeaponOld,oBite, TRUE);
            break;
        case 2: // Copy over glove properties to claws/bite
            WildshapeCopyNonStackProperties(oBracerOld,oClawLeft, FALSE);
            WildshapeCopyNonStackProperties(oBracerOld,oClawRight, FALSE);
            WildshapeCopyNonStackProperties(oBracerOld,oBite, FALSE);
            bCopyGlovesToClaws = TRUE;
            break;
        case 3: // Copy over weapon properties to claws/bite if wearing a weapon, otherwise copy gloves
            if ( GetIsObjectValid(oWeaponOld) )
            {
                WildshapeCopyNonStackProperties(oWeaponOld,oClawLeft, TRUE);
                WildshapeCopyNonStackProperties(oWeaponOld,oClawRight, TRUE);
                WildshapeCopyNonStackProperties(oWeaponOld,oBite, TRUE);
            }
            else
            {
                WildshapeCopyNonStackProperties(oBracerOld,oClawLeft, FALSE);
                WildshapeCopyNonStackProperties(oBracerOld,oClawRight, FALSE);
                WildshapeCopyNonStackProperties(oBracerOld,oBite, FALSE);
                bCopyGlovesToClaws = TRUE;
            }
            break;
        default: // Do not copy over anything
            break;
        };
    }
    //--------------------------------------------------------------------------
    // ...Armor
    //--------------------------------------------------------------------------
    if (bArmor)
    {
        //----------------------------------------------------------------------
        // Merge item properties from armor and helmet...
        //----------------------------------------------------------------------
        WildshapeCopyNonStackProperties(oArmorOld,oArmorNew);
        WildshapeCopyNonStackProperties(oHelmetOld,oArmorNew);
        WildshapeCopyNonStackProperties(oShield,oArmorNew);
        WildshapeCopyNonStackProperties(oHideOld,oArmorNew);
    }
    //--------------------------------------------------------------------------
    // ...Magic Items
    //--------------------------------------------------------------------------
    if (bItems)
    {
        //----------------------------------------------------------------------
        // Merge item properties from from rings, amulets, cloak, boots, belt
        // Iz: And bracers, in case oBracerOld gets set to a valid object.
        //----------------------------------------------------------------------
        WildshapeCopyNonStackProperties(oRing1Old,oArmorNew);
        WildshapeCopyNonStackProperties(oRing2Old,oArmorNew);
        WildshapeCopyNonStackProperties(oAmuletOld,oArmorNew);
        WildshapeCopyNonStackProperties(oCloakOld,oArmorNew);
        WildshapeCopyNonStackProperties(oBootsOld,oArmorNew);
        WildshapeCopyNonStackProperties(oBeltOld,oArmorNew);
        // Because Bracers can have On Hit Cast Spell type properties we should
        // avoid copying the bracers twice. Otherwise the player can get that On
        // Hit effect both when hitting, and getting hit.
        if ( bCopyGlovesToClaws == FALSE )
            WildshapeCopyNonStackProperties(oBracerOld,oArmorNew);
    }
}
}
