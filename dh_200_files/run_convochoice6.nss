void main()
{
    SetLocalInt(OBJECT_SELF, "iConvoChoice", 6);
    string sScript = GetLocalString(OBJECT_SELF, "sConvoScript");
    ExecuteScript(sScript, OBJECT_SELF);
}
