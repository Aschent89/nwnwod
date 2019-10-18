//::///////////////////////////////////////////////
//:: FileName s_pcl_list
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Scott Thorne
//:: Updated On: 04/05/2006
//:: Updated By: Scarss
//:://////////////////////////////////////////////

string GetClassLevels(object oPC)
{
    string sClassLevels = "";
    int iClsIdx;
    int iClsType;
    string sClsName;
    int iClsLvl;

    for (iClsIdx = 1; iClsIdx <= 3; iClsIdx++) {

        iClsType = GetClassByPosition(iClsIdx, oPC);

        if (iClsType != CLASS_TYPE_INVALID) {

            switch (iClsType) {

                case CLASS_TYPE_BARBARIAN: sClsName = "Barbarian"; break;
                case CLASS_TYPE_BARD: sClsName = "Bard"; break;
                case CLASS_TYPE_CLERIC: sClsName = "Cleric"; break;
                case CLASS_TYPE_DRUID: sClsName = "Druid"; break;
                case CLASS_TYPE_FIGHTER: sClsName = "Fighter"; break;
                case CLASS_TYPE_MONK: sClsName = "Monk"; break;
                case CLASS_TYPE_PALADIN: sClsName = "Paladin"; break;
                case CLASS_TYPE_RANGER: sClsName = "Ranger"; break;
                case CLASS_TYPE_ROGUE: sClsName = "Rogue"; break;
                case CLASS_TYPE_SORCERER: sClsName = "Sorcerer"; break;
                case CLASS_TYPE_WIZARD: sClsName = "Wizard"; break;
            //Begin Prestige Class Addition
                case CLASS_TYPE_ARCANE_ARCHER: sClsName = "Arcane Archer"; break;
                case CLASS_TYPE_ASSASSIN: sClsName = "Assassin"; break;
                case CLASS_TYPE_BLACKGUARD: sClsName = "Black Guard"; break;
                case CLASS_TYPE_DRAGON_DISCIPLE: sClsName = "Dragon Disciple"; break;
                case CLASS_TYPE_DWARVEN_DEFENDER: sClsName = "Dwarven Defender"; break;
                case CLASS_TYPE_HARPER: sClsName = "Harper"; break;
                case CLASS_TYPE_PALE_MASTER: sClsName = "Pale Master"; break;
                case CLASS_TYPE_SHADOWDANCER: sClsName = "Shadow Dancer"; break;
                case CLASS_TYPE_WEAPON_MASTER: sClsName = "Weapon Master"; break;
                case CLASS_TYPE_DIVINE_CHAMPION: sClsName = "Champion of Torm"; break;
            //End Prestige Class Addition
                default: sClsName = "?" + IntToString(iClsType) + "?";
            }

            iClsLvl = GetLevelByClass(iClsType, oPC);

            if (sClassLevels != "") {
                sClassLevels = sClassLevels + "/"; }

            sClassLevels = sClassLevels + IntToString(iClsLvl) + " " + sClsName;

        }

    }

    return sClassLevels + " ";
}


void main()
{

object oUser = GetPCSpeaker();

int iPCTot = 0;  /* total PC's */
int iPCVis = 0;  /* total non-anon (visible) PC's */
string sPCName;
string sPCArea;
string sPCLevel;
string sPCClass;
string sPCLFG;
string sPCAFK;
string sDM;
string sMessage;

object oPC = GetFirstPC();

while (oPC != OBJECT_INVALID)
{
    iPCTot++;

    /* skip anonymous PC's */
    if (GetLocalInt(oPC, "PCL_ANON") != 1) {

        iPCVis++;

        sPCName = GetName(oPC) + " ";
        sPCArea = "(" + GetTag(GetArea(oPC)) + ") ";
        sPCLevel = "L" + IntToString(GetHitDice(oPC)) + " ";

        if (GetLocalInt(oPC, "PCL_HIDE_CLASS") == 1) {
            sPCClass = "";
        } else {
            sPCClass = GetClassLevels(oPC);
        }

        if (GetLocalInt(oPC,"PCL_LFG") == 1) {
            sPCLFG = "*LFG* ";
        } else {
            sPCLFG = ""; }

        if (GetLocalInt(oPC,"PCL_AFK") == 1) {
            sPCAFK = "<AFK> ";
        } else {
            sPCAFK = ""; }

        if (GetIsDM(oPC)) {
            sDM = "[DM] ";
        } else {
            sDM = ""; }

        sMessage = sPCName + sPCArea + sPCClass + sPCAFK + sPCLevel + sPCLFG + sDM;
        SendMessageToPC(oUser, sMessage);

    }

    oPC = GetNextPC();
}

sMessage = "[ " + IntToString(iPCVis) + " out of " + IntToString(iPCTot) + "  PC's displayed ]";
SendMessageToPC(oUser, sMessage);

}

