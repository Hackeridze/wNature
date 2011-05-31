/*
* Copyright (c) 2011, Victor Hackeridze All rights reserved.
*
* Redistribution and use in source and binary forms, with or without modification,
* are permitted provided that the following conditions are met:
*
*     Redistributions of source code must retain the above copyright notice, this
* list of conditions and the following disclaimer.
*     Redistributions in binary form must reproduce the above copyright notice, this
* list of conditions and the following disclaimer in the documentation and/or other
* materials provided with the distribution.
*     Neither the name of the HACKERIDZE's BRAIN nor the names of its
* contributors may be used to endorse or promote products derived from this
* software without specific prior written permission.
*
* THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY
* EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
* WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.
* IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT,
* INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
* NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
* PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
* WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
* ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
* POSSIBILITY OF SUCH DAMAGE.
*/
module map;

import std.stdio;
import C = std.c.stdio;

import color;
import hero;
import handlers;

static immutable MAPSIZE = 150; /// Size of map MAPSIZE*MAPSIZE
immutable MINI = 4;/// It's hard to explain, MINI -- for mini map =)

/**
* Map cell struct
*/
struct MapCell {
    string localityType; /// May be bank jungle mountains plain desert water shoal forest
    bool open = false; /// Does its escaped? No by default
}
/**
* Struct of map cells from the file
*/
struct fileMapCell {
    char localityType; /// May be bank(B) jungle(J) mountains(M) plain(P) desert(D) water(W) shoal(S)
}

static MapCell[MAPSIZE][MAPSIZE] worldMap; /// World map
fileMapCell[MAPSIZE][MAPSIZE] fromFile; /// From-file map

void mapInitializator() {

    write("Loading map-file...");
    getMapFromFile();
    writeln(LIGHTGREEN, " OK", DEFAULT);

    write("Building map...");
    for (int column = 0; column < MAPSIZE; ++column) {
        for ( int row = 0; row < MAPSIZE; ++row) {

            if      (fromFile[column][row].localityType == 'D')
                    worldMap[column][row].localityType = "desert";
            else if (fromFile[column][row].localityType == 'B')
                    worldMap[column][row].localityType = "bank";
            else if (fromFile[column][row].localityType == 'F')
                    worldMap[column][row].localityType = "forest";
            else if (fromFile[column][row].localityType == 'M')
                    worldMap[column][row].localityType = "mountains";
            else if (fromFile[column][row].localityType == 'P')
                    worldMap[column][row].localityType = "plain";
            else if (fromFile[column][row].localityType == 'W')
                    worldMap[column][row].localityType = "water";
            else if (fromFile[column][row].localityType == 'S')
                    worldMap[column][row].localityType = "shoal";
            else if (fromFile[column][row].localityType == 'J')
                    worldMap[column][row].localityType = "jungle";
        }
    }
    writeln(LIGHTGREEN, " OK", DEFAULT);

    //write("Присваивание имен...");
    //localityNaming();
    //writeln(LIGHTGREEN, " OK", DEFAULT);
}

