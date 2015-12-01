//
//  NWPickup
//
//  Script to make the PC pick up an item.
//
//  (c) Shir'le E. Illios, 2002 (shirle@drowwanderer.com)
//
////////////////////////////////////////////////////////


// Script to place an item in the inventory of a character in place of this one.
//  ARGUMENTS:
//      a_oCharacter    - The character picking up the item.
//      a_sNewItem      - ResRef of the new item in the character's inventory.
//
void SEI_PickupItem( object a_oCharacter, string a_sNewItem )
{

    // Make the object disappear.
    DestroyObject( OBJECT_SELF );

    // Put a new object in the character's inventory.
    CreateItemOnObject( a_sNewItem, a_oCharacter, 1 );

} // End SEI_PickupItem


void main()
{

    if( GetTag( OBJECT_SELF ) == "movechair" )
    {
        // Put a chair in the PC's inventory.
        SEI_PickupItem( GetPCSpeaker(), "Chair" );
    }
    else if( GetTag( OBJECT_SELF ) == "movestool" )
    {
        // Put a stool in the PC's inventory.
        SEI_PickupItem( GetPCSpeaker(), "Stool" );
    }

} // End main

