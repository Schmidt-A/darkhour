
void main()
{
 object oGm = GetPCSpeaker();
 object oLoc = GetObjectByTag("WP_forestdrop");
 location lLoc = GetLocation(oLoc);
 AssignCommand( oGm,ClearAllActions(TRUE));
 AssignCommand( oGm,JumpToLocation(lLoc));
}
