//::///////////////////////////////////////////////
//:: Shadooow's Pseudo-list impementation
//:: FileName _sh_inc_list
//:://////////////////////////////////////////////

//WELL NOW THERE IS 100 ELEMENTS MAX, BUT IT'S POSSIBLE TO ENLARGE IT; CURRENT SYSTEM WILL WORK RIGHT IF THE LIST WILL CONTAIN EACH CHARACTER ONLY ONCE.
//                                     01234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890  -> 100elements max
const string LIST_ELEMENTS_ALPHABET = "0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZáâäãæçéèëêíìîïóöôðúüý!#$%&()*+,-./:;<=>";//should work too: " " and "?@_~|{}[\]÷^`¦Ç", "'" not recommended as its the mysql string ending char
//                                               1         2         3         4         5         6         7         8         9        10

//This function destroy valid List with same sName on same oListKeeper and nStoreMethod
//or... Do nothing!
// oListKeeper - object that hold the list
void ListCreate(object oListKeeper, string sName);

//Returns TRUE, if List with this name already exists. False otherwise.
//This is usefull for destroying list.
// oListKeeper - object that hold the list
int ListGetIsValid(object oListKeeper, string sName);

//Destroy list and clear all value in it. If you don't do it, you can expect
//that you can retrieve on same index other variables than you added.
// oListKeeper - object that hold the list
void ListDestroy(object oListKeeper, string sName);

//Add new element to end of List with sName
//Each element can contain one integer, one float, one string and one object.
//If there is not valid List with such name, new List is created.
// oListKeeper - object that hold the list
void ListAddElement(object oListKeeper, string sName, int nInt=0 ,string sString="", object oObject=OBJECT_INVALID, float fFloat=0.0);

//Add new int to end of List with sName. It's same as element with only int value.
//You ask why use this function? Well, elements store all types and checks if is every data type valid and
//then store it. So, if you use element for add one int it will do 3 extra commands.
//If there is not valid List with such name, new List is created.
// oListKeeper - object that hold the list
void ListAddInt(object oListKeeper, string sName, int nInt);

//Set nInt to nth element of List with sName.
//But nInt is stored only if List has nTh element!
// oListKeeper - object that hold the list
void ListSetInt(object oListKeeper, string sName, int nTh, int nInt);

//Set sString to nth element of List with sName.
//But sString is stored only if List has nTh element!
// oListKeeper - object that hold the list
void ListSetString(object oListKeeper, string sName, int nTh, string sString);

//Set oObject to nth element of List with sName.
//But oObject is stored only if List has nTh element!
// oListKeeper - object that hold the list
void ListSetObject(object oListKeeper, string sName, int nTh, object oObject);

//Set fFloat to nth element of List with sName.
//But fFloat is stored only if List has nTh element!
// oListKeeper - object that hold the list
void ListSetFloat(object oListKeeper, string sName, int nTh, float fFloat);

//Add new string to end of List with sName. It's same as element with only int value.
//You ask why use this function? Well, elements store all types and checks if is every data type valid and
//then store it. So, if you use element for add one int it will do 3 extra commands.
//If there is not valid List with such name, new List is created.
void ListAddString(object oListKeeper, string sName, string sString);

//Add new float to end of List with sName. It's same as element with only int value.
//You ask why use this function? Well, elements store all types and checks if is every data type valid and
//then store it. So, if you use element for add one int it will do 3 extra commands.
//If there is not valid List with such name, new List is created.
void ListAddFloat(object oListKeeper, string sName, float fFloat);

//Add new object to end of List with sName. It's same as element with only int value.
//You ask why use this function? Well, elements store all types and checks if is every data type valid and
//then store it. So, if you use element for add one int it will do 3 extra commands.
//If there is not valid List with such name, new List is created.
// oListKeeper - object that hold the list
void ListAddObject(object oListKeeper, string sName, object oObject);


//Returns nTh value stored in List with sName
int ListGetInt(object oListKeeper, string sName, int nTh);


//Returns nTh value stored in List with sName
// oListKeeper - object that hold the list
string ListGetString(object oListKeeper, string sName, int nTh);


//Returns nTh value stored in List with sName
// oListKeeper - object that hold the list
float ListGetFloat(object oListKeeper, string sName, int nTh);

