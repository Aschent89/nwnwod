// the PC is Good
int StartingConditional()
{
    int iResult = GetAlignmentGoodEvil(GetPCSpeaker());
    if (iResult == ALIGNMENT_GOOD) return TRUE;
    else return FALSE;
}
