//::///////////////////////////////////////////////////
// Armor related functions.
//::///////////////////////////////////////////////////
// _armor_info_inc
//::///////////////////////////////////////////////////


// CONSTANTS
//-----------------------------------------------------

// Armor types
const int ARMOR_TYPE_CLOTH  = 0;
const int ARMOR_TYPE_LIGHT  = 1;
const int ARMOR_TYPE_MEDIUM = 2;
const int ARMOR_TYPE_HEAVY  = 3;


// FUNCTIONS
//-----------------------------------------------------

//::///////////////////////////////////////////////////
// int GetItemACBase( object oItem)
//::///////////////////////////////////////////////////
// Parameters
//  - oItem:        armor to be evaluated
//
// Returns the base AC of oItem or -1 on error
//  * Returns:      base AC of armor (0 - 8)
//  * OnError:      -1 if oItem is invalid or not armor
//::///////////////////////////////////////////////////
int GetItemACBase( object oItem);
int GetItemACBase( object oItem)
{ // if oItem is not armor then return an error
  if( !GetIsObjectValid( oItem) || (GetBaseItemType( oItem) != BASE_ITEM_ARMOR)) return -1;

  // Get the torso model number
  int nTorso = GetItemAppearance( oItem, ITEM_APPR_TYPE_ARMOR_MODEL, ITEM_APPR_ARMOR_MODEL_TORSO);

  // Read 2DA for base AC
  // Can also use "parts_chest" which returns it as a "float"
  string sACBase = Get2DAString( "des_crft_appear", "BaseAC", nTorso);

  // return base AC
  return StringToInt( sACBase);
}


//::///////////////////////////////////////////////////
// int GetItemArmorType( object oItem);
//::///////////////////////////////////////////////////
// Parameters
//  - oItem:        valid armor
//
// Returns the type of armor oItem is or -1 on error
//  * Returns:      ARMOR_TYPE_* constant
//  * OnError:      -1 if oItem is invalid or not armor
//::///////////////////////////////////////////////////
int GetItemArmorType( object oItem);
int GetItemArmorType( object oItem)
{ if( !GetIsObjectValid( oItem)) return -1;

  // Get and check Base AC
  switch( GetItemACBase( oItem))
  { case 0:                 return ARMOR_TYPE_CLOTH;
    case 1: case 2: case 3: return ARMOR_TYPE_LIGHT;
    case 4: case 5:         return ARMOR_TYPE_MEDIUM;
    case 6: case 7: case 8: return ARMOR_TYPE_HEAVY;
  }
  return -1;
}


//::///////////////////////////////////////////////////
// int GetArmorIsMetallic( object oArmor);
//::///////////////////////////////////////////////////
// Parameters
//  - oItem:        valid armor
//
// Returns TRUE if the armor is metallic.  Note that NWN considered Studded
// Leather armor to be natural.
//  * Returns:      TRUE or FALSE
//  * OnError:      FALSE if oArmour is not valid
//::///////////////////////////////////////////////////
int GetArmorIsMetallic( object oArmor);
int GetArmorIsMetallic( object oArmor)
{ if( !GetIsObjectValid( oArmor) || (GetBaseItemType( oArmor) != BASE_ITEM_ARMOR)) return FALSE;

  // Medium and heavy are metallic
  int nType = GetItemArmorType( oArmor);
  return ((nType == ARMOR_TYPE_MEDIUM) || (nType == ARMOR_TYPE_HEAVY));
}


//::///////////////////////////////////////////////////
// int GetArmorIsNonMetallic( object oArmor);
//::///////////////////////////////////////////////////
// Parameters
//  - oItem:        valid armor
//
// Returns TRUE if the armor is not-metallic.  Note that NWN considered Studded
// Leather armor to be natural.
//  * Returns:      TRUE or FALSE
//  * OnError:      FALSE if oArmour is not valid
//::///////////////////////////////////////////////////
int GetArmorIsNonMetallic( object oArmor);
int GetArmorIsNonMetallic( object oArmor)
{ if( !GetIsObjectValid( oArmor) || (GetBaseItemType( oArmor) != BASE_ITEM_ARMOR)) return FALSE;
  return !GetArmorIsMetallic( oArmor);
}


//::///////////////////////////////////////////////////
// int GetArmorIsCloth( object oArmor);
//::///////////////////////////////////////////////////
// Parameters
//  - oItem:        valid armor
//
// Returns TRUE if the armor is cloth.  Note that NWN considered Studded
// Leather armor to be natural.
//  * Returns:      TRUE or FALSE
//  * OnError:      FALSE if oArmour is not valid
//::///////////////////////////////////////////////////
int GetArmorIsCloth( object oArmor);
int GetArmorIsCloth( object oArmor)
{ if( !GetIsObjectValid( oArmor) || (GetBaseItemType( oArmor) != BASE_ITEM_ARMOR)) return FALSE;
  return (GetItemArmorType( oArmor) == ARMOR_TYPE_CLOTH);
}


//::///////////////////////////////////////////////////
// int GetArmorIsLight( object oArmor);
//::///////////////////////////////////////////////////
// Parameters
//  - oItem:        valid armor
//
// Returns TRUE if the armor is light.  Note that NWN considered Studded
// Leather armor to be natural.
//  * Returns:      TRUE or FALSE
//  * OnError:      FALSE if oArmour is not valid
//::///////////////////////////////////////////////////
int GetArmorIsLight( object oArmor);
int GetArmorIsLight( object oArmor)
{ if( !GetIsObjectValid( oArmor) || (GetBaseItemType( oArmor) != BASE_ITEM_ARMOR)) return FALSE;
  return (GetItemArmorType( oArmor) == ARMOR_TYPE_LIGHT);
}


//::///////////////////////////////////////////////////
// int GetArmorIsMedium( object oArmor);
//::///////////////////////////////////////////////////
// Parameters
//  - oItem:        valid armor
//
// Returns TRUE if the armor is medium.  Note that NWN considered Studded
// Leather armor to be natural.
//  * Returns:      TRUE or FALSE
//  * OnError:      FALSE if oArmour is not valid
//::///////////////////////////////////////////////////
int GetArmorIsMedium( object oArmor);
int GetArmorIsMedium( object oArmor)
{ if( !GetIsObjectValid( oArmor) || (GetBaseItemType( oArmor) != BASE_ITEM_ARMOR)) return FALSE;
  return (GetItemArmorType( oArmor) == ARMOR_TYPE_MEDIUM);
}


//::///////////////////////////////////////////////////
// int GetArmorIsHeavy( object oArmor);
//::///////////////////////////////////////////////////
// Parameters
//  - oItem:        valid armor
//
// Returns TRUE if the armor is heavy.  Note that NWN considered Studded
// Leather armor to be natural.
//  * Returns:      TRUE or FALSE
//  * OnError:      FALSE if oArmour is not valid
//::///////////////////////////////////////////////////
int GetArmorIsHeavy( object oArmor);
int GetArmorIsHeavy( object oArmor)
{ if( !GetIsObjectValid( oArmor) || (GetBaseItemType( oArmor) != BASE_ITEM_ARMOR)) return FALSE;
  return (GetItemArmorType( oArmor) == ARMOR_TYPE_HEAVY);
}

