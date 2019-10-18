///////////////////////////////////////////////////////////////////////////////
/////////////////////Mad Rabbit's Roleplaying World////////////////////////////
/////////////////////////////////Structures////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////

//Structure for passing information about effects in HTF system
struct HTF
{
    effect Lvl1Effect1;
    effect Lvl1Effect2;
    effect Lvl1Effect3;

    effect Lvl2Effect1;
    effect Lvl2Effect2;
    effect Lvl2Effect3;
};

struct Season
{
    int ClearToClear;
    int ClearToRain;
    int ClearToSnow;

    int RainToClear;
    int RainToRain;
    int RainToSnow;

    int SnowToClear;
    int SnowToRain;
    int SnowToSnow;
};

struct Armor
{
    int Dwarf;
    int Elf;
    int Gnome;
    int Human;
    int HalfElf;
    int Halfling;
    int HalfOrc;
};

struct Respawn
{
    effect Penalty1;
    effect Penalty2;
    effect Penalty3;
    effect Penalty4;
    effect Penalty5;

    int HitPointsPerLevel;

    float Duration;
};

struct Fishing
{
    string sFish1;
    string sFish2;
    string sFish3;

    string sTreasure1;
    string sTreasure2;
    string sTreasure3;

    string sJunk1;
    string sJunk2;
    string sJunk3;
};