//Returns nTh value stored in List with sName
// oListKeeper - object that hold the list
object ListGetObject(object oListKeeper, string sName, int nTh);

//Returns nTh element from List with sName
// oListKeeper - object that hold the list
struct element ListGetNthElement(object oListKeeper, string sName, int nTh);

//Returns TRUE if List's element is valid, FALSE otherwise.
int ListGetIsElementValid(struct element eElement);

//Remove nTh element from List with sName
//This move every element that was behind nTh by 1 backwards.
// oListKeeper - object that hold the list
void ListRemoveElement(object oListKeeper, string sName, int nTh);

//Returns how many elements contain List with sName
// oListKeeper - object that hold the list
int ListGetElementCount(object oListKeeper, string sName);

//Returns index of element in List or 0 if there isn't such element
// oListKeeper - object that hold the list
int ListFindElement(object oListKeeper, string sName, struct element lElement);

//Returns index of string in List or 0 if there isn't such string
// oListKeeper - object that hold the list
int ListFindString(object oListKeeper, string sName, string sString);

//Returns index of object in List or 0 if there isn't such object
// oListKeeper - object that hold the list
int ListFindObject(object oListKeeper, string sName, object oObject);

//Returns index of int in List or 0 if there isn't such int
// oListKeeper - object that hold the list
int ListFindInt(object oListKeeper, string sName, int nInt);

//Returns index of float in List or 0 if there isn't such float
// oListKeeper - object that hold the list
int ListFindFloat(object oListKeeper, string sName, float fFloat);

//Returns nTh element name
string ListGetElementName(object oListKeeper, string sName, int nTh);

int ListGetIntArray(object oListKeeper, string sName, int nTh, int nArrayTh);
void ListSetIntArray(object oListKeeper, string sName, int nTh, int nArrayTh, int nInt);

struct element
{
int Int;
string String;
float Float;
object Object;
/*location Location;
itemproperty ItemProperty;
vector Vector;
struct map_pin MapPin;*/
};

////////////////////////////////////////////////////////////////////////////////
//                         function definitions                               //
////////////////////////////////////////////////////////////////////////////////

string GetFirstUnusedChar(object oListKeeper, string sName)//pseudo-list private function
{
int nTh, max = GetStringLength(LIST_ELEMENTS_ALPHABET);
string sChar, sList = GetLocalString(oListKeeper,"LIST_"+sName);
 do
 {
 sChar = GetSubString(LIST_ELEMENTS_ALPHABET,nTh,1);//get next char in a row
  if(FindSubString(sList,sChar) == -1)//this char is not used
  {
  return sChar;
  }
 }while(++nTh < max);
return "";
}

int ListGetIsValid(object oListKeeper, string sName)
{
return GetLocalString(oListKeeper,"LIST_"+sName) != "";
}

int ListFindElement(object oListKeeper, string sName, struct element lElement)
{
struct element e = ListGetNthElement(oListKeeper,sName,1);
int nTh = 1;
 while(ListGetIsElementValid(e))
 {
  if(e == lElement)
  {
  return nTh;
  }
 e = ListGetNthElement(oListKeeper,sName,++nTh);
 }
return 0;
}

void ListCreate(object oListKeeper, string sName)
{
 if(ListGetIsValid(oListKeeper,sName))
 {
 ListDestroy(oListKeeper,sName);
 }
}

void ListDestroy(object oListKeeper, string sName)
{
string sVarName = "LIST_"+sName;
string sList = GetLocalString(oListKeeper,sVarName);
int nCount = GetStringLength(sList);
 while(nCount)
 {
 ListRemoveElement(oListKeeper,sName,nCount--);
 }
}

void ListAddElement(object oListKeeper, string sName, int nInt=0 ,string sString="", object oObject=OBJECT_INVALID, float fFloat=0.0)
{
string sVarName = "LIST_"+sName;
string sChar = GetFirstUnusedChar(oListKeeper,sName);
SetLocalString(oListKeeper,sVarName,GetLocalString(oListKeeper,sVarName)+sChar);
 if(nInt)
 SetLocalInt(oListKeeper,sVarName+"_"+sChar,nInt);
 if(sString != "")
 SetLocalString(oListKeeper,sVarName+"_"+sChar,sString);
 if(fFloat != 0.0)
 SetLocalFloat(oListKeeper,sVarName+"_"+sChar,fFloat);
 if(oObject != OBJECT_INVALID)
 SetLocalObject(oListKeeper,sVarName+"_"+sChar,oObject);
}

