//::///////////////////////////////////////////////
//:: Zombies feed! 1.0
//:: by Lupin III
//:: lupin_3rd@hotmail.com
//:: modified by Ronin
//:: parsec_productions@yahoo.com
//:://////////////////////////////////////////////
/*
    Zombies will move over to the nearest "feed" corpse and start
    diggin' in.  I suggest setting the perception range on the
    zombies down to minimum too.  They will attack as soon as they
    see someone coming.  Place the following line in the OnSpawn
    script of your zombie.

    ExecuteScript("zombie_feed", OBJECT_SELF);

    Note, if you use Sentur Signe's lootable corpse scripts, I recommend
    that you turn off the speech.  A dead zombie will still perform these
    actions and say their lines.  Though they won't get up and go back to
    feeding, they will still speak their lines.  If you know how to fix this
    let me know please

*/
//:://////////////////////////////////////////////

void main ()
{
   /*
  effect eBlood1 = EffectVisualEffect(VFX_COM_CHUNK_RED_SMALL);
  effect eBlood2 = EffectVisualEffect(VFX_COM_BLOOD_LRG_RED);
  effect eBlood3 = EffectVisualEffect(VFX_COM_BLOOD_REG_RED);
  int nNext = 1;
  int nGnawed;

  SetLocalInt(OBJECT_SELF,"feeding",0);
  object oZombieFood = GetNearestObjectByTag("playercorpse",OBJECT_SELF,nNext);
  while (GetLocalInt(oZombieFood,"gnawed") >= 200)
  {
    nNext += 1;
    oZombieFood = GetNearestObjectByTag("playercorpse",OBJECT_SELF,nNext);
  }

  if ((!GetIsInCombat()) && (oZombieFood != OBJECT_INVALID))
  {
  //  create a corpse placeable and give it the tag ZFCorpse
  //  Multiple zombies can feast on a single body.
    if (GetDistanceBetween(OBJECT_SELF,oZombieFood) <= 12.0)
    {
      SetLocalInt(OBJECT_SELF,"feeding",1);
      ClearAllActions();
      ActionForceMoveToObject(oZombieFood, FALSE, 1.0f, 10.0f);
      SetFacingPoint(GetPosition(oZombieFood));
      ActionPlayAnimation(ANIMATION_LOOPING_GET_LOW, 1.0, 10.0);
    }
  //  Delete lines 33 and 55 if you want the zombies to speak a bit.
    if ((GetDistanceBetween(OBJECT_SELF,oZombieFood) > 0.0) &&
        (GetDistanceBetween(OBJECT_SELF,oZombieFood) <= 2.0))
    {
      string sSound = "temp";
      switch (d3())
      {
        case 1:
            sSound = "fs_beetle_wlk1";
            break;
        case 2:
            sSound = "fs_beetle_wlk2";
            break;
        case 3:
            sSound = "fs_beetle_wlk3";
            break;
      }
      PlaySound(sSound);
      nGnawed = GetLocalInt(oZombieFood,"gnawed") + 1;
      SetLocalInt(oZombieFood,"gnawed",nGnawed);
      switch (d6())
      {
        case 1:
            DelayCommand(2.5,ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eBlood1, GetLocation(oZombieFood)));
            break;
        case 2:
            DelayCommand(2.5,ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eBlood2, GetLocation(oZombieFood)));
            break;
        case 3:
            DelayCommand(2.5,ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eBlood2, GetLocation(oZombieFood)));
            break;
        case 4:
            DelayCommand(2.5,ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eBlood3, GetLocation(oZombieFood)));
            break;
        case 5:
            DelayCommand(2.5,ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eBlood3, GetLocation(oZombieFood)));
            break;
        case 6:
            DelayCommand(2.5,ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eBlood3, GetLocation(oZombieFood)));
            break;
        }
        switch (d6())
      {
        case 1:
            DelayCommand(5.0,ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eBlood1, GetLocation(oZombieFood)));
            break;
        case 2:
            DelayCommand(5.0,ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eBlood2, GetLocation(oZombieFood)));
            break;
        case 3:
            DelayCommand(5.0,ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eBlood2, GetLocation(oZombieFood)));
            break;
        case 4:
            DelayCommand(5.0,ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eBlood3, GetLocation(oZombieFood)));
            break;
        case 5:
            DelayCommand(5.0,ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eBlood3, GetLocation(oZombieFood)));
            break;
        case 6:
            DelayCommand(5.0,ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eBlood3, GetLocation(oZombieFood)));
            break;
        }
    }
  }
  float fDelayTime = IntToFloat(Random(4) + 11);
  DelayCommand(fDelayTime, ExecuteScript("zombie_feed", OBJECT_SELF));
    */
}
