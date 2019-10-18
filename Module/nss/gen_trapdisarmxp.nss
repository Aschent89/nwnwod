// ----------------------------------------------------------------------------------------------------
// : Script Courtsey Of Elmer's Neverwinter Nights Script Repository v2.0, 2003
// : http://nwncentral.mine.nu/NWN/
// : Scripts remain the property of their creator.
// : Script Added To The Repository On: 02/21/03 - 8:55:13 PM
// : Added By: Elmer The Destroyer On Behalf Of Author    E-mail: president@abands.com
// -------------------------------------------------------------------------------------------------------

// Traps & XP
//
// Rewards player with XP if trap was disarmed, place in the "OnDisarm"-slot of the trap
//
// by Incanus - big THX to Benn
// enjoy or destroy
//
// www.versuchungdermacht.de
object oPC; //player who disarmed trap
int nXP; //XP player gets
int nDC; //DC
int nlevel;
void main()
{
//Get PC who disarmed the trap
oPC = GetLastDisarmed();
//Get level of PC
nlevel = GetHitDice(oPC);
//Get DC for disarming trap (needed for calculation of XP)
nDC = GetTrapDisarmDC(OBJECT_SELF);
//Check, if trap was set by another PC. Otherwise give XP
if (GetTrapCreator(OBJECT_SELF)==OBJECT_INVALID)
{

//nXP = (nDC-(15+nlevel))*2*nlevel;


    if (nDC <= 25)
    {
        nXP = 2;
    }
    if (18 < nDC <= 40)
    {
        nXP = 4;
    }
    if (nDC > 40)
    {
        nXP = 6;
    }






GiveXPToCreature(oPC,nXP);
}
}

