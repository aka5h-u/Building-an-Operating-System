#include<screen.h>

void print_char(char character ,int col , int row, char attr)
{
    int offset ;
    unsigned char* videomem = (unsigned char *)VIDEO_MEM ;

    if(!attr)
    {
        attr = WHITE_ON_BLACK ;

    }
    //if column and row are non-negative get the screen offset
    if(row > 0 && col > 0)
    {
        offset = get_screen_offset(row,col) ;

    }
    else
    {
        offset = get_cursor() ;
    }
    
    if(character == "\n") //if the character is a new line
    {
        int rows = offset /(2*MAX_COLUMNS);
    }
    else
    /*else write the character's ascii value to the frame buffer and upper half of the 16 bits to attribute*/
    {
        videomem[offset] = character ;
        videomem[offset + 1] = attr ;
    }
    
    

}