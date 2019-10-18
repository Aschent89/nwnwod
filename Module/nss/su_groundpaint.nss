//#include "hx_inc_ring"
#include "x2_inc_toollib"

/*
const int X2_TL_GROUNDTILE_ICE = 426;
const int X2_TL_GROUNDTILE_WATER = 401;
const int X2_TL_GROUNDTILE_GRASS = 402;
const int X2_TL_GROUNDTILE_LAVA_FOUNTAIN = 349; // ugly
const int X2_TL_GROUNDTILE_LAVA = 350;
const int X2_TL_GROUNDTILE_CAVEFLOOR = 406;
const int X2_TL_GROUNDTILE_SEWER_WATER = 461;
*/

//Works in any area, just insert into the OnEnter event and set the Tile & Height variables for area

void main()
{
    object oPC = GetEnteringObject();
    int iTile = GetLocalInt(OBJECT_SELF, "Tile");
    float fHeight = GetLocalFloat(OBJECT_SELF, "Height");
        if (GetLocalInt(OBJECT_SELF, "nDoOnce") != 1 && GetIsPC(oPC))
    {
        SetLocalInt(OBJECT_SELF, "nDoOnce", 1);
        int nColumns = GetAreaSize(AREA_WIDTH);
        int nRows = GetAreaSize(AREA_HEIGHT);

        TLChangeAreaGroundTiles(OBJECT_SELF, iTile, nColumns, nRows, fHeight);

        //PrisonInvis();
    }
    ExecuteScript("wrap_ar_onenter",OBJECT_SELF);
}
