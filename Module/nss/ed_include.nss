//ed_include

/*****************************Editable Constants*******************************/
const int ED_USE_SAME_TAG_FOR_AREAS = FALSE; //Same tag if TRUE, number Tags if False (recommended)
const int ED_PERCENT_CHANCE_TO_EXIT_ENDLESS_AREA = 10;

/***************************Non-Editable Constants*****************************/
const string ED_DIRECTION_WAYPOINT_TAG = "ED_WAYPOINT_EXIT";

/***************************Function Declarations******************************/

//Returns the number of areas with tag sTag + # (i.e. ed_desert1_1, ed_desert1_2, etc...)
int ED_GetNumberAreas(string sTag);

//Returns a random valid location if oArea, out of site from existing players if possible
location ED_GetRandomLocationInArea(object oArea);

//Returns a random area with tag sTag
object ED_GetRandomArea(string sTag);


/**************************Function Implementation*****************************/

int ED_GetNumberAreas(string sTag)
{
    int x,y = 0;
    object oDesert;

    if(ED_USE_SAME_TAG_FOR_AREAS)
    {
        oDesert = GetObjectByTag(sTag, x);
        x++;
        while(GetIsObjectValid(oDesert))
        {
            y++;
            oDesert = GetObjectByTag(sTag, x);
            x++;
        }
        return y;
    }
    else
    {
        x++;
        oDesert = GetObjectByTag(sTag + IntToString(x));
        x++;
        while(GetIsObjectValid(oDesert))
        {
            y++;
            oDesert = GetObjectByTag(sTag + IntToString(x));
            x++;
        }
        return y;
    }
}

location ED_GetRandomLocationInArea(object oArea)
{
    object oObject = OBJECT_INVALID;
    location lLocation1;
    location lLocation2;
    float fDistance1;
    float fDistance2;
    int nSizeX = (GetAreaSize(AREA_WIDTH,oArea)*10)-1;
    int nSizeY = (GetAreaSize(AREA_HEIGHT,oArea)*10)-1;
    int nNth;

    //try to find location out of any existing player's sight
    for (; nNth < 5; nNth++)
    {
        lLocation1 = Location(oArea,
                     Vector(IntToFloat(Random(nSizeX) + 1),
                            IntToFloat(Random(nSizeY) + 1)),
                            0.0);
        oObject = GetNearestCreatureToLocation(CREATURE_TYPE_PLAYER_CHAR, PLAYER_CHAR_IS_PC, lLocation1, 1);
        if (GetIsObjectValid(oObject))
        {
            fDistance1 = GetDistanceBetweenLocations(lLocation1, GetLocation(oObject));
            if (fDistance1 > fDistance2)
            {
                lLocation2 = lLocation1;
                fDistance2 = fDistance1;
            }
            if (fDistance1 >= 25.0) break;
        }
        else
        {
            lLocation2 = lLocation1;
            break;
        }
    }
    //verify location
    object oCreature;
    oCreature = CreateObject(OBJECT_TYPE_CREATURE, "ed_verify", lLocation2);
    lLocation2 = GetLocation(oCreature);
    DestroyObject(oCreature);

    return lLocation2;
}

object ED_GetRandomArea(string sTag)
{
    int iNumAreas = ED_GetNumberAreas(sTag);
    object oArea;
    int iRand = Random(iNumAreas);
    if(ED_USE_SAME_TAG_FOR_AREAS) oArea = GetObjectByTag(sTag, iRand);
    else oArea = GetObjectByTag(sTag + IntToString(iRand+1));
    return oArea;
}