struct element ListGetNthElement(object oListKeeper, string sName, int nTh)
{
struct element e;
string sVarName = "LIST_"+sName;
sVarName += "_"+GetSubString(GetLocalString(oListKeeper,sVarName),nTh-1,1);
e.Int = GetLocalInt(oListKeeper,sVarName);
e.String = GetLocalString(oListKeeper,sVarName);
e.Float = GetLocalFloat(oListKeeper,sVarName);
e.Object = GetLocalObject(oListKeeper,sVarName);
return e;
}

void ListRemoveElement(object oListKeeper, string sName, int nTh)
{
string sVarName = "LIST_"+sName;
string sList = GetLocalString(oListKeeper,sVarName);
 if(GetStringLength(sList) < 2)
 {
 DeleteLocalString(oListKeeper,sVarName);
 }
 else
 {
 SetLocalString(oListKeeper,sVarName,GetStringLeft(sList,nTh-1)+GetStringRight(sList,GetStringLength(sList)-nTh));
 }
sVarName += "_"+GetSubString(sList,nTh-1,1);
DeleteLocalInt(oListKeeper,sVarName);
DeleteLocalString(oListKeeper,sVarName);
DeleteLocalFloat(oListKeeper,sVarName);
DeleteLocalObject(oListKeeper,sVarName);
}

int ListGetElementCount(object oListKeeper, string sName)
{
return GetStringLength(GetLocalString(oListKeeper,"LIST_"+sName));
}

string ListGetElementName(object oListKeeper, string sName, int nTh)
{
return GetSubString(GetLocalString(oListKeeper,"LIST_"+sName),nTh-1,1);
}

int ListGetIsElementValid(struct element eElement)
{
 if(eElement.Int)
 return TRUE;
 else if(eElement.String != "")
 return TRUE;
 else if(eElement.Float != 0.0)
 return TRUE;
 else if(eElement.Object != OBJECT_INVALID)
 return TRUE;
return FALSE;
}

void ListAddInt(object oListKeeper, string sName, int nInt)
{
string sVarName = "LIST_"+sName;
string sChar = GetFirstUnusedChar(oListKeeper,sName);
SetLocalString(oListKeeper,sVarName,GetLocalString(oListKeeper,sVarName)+sChar);
SetLocalInt(oListKeeper,sVarName+"_"+sChar,nInt);
}

int ListGetInt(object oListKeeper, string sName, int nTh)
{
string sVarName = "LIST_"+sName;
sVarName+= "_"+GetSubString(GetLocalString(oListKeeper,sVarName),nTh-1,1);
return GetLocalInt(oListKeeper,sVarName);
}

void ListAddString(object oListKeeper, string sName, string sString)
{
string sVarName = "LIST_"+sName;
string sChar = GetFirstUnusedChar(oListKeeper,sName);
SetLocalString(oListKeeper,sVarName,GetLocalString(oListKeeper,sVarName)+sChar);
SetLocalString(oListKeeper,sVarName+"_"+sChar,sString);
}

string ListGetString(object oListKeeper, string sName, int nTh)
{
string sVarName = "LIST_"+sName;
sVarName+= "_"+GetSubString(GetLocalString(oListKeeper,sVarName),nTh-1,1);
return GetLocalString(oListKeeper,sVarName);
}

void ListAddFloat(object oListKeeper, string sName, float fFloat)
{
string sVarName = "LIST_"+sName;
string sChar = GetFirstUnusedChar(oListKeeper,sName);
SetLocalString(oListKeeper,sVarName,GetLocalString(oListKeeper,sVarName)+sChar);
SetLocalFloat(oListKeeper,sVarName+"_"+sChar,fFloat);
}

float ListGetFloat(object oListKeeper, string sName, int nTh)
{
string sVarName = "LIST_"+sName;
sVarName+= "_"+GetSubString(GetLocalString(oListKeeper,sVarName),nTh-1,1);
return GetLocalFloat(oListKeeper,sVarName);
}

