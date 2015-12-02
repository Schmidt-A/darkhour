void main()
{
object oGm = GetPCSpeaker();
 object oLoc = GetObjectByTag("DmControl");
 location lLoc = GetLocation(oLoc);
 AssignCommand( oGm,ClearAllActions(TRUE));
 AssignCommand( oGm,JumpToLocation(lLoc));
}
