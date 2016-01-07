void main()
      {
        object oPC=GetFirstPC();
            while (GetIsObjectValid(oPC))
                {
                FloatingTextStringOnCreature("1 minute before server restart...",oPC,FALSE);
                DelayCommand(10.0,FloatingTextStringOnCreature("50 seconds before server restart...",oPC,FALSE));
                DelayCommand(20.0,FloatingTextStringOnCreature("40 seconds before server restart...",oPC,FALSE));
                DelayCommand(30.0,FloatingTextStringOnCreature("30 seconds before server restart...",oPC,FALSE));
                DelayCommand(40.0,FloatingTextStringOnCreature("20 seconds before server restart...",oPC,FALSE));
                DelayCommand(50.0,FloatingTextStringOnCreature("10 seconds before server restart...",oPC,FALSE));
                oPC = GetNextPC();
                }

       }
