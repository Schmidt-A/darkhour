
void main()
{
 object oGm = GetPCSpeaker();
 object oLoc = GetObjectByTag("thepit");
 location lLoc = GetLocation(oLoc);
 AssignCommand( oGm,ClearAllActions(TRUE));
 AssignCommand( oGm,JumpToLocation(lLoc));
}
