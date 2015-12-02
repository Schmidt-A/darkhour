
void main()
{
 object oGm = GetPCSpeaker();
 object oLoc = GetObjectByTag("Welcome1");
 location lLoc = GetLocation(oLoc);
 AssignCommand( oGm,ClearAllActions(TRUE));
 AssignCommand( oGm,JumpToLocation(lLoc));
}
