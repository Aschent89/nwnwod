//Modified by Pawn, tweaked by Dey, but Props go to:

//::///////////////////////////////////////////////
//:: OnTriggered Trap Script
//::
//::   The Lands of Tal'a Rune
//:: Scepter of the Serpent Lord
//:://////////////////////////////////////////////

//:://////////////////////////////////////////////
//:: Created By: Zyrathius
//:: Created On: October 15th , 2002
//:://////////////////////////////////////////////

void main()
{
//  Variable Declarations
    object oTargetPC = GetEnteringObject();     // PC triggering Trap
    int    nLevel    = GetHitDice(oTargetPC);   // HD of target PC
    int    nDieRoll  = d100();                  // Set up Percentile Dice For nClass
    int    nRange    = 1;                       // Sets PC Level range  (1-5)
    int    nClass    = 1;                       // Sets Trap Class Category  (1-5)
    string nTtype    = "nw_t1_spikeminoc";      // Sets Trap Type to be triggered (varies)
    string sTag      = GetStringUpperCase(GetTag(OBJECT_SELF)); // Tag of this trap (may contain low/med/high)

// Get the PC level and assign a range check to make based on PC level
    if      (nLevel<5)
        nRange = 1;
    else if (nLevel<9)
        nRange = 2;
    else if (nLevel<13)
        nRange = 3;
    else if (nLevel<17)
        nRange = 4;
    else
        nRange = 5;

// Adjust roll based on type of container (low/med/high)
   if (FindSubString(sTag, "LOW") != -1) nDieRoll-=10;
   else if (FindSubString(sTag, "HIGH") != -1) nDieRoll+=10;

// Find the Trap Class Category to pull from after making a percentile roll
    switch (nRange)
     {
        case 1:
            if      (nDieRoll<6)
                nClass = 0;
            else if (nDieRoll<86)
                nClass = 1;
            else if (nDieRoll<96)
                nClass = 2;
            else if (nDieRoll<99)
                nClass = 3;
            else
                nClass = 4;
            break;

        case 2:
            if      (nDieRoll<6)
                nClass = 0;
            else if (nDieRoll<56)
                nClass = 1;
            else if (nDieRoll<91)
                nClass = 2;
            else if (nDieRoll<96)
                nClass = 3;
            else
                nClass = 4;
            break;

         case 3:
            if      (nDieRoll<26)
                nClass = 1;
            else if (nDieRoll<46)
                nClass = 2;
            else if (nDieRoll<89)
                nClass = 3;
            else if (nDieRoll<99)
                nClass = 4;
            else
                nClass = 5;
            break;

         case 4:
            if      (nDieRoll<16)
                nClass = 1;
            else if (nDieRoll<36)
                nClass = 2;
            else if (nDieRoll<76)
                nClass = 3;
            else if (nDieRoll<96)
                nClass = 4;
            else
                nClass = 5;
            break;

          case 5:
            if      (nDieRoll<11)
                nClass = 1;
            else if (nDieRoll<31)
                nClass = 2;
            else if (nDieRoll<66)
                nClass = 3;
            else if (nDieRoll<91)
                nClass = 4;
            else
                nClass = 5;
            break;
     }

// Trap Class Categories 1-5, and the traps listed in each category.
    switch (nClass)
     {
          //minor
          case 1:
            switch (Random(10)+1)
             {
                case 1:
                    nTtype = "nw_t1_acidminoc";
                    break;
                case 2:
                    nTtype = "nw_t1_coldavgc";
                    break;
                case 3:
                    nTtype = "nw_t1_soncavgc";
                    break;
                case 4:
                    nTtype = "nw_t1_spikeavgc";
                    break;
                case 5:
                    nTtype = "nw_t1_splshminc";
                    break;
                case 6:
                    nTtype = "nw_t1_coldminoc";
                    break;
                case 7:
                    nTtype = "nw_t1_negminc";
                    break;
                case 8:
                    nTtype = "nw_t1_holyminoc";
                    break;
                case 9:
                    nTtype = "nw_t1_soncminc";
                    break;
                case 10:
                    nTtype = "nw_t1_spikeminoc";
                    break;
             }
          //minor/avg
          case 2:
            switch (Random(11)+1)
             {
                case 1:
                    nTtype = "nw_t1_holyavgc";
                    break;
                case 2:
                    nTtype = "nw_t1_negavgc";
                    break;
                case 3:
                    nTtype = "nw_t1_splshdeadc";
                    break;
                case 4:
                    nTtype = "nw_t1_colddeadc";
                    break;
                case 5:
                    nTtype = "nw_t1_soncdeadc";
                    break;
                case 6:
                    nTtype = "nw_t1_acidminoc";
                    break;
                case 7:
                    nTtype = "nw_t1_tangminoc";
                    break;
                case 8:
                    nTtype = "nw_t1_splshstrc";
                    break;
                case 9:
                    nTtype = "nw_t1_coldstrc";
                    break;
                case 10:
                    nTtype = "nw_t1_soncstrc";
                    break;
                case 11:
                    nTtype = "nw_t1_spikestrc";
                    break;
             }
          //avg
          case 3:
            switch (Random(11)+1)
             {
                case 1:
                    nTtype = "nw_t1_acidavgc";
                    break;
                case 2:
                    nTtype = "nw_t1_fireavgc";
                    break;
                case 3:
                    nTtype = "nw_t1_tangavgc";
                    break;
                case 4:
                    nTtype = "nw_t1_holydeadc";
                    break;
                case 5:
                    nTtype = "nw_t1_negdeadc";
                    break;
                case 6:
                    nTtype = "nw_t1_elecminoc";
                    break;
                case 7:
                    nTtype = "nw_t1_fireminoc";
                    break;
                case 8:
                    nTtype = "nw_t1_gasminoc";
                    break;
                case 9:
                    nTtype = "nw_t1_holystrc";
                    break;
                case 10:
                    nTtype = "nw_t1_negstrc";
                    break;
                case 11:
                    nTtype = "nw_t1_tangstrc";
                    break;
             }
          //strong
          case 4:
            switch (Random(8)+1)
             {
                case 1:
                    nTtype = "nw_t1_elecavgc";
                    break;
                case 2:
                    nTtype = "nw_t1_gasavgc";
                    break;
                case 3:
                    nTtype = "nw_t1_aciddeadc";
                    break;
                case 4:
                    nTtype = "nw_t1_spikedeadc";
                    break;
                case 5:
                    nTtype = "nw_t1_tangdeadc";
                    break;
                case 6:
                    nTtype = "nw_t1_acidstrc";
                    break;
                case 7:
                    nTtype = "nw_t1_elecstrc";
                    break;
                case 8:
                    nTtype = "nw_t1_firestrc";
                    break;
             }
           //deadly
           case 5:
            switch (Random(4)+1)
             {
                case 1:
                    nTtype = "nw_t1_elecdeadc";
                    break;
                case 2:
                    nTtype = "nw_t1_firedeadc";
                    break;
                case 3:
                    nTtype = "nw_t1_gasdeadc";
                    break;
                case 4:
                    nTtype = "nw_t1_gasstrc";
                    break;
             }
     }

// Fires the appropriate Trap Script based on value of nTtype
     if (nClass > 0) ExecuteScript(nTtype,OBJECT_SELF);

// Start of Exp reduction code
//        int nXP2 = GetXP(oTargetPC);

// Get DC of Trap (needed for calculation of XP)
//        int nDC  = GetTrapDisarmDC(OBJECT_SELF);

// Penalty amount
//        int nPenalty = nLevel + nDC;
//        int nMin     = ((nLevel * (nLevel - 1)) / 2) * 1000;
//        int nNewXP   = nXP2 - nPenalty;

//        if (nNewXP < nMin)
//            nNewXP = nMin;
//        SetXP(oTargetPC, nNewXP);
}
