//::///////////////////////////////////////////////
//:: CEP Creature Wizard
//:: Community Expansion Pack
//:://////////////////////////////////////////////
/*
    CEP Creature Wizard include file
*/
//:://////////////////////////////////////////////
//:: Created By:   420
//:: Created On:   April 20, 2009
//:://////////////////////////////////////////////



/**********************************************************************
 * ABOUT THE CEP CREATURE WIZARD
 **********************************************************************/
 /*
    The CEP Creature Wizard item is an in-game creature customization DM tool.
    Activate the tool and target the creature you want to edit.

    Name: CEP Creature Wizard
    Tag: ZEP_CW_IT
    ResRef: zep_cw_it
    Location: *CEP 2.1 Custom Palette|*DM Specific|Miscellaneous

    NOTE: The tool item requires that tag-based scripting is enabled for
    the module.

    Alternately, the file "zep_cw_custtool" can be renamed for use with the
    1.69 DM/Player Custom Tool feats. (e.g. x3_dm_tool01)
*/

/**********************************************************************
 * EXPORTING THE CEP CREATURE WIZARD
 **********************************************************************/
 /*
    The following resources are needed for the CEP Creature Wizard:

    2da file: cep2damax.2da (in hak pack or override)

    Creature: CEP Creature Wizard (ResRef: zep_cw_cre)

    Conversation: zep_cw_con

    Item: CEP Creature Wizard (ResRef: zep_cw_it)

    Scripts: All zep_cw_* scripts and zep_destroyself
*/

/**********************************************************************
 * USING THE CREATURE WIZARD WITHOUT THE CEP
 **********************************************************************/
/*
    To use the Creature Wizard without the CEP the following changes
    should be made:

    1. The change color and no glow invisible creature appearance options
    should be disabled by putting the file "x2_con_false" in their
    "Text Appears When..." tab as they will no longer function.

    2. The max 2da values under in the CONSTANTS section must be changed.
    Default 1.69 values have been provided. Delete the "CEP 2da Max Values"
    and uncomment the "NWN 1.69 2da Max Values" to use them.

    3. Change the tool item icon to a non-CEP icon.
*/



/**********************************************************************
 * CONSTANTS
 **********************************************************************/

object CW_TARGET = GetLocalObject(OBJECT_SELF, "CW_Target");
string CW_CHANGE = GetLocalString(OBJECT_SELF, "CW_Change");
int CW_CHANNEL = GetLocalInt(OBJECT_SELF, "CW_Channel");

//CEP 2da Max Values
int CW_APP_2DA_MAX = StringToInt(Get2DAString("cep2damax", "MAX", 1));
int CW_PORT_2DA_MAX = StringToInt(Get2DAString("cep2damax", "MAX", 2));
int CW_TAIL_2DA_MAX = StringToInt(Get2DAString("cep2damax", "MAX", 3));
int CW_VFX_2DA_MAX = StringToInt(Get2DAString("cep2damax", "MAX", 4));
int CW_WING_2DA_MAX = StringToInt(Get2DAString("cep2damax", "MAX", 5));

//NWN 1.69 2da Max Values
/*
int CW_APP_2DA_MAX = 870;
int CW_PORT_2DA_MAX = 1300;
int CW_TAIL_2DA_MAX = 490;
int CW_VFX_2DA_MAX = 672;
int CW_WING_2DA_MAX = 89;
*/

/**********************************************************************
 * FUNCTION PROTOTYPES
 **********************************************************************/

//struct for CW 2da functions
struct CW2da
{
    object target;
    string change;
    string file;
    string column;
    int max;
    int current;
};

//Returns 2da data
struct CW2da Get2daData();

//Returns the last string heard by listener
string GetSpokenString();

//Sets the list of custom tokens for the Creature Wizard conversation
void TokenList();

//Returns the next valid 2da line
int GetNextValid(int nCurrent);

//Returns the previous valid 2da line
int GetPrevValid(int nCurrent);

//Returns the nearest valid 2da line
int GetNearestValid(int nCurrent);

//Sets creature to the next valid part being customized
void SetNextValid();

//Sets creature to the previous valid part being customized
void SetPrevValid();

//Sets creature to the current valid part being customized
void SetCurrentValid(int nValid);

//Convert appearance to matching tail
int AppToTail(int nApp);

//Convert tail to matching appearance
int TailToApp(int nApp);

//Convert appearance to matching portrait
int AppToPort(int nApp);

//Levels oTtarget in iClass iLevel number of times
void LevelUp(object oTarget, int nClass, int nLevel);


/**********************************************************************
 * FUNCTION DEFINITIONS
 **********************************************************************/

