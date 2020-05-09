string sColors = "                                            !!#$%&'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\]^_`abcdefghijklmnopqrstuvwxyz{|}~�������������������������������������������������������������������������������������������������������������������������";
// Returns Pseudo-Ascii Character (for color use only, not accurate Ascii)
string ASCII(int iAsciiCode) // 0 - 255
{
    int ASCIIReturn = iAsciiCode;
    if (ASCIIReturn<0) ASCIIReturn = 0;
    else if (ASCIIReturn>255) ASCIIReturn = 255;
    return GetSubString(sColors,iAsciiCode+1,1);
}

// Returns Pseudo-Ascii Integer Value (for color use only, not accurate Ascii)
int ASCIIToInt(string sLookup)
{
    return FindSubString(sColors, sLookup)-1;
}

// Returns a Color Code Based on Pseudo-Ascii
string RGB(int iR, int iG, int iB) // 0-255
{
    return "<c"+ASCII(iR)+ASCII(iG)+ASCII(iB)+">";
}

const string TEXT_COLOR_RED    =  "�  ";
const string TEXT_COLOR_ORANGE =  "�� ";
const string TEXT_COLOR_YELLOW =  "�� ";
const string TEXT_COLOR_GREEN  =  " � ";
const string TEXT_COLOR_BLUE   =  "  �";
const string TEXT_COLOR_CYAN   =  " ��";
const string TEXT_COLOR_PURPLE =  "� �";
const string TEXT_COLOR_WHITE  =  "���";
const string TEXT_COLOR_GREY   =  "~~~";
const string TEXT_COLOR_CRIMSON = "�  ";
const string TEXT_COLOR_EMERALD = " ~ ";
const string TEXT_COLOR_BROWN   = "�~6";
const string TEXT_COLOR_AZURE   = "~~�";


string RGBColorText(string RGBCode, string sText)
{
  return "<c"+ RGBCode +">"+ sText +"</c>";
}

//ColorText Function, uses either a color token or a 3-Digit Color Code
//Codes can be copied and pasted to item and placable names, descriptions, etc :)
string ColorText(string ColorCode, string sText)
{
       if (ColorCode == "crimson")      ColorCode = "<c�  >";
  else if (ColorCode == "red")          ColorCode = "<c�  >";
  else if (ColorCode == "plum")         ColorCode = "<c�ww>";
  else if (ColorCode == "tangerine")    ColorCode = "<c�Z >";
  else if (ColorCode == "orange")       ColorCode = "<c�� >";
  else if (ColorCode == "peach")        ColorCode = "<c�� >";
  else if (ColorCode == "amber")        ColorCode = "<c�� >";
  else if (ColorCode == "yellow")       ColorCode = "<c�� >";
  else if (ColorCode == "lemon")        ColorCode = "<c��w>";
  else if (ColorCode == "emerald")      ColorCode = "<c ~ >";
  else if (ColorCode == "green")        ColorCode = "<c � >";
  else if (ColorCode == "lime")         ColorCode = "<cw�w>";
  else if (ColorCode == "midnight")     ColorCode = "<c  t>";
  else if (ColorCode == "navy")         ColorCode = "<c  �>";
  else if (ColorCode == "blue")         ColorCode = "<c  �>";
  else if (ColorCode == "azure")        ColorCode = "<c~~�>";
  else if (ColorCode == "skyblue")      ColorCode = "<c���>";
  else if (ColorCode == "violet")       ColorCode = "<c� �>";
  else if (ColorCode == "purple")       ColorCode = "<c� �>";
  else if (ColorCode == "lavender")     ColorCode = "<c�~�>";
  else if (ColorCode == "black")        ColorCode = "<c   >";
  else if (ColorCode == "slate")        ColorCode = "<c666>";
  else if (ColorCode == "darkgrey")     ColorCode = "<cZZZ>";
  else if (ColorCode == "grey")         ColorCode = "<c~~~>";
  else if (ColorCode == "lightgrey")    ColorCode = "<c���>";
  else if (ColorCode == "white")        ColorCode = "<c���>";
  else if (ColorCode == "turquoise")    ColorCode = "<c ��>";
  else if (ColorCode == "jade")         ColorCode = "<c tt>";
  else if (ColorCode == "cyan")         ColorCode = "<c ��>";
  else if (ColorCode == "cerulean")     ColorCode = "<c���>";
  else if (ColorCode == "aqua")         ColorCode = "<cZǯ>";
  else if (ColorCode == "silver")       ColorCode = "<c���>";
  else if (ColorCode == "rose")         ColorCode = "<c�FF>";
  else if (ColorCode == "pink")         ColorCode = "<c�V�>";
  else if (ColorCode == "wood")         ColorCode = "<c�Z(>";
  else if (ColorCode == "brown")        ColorCode = "<c�~6>";
  else if (ColorCode == "tan")          ColorCode = "<cߑF>";
  else if (ColorCode == "flesh")        ColorCode = "<c��Z>";
  else if (ColorCode == "ivory")        ColorCode = "<c�Υ>";
  else if (ColorCode == "gold")         ColorCode = "<c��6>";
  else if (ColorCode == "random")
    {
        switch (d3())
        {
            case 1: ColorCode = RGB(Random(128)+128,Random(192)+64,Random(192)+64); break;
            case 2: ColorCode = RGB(Random(192)+64,Random(128)+128,Random(192)+64); break;
            case 3: ColorCode = RGB(Random(192)+64,Random(192)+64,Random(128)+128); break;
        }
    }

    return ColorCode + sText + "</c>";
}

int LoInt(int iInt1, int iInt2) {return (iInt1>iInt2)?iInt2:iInt1;}

int HiInt(int iInt1, int iInt2) {return (iInt1>iInt2)?iInt1:iInt2;}

string JumbleCode(string JColor1, string JColor2)
{
    string sR1=(GetSubString(JColor1,0,1));
    string sG1=(GetSubString(JColor1,1,1));
    string sB1=(GetSubString(JColor1,2,1));

    string sR2=(GetSubString(JColor2,0,1));
    string sG2=(GetSubString(JColor2,1,1));
    string sB2=(GetSubString(JColor2,2,1));

    int RHi=HiInt(ASCIIToInt(sR1),ASCIIToInt(sR2));
    int RLo=LoInt(ASCIIToInt(sR1),ASCIIToInt(sR2));
    int GHi=HiInt(ASCIIToInt(sG1),ASCIIToInt(sG2));
    int GLo=LoInt(ASCIIToInt(sG1),ASCIIToInt(sG2));
    int BHi=HiInt(ASCIIToInt(sB1),ASCIIToInt(sB2));
    int BLo=LoInt(ASCIIToInt(sB1),ASCIIToInt(sB2));

    return ASCII(Random(RHi-RLo)+RLo+1)+ASCII(Random(GHi-GLo)+GLo+1)+ASCII(Random(BHi-BLo)+BLo+1);
}

//Jumble Text randomly selects a color between Color1 and Color2
string JumbledText(string Color1, string Color2, string JumbleString)
{
    int j;
    string ReturnString;
    while (j<(GetStringLength(JumbleString)))
    {
        ReturnString = ReturnString+"<c"+JumbleCode(Color1,Color2)+">"+GetSubString(JumbleString,j,1)+"</c>";
        j++;
    }
    return ReturnString;
}

string ChaoticText(string RandomString)
{
    int i=1;
    string ReturnString;

    while (i<(GetStringLength(RandomString)+1))
    {
        ReturnString = ReturnString + ColorText("random",GetSubString(RandomString,i-1,1));
        i++;
    }
    return ReturnString;
}
