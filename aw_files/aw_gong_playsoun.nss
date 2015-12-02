void main()
{
if (GetLocalInt(OBJECT_SELF,"InUse") == 1)
    {
    return;
    }
    else
    {
    SetLocalInt(OBJECT_SELF,"InUse",1);
   int nRandom = Random(3)+1;
   string sSound;
   switch (nRandom)
              {
              case 1:
               sSound = "as_cv_gongring1";
              break;
              case 2:
               sSound = "as_cv_gongring2";
               break;
              case 3:
              sSound = "as_cv_gongring3";
               break;
              default:
              sSound = "as_cv_gongring1";
               break;
              }
    AssignCommand(OBJECT_SELF, PlaySound(sSound));
    //as_cv_gongring1
    DelayCommand(3.0,SetLocalInt(OBJECT_SELF,"InUse",0));
    }
}
