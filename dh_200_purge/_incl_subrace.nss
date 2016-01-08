void SubraceLogin(object oPC, int bFirstLogin=FALSE);
void SetupNextECLLevel(object oPC, object oItem);

int     GetLA(string sRace);
string  GetSubraceSkinName(string sRace);
int     GetSubraceXP(int iLA);

void SubraceLogin(object oPC, int bFirstLogin=FALSE)
{
    string sRace = GetStringLowerCase(GetSubRace(oPC));
    int iLA = GetLA(sRace);

    // Equip subrace skin properties if it's the first login
    if(bFirstLogin == TRUE)
    {
        object oSkin = CreateItemOnObject(GetSubraceSkinName(sRace), oPC);
        AssignCommand(oPC, ActionEquipItem(oSkin, INVENTORY_SLOT_CARMOUR));
    }

    // Don't need any more setup for a no-ECL subrace
    if(iLA < 1)
        return;

    // Give them a subrace token
    object oItem = GetItemPossessedBy(oPC, "ecl_token");
    if(oItem == OBJECT_INVALID)
        oItem = CreateItemOnObject("ecl_token", oPC);
}

void SetupNextECLLevel(object oPC, object oItem)
{
    int iBaseLevel = GetHitDice(oPC)+1;
    int iECL = iBaseLevel + GetLocalInt(oItem, "iLA");

    SetLocalInt(oItem, "iECL", iECL);
    SetLocalInt(oItem, "iRealXP", GetSubraceXP(iBaseLevel));
    SetLocalInt(oItem, "iXPNeeded", GetSubraceXP(iECL));
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
    if(sRace == "grey elf")
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
