void main()
{
object oPlayer = GetLastUsedBy();
 object oLoc = GetObjectByTag("Welcome1");
 location lLoc = GetLocation(oLoc);
 AssignCommand( oPlayer,ClearAllActions(TRUE));
 AssignCommand( oPlayer,JumpToLocation(lLoc));
}
