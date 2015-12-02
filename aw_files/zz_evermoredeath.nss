//Spawn 2 more of the dead creature unless it was killed by turn undead.

void main()
{
   if (GetLocalInt(OBJECT_SELF, "TurnKill") != TRUE)
   {
    location lSpawn  = GetLocation(OBJECT_SELF);
    CreateObject(OBJECT_TYPE_CREATURE, "evermore", lSpawn, TRUE);
    CreateObject(OBJECT_TYPE_CREATURE, "evermore", lSpawn, TRUE);
   }
}

