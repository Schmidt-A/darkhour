void main () {
    object oSelf = OBJECT_SELF;

    int nApp = GetLocalInt(oSelf, "CEP_TINT_APPEARANCE");
    if (nApp == 0)
        nApp = 843;

    string sScript = GetLocalString(oSelf, "CEP_TINT_SPAWNSCRIPT");
    if (sScript == "")
        sScript = "nw_c2_default9";

    SetCreatureAppearanceType(oSelf, nApp);

    ExecuteScript(sScript, oSelf);
}
