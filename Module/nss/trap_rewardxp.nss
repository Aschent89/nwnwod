// Declares Variables
object oPC=GetLastDisarmed();
int iXPaward = 0;
int iXPawarddc = 0;

void main()
{

    iXPawarddc = (GetTrapDisarmDC(OBJECT_SELF) *2);
    // Multiplies the Trap Disarm DC by 8

    iXPaward = (iXPawarddc -((GetHitDice(oPC)-1)*2));
    // Subtracts 8 for every level -1 of the pc from the XP award (this way 1st level Pcs get full xp).

    SendMessageToPC( (oPC ),"You have successfully disarmed the trap.");
    // Sends a message to the PC letting them Know that the trap was disarmed.

    if (iXPaward >= 1)
    // checks to make sure that the xp award is at least 1.

    GiveXPToCreature(oPC, iXPaward);
    // If the XP reward is at least 1 then give the PC a reward.

    else
    // If the XP award is less then 1.


    GiveXPToCreature(oPC, 1);
    // give 1 xp.

}
