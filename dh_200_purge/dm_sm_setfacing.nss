void main()
{
    int iConvChoice = GetLocalInt(OBJECT_SELF, "iConvChoice");
    object oTarget = OBJECT_SELF;
    float fFacing = StringToFloat(FloatToString(GetFacing(oTarget), 3, 0));


    switch (iConvChoice)
    { case 1:
         AssignCommand(oTarget, SetFacing(DIRECTION_SOUTH));
         AssignCommand(oTarget, SetFacing(DIRECTION_NORTH));
         break;
      case 2:
         AssignCommand(oTarget, SetFacing(fFacing - 1.0f + 180.0f));
         AssignCommand(oTarget, SetFacing(fFacing - 1.0f));
         break;
      case 3:
         AssignCommand(oTarget, SetFacing(fFacing - 5.0f + 180.0f));
         AssignCommand(oTarget, SetFacing(fFacing - 5.0f));
         break;
      case 4:
         AssignCommand(oTarget, SetFacing(fFacing - 20.0f));
         break;
      case 5:
         AssignCommand(oTarget, SetFacing(fFacing - 60.0f));
         break;
      case 6:
         AssignCommand(oTarget, SetFacing(fFacing - 90.0f));
         break;
      case 7:
         AssignCommand(oTarget, SetFacing(fFacing + 180.0f));
         break;
      case 8:
         AssignCommand(oTarget, SetFacing(fFacing + 90.0f));
         break;
      case 9:
         AssignCommand(oTarget, SetFacing(fFacing + 60.0f));
         break;
      case 10:
         AssignCommand(oTarget, SetFacing(fFacing + 20.0f));
         break;
      case 11:
         AssignCommand(oTarget, SetFacing(fFacing + 5.0f + 180.0f));
         AssignCommand(oTarget, SetFacing(fFacing + 5.0f));
         break;
      case 12:
         AssignCommand(oTarget, SetFacing(fFacing + 1.0f + 180.0f));
         AssignCommand(oTarget, SetFacing(fFacing + 1.0f));
         break;
      default:
         SendMessageToPC(OBJECT_SELF, "ERROR: Invalid distance.");
    }
}

