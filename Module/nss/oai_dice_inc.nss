////////////////////////////////////////////////////////////////////////////////
//
//  DK Dice
//  oai_dice_inc
//
//  Only change to the  oai  prefix for System Implementation
//  (Integral Part of OAI)
//
////////////////////////////////////////////////////////////////////////////////

//::///////////////////////////////////////////////
//:: Name dk_dice_inc
//:://////////////////////////////////////////////
/*
    Percentile dice routines provided for openended d100 rolls (as used in MERP and Rolemaster).
    Also provides for AD&D dice rolls such as 3d6+3 and can even handle 2d6+2d4 etc.
*/
//:://////////////////////////////////////////////
//:: Created By: David Kelly
//:: Created On: 18-Aug-2005
//:://////////////////////////////////////////////
const int ST_N = 0; // Number of dice
const int ST_S = 1; // number of Sides


// uroll
// Openended (upwards only)
int uroll();

// oroll
// Openended d100 roll
int oroll();

// ud20
// Openended d20 (upwards only)
int ud20();

// od20
// Openended d20
int od20();

// ndm
// Rolls 'n' dice of 'm' sides
int ndm(int nrDice, int nrSides);

// sroll
// Rolls dices according to string
// examples:-
//  1d6  2d6+1 2d6+1d4 d8+d10 etc
int sroll(string sDice);

// uroll
//
// Rolls
//upward open ended d100
int uroll()
{
    int r, total = 0;

    while ((r = d100()) >= 96)
        total += r;

    return total + r;
}

// oroll
//
// Rolls openended d100
int oroll()
{
    int r;

    r = d100();
    if (r <= 5)
        return r - uroll();
    else if (r >= 96)
        return r + uroll();
    else
        return r;
}

// ud20
//
// Rolls
//upward open ended d20
int ud20()
{
    int r, total = 0;

    while ((r = d20()) == 20)
        total += r;

    return total + r;
}

// od20
//
// Rolls openended d20
int od20()
{
    int r;

    r = d20();
    if (r == 1)
        return r - ud20();
    else if (r == 20)
        return r + ud20();
    else
        return r;
}

// ndm
// Rolls 'n' Dice of 'm' Sides
int ndm(int nrDice, int nrSides)
{
    int total = 0;

    // Stupid numbers of sides are silly indeed
    if (nrSides < 2)
        return nrDice;

    // Safety precaution
    if (nrDice > 500)
        nrDice = 500;

    while (nrDice > 0)
    {
        // Now dumping trace
        int ntmp = Random(nrSides) + 1;
//SendMessageToPC(GetFirstPC(), "nmd("+IntToString(nrDice)+","+IntToString(nrSides)+") = "+IntToString(ntmp));
        total += ntmp;
        nrDice--;
    }

    return total;
}

// sroll
//
// Rollsdice based on string (for easy storage)
//
// nDm  (eg. 2d6, 3d4, etc)
// nDm+2 (eg. 2d6+2, 3d4-1, etc)
// nDm+nDM (eg. 1d6+1d4)
//
// *** NOT IMPLIMENTED ***
// nDmLx  (eg. 3d6L1 is 3d6 lowest 1, 5d6H3 5d6 highest three, etc)
int sroll(string sDice)
{
    string schr;
    int total = 0;
    int nrDice = 0, nrSides = 0, nrAdd = 0;
    int idx, slen = GetStringLength(sDice);
    int nchr, nsign = 1, state = ST_N;

    // Process every character of the string
    for (idx = 0; idx < slen; idx++)
    {
        schr = GetStringLowerCase(GetSubString(sDice, idx, 1));   // Current character being parsed

        if (schr == "0" || StringToInt(schr) > 0)
        {
            nchr = StringToInt(schr);

            switch (state)
            {
                case ST_N:
                    nrDice = nrDice * 10 + nchr;
                    break;
                case ST_S:
                    nrSides = nrSides * 10 + nchr;
                    break;
                default:
            }
        }
        else if (schr == "d")
        {
            switch (state)
            {
                case ST_N:  // Normal transition to looking for nr Sides
                    if (nrDice == 0)
                       nrDice = 1;
                    state = ST_S;
                    nrSides = 0;
                    break;
                case ST_S:  // roll what we have currently and assume 2d6d4 => 2d6 + d4, 2dd4 => 2d4
                    if (nrSides)
                    {
                        // Here we assume that 2d2d4 => 2d2 + 1d4
                        total += nsign * ndm(nrDice, nrSides);
                        nsign = 1; // Assume missing signs mean add
                        nrDice = 1; // Assume the 1 was missing as in "d4"
                        nrSides = 0;
                        // We are still looking for Sides
                    }
                    // ELSE
                    // We assume we doubled the "d" key as in 2dd4", so keep going
                    break;
                default:
                    // PANIC
            }
        }
        else if (schr == "+" || schr == "-")
        {
            switch (state)
            {
                case ST_N:  // 2d6+2+... => total += sign * nrDice, sign = +/- 1
                    if (nrDice > 0)
                    {
                        total += nsign * nrDice;
                        nrDice = 1;
                    }
                    break;
                case ST_S:  // Normal, 2d6+???, total += 2d6, sign =+/- 1
                    if (nrSides)
                        total += nsign * ndm(nrDice, nrSides);
                    else
                    {
                        // We have somehting like 2d+4, assume 2+4...
                        total = nsign * nrDice;
                    }
                    break;
                default:
                    // PANIC
            }
            // Set the new sign
            nsign = (schr == "+") ? 1 : -1;
            // Now looking for 'N'
            state = ST_N;
            // Reset the counters
            nrDice = 0;
            nrSides = 0;
        }
    }

    // Now finish the last state
    switch (state)
    {
        case ST_N:
            // add/subtract any trailing number (ie 2d6+2)
            if (nrDice)
                total += nsign * nrDice;
            break;
        case ST_S:
            if (nrSides)
                total += nsign * ndm(nrDice, nrSides);
            else
                total += nsign * nrDice;
            break;
        default:
            // PANIC
    }

    return total;
}

//void main(){}

