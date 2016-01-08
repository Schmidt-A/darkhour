/*****************************************************************************
  PC Subdual Damage
  By Rocc
  Version 0.9
  October 26, 2002

  Allows for PC subdual in PvP combat.
******************************************************************************/

// Subdual OnClientEnter script
// If you already have an OnClientEnter script, just copy the following line
// there right below main()'s opening curly bracket.
void main()
{
     if(!GetIsObjectValid(GetItemPossessedBy(GetEnteringObject(),"SubdualModeTog")))
       CreateItemOnObject("subdualmodetog",GetEnteringObject());
}
