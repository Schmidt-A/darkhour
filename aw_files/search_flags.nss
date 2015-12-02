#include "inc_bs_module"
void main()
{
object oGoodFlagHolder = GetLocalObject(GetModule(), "oHasFlag_1"); //GOOD
object oEvilFlagHolder = GetLocalObject(GetModule(), "oHasFlag_2"); //EVIL
object oGm = GetPCSpeaker();

  AssignCommand(oGm,JumpToLocation(GetLocation(oGoodFlagHolder)));

/*  if ( GetIsPC(oGoodFlagHolder) possessed by a player )
  {
  string sCharname == GetName(oGoodFlagHolder);
  SetCustomToken(7701,sCharname+" has the GOOD flag!");
  SetLocalObject(oGm,"oGoodFlagHolder",oGoodFlagHolder);
  }
 else if (GetObjectType(oGoodFlagHolder) == OBJECT_TYPE_PLACEABLE)//is on the floor:
  {
  SetCustomToken(7701,"The GOOD flag is on the floor!");
  SetLocalObject(oGm,"oGoodFlagHolder",oGoodFlagHolder);
  }
  else GetObjectType(oGoodFlagHolder) ==//on the npc.
  {


  }  */
}
