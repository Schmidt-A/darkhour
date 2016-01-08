//::///////////////////////////////////////////////
//:: BODY TAILOR: increase
//:: onconv bodytailor
//:://////////////////////////////////////////////
/*
   this just increments the piece number and slaps it on.
   well, checking for restrictions and looping back to 0,
   too.
*/
//:://////////////////////////////////////////////
//:: Created By: bloodsong
//:: based on the mil tailor by Jake E. Fitch (Milambus Mandragon)
//:: Edited by 420 for CEP where indicated
//:://////////////////////////////////////////////
#include "btlr__inc"



void main()
{
    object oPC = GetPCSpeaker();

    string sToModify = GetLocalString(OBJECT_SELF, "ToModify");
    //-- WINGS, TAIL, HEAD, EYES...
    int iToModify = GetLocalInt(OBJECT_SELF, "ToModify");
    //-- bodypart #...
    string s2DAFile = GetLocalString(OBJECT_SELF, "2DAFile");
    //-- "" for items with no 2da file...?
    string s2DAend; //-- the endoffile check

    int iNewApp;
    string sModel; //Added for CEP
    string sColumn; //Added for CEP

//--WING SECTION vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
    if(sToModify == "WINGS")
    {
      //-- advance wing type.
      iNewApp = GetCreatureWingType()+1;

      //--if it is restricted, skip ahead.
      while(WingIsInvalid(iNewApp))
      {//-- increase
        iNewApp++;

        s2DAend = Get2DACheck(s2DAFile, iNewApp);
        //-- check for blank lines
        if (s2DAend == "SKIP")
        {//-- be careful reading 2da in a fast loop.
          iNewApp++;
          s2DAend = Get2DACheck(s2DAFile, iNewApp);
        }
        //-- check we didnt hit the end
        if (s2DAend == "FAIL" || iNewApp > GetCachedLimit(s2DAFile))
        {//-- if hit the end, loop back to 0
           iNewApp = 0;
        }
      }

     //--do the loop around check
     s2DAend = Get2DACheck(s2DAFile, iNewApp);
    while (s2DAend == "SKIP" || s2DAend == "FAIL")
    {
        if (s2DAend == "FAIL" || iNewApp > GetCachedLimit(s2DAFile))
        {
            iNewApp = 0;
        } else {
            iNewApp++;
        }

        s2DAend = Get2DACheck(s2DAFile, iNewApp);
    }  //-- end loop around check

      SetCreatureWingType(iNewApp); //--now slap the new wing on!
    }
//--END WINGS ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^


//--TAIL SECTION vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
    if(sToModify == "TAIL")
    {
      //-- advance tail type.
      iNewApp = GetCreatureTailType()+1;

      //--if it is restricted, skip ahead.
      while(TailIsInvalid(iNewApp))
      {//-- increase
        iNewApp++;

        s2DAend = Get2DACheck(s2DAFile, iNewApp);
        //-- check for blank lines
        if (s2DAend == "SKIP")
        {//-- be careful reading 2da in a fast loop.
          iNewApp++;
          s2DAend = Get2DACheck(s2DAFile, iNewApp);
        }
        //-- check we didnt hit the end
        if (s2DAend == "FAIL" || iNewApp > GetCachedLimit(s2DAFile))
        {//-- if hit the end, loop back to 0
           iNewApp = 0;
        }
      }

     //--do the loop around check
     s2DAend = Get2DACheck(s2DAFile, iNewApp);
    while (s2DAend == "SKIP" || s2DAend == "FAIL")
    {
        if (s2DAend == "FAIL" || iNewApp > GetCachedLimit(s2DAFile))
        {
            iNewApp = 0;
        } else {
            iNewApp++;
        }

        s2DAend = Get2DACheck(s2DAFile, iNewApp);
    }  //-- end loop around check

      SetCreatureTailType(iNewApp); //--now slap the new tail on!
    }
//--END TAIL ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

//--the rest of the parts dont have 2da files to read from.
//-- be sure you set your max numbers in the include file (btlr__inc)

  int nGender = GetGender(OBJECT_SELF);
  int nRace = GetAppearanceType(OBJECT_SELF);
  int nMax = 256;

//--HEAD BITS-------------------------------------------------------
  if(sToModify == "HEAD")
  {
    iNewApp = GetCreatureBodyPart(CREATURE_PART_HEAD)+1;
       //-- check we didnt hit the end(s)
       //Added 2da Columns for CEP
    if(nGender==GENDER_FEMALE)
    {
       switch(nRace)
       {
        case 0: nMax = DFHEADMAX;
                sColumn = "HEAD_FEMALE_DWARF";
                break;
        case 1: nMax = EFHEADMAX;
                sColumn = "HEAD_FEMALE_ELF";
                break;
        case 2: nMax = GFHEADMAX;
                sColumn = "HEAD_FEMALE_GNOME";
                break;
        case 4:
        case 6: nMax = HFHEADMAX;
                sColumn = "HEAD_FEMALE_HUMAN";
                break;
        case 3: nMax = AFHEADMAX;
                sColumn = "HEAD_FEMALE_HALFLING";
                break;
        case 5: nMax = OFHEADMAX;
                sColumn = "HEAD_FEMALE_HALF_ORC";
                break;
       }
     }
     else //--males and everything else
     {
       switch(nRace)
       {
        case 0: nMax = DMHEADMAX;
                sColumn = "HEAD_MALE_DWARF";
                break;
        case 1: nMax = EMHEADMAX;
                sColumn = "HEAD_MALE_ELF";
                break;
        case 2: nMax = GMHEADMAX;
                sColumn = "HEAD_MALE_GNOME";
                break;
        case 4:
        case 6: nMax = HMHEADMAX;
                sColumn = "HEAD_MALE_HUMAN";
                break;
        case 3: nMax = AMHEADMAX;
                sColumn = "HEAD_MALE_HALFLING";
                break;
        case 5: nMax = OMHEADMAX;
                sColumn = "HEAD_MALE_HALF_ORC";
                break;
       }
    }
//Skip lines using cepheadmodel.2da for CEP

    //Loop to 0 if greater than max head
    if(iNewApp > nMax)
        {
        SetCreatureBodyPart(CREATURE_PART_HEAD, 0);
        return;
        }

    sModel = Get2DAString("cepheadmodel", sColumn, iNewApp);

    while(sModel == "")
        {
        iNewApp = iNewApp + 1;
        sModel = Get2DAString("cepheadmodel", sColumn, iNewApp);
        }

     SetCreatureBodyPart(CREATURE_PART_HEAD, iNewApp);
  }  //-- end HEAD section


//--MISC BITS------------------------------------------------------

    if(sToModify == "PARTS")
    {
     iNewApp = GetCreatureBodyPart(iToModify) +1;
     //--check the ceiling
     if(iNewApp > CUSTOMPARTS)
     { //-- more than our 3 parts
       if(iNewApp >= 255)
       { //-- if it is 256, loop to 0
         iNewApp = 0;
       }
       else
       { //-- or else jump from max custom to 256
        iNewApp = 255;
       }
     }  //-- end loop check

     SetCreatureBodyPart(iToModify, iNewApp);
    }



//--EVERYBODY/THING SECTION ---------------------------------------------
    SendMessageToPC(oPC, "New Appearance: " + IntToString(iNewApp));
}
