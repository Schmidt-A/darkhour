//::///////////////////////////////////////////////
//:: Greater Wild Shape, Humanoid Shape
//:: x2_s2_gwildshp
//:: Copyright (c) 2003 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Allows the character to shift into one of these
    forms, gaining special abilities
    Credits must be given to mr_bumpkin from the NWN
    community who had the idea of merging item properties
    from weapon and armor to the creatures new forms.
*/
//:://////////////////////////////////////////////
//:: Created By: Georg Zoeller
//:: Created On: 2003-07-02
//:://////////////////////////////////////////////
//:: Modified By: Iznoghoud
/*
What this script changes:
- Tower shields now carry over their properties just like Small and Large
shields. (Which has been a bug I believe since the original script had 2 checks
for SMALLSHIELD in it, one probably should have been TOWERSHIELD)
- Melee Weapon properties now carry over to the unarmed forms' claws and bite
attacks.
- My last (and most complicated) changes:
1) Now, items with an AC bonus (or penalty) carry over to the shifted form as
the correct type. This means if you wear an amulet of natural armor +4, and a
cloak of protection +5, and you shift to a form that gets all item properties
carried over, you will have the +4 natural armor bonus from the ammy, as well as
the +5 deflection bonus from the cloak. No longer will the highest one override
all the other AC bonuses even if they are a different type. Note that some
forms, such as the dragon, get an inherent natural AC bonus, which may still
override your amulet of natural armor, if the inherent bonus is better.
2) Other "stackable" item properties, like ability bonuses, skill bonuses and
saving throw bonuses, now correctly add up in shifted form. This means if you
have a ring that gives +2 strength, and a ring with +3 strength, and you shift
into a drow warrior, you get +5 strength in shifted form, where you used to get
only +3. (the highest)

-- Modified by StoneDK 2003.12.21
Added saving of old equip to allow items to be applied without going
through normal shape, should now get item effects even when changing
directly from wyrm to kobold shape.
Added message to player about which items are merged.

-- Modified by Iznoghoud 2003-12-26
Added storing of Polymorph ID on the player for letting exportallchars() scripts
reapply polymorphing effects when saving

-- Modified by Iznoghoud 2003-12-27
Added regeneration as a stacking property, bracers now stored correctly for re-shifting,
Added constants for easy configuration.

-- Modified by Iznoghoud January 13 2004
The bulk of the handling of stacking item properties, as well as the constants
for configuration, are now in ws_inc_shifter, which is included
by this file, and the two druid polymorphing scripts, nw_s2_elemshape and nw_s2_wildshape.
Made the message about which items are merged more explicit.
*/
//:://////////////////////////////////////////////

#include "ws_inc_shifter"