struct CW2da Get2daData()
{
struct CW2da ret;

ret.target = CW_TARGET;
ret.change = CW_CHANGE;

if(ret.change == "appearance")
    {
    ret.file = "appearance";
    ret.column = "LABEL";
    ret.max = CW_APP_2DA_MAX;
    ret.current = GetAppearanceType(ret.target);
    }
else if(ret.change == "portrait")
    {
    ret.file = "portraits";
    ret.column = "BaseResRef";
    ret.max = CW_PORT_2DA_MAX ;
    ret.current =  GetPortraitId(ret.target);
    }
else if(ret.change == "tail")
    {
    ret.file = "tailmodel";
    ret.column = "LABEL";
    ret.max = CW_TAIL_2DA_MAX;
    ret.current = GetCreatureTailType(ret.target);
    }
else if(ret.change == "vfx")
    {
    ret.file = "visualeffects";
    ret.column = "Type_FD";
    ret.max = CW_VFX_2DA_MAX;
    ret.current = GetLocalInt(OBJECT_SELF, "CW_VFX");
    }
else if(ret.change == "wings")
    {
    ret.file = "wingmodel";
    ret.column = "LABEL";
    ret.max = CW_WING_2DA_MAX;
    ret.current = GetCreatureWingType(ret.target);
    }
else if(ret.change == "color")
    {
    ret.file = "";
    ret.max = 175;
    ret.current = GetColor(ret.target, CW_CHANNEL);
    }
else if(ret.change == "level")
    {
    ret.file = "classes";
    ret.column = "Label";
    }

return ret;
}

string GetSpokenString()
{
int nCount = 0;
int nMax = GetMatchedSubstringsCount();
string sString;

if(GetListenPatternNumber() == 0)
    {
    while(nCount<nMax)
        {
        sString = sString+GetMatchedSubstring(nCount);
        nCount++;
        }
    }
SetListening(OBJECT_SELF, FALSE);
return sString;
}

void TokenList()
{
struct CW2da data = Get2daData();
object oTarget = data.target;
string sChange = data.change;
string s2DA = data.file;
string sColumn = data.column;
int nMax = data.max;
int nCurrent = data.current;
string sChannel;

if(sChange == "color")
    {
    switch(CW_CHANNEL)
        {
        case COLOR_CHANNEL_SKIN:
            sChannel = "skin";
            break;
        case COLOR_CHANNEL_TATTOO_1:
            sChannel = "tattoo 1";
            break;
        case COLOR_CHANNEL_TATTOO_2:
            sChannel = "tattoo 2";
            break;
        default:
            sChannel = "hair";
            break;
        }
    SetCustomToken(308, sChannel);
    SetCustomToken(309, IntToString(GetColor(oTarget, CW_CHANNEL)));
    }
else if(sChange == "level")
    {
    int nClass1 = GetClassByPosition(1, oTarget);
    int nClass2 = GetClassByPosition(2, oTarget);
    int nClass3 = GetClassByPosition(3, oTarget);
    string sCustom310 = Get2DAString(s2DA, sColumn, nClass1)+" "+IntToString(GetLevelByPosition(1, oTarget));
    string sCustom311 = "";
    string sCustom312 = "";
    if(nClass2 != CLASS_TYPE_INVALID)
        {
        sCustom311 = Get2DAString(s2DA, sColumn, nClass2)+" "+IntToString(GetLevelByPosition(2, oTarget));
        }
    if(nClass3 != CLASS_TYPE_INVALID)
        {
        sCustom312 = Get2DAString(s2DA, sColumn, nClass3)+" "+IntToString(GetLevelByPosition(3, oTarget));
        }

    SetCustomToken(310, sCustom310);
    SetCustomToken(311, sCustom311);
    SetCustomToken(312, sCustom312);
    }
else if(sChange == "vfx")
    {
    int nVFX = GetLocalInt(OBJECT_SELF, "CW_VFX");
    string sCustom313 = IntToString(nVFX)+" "+Get2DAString(s2DA, "Label", nVFX);
    SetCustomToken(313, sCustom313);
    }
else
    {
    int nPrev1 = GetPrevValid(nCurrent);
    int nPrev2 = GetPrevValid(nPrev1);
    int nNext1 = GetNextValid(nCurrent);
    int nNext2 = GetNextValid(nNext1);

    SetCustomToken(301, sChange);
    SetCustomToken(302, IntToString(nPrev2)+" "+Get2DAString(s2DA, sColumn, nPrev2));
    SetCustomToken(303, IntToString(nPrev1)+" "+Get2DAString(s2DA, sColumn, nPrev1));
    SetCustomToken(304, IntToString(nCurrent)+" "+Get2DAString(s2DA, sColumn, nCurrent));
    SetCustomToken(305, IntToString(nNext1)+" "+Get2DAString(s2DA, sColumn, nNext1));
    SetCustomToken(306, IntToString(nNext2)+" "+Get2DAString(s2DA, sColumn, nNext2));
    }
}

int GetNextValid(int nCurrent)
{
struct CW2da data = Get2daData();
string s2DA = data.file;
string sColumn = data.column;
int nMax = data.max;

if(nCurrent < 0 ||
   nCurrent >= nMax)
    {
    return 0;
    }

nCurrent++;

if(s2DA != "")
    {
    while(Get2DAString(s2DA, sColumn, nCurrent) == "")
        {
        if(nCurrent >= nMax)
            {
            return 0;
            }
        nCurrent++;
        }
    }

return nCurrent;
}

