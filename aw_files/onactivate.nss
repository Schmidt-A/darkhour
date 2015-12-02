void main()
{
object oItem=GetItemActivated();
string oScript=GetTag(oItem);
ExecuteScript(oScript, GetItemActivator());
}
