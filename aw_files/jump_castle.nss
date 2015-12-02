
void main()
{
 object oGm = GetPCSpeaker();
 object oLoc = GetObjectByTag("Castle");
 location lLoc = GetLocation(oLoc);
 AssignCommand( oGm,ClearAllActions(TRUE));
 AssignCommand( oGm,JumpToLocation(lLoc));
}
