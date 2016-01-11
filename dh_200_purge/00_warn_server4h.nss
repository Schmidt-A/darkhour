void main()
      {
        object oPC=GetFirstPC();
            while (GetIsObjectValid(oPC))
                {
                FloatingTextStringOnCreature("4 hours before server restart...",oPC,FALSE);

                oPC = GetNextPC();
                }

       }
