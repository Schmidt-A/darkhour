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
  if(GetLocalInt(OBJECT_SELF, "hasentsub") == 0)
    {
    SetLocalInt(OBJECT_SELF, "SUBDUAL", SUBDUAL_MODE_SPARRING);
    SetLocalInt(OBJECT_SELF, "hasentsub", 1);
    AssignCommand(OBJECT_SELF, SpeakString("*Is fighting to disable*"));
    }
}