/// Print mini-map
void printMapMini() {
    writeln("\n\n\n\n");
    write(DEFAULT);

    int column, row, maxColumn, maxRow, ttt;

    if (!((hero.hero.coord.x - MINI) < 0)) column = (hero.hero.coord.x - MINI);
    else column = 0;

    if (!((hero.hero.coord.x + MINI) > MAPSIZE)) maxColumn = (hero.hero.coord.x + MINI);
    else maxColumn = MAPSIZE;

    if (!((hero.hero.coord.y + MINI) >MAPSIZE)) maxRow = (hero.hero.coord.y + MINI);
    else maxRow = MAPSIZE;

    if (!((hero.hero.coord.y - MINI) < 0)) row = (hero.hero.coord.y - MINI);
    else row = 0;

    printMapCap(column, maxColumn);

    for (; row < maxRow; ++row) {

        ttt = 0;

        if (!((hero.hero.coord.x - MINI) < 0)) column = (hero.hero.coord.x - MINI);
        else column = 0;

        write("\t\t\t");
        printMapRow(ttt, row);

        for (; column < maxColumn; ++column) {
            if ( (column == hero.hero.coord.x) && (row == hero.hero.coord.y)) {
                if (worldMap[column][row].localityType == "desert")
                    write(COLORDESERT,'D',DEFAULT,COLORHERO,'H',DEFAULT);
                else if (worldMap[row][column].localityType == "bank")
                    write(COLORBANK,'B',DEFAULT,COLORHERO,'H',DEFAULT);
                else if (worldMap[row][column].localityType == "forest")
                    write(COLORFOREST,'F',DEFAULT,COLORHERO,'H',DEFAULT);
                else if (worldMap[row][column].localityType == "mountains")
                    write(COLORMOUNTAINS,'M',DEFAULT,COLORHERO,'H',DEFAULT);
                else if (worldMap[row][column].localityType == "plain")
                    write(COLORPLAIN,'P',DEFAULT,COLORHERO,'H',DEFAULT);
                else if (worldMap[row][column].localityType == "water")
                    write(COLORWATER,'W',DEFAULT,COLORHERO,'H',DEFAULT);
                else if (worldMap[row][column].localityType == "shoal")
                    write(COLORSHOAL,'S',DEFAULT,COLORHERO,'H',DEFAULT);
                else if (worldMap[row][column].localityType == "jungle")
                    write(COLORJUNGLE,'J',DEFAULT,COLORHERO,'H',DEFAULT);
            }
            else {
                if (worldMap[column][row].open == false)
                    write(COLORNOTOPENED,' ',' ',DEFAULT);
                else if (worldMap[row][column].localityType == "desert")
                    write(COLORDESERT,'D',' ',DEFAULT);
                else if (worldMap[row][column].localityType == "bank")
                    write(COLORBANK,'B',' ',DEFAULT);
                else if (worldMap[row][column].localityType == "forest")
                    write(COLORFOREST,'F',' ',DEFAULT);
                else if (worldMap[row][column].localityType == "mountains")
                    write(COLORMOUNTAINS,'M',' ',DEFAULT);
                else if (worldMap[row][column].localityType == "plain")
                    write(COLORPLAIN,'P',' ',DEFAULT);
                else if (worldMap[row][column].localityType == "water")
                    write(COLORWATER,'W',' ',DEFAULT);
                else if (worldMap[row][column].localityType == "shoal")
                    write(COLORSHOAL,'S',' ',DEFAULT);
                else if (worldMap[row][column].localityType == "jungle")
                    write(COLORJUNGLE,'J',' ',DEFAULT);
            }
        }
        writeln();
    }
    write(DEFAULT);
}

