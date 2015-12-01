void main()
      {
        object oPC=GetFirstPC();
            while (GetIsObjectValid(oPC))
                {
                FloatingTextStringOnCreature("2 hours before server restart...",oPC,FALSE);

                oPC = GetNextPC();
                }

       }
