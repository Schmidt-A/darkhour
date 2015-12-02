#include "aw_include"
void main()
{
object oLocker = GetLastLocked();
int lockskill = GetSkillRank(SKILL_OPEN_LOCK, oLocker, FALSE);
int sneaklevels = GetLevelByClass(CLASS_TYPE_ROGUE, oLocker) + GetLevelByClass(CLASS_TYPE_ASSASSIN, oLocker);
int nRoll = d20();
if (!GetIsInCombat(oLocker)) nRoll = 20;

int nLockDC = lockskill+nRoll;

SetLockUnlockDC(OBJECT_SELF, nLockDC);
DelayCommand(1.5f,FloatingTextStringOnCreature("Lock set with DC "+IntToString(nLockDC),oLocker));
}