int GetPrevValid(int nCurrent)
{
struct CW2da data = Get2daData();
string s2DA = data.file;
string sColumn = data.column;
int nMax = data.max;

if(nCurrent <= 0 ||
   nCurrent > nMax)
    {
    nCurrent = nMax;
    }
else
    {
    nCurrent--;
    }

if(s2DA != "")
    {
    while(Get2DAString(s2DA, sColumn, nCurrent) == "")
        {
        if(nCurrent <= 0)
            {
            return 0;
            }
        nCurrent--;
        }
    }

return nCurrent;
}

int GetNearestValid(int nCurrent)
{
struct CW2da data = Get2daData();
string s2DA = data.file;
string sColumn = data.column;
string sChange = data.change;
int nValid = nCurrent;

if(Get2DAString(s2DA, sColumn, nCurrent) == "" &&
   nCurrent != 0 &&
   sChange != "color")
    {
    nValid = GetNextValid(nCurrent);

    if(nValid-nCurrent > nCurrent-GetPrevValid(nCurrent))
        {
        nValid = GetPrevValid(nCurrent);
        }
    }
return nValid;
}

void SetNextValid()
{
struct CW2da data = Get2daData();
object oTarget = data.target;
int nValid = GetNextValid(data.current);

SetCurrentValid(nValid);
}

void SetPrevValid()
{
struct CW2da data = Get2daData();
object oTarget = data.target;
int nValid = GetPrevValid(data.current);

SetCurrentValid(nValid);
}

void SetCurrentValid(int nValid)
{
struct CW2da data = Get2daData();
object oTarget = data.target;
string sChange = data.change;

if(sChange == "appearance")
    {
    SetCreatureAppearanceType(oTarget, nValid);
    }
else if(sChange == "portrait")
    {
    ActionPauseConversation();
    SetPortraitId(OBJECT_SELF, nValid);
    SetPortraitId(oTarget, nValid);
    DelayCommand(0.3, ActionResumeConversation());
    }
else if(sChange == "tail")
    {
    SetCreatureTailType(nValid, oTarget);
    }
else if(sChange == "vfx")
    {
    SetLocalInt(OBJECT_SELF, "CW_VFX", nValid);
    }
else if(sChange == "wings")
    {
    SetCreatureWingType(nValid, oTarget);
    }
else if(sChange == "color")
    {
    ActionPauseConversation();
    int nApp = GetAppearanceType(oTarget);
    SetCreatureAppearanceType(oTarget, 0);
    SetColor(oTarget, CW_CHANNEL, nValid);
    DelayCommand(1.0, SetCreatureAppearanceType(oTarget, nApp));
    DelayCommand(1.0, ActionResumeConversation());
    }
TokenList();
}

int AppToTail(int nApp)
{
string sAppModel = GetStringLowerCase(Get2DAString("appearance", "RACE", nApp));
int nTail = 0;
int nTailMax = CW_TAIL_2DA_MAX;
string sTailModel;
int nLine = 0;

while(nTail <= nTailMax)
    {
    sTailModel = GetStringLowerCase(Get2DAString("tailmodel", "MODEL", nTail));
    if(sTailModel == sAppModel)
        {
        nLine = nTail;
        break;
        }
    nTail++;
    }

if(nLine == 0)
    {
    nLine = 15;
    }

return nLine;
}

int TailToApp(int nTail)
{
string sTailModel = GetStringLowerCase(Get2DAString("tailmodel", "MODEL", nTail));
int nApp = 0;
int nAppMax = CW_APP_2DA_MAX;
string sAppModel;
int nLine = 0;

while(nApp <= nAppMax)
    {
    sAppModel = GetStringLowerCase(Get2DAString("appearance", "RACE", nApp));
    if(sAppModel == sTailModel)
        {
        nLine = nApp;
        break;
        }
    nApp++;
    }

return nLine;
}

int AppToPort(int nApp)
{
struct CW2da data = Get2daData();
object oTarget = data.target;
int nPort = 0;
int nPortMax = CW_PORT_2DA_MAX;
string sPortResRef;
int nLine = 0;
string sPort = GetStringLowerCase(Get2DAString("appearance", "PORTRAIT", nApp));

if(sPort == "")
    {
    return nLine;
    }

while(nPort <= nPortMax)
    {
    sPortResRef = GetStringLowerCase(Get2DAString("portraits", "BaseResRef", nPort));
    if("po_"+sPortResRef == sPort+"_")
        {
        nLine = nPort;
        break;
        }
    nPort++;
    }

return nLine;
}

void LevelUp(object oTarget, int nClass, int nLevel)
{
int nCount;

if(nLevel <= 0)
    {
    nLevel = 1;
    }
else if(nLevel > 39)
    {
    nLevel = 39;
    }

for(nCount = 0; nCount < nLevel; nCount++)
    {
    LevelUpHenchman(oTarget, nClass, TRUE);
    }
}
