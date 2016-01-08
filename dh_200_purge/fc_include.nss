// * FC_INCLUDE.nss
// * Created on 7/26/04
// * FRAGILE CONTENTS SYSTEM V1.0 by Seka


// * ---------
// * CONSTANTS
// * ---------

// * Adjust these as you see fit.  A setting of TRUE will make items of
// * that type breakable.

const int AMULETS_ARE_BREAKABLE = TRUE;
const int ARMOR_IS_BREAKABLE = TRUE;
const int ARROWS_ARE_BREAKABLE = TRUE;
const int BASTARDSWORDS_ARE_BREAKABLE = TRUE;
const int BATTLEAXES_ARE_BREAKABLE = TRUE;
const int BELTS_ARE_BREAKABLE = TRUE;
const int BOLTS_ARE_BREAKABLE = TRUE;
const int BOOKS_ARE_BREAKABLE = TRUE;
const int BOOTS_ARE_BREAKABLE = TRUE;
const int BRACERS_ARE_BREAKABLE = TRUE;
const int BULLETS_ARE_BREAKABLE = TRUE;
const int CLOAKS_ARE_BREAKABLE = TRUE;
const int CLUBS_ARE_BREAKABLE = TRUE;
const int DAGGERS_ARE_BREAKABLE = TRUE;
const int DARTS_ARE_BREAKABLE = TRUE;
const int DIREMACES_ARE_BREAKABLE = TRUE;
const int DOUBLEAXES_ARE_BREAKABLE = TRUE;
const int GEMS_ARE_BREAKABLE = TRUE;
const int GLOVES_ARE_BREAKABLE = TRUE;
const int GOLD_IS_BREAKABLE = TRUE;
const int GREATAXES_ARE_BREAKABLE = TRUE;
const int GREATSWORDS_ARE_BREAKABLE = TRUE;
const int GRENADES_ARE_BREAKABLE = TRUE;
const int HALBERDS_ARE_BREAKABLE = TRUE;
const int HANDAXES_ARE_BREAKABLE = TRUE;
const int HEALERSKITS_ARE_BREAKABLE = TRUE;
const int HEAVYCROSSBOWS_ARE_BREAKABLE = TRUE;
const int HEAVYFLAILS_ARE_BREAKABLE = TRUE;
const int HELMETS_ARE_BREAKABLE = TRUE;
const int JEWELS_ARE_BREAKABLE = TRUE;
const int KAMAS_ARE_BREAKABLE = TRUE;
const int KATANAS_ARE_BREAKABLE = TRUE;
const int KEYS_ARE_BREAKABLE = TRUE;
const int KUKRI_ARE_BREAKABLE = TRUE;
const int LARGEBOXES_ARE_BREAKABLE = TRUE;
const int LARGESHIELDS_ARE_BREAKABLE = TRUE;
const int LIGHTCROSSBOWS_ARE_BREAKABLE = TRUE;
const int LIGHTFLAILS_ARE_BREAKABLE = TRUE;
const int LIGHTHAMMERS_ARE_BREAKABLE = TRUE;
const int LIGHTMACES_ARE_BREAKABLE = TRUE;
const int LONGBOWS_ARE_BREAKABLE = TRUE;
const int LONGSWORDS_ARE_BREAKABLE = TRUE;
const int MAGICRODS_ARE_BREAKABLE = TRUE;
const int MAGICSTAFFS_ARE_BREAKABLE = TRUE;
const int MAGICWANDS_ARE_BREAKABLE = TRUE;
const int MORNINGSTARS_ARE_BREAKABLE = TRUE;
const int POTIONS_ARE_BREAKABLE = TRUE;
const int QUARTERSTAFFS_ARE_BREAKABLE = TRUE;
const int RAPIERS_ARE_BREAKABLE = TRUE;
const int RINGS_ARE_BREAKABLE = TRUE;
const int SCIMITARS_ARE_BREAKABLE = TRUE;
const int SCROLLS_ARE_BREAKABLE = TRUE;
const int SCYTHES_ARE_BREAKABLE = TRUE;
const int SHORTBOWS_ARE_BREAKABLE = TRUE;
const int SHORTSPEARS_ARE_BREAKABLE = TRUE;
const int SHORTSWORDS_ARE_BREAKABLE = TRUE;
const int SHURIKEN_ARE_BREAKABLE = TRUE;
const int SICKLES_ARE_BREAKABLE = TRUE;
const int SLINGS_ARE_BREAKABLE = TRUE;
const int SMALLSHIELDS_ARE_BREAKABLE = TRUE;
const int THIEVESTOOLS_ARE_BREAKABLE = TRUE;
const int THROWINGAXES_ARE_BREAKABLE = TRUE;
const int TORCHES_ARE_BREAKABLE = TRUE;
const int TOWERSHIELDS_ARE_BREAKABLE = TRUE;
const int TRAPKITS_ARE_BREAKABLE = TRUE;
const int TWOBLADEDSWORDS_ARE_BREAKABLE = TRUE;
const int WARHAMMERS_ARE_BREAKABLE = TRUE;
const int WHIPS_ARE_BREAKABLE = TRUE;
const string sBrokenObject = "brokenobject"; // This string must be the resref of the "Broken Pieces" item, not the item tag, because it's a custom object.
const int MAX_CHANCE_OF_DMG = 95; // The cap for the likelihood of broken objects (max: 100)
const int DAMAGE_INCREMENT = 40; // Each time a container is damaged, the chance of broken items is increased by this percentage.

