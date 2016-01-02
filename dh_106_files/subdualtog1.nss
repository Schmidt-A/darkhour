/*****************************************************************************
  PC Subdual Damage
  By Rocc
  Version 0.9
  October 26, 2002

  Allows for PC subdual in PvP combat.
******************************************************************************/

// Set subdual mode for player
#include "subdual_inc"
void main()
{
  SetLocalInt(GetPCSpeaker(),"SUBDUAL",SUBDUAL_MODE_SUBDUAL);
  AssignCommand(GetPCSpeaker(),SpeakString("*Doing subdual damage*"));
}
