void main()
{
   int iConvChoice = GetLocalInt(OBJECT_SELF, "iConvChoice");
   object oWidget = GetLocalObject(OBJECT_SELF, "DM_SM_oWidget");


   switch (iConvChoice)
   { case 1:
       SetLocalInt(oWidget, "iSimUses", 1);
       SetCustomToken(11032, "1");
       break;
     case 2:
       SetLocalInt(oWidget, "iSimUses", 2);
       SetCustomToken(11032, "2");
       break;
     case 3:
       SetLocalInt(oWidget, "iSimUses", 3);
       SetCustomToken(11032, "3");
       break;
     case 4:
       SetLocalInt(oWidget, "iSimUses", 4);
       SetCustomToken(11032, "4");
       break;
     case 5:
       SetLocalInt(oWidget, "iSimUses", 5);
       SetCustomToken(11032, "5");
       break;
     case 6:
       SetLocalInt(oWidget, "iSimUses", -1);
       SetCustomToken(11032, "Unlimited");
       break;
     default:
       break;
   }

}
