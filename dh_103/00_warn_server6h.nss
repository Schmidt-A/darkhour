void main()
      {
        object oPC=GetFirstPC();
            while (GetIsObjectValid(oPC))
                {
                FloatingTextStringOnCreature("6 hours before server restart...",oPC,FALSE);

                oPC = GetNextPC();
                }

       }
