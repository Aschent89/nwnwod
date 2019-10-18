////////////////////////////////////////////////////////////////////////////////
// civ_colorbar
//
// by Civious
// Rev: 20091123
////////////////////////////////////////////////////////////////////////////////

#include "x3_inc_string"

// More colors added
const string STRING_COLOR_DKBLUE = "227";
const string STRING_COLOR_YELLOW = "770";
const string STRING_COLOR_ORANGE = "730";
const string STRING_COLOR_PURPLE = "505";

// Send the player a colored bar meter representing iValue;
// - iValue: The length of the "foreground" color
// - oPC: The player the message is being sent to
// - sLabel: The label that appears to the left of the meter
// - iBackground: Optional; The background color of the meter; default is black
// - iForeground: Optional; The foreground color of the meter; default is green
// - iShowNumber: Optional; Whether to show the iValue number at the end of the
// graph default is off
// - iMax: Optional; The highest value iValue can be; default is 100 used for
// percentages

void CIV_ColorBar(int iValue, object oPC, string sLabel, int iBackround = 0,
int iForeground = 0, int iShowNumber = FALSE, int iMax = 100);


void CIV_ColorBar(int iValue, object oPC, string sLabel, int iBackround = 0,
int iForeground = 0, int iShowNumber = FALSE, int iMax = 100)
{

string sForeColor, sBackColor;

// Foreground is the (left) iValue representation

switch (iForeground)
{
case 1: sForeColor = STRING_COLOR_YELLOW; break;
case 2: sForeColor = STRING_COLOR_BLACK; break;
case 3: sForeColor = STRING_COLOR_BLUE; break;
case 4: sForeColor = STRING_COLOR_GREEN; break;
case 5: sForeColor = STRING_COLOR_PINK; break;
case 6: sForeColor = STRING_COLOR_RED; break;
case 7: sForeColor = STRING_COLOR_ROSE; break;
case 8: sForeColor = STRING_COLOR_WHITE; break;
case 9: sForeColor = STRING_COLOR_DKBLUE; break;
case 10: sForeColor = STRING_COLOR_ORANGE; break;
case 11: sForeColor = STRING_COLOR_PURPLE; break;
default: sForeColor = STRING_COLOR_GREEN; break;
}

switch (iBackround)
{
case 1: sBackColor = STRING_COLOR_YELLOW; break;
case 2: sBackColor = STRING_COLOR_BLACK; break;
case 3: sBackColor = STRING_COLOR_BLUE; break;
case 4: sBackColor = STRING_COLOR_GREEN; break;
case 5: sBackColor = STRING_COLOR_PINK; break;
case 6: sBackColor = STRING_COLOR_RED; break;
case 7: sBackColor = STRING_COLOR_ROSE; break;
case 8: sBackColor = STRING_COLOR_WHITE; break;
case 9: sBackColor = STRING_COLOR_DKBLUE; break;
case 10: sBackColor = STRING_COLOR_ORANGE; break;
case 11: sForeColor = STRING_COLOR_PURPLE; break;
default: sBackColor = STRING_COLOR_BLACK; break;
}


string sBar = "||||||||||||||||||||||||||||||||||||||||||||||||||";

float fRatio = IntToFloat(iValue) / IntToFloat(iMax);
int iPercent = FloatToInt(fRatio * 100.0);
int nForeLength = iPercent / 2;
int nBackLength = 50 - nForeLength;

string sForeBar = StringToRGBString(GetStringLeft(sBar, nForeLength), sForeColor);
string sBackBar = StringToRGBString(GetStringLeft(sBar, nBackLength), sBackColor);

string sBarMessage = sLabel + ": " + sForeBar + sBackBar;
if (iShowNumber) sBarMessage += " " + IntToString(iValue);

SetName(OBJECT_SELF, sBarMessage);
//SpeakString(sBarMessage, TALKVOLUME_WHISPER);
//SendMessageToPC(oPC, sBarMessage);
}
