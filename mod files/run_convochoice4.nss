void main()
{
    SetLocalInt(OBJECT_SELF, "iConvoChoice", 4);
    string sScript = GetLocalString(OBJECT_SELF, "sConvoScript");
    ExecuteScript(sScript, OBJECT_SELF);
}
