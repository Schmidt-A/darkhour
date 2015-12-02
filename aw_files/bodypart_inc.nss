const int NWNX_BODYPART_LOW = 3;
const int NWNX_BODYPART_GENDER = 3;
const int NWNX_BODYPART_COLOR_SKIN = 4;
const int NWNX_BODYPART_COLOR_HAIR = 5;
const int NWNX_BODYPART_COLOR_TATTOO_1 = 6;
const int NWNX_BODYPART_COLOR_TATTOO_2 = 7;
const int NWNX_BODYPART_FOOT_R = 8;
const int NWNX_BODYPART_FOOT_L = 9;
const int NWNX_BODYPART_SHIN_R = 10;
const int NWNX_BODYPART_SHIN_L = 11;
const int NWNX_BODYPART_THIGH_L = 12;
const int NWNX_BODYPART_THIGH_R = 13;
const int NWNX_BODYPART_PELVIS = 14;
const int NWNX_BODYPART_TORSO = 15;
const int NWNX_BODYPART_BELT = 16;
const int NWNX_BODYPART_NECK = 17;
const int NWNX_BODYPART_FOREARM_R = 18;
const int NWNX_BODYPART_FOREARM_L = 19;
const int NWNX_BODYPART_BICEP_R = 20;
const int NWNX_BODYPART_BICEP_L = 21;
const int NWNX_BODYPART_SHOULDER_R = 22;
const int NWNX_BODYPART_SHOULDER_L = 23;
const int NWNX_BODYPART_HAND_R = 24;
const int NWNX_BODYPART_HAND_L = 25;
const int NWNX_BODYPART_UNKNOWN = 26;
const int NWNX_BODYPART_HEAD = 27;
const int NWNX_BODYPART_TAIL = 28;
const int NWNX_BODYPART_WING = 29;
const int NWNX_BODYPART_HIGH = 29;

// Returns the byte value type stored for the part requested.
// Types are the corresponding 2DA index for that bodypart.
// It is strongly advised to use the NWNX_BODYPART constants
// instead of directly pluggin in the integer if and when the
// offset changes.
int GetBodyPart(object oTgt, int nPart);

// Changes the creature bodypart on dynamic models.
// Types are the corresponding 2DA index for that bodypart.
// It is strongly advised to use the NWNX_BODYPART constants
// instead of directly pluggin in the integer if and when the
// offset changes.
void SetBodyPart(object oTgt, int nPart, int nType);

int GetBodyPart(object oTgt, int nPart)
{
    SetLocalString(oTgt,"NWNX!FUNCTIONS!GETBODYPART",
        IntToString(nPart));
    string sType = GetLocalString(oTgt,"NWNX!FUNCTIONS!GETBODYPART");
    return StringToInt(sType);
}

void SetBodyPart(object oTgt, int nPart, int nType)
{
    SetLocalString(oTgt,"NWNX!FUNCTIONS!SETBODYPART",
        IntToString(nPart)+"!"+IntToString(nType));
}

// Need to sync the engine to the client otherwise effects
// stack.  SetCreatureAppearanceType() can do this, but it
// must be a change and not application of their current type.
// Therefore we need a pair.  A delay of about 1.0 second seems
// to be the safe minium between them.

// Hide SetCreatureAppearanceType() effects with a flashy effect.
// You can also do this with Cutscene Invisibility applied before
// the first SCAT();
