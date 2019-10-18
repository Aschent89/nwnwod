////////////////////////////////////////////////////////////////////////////////
//
//  Realistic Torches - OnUnequip
//  torch_onunequip
//  By:Don Anderson
//  dandersonru@msn.com
//
//  This is placed in the Module OnUnequip Event
//
////////////////////////////////////////////////////////////////////////////////

void main()
{
    object oTorch = GetPCItemLastUnequipped();
    string sTorch = GetTag(oTorch);

    //This is for a Torch
    if(sTorch == "Torch") SetLocalInt(oTorch,"TORCHEQUIP",0);

    //This is for an Open Lantern
    if(sTorch == "OpenLantern") SetLocalInt(oTorch,"TORCHEQUIP",0);

    //This is for a Lantern
    if(sTorch == "Lantern") SetLocalInt(oTorch,"TORCHEQUIP",0);
}
