void main()
{
object oUnlocker = GetLastUnlocked();
string sTag = "bHAS_XP_FOR_" + GetTag(OBJECT_SELF);
if(!GetLocalInt(oUnlocker, sTag))
{
object oPC=GetLastUnlocked();
int iMultiplier = 20/5;
int iXPawarddc = GetLockUnlockDC(OBJECT_SELF) * iMultiplier;
int iXPaward = (iXPawarddc - ((GetHitDice(oPC)-1) * iMultiplier))*2;
    SendMessageToPC(oPC,"Door Unlocked");
    GiveXPToCreature(oPC, ((iXPaward > 1) ? iXPaward : 1));
    SetLocalInt(oUnlocker, sTag, TRUE);
    // optional. 300.0 is 5 minutes before it rewards again
    DelayCommand(300.0, DeleteLocalInt(oUnlocker, sTag));
}
}
