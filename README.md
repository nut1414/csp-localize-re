# Clip Studio Localization File Format Reverse Engineering

This is an attempt at reverse engineering the clip studio localization file for education purposes.

Why? Because I "accidentally" bought the Japanese version of the software w/o reading the fine print.

This repository includes hexpattern code for ImHex for automatic pattern detection (still a WIP).

Any help is appreciated, and if you got the old l10n tools, please message me :p.

Formats are numbered based on the order of when (I) first encounter.

From Clip Studio Paint 1.12.8

```c
First text address
JP1 11C8
EN1 11C8
```

```c
FF FF FF FF # Block seperator
```

```c
Some sort of header at the beginning
00000003 # indicating new start or count 3?

00000001 # first section?
00000028 #
0025B1E8 # ?? seems to store something about region

00000002 # second section?
0025B210 # ??
0001EED2 # ??

00000003 # third section?
0027A0E2 # ??
```

## Format 1

```c
00000003 # start 3 block or start??
00000001

00000028 
0025B1E8 
00000002

0025B210 
0001EED2 
00000003 
0027A0E2 

XXXXXXXX # address
XXXXXXXX # ???
XXXXXXXX # counter

XXXXXXXX # address
XXXXXXXX # ???
XXXXXXXX # counter

  ....
XXXXXXXX 
XXXXXXXX 
XXXXXXXX 

```

```c
00000003 # 3 block or start??

00000001 # magic?
00000028 
0025B1E8 

00000002 
0025B210 
0001EED2 

00000003 
0027A0E2  

00000030 # starting address [header?]
00000153 # total count of the following block
00000001 # counter

@0x00000030

00001010 # address of data 
000038A9  
00000002 

000048B9 
00001890
00000003

00006149
00000B44
00000004 
  ....
```

## Format 2 (DataType::Text = 0x3) linked list of text

```c
00000003 # type

XXXXXXXX # type
XXXXXXXX # address
XXXXXXXX # size
```

```c
@ 0x00001010

00000003 # starting

00000001 # type?  01 start 04 end 02 ???
00001038 # address
000005B5 # size?

00000004 
000015ED 
00002E22 

00000002 
0000440F 
000004AA
```

## Format 3

Location and size of the text

```c
@ 0x00001038

00000021 # count

00000003 # counter/magic?
000011C8 # address 
0000002B # size of the text including header & 0 pad

00000005
000011F3 
00000034 

00000007 
00001227 
00000034 
 ......
```

## Format 4

```c
First 4 byte indicate the sizeof text  
Follow by UTF-8 encoded text
End with three 0 bytes

XXXXXXXX # Size in hex
CCCCCCCC # UTF-8 encoded text
  ....   
XXXXXXXX
CCCCCCCC
  ....
 000000

```

```c
@ 0x000011C8

00 00 00 27 # 0x27 -> 0d39

E3 83 93 E3 
83 A5 E3 83 
BC E3 82 92 
E7 B7 A8 E9 
9B 86 E5 AF 
BE E8 B1 A1 
E3 81 AB E5 
90 88 E3 82 
8F E3 81 9B 
E3 82 8B    # text 

ビューを編集対象に合わせる

text bytes count: 0d39
total byte count: 0x2B -> 0d43
```

## Format 5 (DataType::???????? = 0x2) Text (array)

```c
@0x00006149

00000002 # Type

00000001 # magic  01 START   04 END 
00006165 # Address
000000BA # Length  <- 621F-6165 = BA

00000004 # magic
0000621F # Address
00000A6E # ?????

-------
@0x00006165

00000006 # Count 6 , 

00000006
000061B1
00000010

00000006
000061C1
0000000A

00000007
000061CB
00000010

00000008
000061DB
0000002B

00000004
00006206
00000006

00000005
0000620C
00000013
```

## Format 6 (DataType::???????? = 0x1) Unknown (????)

```c
@0x00006C8D

00000001 # type 1

00000004
00006C9D
0000119E

-----------

@0x00006C9D

00000002 

00000001
00006CB9
000007D8

00000007
00007491
000009AA

----------

@0x00006CB9

000007D8
00000010
00000014
0000004A
00000000
00000005
FFFFFFFF
FFFFFFFF

@0x00007491

000009AA
00000010
00000014
0000004A
00000000
00000005
FFFFFFFF
FFFFFFFF

```

## Format 7 (DataType::???????? = 0x5) Unknown (inner GUI system????)

```c
@0x0000CE92

00000005

0000000A
0000CED2
000000FE

00000009
0000CFD0
00002271

00000001
0000F241
0001C95D
00000005
0002BB9E
00000684
00000002
0002C222
00015564

@0x00000CED2

00000001
00000001
0000CEE2
000000EE
000000EE
00000010
00000020
000000BA
0000000C 
50574D6F 
64756C65 
496E666F 
0000000F 
FFFFFFFF 
FFFFFFFF

PWModuleInfo
```

## Format 8 (DataType::???????? = 0x4) Unknown (More Text?)

```c
@0x0020385D
```
