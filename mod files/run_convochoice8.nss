void main()
{
    SetLocalInt(OBJECT_SELF, "iConvoChoice", 8);
    string sScript = GetLocalString(OBJECT_SELF, "sConvoScript");
    ExecuteScript(sScript, OBJECT_SELF);
}
