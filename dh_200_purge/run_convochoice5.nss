void main()
{
    SetLocalInt(OBJECT_SELF, "iConvoChoice", 5);
    string sScript = GetLocalString(OBJECT_SELF, "sConvoScript");
    ExecuteScript(sScript, OBJECT_SELF);
}
