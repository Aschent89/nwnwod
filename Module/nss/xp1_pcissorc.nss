// the PC has at least 1 level Sorcerer
int StartingConditional()
{
    int iResult;

    iResult = GetLevelByClass(CLASS_TYPE_SORCERER, GetPCSpeaker()) > 0;
    return iResult;
}
