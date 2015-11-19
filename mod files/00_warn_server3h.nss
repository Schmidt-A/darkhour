void main()
      {
        object oPC=GetFirstPC();
            while (GetIsObjectValid(oPC))
                {
                FloatingTextStringOnCreature("3 hours before server restart...",oPC,FALSE);

                oPC = GetNextPC();
                }

       }
