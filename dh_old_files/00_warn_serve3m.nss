void main()
      {
        object oPC=GetFirstPC();
            while (GetIsObjectValid(oPC))
                {
                FloatingTextStringOnCreature("3 Minutes before server restart...",oPC,FALSE);

                oPC = GetNextPC();
                }

       }
