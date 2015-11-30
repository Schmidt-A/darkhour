int StartingConditional()
{
   object oTarget = GetLocalObject(OBJECT_SELF, "DM_PAA_oTarget");
   location lTarget = GetLocation(oTarget);
   vector vPosition = GetPositionFromLocation(lTarget);
   float fFacing = GetFacingFromLocation(lTarget);
   string sNameTag = GetLocalString(oTarget, "sNameTag");
   string sDirection;

   if (!GetLocalInt(oTarget, "DM_PAA_iOriginal"))
   { SetLocalLocation(oTarget, "DM_PAA_lOriginal", GetLocation(oTarget));
     SetLocalInt(oTarget, "DM_PAA_iOriginal", TRUE);
   }

   int iDirection = GetLocalInt(OBJECT_SELF, "DM_PAA_iDirection");

   switch (iDirection)
   { case 1:
       sDirection = "forward"; break;
     case 2:
       sDirection = "backward"; break;
     case 3:
       sDirection = "left"; break;
     case 4:
       sDirection = "right"; break;
     case 5:
       sDirection = "up"; break;
     case 6:
       sDirection = "down"; break;
     case 7:
       sDirection = "north"; break;
     case 8:
       sDirection = "south"; break;
     case 9:
       sDirection = "east"; break;
     case 10:
       sDirection = "west"; break;
     case 11:
       sDirection = "northeast"; break;
     case 12:
       sDirection = "northwest"; break;
     case 13:
       sDirection = "southeast"; break;
     case 14:
       sDirection = "southwest"; break;
     default:
       iDirection = 1;
       SetLocalInt(OBJECT_SELF, "DM_PAA_iDirection", iDirection);
       sDirection = "forward";
       break;
   }

   SetCustomToken(11000, GetName(oTarget));
   SetCustomToken(11001, GetPlotFlag(oTarget) ? "ON" : "OFF");
   SetCustomToken(11002, FloatToString(vPosition.x, 4, 2));
   SetCustomToken(11003, FloatToString(vPosition.y, 4, 2));
   SetCustomToken(11004, FloatToString(vPosition.z, 4, 2));
   SetCustomToken(11005, FloatToString(fFacing, 3, 0));

   if(sNameTag == "")
   { SetCustomToken(11008, ""); }
   else
   { SetCustomToken(11008, "Placed by: " + sNameTag); }

   SetCustomToken(11009, GetUseableFlag(oTarget) ? "ON" : "OFF");
   SetCustomToken(11010, GetTag(oTarget));

   SetCustomToken(11011, sDirection);

   SetLocalString(OBJECT_SELF, "DM_PAA_sResRef", GetResRef(oTarget));
   SetLocalString(OBJECT_SELF, "sConvScript", "dm_paa_adjust");

   return TRUE;
}
