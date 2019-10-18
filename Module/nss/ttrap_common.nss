//::///////////////////////////////////////////////
//:: Common Trap Utils
//:: ttrap_common
//:://////////////////////////////////////////////
/*
    Common functions used by the trap package
*/
//:://////////////////////////////////////////////
//:: Created By: TOJ
//:: Created On: Fall 2004
//:://////////////////////////////////////////////

int RollDices(string diceString)
{
    int n, result, sides, i, pos;

    pos = FindSubString(diceString, "d");
    if (pos==-1)
    {
        pos = FindSubString(diceString, "d");
    }

    // no result, can't roll dice
    if (pos==-1) return 0;

    result = 0;
    n = StringToInt(GetStringLeft(diceString, pos));
    sides = StringToInt(GetStringRight(diceString, GetStringLength(diceString) - (pos+1)));

    for (i=0; i<n; i++)
    {
        result += Random(sides);
    }

    // debug

    return result;
}

