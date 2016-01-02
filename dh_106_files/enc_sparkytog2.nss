#include "mali_string_fns"

void main()
{
    object oArea = GetArea(OBJECT_SELF);

    int iChoice = GetLocalInt(OBJECT_SELF, "iConvChoice");
    int iPage = GetLocalInt(OBJECT_SELF, "iConvPage");
    int iPageLen = 10;
    int iOffset = iPage * iPageLen;

    int iEnc = iChoice + iOffset;
    string sNum;


    if (iEnc < 10)
    { sNum = "0" + IntToString(iEnc); }
    else
    { sNum = IntToString(iEnc); }
    string sEnc = GetLocalString(oArea, "encounter_" + sNum);

    if (TestStringAgainstPattern("OFF:**", sEnc))
    { sEnc = RestWords(sEnc, "OFF:"); }
    else
    { sEnc = "OFF:" + sEnc; }

    SetLocalString(oArea, "encounter_" + sNum, sEnc);
}