/// Print all map, its fucking large!
void printMapAll() {

    int column, row;

    for (column = -1; column < MAPSIZE; ++column) {
        if (column == -1) {

            write(RED);

            write("   ");
            for (int t = column + 1; t < MAPSIZE; t++)
                writef("%d ", ((t%1000)/100));
            writeln();

            write("   ");
            for (int t = column + 1; t < MAPSIZE; t++)
                writef("%d ", ((t%100)/10));
            writeln();

            write("   ");
            for (int t = column + 1; t < MAPSIZE; t++)
                writef("%d ", (t%10));
            writeln();

            ++column;
            write(DEFAULT);
        }
                    //write(COLORHERO,'H',' ',DEFAULT);
        for (row = -1; row < MAPSIZE; ++row) {

            if (row == -1) {

                write(RED);

                writef("%03d", column);

                ++row;
                write(DEFAULT);
            }

            if ( (row == hero.hero.coord.x) && (column == hero.hero.coord.y)) {
                if (worldMap[column][row].localityType == "desert")
                    write(COLORDESERT,'D',DEFAULT,COLORHERO,'H',DEFAULT);
                else if (worldMap[column][row].localityType == "bank")
                    write(COLORBANK,'B',DEFAULT,COLORHERO,'H',DEFAULT);
                else if (worldMap[column][row].localityType == "forest")
                    write(COLORFOREST,'F',DEFAULT,COLORHERO,'H',DEFAULT);
                else if (worldMap[column][row].localityType == "mountains")
                    write(COLORMOUNTAINS,'M',DEFAULT,COLORHERO,'H',DEFAULT);
                else if (worldMap[column][row].localityType == "plain")
                    write(COLORPLAIN,'P',DEFAULT,COLORHERO,'H',DEFAULT);
                else if (worldMap[column][row].localityType == "water")
                    write(COLORWATER,'W',DEFAULT,COLORHERO,'H',DEFAULT);
                else if (worldMap[column][row].localityType == "shoal")
                    write(COLORSHOAL,'S',DEFAULT,COLORHERO,'H',DEFAULT);
                else if (worldMap[column][row].localityType == "jungle")
                    write(COLORJUNGLE,'J',DEFAULT,COLORHERO,'H',DEFAULT);
            }
            else {
                if (worldMap[column][row].open == false)
                    write(COLORNOTOPENED,' ',' ',DEFAULT);
                else if (worldMap[row][column].localityType == "desert")
                    write(COLORDESERT,'D',' ',DEFAULT);
                else if (worldMap[column][row].localityType == "bank")
                    write(COLORBANK,'B',' ',DEFAULT);
                else if (worldMap[column][row].localityType == "forest")
                    write(COLORFOREST,'F',' ',DEFAULT);
                else if (worldMap[column][row].localityType == "mountains")
                    write(COLORMOUNTAINS,'M',' ',DEFAULT);
                else if (worldMap[column][row].localityType == "plain")
                    write(COLORPLAIN,'P',' ',DEFAULT);
                else if (worldMap[column][row].localityType == "water")
                    write(COLORWATER,'W',' ',DEFAULT);
                else if (worldMap[column][row].localityType == "shoal")
                    write(COLORSHOAL,'S',' ',DEFAULT);
                else if (worldMap[column][row].localityType == "jungle")
                    write(COLORJUNGLE,'J',' ',DEFAULT);
            }
        }
        writeln();
    }
    write(DEFAULT);
}


