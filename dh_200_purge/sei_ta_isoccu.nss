//
//  NWIsOccupied
//
//  Check if the object is currently being sat on.
//
//  (c) Shir'le E. Illios, 2002 (shirle@drowwanderer.com)
//
////////////////////////////////////////////////////////

int StartingConditional()
{
    return GetIsObjectValid( GetSittingCreature( OBJECT_SELF ) );
}