// * ---------
// * FUNCTIONS
// * ---------

// * GetItemBreakability checks the above constants and returns TRUE if
// * the item type in question is capable of being broken.
// * ADJUST ITEM BREAKABILITY IN THE CONSTANTS SECTION ABOVE, NOT HERE.

int GetItemBreakability(int nNewItemType)
{
    int nBreakable = FALSE;
    switch (nNewItemType)
    {
        case BASE_ITEM_AMULET: nBreakable = AMULETS_ARE_BREAKABLE; break;
        case BASE_ITEM_ARMOR: nBreakable = ARMOR_IS_BREAKABLE; break;
        case BASE_ITEM_ARROW: nBreakable = ARROWS_ARE_BREAKABLE; break;
        case BASE_ITEM_BASTARDSWORD: nBreakable = BASTARDSWORDS_ARE_BREAKABLE; break;
        case BASE_ITEM_BATTLEAXE: nBreakable = BATTLEAXES_ARE_BREAKABLE; break;
        case BASE_ITEM_BELT: nBreakable = BELTS_ARE_BREAKABLE; break;
        case BASE_ITEM_BLANK_POTION: nBreakable = POTIONS_ARE_BREAKABLE; break;
        case BASE_ITEM_BLANK_SCROLL: nBreakable = SCROLLS_ARE_BREAKABLE; break;
        case BASE_ITEM_BLANK_WAND: nBreakable = MAGICWANDS_ARE_BREAKABLE; break;
        case BASE_ITEM_BOLT: nBreakable = BOLTS_ARE_BREAKABLE; break;
        case BASE_ITEM_BOOK: nBreakable = BOOKS_ARE_BREAKABLE; break;
        case BASE_ITEM_BOOTS: nBreakable = BOOTS_ARE_BREAKABLE; break;
        case BASE_ITEM_BRACER: nBreakable = BRACERS_ARE_BREAKABLE; break;
        case BASE_ITEM_BULLET: nBreakable = BULLETS_ARE_BREAKABLE; break;
        case BASE_ITEM_CLOAK: nBreakable = CLOAKS_ARE_BREAKABLE; break;
        case BASE_ITEM_CLUB: nBreakable = CLUBS_ARE_BREAKABLE; break;
        case BASE_ITEM_DAGGER: nBreakable = DAGGERS_ARE_BREAKABLE; break;
        case BASE_ITEM_DART: nBreakable = DARTS_ARE_BREAKABLE; break;
        case BASE_ITEM_DIREMACE: nBreakable = DIREMACES_ARE_BREAKABLE; break;
        case BASE_ITEM_DOUBLEAXE: nBreakable = DOUBLEAXES_ARE_BREAKABLE; break;
        case BASE_ITEM_DWARVENWARAXE: nBreakable = BATTLEAXES_ARE_BREAKABLE; break;
        case BASE_ITEM_ENCHANTED_POTION: nBreakable = POTIONS_ARE_BREAKABLE; break;
        case BASE_ITEM_ENCHANTED_SCROLL: nBreakable = SCROLLS_ARE_BREAKABLE; break;
        case BASE_ITEM_ENCHANTED_WAND: nBreakable = MAGICWANDS_ARE_BREAKABLE; break;
        case BASE_ITEM_GEM: nBreakable = GEMS_ARE_BREAKABLE; break;
        case BASE_ITEM_GLOVES: nBreakable = GLOVES_ARE_BREAKABLE; break;
        case BASE_ITEM_GOLD: nBreakable = GOLD_IS_BREAKABLE; break;
        case BASE_ITEM_GREATAXE: nBreakable = GREATAXES_ARE_BREAKABLE; break;
        case BASE_ITEM_GREATSWORD: nBreakable = GREATSWORDS_ARE_BREAKABLE; break;
        case BASE_ITEM_GRENADE: nBreakable = GRENADES_ARE_BREAKABLE; break;
        case BASE_ITEM_HALBERD: nBreakable = HALBERDS_ARE_BREAKABLE; break;
        case BASE_ITEM_HANDAXE: nBreakable = HANDAXES_ARE_BREAKABLE; break;
        case BASE_ITEM_HEALERSKIT: nBreakable = HEALERSKITS_ARE_BREAKABLE; break;
        case BASE_ITEM_HEAVYCROSSBOW: nBreakable = HEAVYCROSSBOWS_ARE_BREAKABLE; break;
        case BASE_ITEM_HEAVYFLAIL: nBreakable = HEAVYFLAILS_ARE_BREAKABLE; break;
        case BASE_ITEM_HELMET: nBreakable = HELMETS_ARE_BREAKABLE; break;
        case BASE_ITEM_KAMA: nBreakable = KAMAS_ARE_BREAKABLE; break;
        case BASE_ITEM_KEY: nBreakable = KEYS_ARE_BREAKABLE; break;
        case BASE_ITEM_KUKRI: nBreakable = KUKRI_ARE_BREAKABLE; break;
        case BASE_ITEM_LARGEBOX: nBreakable = LARGEBOXES_ARE_BREAKABLE; break;
        case BASE_ITEM_LARGESHIELD: nBreakable = LARGESHIELDS_ARE_BREAKABLE; break;
        case BASE_ITEM_LIGHTCROSSBOW: nBreakable = LIGHTCROSSBOWS_ARE_BREAKABLE; break;
        case BASE_ITEM_LIGHTFLAIL: nBreakable = LIGHTFLAILS_ARE_BREAKABLE; break;
        case BASE_ITEM_LIGHTHAMMER: nBreakable = LIGHTHAMMERS_ARE_BREAKABLE; break;
        case BASE_ITEM_LIGHTMACE: nBreakable = LIGHTMACES_ARE_BREAKABLE; break;
        case BASE_ITEM_LONGBOW: nBreakable = LONGBOWS_ARE_BREAKABLE; break;
        case BASE_ITEM_LONGSWORD: nBreakable = LONGSWORDS_ARE_BREAKABLE; break;
        case BASE_ITEM_MAGICROD: nBreakable = MAGICRODS_ARE_BREAKABLE; break;
        case BASE_ITEM_MAGICSTAFF: nBreakable = MAGICSTAFFS_ARE_BREAKABLE; break;
        case BASE_ITEM_MAGICWAND: nBreakable = MAGICWANDS_ARE_BREAKABLE; break;
        case BASE_ITEM_MORNINGSTAR: nBreakable = MORNINGSTARS_ARE_BREAKABLE; break;
        case BASE_ITEM_POTIONS: nBreakable = POTIONS_ARE_BREAKABLE; break;
        case BASE_ITEM_QUARTERSTAFF: nBreakable = QUARTERSTAFFS_ARE_BREAKABLE; break;
        case BASE_ITEM_RAPIER: nBreakable = RAPIERS_ARE_BREAKABLE; break;
        case BASE_ITEM_RING: nBreakable = RINGS_ARE_BREAKABLE; break;
        case BASE_ITEM_SCIMITAR: nBreakable = SCIMITARS_ARE_BREAKABLE; break;
        case BASE_ITEM_SCYTHE: nBreakable = SCYTHES_ARE_BREAKABLE; break;
        case BASE_ITEM_SHORTBOW: nBreakable = SHORTBOWS_ARE_BREAKABLE; break;
        case BASE_ITEM_SHORTSPEAR: nBreakable = SHORTSPEARS_ARE_BREAKABLE; break;
        case BASE_ITEM_SHORTSWORD: nBreakable = SHORTSWORDS_ARE_BREAKABLE; break;
        case BASE_ITEM_SHURIKEN: nBreakable = SHURIKEN_ARE_BREAKABLE; break;
        case BASE_ITEM_SICKLE: nBreakable = SICKLES_ARE_BREAKABLE; break;
        case BASE_ITEM_SLING: nBreakable = SLINGS_ARE_BREAKABLE; break;
        case BASE_ITEM_SMALLSHIELD: nBreakable = SMALLSHIELDS_ARE_BREAKABLE; break;
        case BASE_ITEM_SPELLSCROLL: nBreakable = SCROLLS_ARE_BREAKABLE; break;
        case BASE_ITEM_THIEVESTOOLS: nBreakable = THIEVESTOOLS_ARE_BREAKABLE; break;
        case BASE_ITEM_THROWINGAXE: nBreakable = THROWINGAXES_ARE_BREAKABLE; break;
        case BASE_ITEM_TORCH: nBreakable = TORCHES_ARE_BREAKABLE; break;
        case BASE_ITEM_TOWERSHIELD: nBreakable = TOWERSHIELDS_ARE_BREAKABLE; break;
        case BASE_ITEM_TRAPKIT: nBreakable = TRAPKITS_ARE_BREAKABLE; break;
        case BASE_ITEM_TWOBLADEDSWORD: nBreakable = TWOBLADEDSWORDS_ARE_BREAKABLE; break;
        case BASE_ITEM_WARHAMMER: nBreakable = WARHAMMERS_ARE_BREAKABLE; break;
        case BASE_ITEM_WHIP: nBreakable = WHIPS_ARE_BREAKABLE; break;
    }
    return nBreakable;
}