/// Print a part of the map
void printMapPart(ushort how) {

    writeln(DEFAULT);

    int column, row, maxColumn, maxRow, ttt;

    if (!((hero.hero.coord.x - how) < 0)) column = (hero.hero.coord.x - how);
    else column = 0;

    if (!((hero.hero.coord.x + how) > MAPSIZE)) maxColumn = (hero.hero.coord.x + how);
    else maxColumn = MAPSIZE;

    if (!((hero.hero.coord.y + how) >MAPSIZE)) maxRow = (hero.hero.coord.y + how);
    else maxRow = MAPSIZE;

    if (!((hero.hero.coord.y - how) < 0)) row = (hero.hero.coord.y - how);
    else row = 0;

    printMapCapNoTab(column, maxColumn);

    for (; row < maxRow; ++row) {

        ttt = 0;

        if (!((hero.hero.coord.x - how) < 0)) column = (hero.hero.coord.x - how);
        else column = 0;

        printMapRow(ttt, row);

        for (; column < maxColumn; ++column) {
            if ( (column == hero.hero.coord.x) && (row == hero.hero.coord.y)) {
                if (worldMap[column][row].localityType == "desert")
                    write(COLORDESERT,'D',DEFAULT,COLORHERO,'H',DEFAULT);
                else if (worldMap[row][column].localityType == "bank")
                    write(COLORBANK,'B',DEFAULT,COLORHERO,'H',DEFAULT);
                else if (worldMap[row][column].localityType == "forest")
                    write(COLORFOREST,'F',DEFAULT,COLORHERO,'H',DEFAULT);
                else if (worldMap[row][column].localityType == "mountains")
                    write(COLORMOUNTAINS,'M',DEFAULT,COLORHERO,'H',DEFAULT);
                else if (worldMap[row][column].localityType == "plain")
                    write(COLORPLAIN,'P',DEFAULT,COLORHERO,'H',DEFAULT);
                else if (worldMap[row][column].localityType == "water")
                    write(COLORWATER,'W',DEFAULT,COLORHERO,'H',DEFAULT);
                else if (worldMap[row][column].localityType == "shoal")
                    write(COLORSHOAL,'S',DEFAULT,COLORHERO,'H',DEFAULT);
                else if (worldMap[row][column].localityType == "jungle")
                    write(COLORJUNGLE,'J',DEFAULT,COLORHERO,'H',DEFAULT);
            }
            else {
                if (worldMap[column][row].open == false)
                    write(COLORNOTOPENED,' ',' ',DEFAULT);
                else if (worldMap[row][column].localityType == "desert")
                    write(COLORDESERT,'D',' ',DEFAULT);
                else if (worldMap[row][column].localityType == "bank")
                    write(COLORBANK,'B',' ',DEFAULT);
                else if (worldMap[row][column].localityType == "forest")
                    write(COLORFOREST,'F',' ',DEFAULT);
                else if (worldMap[row][column].localityType == "mountains")
                    write(COLORMOUNTAINS,'M',' ',DEFAULT);
                else if (worldMap[row][column].localityType == "plain")
                    write(COLORPLAIN,'P',' ',DEFAULT);
                else if (worldMap[row][column].localityType == "water")
                    write(COLORWATER,'W',' ',DEFAULT);
                else if (worldMap[row][column].localityType == "shoal")
                    write(COLORSHOAL,'S',' ',DEFAULT);
                else if (worldMap[row][column].localityType == "jungle")
                    write(COLORJUNGLE,'J',' ',DEFAULT);
            }
        }
        writeln();
    }
    write(DEFAULT);
}




void printMapCap(int column, int maxColumn) {
  write("\t\t\t");
    write(RED, "   ");
    for (int t = column; t < maxColumn; t++)
                    writef("%d ", ((t%1000)/100));
    writeln();
  write("\t\t\t");
    write(RED, "   ");
    for (int t = column; t < maxColumn; t++)
                    writef("%d ", ((t%100)/10));
    writeln();
  write("\t\t\t");
    write(RED, "   ");
    for (int t = column; t < maxColumn; t++)
                    writef("%d ", (t%10));
    writeln(DEFAULT);
}

void printMapCapNoTab(int column, int maxColumn) {

    write(RED, "   ");
    for (int t = column; t < maxColumn; t++)
                    writef("%d ", ((t%1000)/100));
    writeln();

    write(RED, "   ");
    for (int t = column; t < maxColumn; t++)
                    writef("%d ", ((t%100)/10));
    writeln();

    write(RED, "   ");
    for (int t = column; t < maxColumn; t++)
                    writef("%d ", (t%10));
    writeln(DEFAULT);
}

void printMapRow(ref int ttt, int row) {
    if (ttt == 0) {
        write(RED);
        writef("%03d", row);
        write(DEFAULT);
        ++ttt;
    } else return;
}

/// Getting map from the 'world.map' file
void getMapFromFile() {

    FILE *worldMapFile;
    worldMapFile = C.fopen("world.map", "r");

    int column, row;

    for (column = 0; column < MAPSIZE ; column++) {
        for (row = 0; row < MAPSIZE; row++)
            C.fscanf (worldMapFile, "%c ", &fromFile[column][row].localityType);
    }
    C.fclose(worldMapFile);
}


/*
void ololo() {
    FILE *worldMapFile;
    worldMapFile = C.fopen("world.map.ololo", "w");

    int column, row;

    for (column = 0; column < 150 ; column++) {
        for (row = 0; row < 150; row++)
            C.fprintf (worldMapFile, "P ");
        C.fprintf (worldMapFile, "\n");
    }
}
*/
