void main()
{
object oPC = GetLastUsedBy();
if(GetTag(OBJECT_SELF) == "DoorMetal_2")
{
   AssignCommand(oPC, JumpToLocation(GetLocation(GetObjectByTag("wp_2_tower_low_down"))));
 }
 else if    (GetTag(OBJECT_SELF) == "DoorMetal_1")
 {
 AssignCommand(oPC, JumpToLocation(GetLocation(GetObjectByTag("wp_1_tower_low_down2"))));
 }
}
