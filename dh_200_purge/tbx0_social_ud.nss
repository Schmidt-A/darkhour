//::///////////////////////////////////////////////
//:: FileName: tbx0_social_ud
//:://////////////////////////////////////////////
/*
    determines action social pheno will use
*/
//:://////////////////////////////////////////////
//:: Created By: John Hawkins
//:: Created On: 03/07/2008
//:://////////////////////////////////////////////
void main()
{
 int iNum = GetUserDefinedEventNumber();
 switch (iNum)
 {
  case 4201:
  {
    if(GetLocalInt(OBJECT_SELF,"SITTING") == 1)
    {
        SetLocalInt(OBJECT_SELF,"SocialFoundSeat",1);
        AssignCommand(OBJECT_SELF,ActionPlayAnimation(ANIMATION_LOOPING_SIT_CROSS,1.0,60000.0));
        string sStool = GetLocalString(OBJECT_SELF,"SocialChairResRef");
        if(sStool == "") sStool = "plx_socialstool";
        object oStool = CreateObject(OBJECT_TYPE_PLACEABLE,sStool,
                GetLocation(OBJECT_SELF),FALSE,"SIT"+GetTag(OBJECT_SELF));
        SetLocalObject(OBJECT_SELF,"MySocialStool",oStool);
        SetName(oStool,GetName(OBJECT_SELF));
        SetLocalInt(OBJECT_SELF,"BUSY",1);
        if(GetLocalString(OBJECT_SELF,"BUSY")=="")
        {
            int iChange = d4();
            string sTxt = "as_pl_x2rghtav";
            string sSound = sTxt + IntToString(iChange);
            SetLocalString(OBJECT_SELF,"BUSY",sSound);
        }
       return;
    }
    if(GetLocalInt(OBJECT_SELF,"SITTING") == 2)
    {
        SetLocalInt(OBJECT_SELF,"SocialFoundSeat",1);
        AssignCommand(OBJECT_SELF,ActionPlayAnimation(ANIMATION_LOOPING_CUSTOM2,1.0,60000.0));
        string sStool = GetLocalString(OBJECT_SELF,"SocialChairResRef");
        if(sStool == "") sStool = "plx_socialstool";
        object oStool = CreateObject(OBJECT_TYPE_PLACEABLE,sStool,
                GetLocation(OBJECT_SELF),FALSE,"SIT"+GetTag(OBJECT_SELF));
        SetLocalObject(OBJECT_SELF,"MySocialStool",oStool);
        SetName(oStool,GetName(OBJECT_SELF));
        SetLocalInt(OBJECT_SELF,"BUSY",1);
        if(GetLocalString(OBJECT_SELF,"BUSY")=="")
        {
            int iChange = d4();
            string sTxt = "as_pl_x2rghtav";
            string sSound = sTxt + IntToString(iChange);
            SetLocalString(OBJECT_SELF,"BUSY",sSound);
        }
       return;
    }
    int iRnd = d20();
    switch(iRnd)
    {
       case 1:
             ClearAllActions();       //drink  (15% chance)
             AssignCommand(OBJECT_SELF,ActionPlayAnimation(ANIMATION_FIREFORGET_BOW));
            break;

       case 2:
             ClearAllActions();       //drink
             AssignCommand(OBJECT_SELF,ActionPlayAnimation(ANIMATION_FIREFORGET_BOW));
            break;

       case 3:
             ClearAllActions();       //drink
             AssignCommand(OBJECT_SELF,ActionPlayAnimation(ANIMATION_FIREFORGET_BOW));
            break;

       case 4:
             ClearAllActions();       //look right (5% chance)
             AssignCommand(OBJECT_SELF,ActionPlayAnimation(ANIMATION_FIREFORGET_HEAD_TURN_RIGHT));
            break;

       case 5:
             ClearAllActions();       //look left (5% chance)
             AssignCommand(OBJECT_SELF,ActionPlayAnimation(ANIMATION_FIREFORGET_HEAD_TURN_LEFT));
            break;

       case 6:
             ClearAllActions();       //chug (5% chance)
             AssignCommand(OBJECT_SELF,ActionPlayAnimation(ANIMATION_FIREFORGET_PAUSE_SCRATCH_HEAD));
            break;

       case 7:
             ClearAllActions();       //pause   (20% chance)
             AssignCommand(OBJECT_SELF,ActionPlayAnimation(ANIMATION_LOOPING_PAUSE,1.0,6.0));
            break;

       case 8:
             ClearAllActions();      //pause
             AssignCommand(OBJECT_SELF,ActionPlayAnimation(ANIMATION_LOOPING_PAUSE,1.0,6.0));
            break;

       case 9:
             ClearAllActions();      //pause
             AssignCommand(OBJECT_SELF,ActionPlayAnimation(ANIMATION_LOOPING_PAUSE,1.0,6.0));
            break;

       case 10:
             ClearAllActions();      //pause
             AssignCommand(OBJECT_SELF,ActionPlayAnimation(ANIMATION_LOOPING_PAUSE,1.0,6.0));
            break;

       case 11:
             ClearAllActions();      //cheers!  (10% chance)
             AssignCommand(OBJECT_SELF,ActionPlayAnimation(ANIMATION_FIREFORGET_GREETING));
            break;

       case 12:
             ClearAllActions();      //cheers!
             AssignCommand(OBJECT_SELF,ActionPlayAnimation(ANIMATION_FIREFORGET_GREETING));
            break;

       case 13:
             ClearAllActions();      //cheers! + drink   (5% chance)
             AssignCommand(OBJECT_SELF,ActionPlayAnimation(ANIMATION_FIREFORGET_SALUTE));
            break;

       case 14:
             ClearAllActions();     //walk...   (10% chance)
             AssignCommand(OBJECT_SELF,ActionRandomWalk());
            break;

       case 15:
             ClearAllActions();     //walk...
             AssignCommand(OBJECT_SELF,ActionRandomWalk());
            break;

       case 16:
             ClearAllActions();     //bored   (5% chance)
             AssignCommand(OBJECT_SELF,ActionPlayAnimation(ANIMATION_FIREFORGET_PAUSE_BORED));
            break;

       case 17:
             ClearAllActions();     //we're getting a buzz now!  (10% chance)
             AssignCommand(OBJECT_SELF,ActionPlayAnimation(ANIMATION_LOOPING_PAUSE_DRUNK,1.0,6.0));
            break;

       case 18:
             ClearAllActions();     //we're getting a buzz now!
             AssignCommand(OBJECT_SELF,ActionPlayAnimation(ANIMATION_LOOPING_PAUSE_DRUNK,1.0,6.0));
            break;

       case 19:
             ClearAllActions();     //wahoo!   (5% chance)
             AssignCommand(OBJECT_SELF,ActionPlayAnimation(ANIMATION_FIREFORGET_VICTORY3));
            break;

       case 20:
             ClearAllActions();     //tired    (5% chance)
             AssignCommand(OBJECT_SELF,ActionPlayAnimation(ANIMATION_LOOPING_PAUSE_TIRED,1.0,6.0));
            break;

      }
    }
  }
}