void BreakFragileItems()
{
    // Get the container's CHANCE_OF_DAMAGE variable
    int nChanceOfDamage = GetLocalInt(OBJECT_SELF, "CHANCE_OF_DAMAGE");
    int nNumOfDestroyedObjects = 0;

    object oItem = GetFirstItemInInventory();

    if (oItem == OBJECT_INVALID)
        return;

    // Cycle through the object's inventory
    while (GetIsObjectValid(oItem) == TRUE)
    {
        // Find out what type of item this object is
        int nNewItemType = GetBaseItemType(oItem);

        // Determine its 'breakability'
        int nBreakable = GetItemBreakability(nNewItemType);

        if (nBreakable && !GetPlotFlag(oItem))
        {
            // Check to see if this particular treasure item survived
            int nTreasureSurvivalRoll = d100();
            // If Treasure Survival Roll does not exceed Damage Chance, 'break' the treasure
            if (nChanceOfDamage > nTreasureSurvivalRoll)
            {
                // If 'broken', destroy object and increment the NumOfDestroyedObjects counter
                DestroyObject(oItem);
                nNumOfDestroyedObjects = nNumOfDestroyedObjects + 1;
            }
        }
        oItem = GetNextItemInInventory();
    }
    int i;
    for(i=0; i < nNumOfDestroyedObjects; i++)
    {
        // Create "Broken Pieces" objects for each item that was destroyed.
        CreateItemOnObject(sBrokenObject);
    }
}
