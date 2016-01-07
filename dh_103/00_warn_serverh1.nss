void main()
      {
        object oPC=GetFirstPC();
            while (GetIsObjectValid(oPC))
                {
                FloatingTextStringOnCreature("1 hour before server restart...",oPC,FALSE);

                oPC = GetNextPC();
                }

       }
