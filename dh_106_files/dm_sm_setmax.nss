void main()
{
   int iConvChoice = GetLocalInt(OBJECT_SELF, "iConvChoice");
   object oWidget = GetLocalObject(OBJECT_SELF, "DM_SM_oWidget");


   switch (iConvChoice)
   { case 1:
        SetLocalInt(oWidget, "iMaxUses", 1);
        SetCustomToken(11031, "1");
        break;
     case 2:
        SetLocalInt(oWidget, "iMaxUses", 5);
        SetCustomToken(11031, "5");
        break;
     case 3:
        SetLocalInt(oWidget, "iMaxUses", 10);
        SetCustomToken(11031, "10");
        break;
     case 4:
        SetLocalInt(oWidget, "iMaxUses", 15);
        SetCustomToken(11031, "15");
        break;
     case 5:
        SetLocalInt(oWidget, "iMaxUses", 20);
        SetCustomToken(11031, "20");
        break;
     case 6:
        SetLocalInt(oWidget, "iMaxUses", 25);
        SetCustomToken(11031, "25");
        break;
     case 7:
        SetLocalInt(oWidget, "iMaxUses", 50);
        SetCustomToken(11031, "50");
        break;
     case 8:
        SetLocalInt(oWidget, "iMaxUses", -1);
        SetCustomToken(11031, "Unlimited");
        break;
     default:
        break;
   }

}

