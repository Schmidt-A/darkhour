#include "mali_string_fns"


string FormatV2String(string sEnc)
{   string sRed = "<cþ  >";
    string sGreen = "<c þ >";
    string sFormat;

    if (TestStringAgainstPattern("OFF:**", sEnc))
    { sFormat = sRed; }
    else
    { sFormat = sGreen; }
    sEnc = RestWords(sEnc, ",");

    string sHours = GetStringLowerCase(FirstWord(sEnc, ","));
    sEnc = RestWords(sEnc, ",");

    string sChance = GetStringLowerCase(FirstWord(sEnc, ","));
    sEnc = RestWords(sEnc, ",");

    string sType = GetStringLowerCase(FirstWord(sEnc, ","));
    sEnc = RestWords(sEnc, ",");

    string sParameter = GetStringLowerCase(FirstWord(sEnc, ","));
    sEnc = RestWords(sEnc, ",");

    if ((sType == "script") || (sType == "group") || (sType == "table"))
    { sFormat += sType + " " + sParameter; }
    else if ((sType == "trap") || (sType == "traps"))
    { sFormat += sType; }
    else if (sType == "copy")
    { sFormat += sType + " " + FirstWord(sEnc, ",") + " from " + sParameter; }
    else
    { sFormat += FirstWord(sEnc, ",") + " " + sParameter; }

    sFormat += ", " + sChance + "%";
    if (sHours != "always")
    { sFormat += " during " + sHours + " hours"; }

    return sFormat + "</c>";
}

string FormatEncString(string sEnc)
{   string sChance;
    string sResRef;
    string sAmount;
    string sV2;
    string sRed = "<cþ  >";
    string sGreen = "<c þ >";
    string sFormat;

    sV2 = GetStringLowerCase(FirstWord(sEnc, ","));
    if (sV2 == "v2" || sV2 == "off:v2")
    { return FormatV2String(sEnc); }

    if (TestStringAgainstPattern("OFF:**", sEnc))
    { sFormat = sRed;
      sEnc = RestWords(sEnc, "OFF:");
    }
    else
    { sFormat = sGreen; }

    if (FirstWord(sEnc, ":") == "runscript")
    { sFormat += "Script: " + RestWords(sEnc, ":") + "</c>"; }
    else
    { sChance = FirstWord(sEnc, ",");
      sEnc = RestWords(sEnc, ",");
      sResRef = FirstWord(sEnc, ",");
      sEnc = RestWords(sEnc, ",");
      sAmount = FirstWord(sEnc, ",");
      sEnc = RestWords(sEnc, ",");

      sFormat += sAmount + " " + sResRef + ", " + sChance + "%" + "</c>";
    }

    return sFormat;
}

int StartingConditional()
{
    object oArea = GetArea(OBJECT_SELF);
    int iDisabled = GetLocalInt(oArea, "iSparkyDisabled");
    string sToggle = iDisabled ? "Enable" : "Disable";
    SetCustomToken(11050, sToggle);

    int iTotalSpawns = GetLocalInt(OBJECT_SELF, "iConvTotal");
    int iPage = GetLocalInt(OBJECT_SELF, "iConvPage");
    int iPageLen = 10;
    int iOffset = iPage * iPageLen;
    int iBaseToken = 11051;
    int iEnc;
    string sNum;
    string sEnc;

    int iLoop = 0;

    while ((iLoop < iPageLen) && (iLoop < iTotalSpawns))
    {  iEnc = iLoop + iOffset + 1;
       if (iEnc < 10)
       { sNum = "0" + IntToString(iEnc); }
       else
       { sNum = IntToString(iEnc); }
       sEnc = GetLocalString(oArea, "encounter_" + sNum);

       SetCustomToken(iBaseToken + iLoop, FormatEncString(SearchAndReplace(sEnc, " ", "")));
       iLoop++;
    }

    SetLocalString(OBJECT_SELF, "sConvScript", "enc_sparkytog2");
    return TRUE;
}