void ListAddObject(object oListKeeper, string sName, object oObject)
{
string sVarName = "LIST_"+sName;
string sChar = GetFirstUnusedChar(oListKeeper,sName);
SetLocalString(oListKeeper,sVarName,GetLocalString(oListKeeper,sVarName)+sChar);
SetLocalObject(oListKeeper,sVarName+"_"+sChar,oObject);
}

object ListGetObject(object oListKeeper, string sName, int nTh)
{
string sVarName = "LIST_"+sName;
sVarName+= "_"+GetSubString(GetLocalString(oListKeeper,sVarName),nTh-1,1);
return GetLocalObject(oListKeeper,sVarName);
}

int ListFindString(object oListKeeper, string sName, string sString)
{
int nTh = 1;
int nCount = ListGetElementCount(oListKeeper,sName)+1;
 for(;nTh < nCount;nTh++)
 {
  if(ListGetString(oListKeeper,sName,nTh) == sString)
  {
  return nTh;
  }
 }
return 0;
}

int ListFindObject(object oListKeeper, string sName, object oObject)
{
int nTh = 1;
int nCount = ListGetElementCount(oListKeeper,sName)+1;
 for(;nTh < nCount;nTh++)
 {
  if(ListGetObject(oListKeeper,sName,nTh) == oObject)
  {
  return nTh;
  }
 }
return 0;
}

int ListFindInt(object oListKeeper, string sName, int nInt)
{
int nTh = 1;
int nCount = ListGetElementCount(oListKeeper,sName)+1;
 for(;nTh < nCount;nTh++)
 {
  if(ListGetInt(oListKeeper,sName,nTh) == nInt)
  {
  return nTh;
  }
 }
return 0;
}

int ListFindFloat(object oListKeeper, string sName, float fFloat)
{
int nTh = 1;
int nCount = ListGetElementCount(oListKeeper,sName)+1;
 for(;nTh < nCount;nTh++)
 {
  if(ListGetFloat(oListKeeper,sName,nTh) == fFloat)
  {
  return nTh;
  }
 }
return 0;
}

void ListSetInt(object oListKeeper, string sName, int nTh, int nInt)
{
sName = "LIST_"+sName;
string sList = GetLocalString(oListKeeper,sName);
 if(GetStringLength(sList) >= nTh)
 {
 SetLocalInt(oListKeeper,sName+"_"+GetSubString(sList,nTh-1,1),nInt);
 }
}

void ListSetIntArray(object oListKeeper, string sName, int nTh, int nArrayTh, int nInt)
{
sName = "LIST_"+sName;
string sChar = GetSubString(GetLocalString(oListKeeper,sName),nTh-1,1);
 if(sChar != "")
 {
 SetLocalInt(oListKeeper,sName+"_"+sChar+"_"+IntToString(nArrayTh),nInt);
 }
}

int ListGetIntArray(object oListKeeper, string sName, int nTh, int nArrayTh)
{
string sVarName = "LIST_"+sName;
sVarName+= "_"+GetSubString(GetLocalString(oListKeeper,sName),nTh-1,1)+"_"+IntToString(nArrayTh);
return GetLocalInt(oListKeeper,sVarName);
}

void ListSetString(object oListKeeper, string sName, int nTh, string sString)
{
sName = "LIST_"+sName;
string sList = GetLocalString(oListKeeper,sName);
 if(GetStringLength(sList) >= nTh)
 {
 SetLocalString(oListKeeper,sName+"_"+GetSubString(sList,nTh-1,1),sString);
 }
}

void ListSetObject(object oListKeeper, string sName, int nTh, object oObject)
{
sName = "LIST_"+sName;
string sList = GetLocalString(oListKeeper,sName);
 if(GetStringLength(sList) >= nTh)
 {
 SetLocalObject(oListKeeper,sName+"_"+GetSubString(sList,nTh-1,1),oObject);
 }
}

void ListSetFloat(object oListKeeper, string sName, int nTh, float fFloat)
{
sName = "LIST_"+sName;
 string sList = GetLocalString(oListKeeper,sName);
 if(GetStringLength(sList) >= nTh)
 {
 SetLocalFloat(oListKeeper,sName+"_"+GetSubString(sList,nTh-1,1),fFloat);
 }
}
