void main()
{
int Nobody = 0;
object oPlayer = GetFirstObjectInArea();
     while ( GetIsObjectValid(oPlayer))
     {
        if (GetIsPC(oPlayer))
        {
        Nobody = 1;
        }
     oPlayer = GetNextObjectInArea();
     }

if ((Nobody == 0) && (GetLocalInt(GetModule(),"PriDragonStone") == 1))
  {
  CreateObject(OBJECT_TYPE_PLACEABLE,"aw_plc_statu_dra", GetLocation(GetObjectByTag("DragonStatue")));
  SetLocalInt(GetModule(),"PriDragonStone",0);
  }
  if ((Nobody == 0) && (GetLocalInt(GetModule(),"PriDragonStone2") == 1))
  {
  CreateObject(OBJECT_TYPE_PLACEABLE,"aw_plc_statu_und", GetLocation(GetObjectByTag("DragonStatue2")));
  SetLocalInt(GetModule(),"PriDragonStone2",0);
  }
  ExecuteScript("clean_area",OBJECT_SELF);
}
