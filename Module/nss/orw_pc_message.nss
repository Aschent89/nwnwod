////////////////////////////////////////////////////////////////////////////////
//  Olander's Realistic Weather System
//  orw_pc_message
//  By Don Anderson
//  dandersonru@msn.com
//
//  This will give the Temperature, Humidity, and Front information to each
//  Player in the Area.
//
//  This is called from the Area Weather script and does not require to be placed
//  in any events.
//
////////////////////////////////////////////////////////////////////////////////

#include "orw_inc_weather"

void main()
{
    object oPC = OBJECT_SELF;
    object oMod = GetModule();
    object oArea = GetArea(oPC);

    int nDebug = GetLocalInt(oMod,"WEATHERDEBUG");
    int nCT = GetLocalInt(oArea,WEATHERCURTEMP);//Current Temp
    int nHM = GetLocalInt(oArea,WEATHERCURHUMID);//Current Humidity
    int nWarm = GetLocalInt(oArea,WEATHERWFRONT);
    int nCold = GetLocalInt(oArea,WEATHERCFRONT);

    //Warm and Cold Front Messages
    if(nWarm == 1) SendMessageToPC(oPC,"A Warm front is now passing through the area.");
    if(nCold == 1) SendMessageToPC(oPC,"A Cold front is now passing through the area.");

    //Fahrenheit Option Enabled?
    int nF = GetLocalInt(oMod,"WEATHERF");
    if(nF == 1)
    {
      int nFT = 9*nCT/5+32;
      SendMessageToPC (oPC,IntToString(nFT) + " Deg Fahrenheit");
    }
    else
    {
      SendMessageToPC(oPC,IntToString(nCT) + " Deg Celsius");
    }

    //Humidity
    SendMessageToPC(oPC,IntToString(nHM) + "% Humidity");

    //Lots of info here....don't turn on unless testing or the chat window will be spammed =)
    if(nDebug == 1)
    {
      int nTZ = GetLocalInt(oArea,WEATHERTZONE);
      int nMT = GetLocalInt(oArea,WEATHERMAXTEMP);
      int nPZ = GetLocalInt(oArea,WEATHERPZONE);
      int nWC = GetLocalInt(oArea,WEATHERWATER);
      int nSI = GetLocalInt(oArea,WEATHERLEVEL);
      int nFS = GetFogAmount(FOG_TYPE_SUN,oArea);
      int nFM = GetFogAmount(FOG_TYPE_MOON,oArea);
      int nFCount = GetLocalInt(oArea,WEATHERCOUNTER);
      int nSDurat = GetLocalInt(oArea,WEATHERDURATION);

      SendMessageToPC(oPC,IntToString(nTZ) + " : Temp Zone");
      SendMessageToPC(oPC,IntToString(nMT) + " : Max Temp");
      SendMessageToPC(oPC,IntToString(nPZ) + " : Precip Zone");
      SendMessageToPC(oPC,IntToString(nWC) + " : Water Content");
      SendMessageToPC(oPC,IntToString(nWarm) + " : Warm Front");
      SendMessageToPC(oPC,IntToString(nCold) + " : Cold Front");
      SendMessageToPC(oPC,IntToString(nSI) + " : Weather Level");
      SendMessageToPC(oPC,IntToString(nFS) + " : Sun Fog");
      SendMessageToPC(oPC,IntToString(nFM) + " : Moon Fog");
      SendMessageToPC(oPC,IntToString(nFCount) + " : Front Current Length");
      SendMessageToPC(oPC,IntToString(nSDurat) + " : Front Total Duration");
    }
}
