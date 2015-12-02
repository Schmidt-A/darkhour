void main()
{
object oPC = GetPCSpeaker();
int nTotal = GetLocalInt(oPC,"invitations");
int nCount = 1;
for (nCount = 1; nCount <= nTotal;nCount++)
  {
  DeleteLocalObject(oPC,"inviter"+IntToString(nCount));
  }
DeleteLocalInt(oPC,"invitations");

int nValids = GetLocalInt(oPC,"ValidInviters");
for (nCount = 1; nCount <= nValids;nCount++)
  {
  DeleteLocalInt(oPC,"ValidInviters");
  DeleteLocalObject(oPC,"inviter"+IntToString(4000+nCount));
  }
//DeleteLocalInt(oPC,"invitations");
//int nValids = GetLocalInt(oPC,"ValidInviters");
//SetLocalObject(oPC,"inviter"+IntToString(nNewCount),oInviter);
//DeleteLocalObject(oPC,"inviter"+IntToString(count));
}
