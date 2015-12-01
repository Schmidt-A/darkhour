void main()
      {
        object oPC=GetFirstPC();
            while (GetIsObjectValid(oPC))
                {
                FloatingTextStringOnCreature("15 Minutes before server restart...",oPC,FALSE);

                oPC = GetNextPC();
                }

       }
