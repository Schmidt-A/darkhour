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
  SetLocalInt(GetPCSpeaker(),"SUBDUAL",SUBDUAL_MODE_FULL_DAMAGE);
  AssignCommand(GetPCSpeaker(),SpeakString("*Is fighting at full capacity*"));
}
