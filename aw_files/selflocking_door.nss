void main()
{
     if (GetTag(OBJECT_SELF) != "1_stone_door" && GetTag(OBJECT_SELF) != "2_stone_door")
     {
         ActionWait(6.0);
     }
     else
     {
         ActionWait(12.0);
     }
     ActionCloseDoor(OBJECT_SELF);
     SetLocked(OBJECT_SELF, TRUE);
}
