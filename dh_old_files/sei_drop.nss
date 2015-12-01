//
//  NWDrop
//
//  Script for when a character drops an item.
//  Place in the OnUnAcquireItem module event.
//
//  (c) Shir'le E. Illios, 2002 (shirle@drowwanderer.com)
//
////////////////////////////////////////////////////////


// Script to place an item on the ground in front of a character.
//  ARGUMENTS:
//      a_oCharacter    - The character dropping the item.
//      a_oItem         - The inventory item being dropped.
//      a_sNewItem      - ResRef of the new item to place.
//
void SEI_PlaceItem( object a_oCharacter, object a_oItem, string a_sNewItem )
{

    // Get information on where we want the object.
    location lCharLocation = GetLocation( a_oCharacter );
    object oArea = GetAreaFromLocation( lCharLocation );
    vector vPosition = GetPositionFromLocation( lCharLocation );
    float fFacing = GetFacingFromLocation( lCharLocation );

    // Face away from the character.
    fFacing += 180.0f;

    // SEI_TODO: Change position to slightly in front of character.

    // Create the new location to place the object.
    location lPlace = Location( oArea, vPosition, fFacing );

    // First destroy the inventory item.
    DestroyObject( a_oItem );

    // And create the new object.
    CreateObject( OBJECT_TYPE_PLACEABLE, a_sNewItem, lPlace );

} // End SEI_PlaceItem


void main()
{

    // Get te item that was lost.
    object oItem = GetModuleItemLost();

    // Get the character who lost the item.
    object oChar = GetModuleItemLostBy();

    // SEI_Note: There seems to be a bug in GetModuleItemLostBy(), which
    //           returns the lost object, not the lost character holding the
    //           object. But strangely enough GetEnteringObject does return the
    //           character. Done like this for backwards compatibility if
    //           BioWare ever fixes the bug.
    if( oChar == oItem )
    {
        oChar = GetEnteringObject();
    }

    // Check if the dropped item is a chair.
    if( GetTag( oItem ) == "Chair" )
    {
        SEI_PlaceItem( oChar, oItem, "movechair" );
    }
    // Check if the dropped item is a stool.
    else if( GetTag( oItem ) == "Stool" )
    {
        SEI_PlaceItem( oChar, oItem, "movestool" );
    }

} // End main

