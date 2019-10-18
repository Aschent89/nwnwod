////////////////////////////////////////////////////////////////////////////////
//  Olander's Realistic Systems - Underwater System
//  ouw_main
//  By Don Anderson
//  dandersonru@msn.com
//
//  Main Underwater Script
//
////////////////////////////////////////////////////////////////////////////////

void Underwater(object oPC)
{
    //Underwater Defined Area
    object oUWWP = GetNearestObjectByTag("Underwater",oPC);
    if(!GetIsObjectValid(oUWWP)) return;

    SetLocalInt(oPC,"UNDERWATER_LOOP",1);

    //Color set up for the graphical portion of Holding Breath
    string sRed         = "<có  >";
    string sGreen       = "<c ó >";
    string s100         = "||||||||||||||||||||||||||||||||||||||||||||||||||";
    string s98          = "|||||||||||||||||||||||||||||||||||||||||||||||||";
    string s96          = "||||||||||||||||||||||||||||||||||||||||||||||||";
    string s94          = "|||||||||||||||||||||||||||||||||||||||||||||||";
    string s92          = "||||||||||||||||||||||||||||||||||||||||||||||";
    string s90          = "|||||||||||||||||||||||||||||||||||||||||||||";
    string s88          = "||||||||||||||||||||||||||||||||||||||||||||";
    string s86          = "|||||||||||||||||||||||||||||||||||||||||||";
    string s84          = "||||||||||||||||||||||||||||||||||||||||||";
    string s82          = "|||||||||||||||||||||||||||||||||||||||||";
    string s80          = "||||||||||||||||||||||||||||||||||||||||";
    string s78          = "|||||||||||||||||||||||||||||||||||||||";
    string s76          = "||||||||||||||||||||||||||||||||||||||";
    string s74          = "|||||||||||||||||||||||||||||||||||||";
    string s72          = "||||||||||||||||||||||||||||||||||||";
    string s70          = "|||||||||||||||||||||||||||||||||||";
    string s68          = "||||||||||||||||||||||||||||||||||";
    string s66          = "|||||||||||||||||||||||||||||||||";
    string s64          = "||||||||||||||||||||||||||||||||";
    string s62          = "|||||||||||||||||||||||||||||||";
    string s60          = "||||||||||||||||||||||||||||||";
    string s58          = "|||||||||||||||||||||||||||||";
    string s56          = "||||||||||||||||||||||||||||";
    string s54          = "|||||||||||||||||||||||||||";
    string s52          = "||||||||||||||||||||||||||";
    string s50          = "|||||||||||||||||||||||||";
    string s48          = "||||||||||||||||||||||||";
    string s46          = "|||||||||||||||||||||||";
    string s44          = "||||||||||||||||||||||";
    string s42          = "|||||||||||||||||||||";
    string s40          = "||||||||||||||||||||";
    string s38          = "|||||||||||||||||||";
    string s36          = "||||||||||||||||||";
    string s34          = "|||||||||||||||||";
    string s32          = "||||||||||||||||";
    string s30          = "|||||||||||||||";
    string s28          = "||||||||||||||";
    string s26          = "|||||||||||||";
    string s24          = "||||||||||||";
    string s22          = "|||||||||||";
    string s20          = "||||||||||";
    string s18          = "|||||||||";
    string s16          = "||||||||";
    string s14          = "|||||||";
    string s12          = "||||||";
    string s10          = "|||||";
    string s8           = "||||";
    string s6           = "|||";
    string s4           = "||";
    string s2           = "|";

    object oUW = GetItemPossessedBy(oPC,"UnderWater");
    if(!GetIsObjectValid(oUW)) return;
    int nTotRnds = GetLocalInt(oUW,"UNDERWATER_TOT_ROUNDS");
    int nCurRnds = GetLocalInt(oUW,"UNDERWATER_CUR_ROUNDS");

    float fCurRnds = IntToFloat(nCurRnds);
    float fTotRnds = IntToFloat(nTotRnds);
    float fTotal = (fCurRnds/fTotRnds) * 100;
    int nTotal = FloatToInt(fTotal);

    //Set Rounds to Underwater Item
    SetLocalInt(oUW,"UNDERWATER_CUR_ROUNDS",nCurRnds-1);

    //Graphics Bar
    if(nTotal >= 100 || nTotal == 99) SendMessageToPC(oPC, "Air in Lungs "+ ": " +sGreen+ s100);
    if(nTotal == 98  || nTotal == 97) SendMessageToPC(oPC, "Air in Lungs "+ ": " +sGreen+ s98 +sRed+ s2);
    if(nTotal == 96  || nTotal == 95) SendMessageToPC(oPC, "Air in Lungs "+ ": " +sGreen+ s96 +sRed+ s4);
    if(nTotal == 94  || nTotal == 93) SendMessageToPC(oPC, "Air in Lungs "+ ": " +sGreen+ s94 +sRed+ s6);
    if(nTotal == 92  || nTotal == 91) SendMessageToPC(oPC, "Air in Lungs "+ ": " +sGreen+ s92 +sRed+ s8);
    if(nTotal == 90  || nTotal == 89) SendMessageToPC(oPC, "Air in Lungs "+ ": " +sGreen+ s90 +sRed+ s10);
    if(nTotal == 88  || nTotal == 87) SendMessageToPC(oPC, "Air in Lungs "+ ": " +sGreen+ s88 +sRed+ s12);
    if(nTotal == 86  || nTotal == 85) SendMessageToPC(oPC, "Air in Lungs "+ ": " +sGreen+ s86 +sRed+ s14);
    if(nTotal == 84  || nTotal == 83) SendMessageToPC(oPC, "Air in Lungs "+ ": " +sGreen+ s84 +sRed+ s16);
    if(nTotal == 82  || nTotal == 81) SendMessageToPC(oPC, "Air in Lungs "+ ": " +sGreen+ s82 +sRed+ s18);
    if(nTotal == 80  || nTotal == 79) SendMessageToPC(oPC, "Air in Lungs "+ ": " +sGreen+ s80 +sRed+ s20);
    if(nTotal == 78  || nTotal == 77) SendMessageToPC(oPC, "Air in Lungs "+ ": " +sGreen+ s78 +sRed+ s22);
    if(nTotal == 76  || nTotal == 75) SendMessageToPC(oPC, "Air in Lungs "+ ": " +sGreen+ s76 +sRed+ s24);
    if(nTotal == 74  || nTotal == 73) SendMessageToPC(oPC, "Air in Lungs "+ ": " +sGreen+ s74 +sRed+ s26);
    if(nTotal == 72  || nTotal == 71) SendMessageToPC(oPC, "Air in Lungs "+ ": " +sGreen+ s72 +sRed+ s28);
    if(nTotal == 70  || nTotal == 69) SendMessageToPC(oPC, "Air in Lungs "+ ": " +sGreen+ s70 +sRed+ s30);
    if(nTotal == 68  || nTotal == 67) SendMessageToPC(oPC, "Air in Lungs "+ ": " +sGreen+ s68 +sRed+ s32);
    if(nTotal == 66  || nTotal == 65) SendMessageToPC(oPC, "Air in Lungs "+ ": " +sGreen+ s66 +sRed+ s34);
    if(nTotal == 64  || nTotal == 63) SendMessageToPC(oPC, "Air in Lungs "+ ": " +sGreen+ s64 +sRed+ s36);
    if(nTotal == 62  || nTotal == 61) SendMessageToPC(oPC, "Air in Lungs "+ ": " +sGreen+ s62 +sRed+ s38);
    if(nTotal == 60  || nTotal == 59) SendMessageToPC(oPC, "Air in Lungs "+ ": " +sGreen+ s60 +sRed+ s40);
    if(nTotal == 58  || nTotal == 57) SendMessageToPC(oPC, "Air in Lungs "+ ": " +sGreen+ s58 +sRed+ s42);
    if(nTotal == 56  || nTotal == 55) SendMessageToPC(oPC, "Air in Lungs "+ ": " +sGreen+ s56 +sRed+ s44);
    if(nTotal == 54  || nTotal == 53) SendMessageToPC(oPC, "Air in Lungs "+ ": " +sGreen+ s54 +sRed+ s46);
    if(nTotal == 52  || nTotal == 51) SendMessageToPC(oPC, "Air in Lungs "+ ": " +sGreen+ s52 +sRed+ s48);
    if(nTotal == 50  || nTotal == 49) SendMessageToPC(oPC, "Air in Lungs "+ ": " +sGreen+ s50 +sRed+ s50);
    if(nTotal == 48  || nTotal == 47) SendMessageToPC(oPC, "Air in Lungs "+ ": " +sGreen+ s48 +sRed+ s52);
    if(nTotal == 46  || nTotal == 45) SendMessageToPC(oPC, "Air in Lungs "+ ": " +sGreen+ s46 +sRed+ s54);
    if(nTotal == 44  || nTotal == 43) SendMessageToPC(oPC, "Air in Lungs "+ ": " +sGreen+ s44 +sRed+ s56);
    if(nTotal == 42  || nTotal == 41) SendMessageToPC(oPC, "Air in Lungs "+ ": " +sGreen+ s42 +sRed+ s58);
    if(nTotal == 40  || nTotal == 39) SendMessageToPC(oPC, "Air in Lungs "+ ": " +sGreen+ s40 +sRed+ s60);
    if(nTotal == 38  || nTotal == 37) SendMessageToPC(oPC, "Air in Lungs "+ ": " +sGreen+ s38 +sRed+ s62);
    if(nTotal == 36  || nTotal == 35) SendMessageToPC(oPC, "Air in Lungs "+ ": " +sGreen+ s36 +sRed+ s64);
    if(nTotal == 34  || nTotal == 33) SendMessageToPC(oPC, "Air in Lungs "+ ": " +sGreen+ s34 +sRed+ s66);
    if(nTotal == 32  || nTotal == 31) SendMessageToPC(oPC, "Air in Lungs "+ ": " +sGreen+ s32 +sRed+ s68);
    if(nTotal == 30  || nTotal == 29) SendMessageToPC(oPC, "Air in Lungs "+ ": " +sGreen+ s30 +sRed+ s70);
    if(nTotal == 28  || nTotal == 27) SendMessageToPC(oPC, "Air in Lungs "+ ": " +sGreen+ s28 +sRed+ s72);
    if(nTotal == 26  || nTotal == 25) SendMessageToPC(oPC, "Air in Lungs "+ ": " +sGreen+ s26 +sRed+ s74);
    if(nTotal == 24  || nTotal == 23) SendMessageToPC(oPC, "Air in Lungs "+ ": " +sGreen+ s24 +sRed+ s76);
    if(nTotal == 22  || nTotal == 21) SendMessageToPC(oPC, "Air in Lungs "+ ": " +sGreen+ s22 +sRed+ s78);
    if(nTotal == 20  || nTotal == 19) SendMessageToPC(oPC, "Air in Lungs "+ ": " +sGreen+ s20 +sRed+ s80);
    if(nTotal == 18  || nTotal == 17) SendMessageToPC(oPC, "Air in Lungs "+ ": " +sGreen+ s18 +sRed+ s82);
    if(nTotal == 16  || nTotal == 15) SendMessageToPC(oPC, "Air in Lungs "+ ": " +sGreen+ s16 +sRed+ s84);
    if(nTotal == 14  || nTotal == 13) SendMessageToPC(oPC, "Air in Lungs "+ ": " +sGreen+ s14 +sRed+ s86);
    if(nTotal == 12  || nTotal == 11) SendMessageToPC(oPC, "Air in Lungs "+ ": " +sGreen+ s12 +sRed+ s88);
    if(nTotal == 10  || nTotal ==  9) SendMessageToPC(oPC, "Air in Lungs "+ ": " +sGreen+ s10 +sRed+ s90);
    if(nTotal ==  8  || nTotal ==  7) SendMessageToPC(oPC, "Air in Lungs "+ ": " +sGreen+ s8 +sRed+ s92);
    if(nTotal ==  6  || nTotal ==  5) SendMessageToPC(oPC, "Air in Lungs "+ ": " +sGreen+ s6 +sRed+ s94);
    if(nTotal ==  4  || nTotal ==  3) SendMessageToPC(oPC, "Air in Lungs "+ ": " +sGreen+ s4 +sRed+ s96);
    if(nTotal ==  2  || nTotal ==  1) SendMessageToPC(oPC, "Air in Lungs "+ ": " +sGreen+ s2 +sRed+ s98);
    if(nTotal <  1) SendMessageToPC(oPC, "Air in Lungs "+ ": " +sRed+ s100);

    //Make Bubbles Effect Each Round
    effect eBubbles =  EffectVisualEffect(VFX_DUR_BUBBLES);
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eBubbles,oPC,1.0);

    if(nTotal < 1)
    {
      //Kill the Player
      int nHP = GetCurrentHitPoints(oPC);
      effect eKillPC = EffectDamage(nHP + 1000);
      ApplyEffectToObject(DURATION_TYPE_INSTANT,eKillPC,oPC);
      SendMessageToPC(oPC, "You Drowned!!");

      SetLocalInt(oPC,"UNDERWATER_LOOP",0);

      //Now Destroy Item
      object oUW = GetItemPossessedBy(oPC,"UnderWater");
      DestroyObject(oUW);

      return;
    }

    DelayCommand(6.0,Underwater(oPC));
}

void main()
{
    object oPC = OBJECT_SELF;

    //Only Run On PC
    if(!GetIsPC(oPC)) return;

    //Underwater Defined Area
    object oUWWP = GetNearestObjectByTag("Underwater",oPC);
    if(!GetIsObjectValid(oUWWP)) return;

    //Underwater Loop Already Running
    int nUWLoop = GetLocalInt(oPC,"UNDERWATER_LOOP");
    if(nUWLoop > 0) return;

    DelayCommand(1.0,Underwater(oPC));
}
