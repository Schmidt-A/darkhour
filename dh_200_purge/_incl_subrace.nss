void SubraceLogin(object oPC);
void SetupNextECLLevel(object oPC);

int     GetLA(string sRace);
string  GetSubraceSkinName(string sRace);
string  GetDBVarName(object oPC);
int     GetSubraceXP(int iLA);

string GetDBVarName(object oPC)
{
    return GetSubString(GetPCPlayerName(oPC), 0, 8) + GetSubString(GetName(oPC), 0, 8);
}

void SubraceLogin(object oPC)
{
    string sPre = GetDBVarName(oPC);
    // Don't do anything unless this is the first time logging in.
    if(GetCampaignInt("SUBRACE", sPre+"enabled") == TRUE)
        return;

    string sRace = GetStringLowerCase(GetSubRace(oPC));
    int iLA = GetLA(sRace);

    object oSkin = CreateItemOnObject(GetSubraceSkinName(sRace), oPC);
    AssignCommand(oPC, ActionEquipItem(oSkin, INVENTORY_SLOT_CARMOUR));

    SetCampaignInt("SUBRACE", sPre+"enabled", TRUE);
    // Don't need any more setup for a no-ECL subrace
    if(iLA < 1)
        return;

    // Give them a subrace token
    object oItem = GetItemPossessedBy(oPC, "ecl_token");
    if(oItem == OBJECT_INVALID)
        oItem = CreateItemOnObject("ecl_token", oPC);
}

void SetupNextECLLevel(object oPC)
{
    int iBaseLevel = GetHitDice(oPC)+1;
    string sPre = GetDBVarName(oPC);
    int iECL = iBaseLevel + GetCampaignInt("SUBRACE", sPre+"iLA");

    SetCampaignInt("SUBRACE", sPre+"iECL", iECL);
    SetCampaignInt("SUBRACE", sPre+"iRealXP", GetSubraceXP(iBaseLevel));
    SetCampaignInt("SUBRACE", sPre+"iXPNeeded", GetSubraceXP(iECL));
}

int GetLA(string sRace)
{
    if(sRace == "aasimar" || sRace == "duegar" || sRace == "steam genasi" || sRace == "tiefling")
        return 1;
    if(sRace == "drow" || sRace == "fey'ri")
        return 2;
    if(sRace == "svirfneblin")
        return 3;
    return 0;
}

// This function is so gross it makes me want to claw my eyes out but SOMEONE gave me
// inconstently-named resrefs to work with.
string GetSubraceSkinName(string sRace)
{
    if(sRace == "aasimar")
        return "subraceaasimar";
    if(sRace == "air genasi")
        return "subraceairgenasi";
    if(sRace == "aquatic elf")
        return "subraceaquaelf";
    if(sRace == "deep dwarf")
        return "subracedeepdwarf";
    if(sRace == "deep halfling")
        return "subracedeephalf";
    if(sRace == "drow")
        return "subracedarkelf";
    if(sRace == "Duegar")
        return "subraceduergar";
    if(sRace == "earth genasi")
        return "subraceeganasi";
    if(sRace == "fire genasi")
        return "subracefiregenas";
    if(sRace == "gold dwarf")
        return "subracegolddwarf";
    if(sRace == "grey elf" || sRace == "gray elf")
        return "subracegrayelf";
    if(sRace == "steam genasi")
        return "subracesgenasi";
    if(sRace == "svirfneblin")
        return "subracesvirf";
    if(sRace == "sun elf")
        return "subracesunelf";
    if(sRace == "tiefling")
        return "subracetiefling";
    if(sRace == "water genasi")
        return "subracewgenasi";
    if(sRace == "wild elf")
        return "subracewgenasi";
    if(sRace == "fey'ri")
        return "subracefeyri";
    if(sRace == "kobold")
        return "subracekobold";
    if(sRace == "gobin")
        return "subracegoblin";

    return "";
}

int GetSubraceXP(int iEffectiveLevel)
{
    int iXPNeeded = 0;
    switch(iEffectiveLevel)
    {
        case 2:
            iXPNeeded = 3000;
            break;
        case 3:
            iXPNeeded = 6000;
            break;
        case 4:
            iXPNeeded = 10000;
            break;
        case 5:
            iXPNeeded = 15000;
            break;
        case 6:
            iXPNeeded = 21000;
            break;
        case 7:
            iXPNeeded = 28000;
            break;
        case 8:
            iXPNeeded = 36000;
            break;
        case 9:
            iXPNeeded = 45000;
            break;
        case 10:
            iXPNeeded = 55000;
            break;
        default:
            break;
    }
    return iXPNeeded;
}
