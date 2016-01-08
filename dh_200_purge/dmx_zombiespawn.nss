void main()
{
int nDensity = GetLocalInt(OBJECT_SELF,"DENSITY");
if(nDensity < 1)
   {nDensity = 1;}
object oSpawn = GetFirstObjectInArea(GetArea(OBJECT_SELF));
while(oSpawn != OBJECT_INVALID)
    {
    if(GetTag(oSpawn)=="ZOMBIE_SPAWN" && GetLocalInt(oSpawn,"SPAWNED")!=TRUE)
        {
        SetLocalFloat(oSpawn,"SPAWN_DELAY",GetLocalFloat(OBJECT_SELF,"SPAWN_DELAY"));
        SetLocalInt(oSpawn,"SPAWNED",TRUE);
        int nCount = 1;
        string sZombie = GetLocalString(oSpawn,"Zombie"+IntToString(nCount));
        while(sZombie != "")
            {
            nCount++;
            sZombie = GetLocalString(oSpawn,"Zombie"+IntToString(nCount));
            }
       sZombie = GetLocalString(oSpawn,"Zombie"+IntToString(Random(nCount)+1));
       int i;
       for(i = 0; i < nDensity; i++)
            {
            object oZombie = CreateObject(OBJECT_TYPE_CREATURE,sZombie,GetLocation(oSpawn));
            SetLocalInt(oZombie,"DMX_SPAWNED",TRUE);
            SetLocalObject(oZombie,"SPAWN_POINT",oSpawn);
            }
        }
    oSpawn = GetNextObjectInArea(GetArea(OBJECT_SELF));
    }
DestroyObject(OBJECT_SELF,0.1f);
}
