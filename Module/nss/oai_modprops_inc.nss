////////////////////////////////////////////////////////////////////////////////
//
//  DK Library
//  oai_modprops_inc
//
//  Only change to the  oai  prefix for System Implementation
//  (Integral Part of OAI)
//
////////////////////////////////////////////////////////////////////////////////

//::///////////////////////////////////////////////
//:: Name dk_modprops_inc
//:://////////////////////////////////////////////
/*
    Library or routines to support getting/setting properties for items
    based on tags. Also allows searching for items with properties.

    MOTE: Keep you property names short.
*/
//:://////////////////////////////////////////////
//:: Created By: David Kelly
//:: Created On: 28-Dec-2005
//:://////////////////////////////////////////////

// Property prefix. Change if you have a clash with your mod
const string DKPROP_PREFIX = "DKP_";

// Properties and values
//
// Define your own below as you need
const string PROP_LIGHT = "LIGHT";
const int PROPV_TORCH   = 0x0001;
const int PROPV_LANTERN = 0x0002;
const int PROPV_LIGHT   = 0x0003;   // Detects either Torch or Lantern

// Sets the sPropery for sRef to current value OR nValue
// Returns new setting.
int SetModPropertyForRef(string sRef, string sProperty, int nMask);

// Sets the sPropery for oItem to current value OR nValue
// Returns new setting.
int SetModPropertyForItem(object oItem, string sProperty, int nMask);

// Gets the bits that match nMask stored under the sProperty for the sRef
int GetModPropertyForRef(string sRef, string sProperty, int nMask=0xffff);

// Gets the bits that match nMask stored under the sProperty for the oItem
int GetModPropertyForItem(object oItem, string sProperty, int nMask=0xffff);

// Search oContainer and return the nCnt(th) item that nMask matches any setting
// stored under the property sProperty.
object GetModItemWithProperty(object oContainer, string sProperty, int nMask, int nCnt=1);

// SetModProperty, ORs in value
int SetModPropertyForRef(string sRef, string sProperty, int nMask)
{
    string sProp = DKPROP_PREFIX + sProperty + "_" + sRef;
    object oMod = GetModule();

    SetLocalInt(oMod, sProp, GetLocalInt(oMod, sProp) | nMask);

    return nMask;
}

// SetModProperty, ORs in value
int SetModPropertyForItem(object oItem, string sProperty, int nMask)
{
    if (!GetIsObjectValid(oItem))
        return FALSE;

    return SetModPropertyForRef(GetResRef(oItem), sProperty, nMask);
}

// GetModProperty returns matched part of mask
int GetModPropertyForRef(string sRef, string sProperty, int nMask=0xffff)
{
    return GetLocalInt(GetModule(), DKPROP_PREFIX + sProperty + "_" + sRef) & nMask;
}
// GetModProperty returns matched part of mask
int GetModPropertyForItem(object oItem, string sProperty, int nMask=0xffff)
{
    if (!GetIsObjectValid(oItem))
        return FALSE;

    return GetLocalInt(GetModule(), DKPROP_PREFIX + sProperty + "_" + GetResRef(oItem)) & nMask;
}

// GetItemWithProperty searchs contents looking for any item with part of
// requested value. Will return the nth (nCnt) match.
object GetModItemWithProperty(object oContainer, string sProperty, int nMask, int nCnt=1)
{
    if (!GetHasInventory(oContainer))
        return OBJECT_INVALID;

    object oItem = GetFirstItemInInventory(oContainer);

    while (GetIsObjectValid(oItem)) {
        if (GetModPropertyForItem(oItem, sProperty, nMask) > 0)
            if (--nCnt == 0)
                return oItem;
        oItem = GetNextItemInInventory(oContainer);
    }

    return OBJECT_INVALID;
}

//void main(){}