// Main function of the script
void main()
{
int nRound = GetLocalInt(GetModule(), "nRound");
if (nRound < 999)
{
    //--------------------------------------------------------------------------
    // Declare major variables
    //--------------------------------------------------------------------------
    object oPC = OBJECT_SELF;
    int    nSpell = GetSpellId();
    object oTarget = GetSpellTargetObject();
    effect eVis = EffectVisualEffect(VFX_IMP_POLYMORPH);
    int    nShifter = GetLevelByClass(CLASS_TYPE_SHIFTER);
    effect ePoly;
    int    nPoly;
    //--------------------------------------------------------------------------
    // Determine which form to use based on spell id, gender and level
    //--------------------------------------------------------------------------
    switch (nSpell)
    {
        //-----------------------------------------------------------------------
        // Greater Wildshape I - Wyrmling Shape
        //-----------------------------------------------------------------------
        case 658:  nPoly = POLYMORPH_TYPE_WYRMLING_RED; break;
        case 659:  nPoly = POLYMORPH_TYPE_WYRMLING_BLUE; break;
        case 660:  nPoly = POLYMORPH_TYPE_WYRMLING_BLACK; break;
        case 661:  nPoly = POLYMORPH_TYPE_WYRMLING_WHITE; break;
        case 662:  nPoly = POLYMORPH_TYPE_WYRMLING_GREEN; break;
        //-----------------------------------------------------------------------
        // Greater Wildshape II  - Minotaur, Gargoyle, Harpy
        //-----------------------------------------------------------------------
        case 672: if (nShifter < X2_GW2_EPIC_THRESHOLD)
                     nPoly = POLYMORPH_TYPE_HARPY;
                  else
                     nPoly = 97;
                  break;
        case 678: if (nShifter < X2_GW2_EPIC_THRESHOLD)
                     nPoly = POLYMORPH_TYPE_GARGOYLE;
                  else
                     nPoly = 98;
                  break;
        case 680: if (nShifter < X2_GW2_EPIC_THRESHOLD)
                     nPoly = POLYMORPH_TYPE_MINOTAUR;
                  else
                     nPoly = 96;
                  break;
        //-----------------------------------------------------------------------
        // Greater Wildshape III  - Drider, Basilisk, Manticore
        //-----------------------------------------------------------------------
        case 670: if (nShifter < X2_GW3_EPIC_THRESHOLD)
                     nPoly = POLYMORPH_TYPE_BASILISK;
                  else
                     nPoly = 99;
                  break;
        case 673: if (nShifter < X2_GW3_EPIC_THRESHOLD)
                     nPoly = POLYMORPH_TYPE_DRIDER;
                  else
                     nPoly = 100;
                  break;
        case 674: if (nShifter < X2_GW3_EPIC_THRESHOLD)
                     nPoly = POLYMORPH_TYPE_MANTICORE;
                  else
                     nPoly = 101;
                  break;
       //-----------------------------------------------------------------------
       // Greater Wildshape IV - Dire Tiger, Medusa, MindFlayer
       //-----------------------------------------------------------------------
        case 679: nPoly = POLYMORPH_TYPE_MEDUSA; break;
        case 691: nPoly = 68; break; // Mindflayer
        case 694: nPoly = 69; break; // DireTiger
       //-----------------------------------------------------------------------
       // Humanoid Shape - Kobold Commando, Drow, Lizard Crossbow Specialist
       //-----------------------------------------------------------------------
       case 682:
                 if(nShifter< 17)
                 {
                     if (GetGender(OBJECT_SELF) == GENDER_MALE) //drow
                         nPoly = 59;
                     else
                         nPoly = 70;
                 }
                 else
                 {
                     if (GetGender(OBJECT_SELF) == GENDER_MALE) //drow
                         nPoly = 105;
                     else
                         nPoly = 106;
                 }
                 break;
       case 683:
                 if(nShifter< 17)
                 {
                    nPoly = 82; break; // Lizard
                 }
                 else
                 {
                    nPoly =104; break; // Epic Lizard
                 }
       case 684: if(nShifter< 17)
                 {
                    nPoly = 83; break; // Kobold Commando
                 }
                 else
                 {
                    nPoly = 103; break; // Kobold Commando
                 }
       //-----------------------------------------------------------------------
       // Undead Shape - Spectre, Risen Lord, Vampire
       //-----------------------------------------------------------------------
       case 704: nPoly = 75; break; // Risen lord
       case 705: if (GetGender(OBJECT_SELF) == GENDER_MALE) // vampire
                     nPoly = 74;
                  else
                     nPoly = 77;
                 break;
       case 706: nPoly = 76; break; /// spectre
       //-----------------------------------------------------------------------
       // Dragon Shape - Red Blue and Green Dragons
       //-----------------------------------------------------------------------
       case 707: nPoly = 72; break; // Ancient Red   Dragon
       case 708: nPoly = 71; break; // Ancient Blue  Dragon
       case 709: nPoly = 73; break; // Ancient Green Dragon
       //-----------------------------------------------------------------------
       // Outsider Shape - Rakshasa, Azer Chieftain, Black Slaad
       //-----------------------------------------------------------------------
       case 733:   if (GetGender(OBJECT_SELF) == GENDER_MALE) //azer
                      nPoly = 85;
                    else // anything else is female
                      nPoly = 86;
                    break;
       case 734:   if (GetGender(OBJECT_SELF) == GENDER_MALE) //rakshasa
                      nPoly = 88;
                    else // anything else is female
                      nPoly = 89;
                    break;
       case 735: nPoly =87; break; // slaad
       //-----------------------------------------------------------------------
       // Construct Shape - Stone Golem, Iron Golem, Demonflesh Golem
       //-----------------------------------------------------------------------
       case 738: nPoly =91; break; // stone golem
       case 739: nPoly =92; break; // demonflesh golem
       case 740: nPoly =90; break; // iron golem
    }
    //--------------------------------------------------------------------------
    // Determine which items get their item properties merged onto the shifters
    // new form.
    //--------------------------------------------------------------------------
    int bWeapon;
    int bArmor;
    int bItems;
    int bCopyGlovesToClaws = FALSE;

    bWeapon = ShifterMergeWeapon(nPoly);

    if ( GW_ALWAYS_COPY_ARMOR_PROPS )
        bArmor = TRUE;
    else
        bArmor  = ShifterMergeArmor(nPoly);

    if ( GW_ALWAYS_COPY_ITEM_PROPS )
        bItems = TRUE;
    else
        bItems  = ShifterMergeItems(nPoly);

    // Send message to PC about which items get merged to this form
    string sMerge;
    sMerge = "Merged: "; // <c~¬þ>: This is a color code that makes the text behind it sort of light blue.
    if(bArmor) sMerge += "<cazþ>Armor, Helmet, Shield";
    if(bItems) sMerge += ",</c> <caþa>Rings, Amulet, Cloak, Boots, Belt, Bracers";
    if( bWeapon || GW_COPY_WEAPON_PROPS_TO_UNARMED == 1 )
        sMerge += ",</c> <cþAA>Weapon";
    else if ( GW_COPY_WEAPON_PROPS_TO_UNARMED == 2 )
        sMerge += ",</c> <cþAA>Gloves to unarmed attacks";
    else if (GW_COPY_WEAPON_PROPS_TO_UNARMED == 3 )
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

        //prevent monks from getting shield bonus
        int hasMonkLvls = GetLevelByClass(CLASS_TYPE_MONK);

        if (GetIsObjectValid(oShield))
        {
            if ((GetBaseItemType(oShield) !=BASE_ITEM_LARGESHIELD &&
                GetBaseItemType(oShield) !=BASE_ITEM_SMALLSHIELD &&
                GetBaseItemType(oShield) !=BASE_ITEM_TOWERSHIELD) /*|| hasMonkLvls*/)
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
    ePoly = AddStackablePropertiesToPoly ( oPC, ePoly, bWeapon, bItems, bArmor, oArmorOld, oRing1Old, oRing2Old, oAmuletOld, oCloakOld, oBracerOld, oBootsOld, oBeltOld, oHelmetOld, oShield, oWeaponOld, oHideOld);
    ePoly = ExtraordinaryEffect(ePoly);
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, OBJECT_SELF);
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, ePoly, OBJECT_SELF);
    SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, GetSpellId(), FALSE));
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
            WildshapeCopyWeaponProperties(oTarget, oWeaponOld,oWeaponNew);
        }
    }
    else {
        switch ( GW_COPY_WEAPON_PROPS_TO_UNARMED )
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
    //--------------------------------------------------------------------------
    // Set artificial usage limits for special ability spells to work around
    // the engine limitation of not being able to set a number of uses for
    // spells in the polymorph radial
    //--------------------------------------------------------------------------
    ShifterSetGWildshapeSpellLimits(nSpell);
}
}

