////////////////////////////////////////////////////////////////////////////////
//
//  Realistic Torches - OnEquip
//  torch_onequip
//  By:Don Anderson
//  dandersonru@msn.com
//
//  This is placed in the Module OnEquip Event
//
////////////////////////////////////////////////////////////////////////////////

#include "x2_inc_itemprop"

void TorchUpdate(object oTorch);

void main()
{
    object oTorch   = GetPCItemLastEquipped();
    string sTorch   = GetTag(oTorch);
    object oPC      = GetItemPossessor(oTorch);
    object oMod     = GetModule();

    int nTHP        = GetLocalInt(oMod,"TORCHHP");
    int nOLHP       = GetLocalInt(oMod,"OLANTERNHP");
    int nLHP        = GetLocalInt(oMod,"LANTERNHP");

    //This is for a Torch
    if(sTorch == "Torch")
    {
      //Get Status of Torch
      int nCurTHP = GetLocalInt(oTorch,"TORCHHP");
      int nTNew   = GetLocalInt(oTorch,"TORCHNEW");

      //Set as New Torch and Equipped
      if(nCurTHP == 0 && nTNew == 0)
      {
        SetLocalInt(oTorch,"TORCHHP",nTHP);
        SetLocalInt(oTorch,"TORCHNEW",1);//Set to Used
        SetLocalInt(oTorch,"TORCHEQUIP",1);
      }

      //Set as Equipped
      else
      {
        SetLocalInt(oTorch,"TORCHEQUIP",1);

        //Always lose 1 HP when equipping....stops cheating
        nCurTHP = nCurTHP - 1;
        SetLocalInt(oTorch,"TORCHHP",nCurTHP);
      }

      //Now we start the Torch Cycle
      DelayCommand(1.0,TorchUpdate(oTorch));
    }

    //This is for an Open Lantern
    if(sTorch == "OpenLantern")
    {
      //Get Status of Open Lantern
      int nCurOLHP = GetLocalInt(oTorch,"OLANTERNHP");
      int nOLNew   = GetLocalInt(oTorch,"OLANTERNNEW");

      //Set as New Open Lantern and Equipped
      if(nCurOLHP == 0 && nOLNew == 0)
      {
        SetLocalInt(oTorch,"OLANTERNHP",nOLHP);
        SetLocalInt(oTorch,"OLANTERNNEW",1);//Set to Used
        SetLocalInt(oTorch,"TORCHEQUIP",1);
      }
      else if(nCurOLHP <= 0 && nOLNew == 1)
      {
        DelayCommand(0.5,AssignCommand(oPC,ActionUnequipItem(oTorch)));
        SendMessageToPC(oPC,"Your Lantern needs more Oil.");
        return;
      }
      //Set as Equipped
      else
      {
        SetLocalInt(oTorch,"TORCHEQUIP",1);

        //Always lose 1 HP when equipping....stops cheating
        nCurOLHP = nCurOLHP - 1;
        SetLocalInt(oTorch,"OLANTERNHP",nCurOLHP);
      }

      //Now we start the Torch Cycle
      DelayCommand(1.0,TorchUpdate(oTorch));
    }

    //This is for a Lantern
    if(sTorch == "Lantern")
    {
      //Get Status of Lantern
      int nCurLHP = GetLocalInt(oTorch,"LANTERNHP");
      int nLNew   = GetLocalInt(oTorch,"LANTERNNEW");

      //Set as New Lantern and Equipped
      if(nCurLHP == 0 && nLNew == 0)
      {
        SetLocalInt(oTorch,"LANTERNHP",nLHP);
        SetLocalInt(oTorch,"LANTERNNEW",1);//Set to Used
        SetLocalInt(oTorch,"TORCHEQUIP",1);
      }
      else if(nCurLHP <= 0 && nLNew == 1)
      {
        DelayCommand(0.5,AssignCommand(oPC,ActionUnequipItem(oTorch)));
        SendMessageToPC(oPC,"Your Lantern needs more Oil.");
        return;
      }
      //Set as Equipped
      else
      {
        SetLocalInt(oTorch,"TORCHEQUIP",1);

        //Always lose 1 HP when equipping....stops cheating
        nCurLHP = nCurLHP - 1;
        SetLocalInt(oTorch,"LANTERNHP",nCurLHP);
      }

      //Now we start the Torch Cycle
      DelayCommand(1.0,TorchUpdate(oTorch));
    }
}

