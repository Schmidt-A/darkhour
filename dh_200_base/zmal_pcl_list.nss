//::///////////////////////////////////////////////
//:: FileName s_pcl_list
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Scott Thorne
//:: Updated On: 08/27/2002
//:://////////////////////////////////////////////

//
string GetClassLevels(object oPC)
{
    string sClassLevels = "";
    int iClsIdx;
    int iClsType;
    string sClsName;
    int iClsLvl;

    for (iClsIdx = 1; iClsIdx <= 3; iClsIdx++)
    {
        iClsType = GetClassByPosition(iClsIdx, oPC);
        if (iClsType != CLASS_TYPE_INVALID)
        {   sClsName = GetStringByStrRef(StringToInt(Get2DAString("classes", "Name", iClsType)), GetGender(oPC));
            iClsLvl = GetLevelByClass(iClsType, oPC);
            if (sClassLevels != "")
                sClassLevels += "/";
            sClassLevels += sClsName + " " + IntToString(iClsLvl);
        }
    }
    return(sClassLevels + " ");
}

//
void main()
{
    object oUser = GetPCSpeaker();
    if (GetIsPC(OBJECT_SELF))
    { oUser = OBJECT_SELF; }
    int iPCTot = 0;  /* total PC's */
    int iPCVis = 0;  /* total non-anon (visible) PC's */
    string sPCName;
    string sPCArea;
    string sPCLevel;
    string sPCClass;
    string sPCLFG;
    string sPCAFK;
    string sMessage;
    object oPC = GetFirstPC();

    while (GetIsObjectValid(oPC))
    {
        if (!GetIsDM(oPC))
        {
            sPCName = "";
            sPCArea = "";
            sPCLevel = "";
            sPCClass = "";
            sPCLFG = "";
            sPCAFK = "";
            sMessage = "";
            //
            iPCTot++;
            /* skip anonymous PC's */
            if (GetLocalInt(oPC, "PCL_ANON") != 1)
            {
                iPCVis++;
                sPCName = GetName(oPC) + " ";
                sPCArea = "(" + GetTag(GetArea(oPC)) + ") ";
                sPCLevel = "L" + IntToString(GetHitDice(oPC)) + " ";
                //
                if (GetLocalInt(oPC, "PCL_HIDE_CLASS") != 1)
                    sPCClass = GetClassLevels(oPC);
                //
                if (GetLocalInt(oPC,"PCL_LFG") == 1)
                    sPCLFG = "*LFG* ";
                //
                if (GetLocalInt(oPC,"PCL_AFK") == 1)
                    sPCAFK = "<AFK> ";
                //
                sMessage = sPCName + sPCArea + sPCClass + sPCAFK + sPCLevel + sPCLFG;
                SendMessageToPC(oUser, sMessage);
            }
        }
        oPC = GetNextPC();
    }
    sMessage = "[ " + IntToString(iPCVis) + " out of " + IntToString(iPCTot) + "  PC's displayed ]";
    SendMessageToPC(oUser, sMessage);
}

