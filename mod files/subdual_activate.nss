/*****************************************************************************
  PC Subdual Damage
  By Rocc
  Version 0.9
  October 26, 2002

  Allows for PC subdual in PvP combat.
******************************************************************************/

// Subdual OnActivate script
// If you already have an OnItemActivate script, just copy the following line
// there right below main()'s opening curly bracket.
void main()
{
     if(GetTag(GetItemActivated())=="SubdualModeTog")
        AssignCommand(GetItemActivator(),ActionStartConversation(GetItemActivator(),"subdualconv",TRUE));
}
