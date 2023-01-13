#include <std/io.pat>
#pragma endian big

u32 outputValue out;
outputValue = 0;

enum DataType : u32 {
    UNKNOWN_DATA = 0x1,
    TEXT_LIST = 0x2,
    TEXT_LINK_LIST = 0x3,
    UNKNOWN_TEXT = 0x4,
    UNKNOWN_GUI = 0x5,
    UNKNOWN_TYPE
};

enum TextBlockType : u32 {
    START_POS = 0x1,
    END_POS = 0x4,
    TEXT_BLOCK = 0x3,
    LINKED_UNKNOWN = 0x2
};

struct TextData {
    u32 size;
    char text[size];
};

struct TextMeta{
    u32 magic;
    TextData* text : u32 [[inline]];
    u32 size;
};

struct TextHeader{
    u32 size;
    TextMeta meta[size];
};

struct TextBlock {
   TextBlockType block_type; 
   if (block_type ==  TextBlockType::START_POS){
    TextHeader* text_header : u32 [[inline]];
   }else{
    u32* address : u32;
   }
   
   u32 size;
};

struct TextLinkList {
   TextBlock blocks[3];
};

struct TextList {
   TextBlock blocks[2];
};

struct Data {
    DataType type;
    if(type == DataType::TEXT_LINK_LIST){
        TextLinkList block_list[[inline]];
        outputValue += 1;
        std::print("Found at {:8x}",addressof(block_list));
    }else if (type == DataType::TEXT_LIST){
        TextList block_list[[inline]];
        outputValue += 1;
        std::print("Found at {:8x}",addressof(block_list));
    }else if(type == 0x1 || type == 0x4 || type == 0x5){
    
    }else{
        u32 addr;
        std::print("Unknown at {:8x}",addressof(addr));
    }
};

struct DataPointer{
    Data* data: u32 [[inline]];
    u32 count;
    u32 magic;
    
};

struct DataHeader{    
    DataPointer* first_data: u32  ;
    u32 count;
    u32 pos;
    DataPointer data_list[count];
    
};

DataHeader h @ 0x24;

//TextHeader thead @ 0x1038;