void TorchUpdate(object oTorch)
{
    string sTorch   = GetTag(oTorch);
    object oPC      = GetItemPossessor(oTorch);
    object oMod     = GetModule();

    //Don't go further if the Torch was UnEquipped
    int nEquip      = GetLocalInt(oTorch,"TORCHEQUIP");
    if(nEquip == 0) return;

    int nTHP        = GetLocalInt(oMod,"TORCHHP");
    int nOLHP       = GetLocalInt(oMod,"OLANTERNHP");
    int nLHP        = GetLocalInt(oMod,"LANTERNHP");

    float fCycle    = GetLocalFloat(oMod,"TORCHCYCLE");

    itemproperty ipBright = ItemPropertyLight(IP_CONST_LIGHTBRIGHTNESS_BRIGHT, IP_CONST_LIGHTCOLOR_YELLOW);
    itemproperty ipNorm   = ItemPropertyLight(IP_CONST_LIGHTBRIGHTNESS_NORMAL, IP_CONST_LIGHTCOLOR_YELLOW);
    itemproperty ipLow    = ItemPropertyLight(IP_CONST_LIGHTBRIGHTNESS_LOW, IP_CONST_LIGHTCOLOR_YELLOW);
    itemproperty ipDim    = ItemPropertyLight(IP_CONST_LIGHTBRIGHTNESS_DIM, IP_CONST_LIGHTCOLOR_YELLOW);

    //This is for a Torch
    if(sTorch == "Torch")
    {
      int nCurTHP = GetLocalInt(oTorch,"TORCHHP");
      if(nCurTHP <= 0)
      {
        DestroyObject(oTorch,1.0);
        SendMessageToPC(oPC,"Your Torch has been used up.");
        return;
      }
      else
      {
        nCurTHP = nCurTHP - 1;
        SetLocalInt(oTorch,"TORCHHP",nCurTHP);
      }

      //This is where we apply the Dimming Effects
      int nQuar = nTHP/4;
      int nNorm = nQuar * 3;
      int nLow  = nQuar * 2;
      int nDim  = nQuar * 1;
      if(nCurTHP >= nLow) IPSafeAddItemProperty(oTorch,ipNorm);
      if(nCurTHP >= nDim && nCurTHP < nLow) IPSafeAddItemProperty(oTorch,ipLow);
      if(nCurTHP < nDim) IPSafeAddItemProperty(oTorch,ipDim);
    }

    //This is for an Open Lantern
    if(sTorch == "OpenLantern")
    {
      int nCurOLHP = GetLocalInt(oTorch,"OLANTERNHP");
      if(nCurOLHP <= 0)
      {
        AssignCommand(oPC,ActionUnequipItem(oTorch));
        SendMessageToPC(oPC,"Your Lantern needs more Oil.");
        return;
      }
      else
      {
        nCurOLHP = nCurOLHP - 1;
        SetLocalInt(oTorch,"OLANTERNHP",nCurOLHP);
      }

      //This is where we apply the Dimming Effects
      int nQuar = nOLHP/4;
      int nNorm = nQuar * 3;
      int nLow  = nQuar * 2;
      int nDim  = nQuar * 1;
      if(nCurOLHP >= nLow) IPSafeAddItemProperty(oTorch,ipNorm);
      if(nCurOLHP >= nDim && nCurOLHP < nLow) IPSafeAddItemProperty(oTorch,ipLow);
      if(nCurOLHP < nDim) IPSafeAddItemProperty(oTorch,ipDim);
    }

    //This is for a Lantern
    if(sTorch == "Lantern")
    {
      int nCurLHP = GetLocalInt(oTorch,"LANTERNHP");
      if(nCurLHP <= 0)
      {
        AssignCommand(oPC,ActionUnequipItem(oTorch));
        SendMessageToPC(oPC,"Your Lantern needs more Oil.");
        return;
      }
      else
      {
        nCurLHP = nCurLHP - 1;
        SetLocalInt(oTorch,"LANTERNHP",nCurLHP);
      }

      //This is where we apply the Dimming Effects
      int nQuar = nLHP/4;
      int nNorm = nQuar * 3;
      int nLow  = nQuar * 2;
      int nDim  = nQuar * 1;
      if(nCurLHP >= nNorm) IPSafeAddItemProperty(oTorch,ipBright);
      if(nCurLHP >= nLow && nCurLHP < nNorm) IPSafeAddItemProperty(oTorch,ipNorm);
      if(nCurLHP < nLow) IPSafeAddItemProperty(oTorch,ipLow);
    }

    //Now we start the Torch Cycle
    DelayCommand(fCycle,TorchUpdate(oTorch));
}
