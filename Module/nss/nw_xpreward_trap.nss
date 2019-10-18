void main()
{
object oPC=GetLastDisarmed();
int iMultiplier = 20/5;
int iXPawarddc = GetTrapDisarmDC(OBJECT_SELF) * iMultiplier;
int iXPaward = (iXPawarddc - ((GetHitDice(oPC)-1) * iMultiplier))*2;

    SendMessageToPC(oPC,"Trap disarmed");
    GiveXPToCreature(oPC, ((iXPaward > 1) ? iXPaward : 1));
}
