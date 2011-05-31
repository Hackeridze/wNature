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
module hero;

import std.stdio;

public import map;
import random;
import color;
import handlers;

static char[11] PlayerNickName = '\n'; /// Player's nickname, 10 chars maximum long
immutable STD_HEALTH = 20;
immutable STD_MANA = 20;
immutable STD_SPELL_POWER = 2; /// Have always done a multiple of two
immutable STD_ATTACK_POWER = 2; /// Have always done a multiple of two
immutable STD_FORTUNE = 0;
immutable STD_REDUCTION = 0;
immutable STD_CRIT_STRIKE_RATE = 0;

static immutable START_COORD = Coord(45, 15); /// Start hero coordinates, х = 45 и у = 15

/// Координаты
struct Coord {
    int x;
    int y;
    this(int x, int y) {
        this.x = x;
        this.y = y;
    }
}


/**
* Hero
*/
struct Hero {
    char[11] name; /// Name
    uint health; /// Health, maximum
    uint healthNow; /// Health, now
    uint mana; /// Mana, maximum
    uint manaNow; /// Mana, now
    uint attackPower; /// Attack power
    uint spellPower; /// Spell power
    uint damageReduction; /// Damage reduction
    uint fortune; /// fortune
    uint critStrikeRate; /// Critical strike rating

    uint armor = 0; /// Armor

    string[32] inventory; /// Inventory

    Coord coord = START_COORD; /// initialize hero coords by START_COORDS

    void die() {
        if (this.healthNow <= 0) {
            writeln("You die... Let ",heroLocalityType()," be a piece of shit for you!");
        }
    }

    /// Returns rating. FUCK! WTF?
    float rating() {
        float rating = (((this.health + this.mana)*38)/75 + ((this.attackPower + this.spellPower)*67)/81);
        rating /= 13.2546798511277;
        return rating;
    }
    /// Up going func
    bool goUp() {
        if ((this.coord.y - 1) !< 0) this.coord.y--;
        else {  writeln(RED, "НИЗЯ, БАШКОЙ ДУМАЙ! ПРИДЕЛИ КАРТЫ! ЕТА ПЛОХА!", DEFAULT);
                return false;
        }
        coordHandler();
        return true;
    }
    /// Down  going func
    bool goDown() {
        if ((this.coord.y + 1) !> MAPSIZE - 1) this.coord.y++;
        else {writeln(RED, "НИЗЯ, БАШКОЙ ДУМАЙ! ПРИДЕЛИ КАРТЫ! ЕТА ПЛОХА!", DEFAULT);
        return false;
        }
        coordHandler();
        return true;
    }
    /// Left going func
    bool goLeft() {
        if ((this.coord.x - 1) !< 0) this.coord.x--;
        else {writeln(RED, "НИЗЯ, БАШКОЙ ДУМАЙ! ПРИДЕЛИ КАРТЫ! ЕТА ПЛОХА!", DEFAULT);
        return false;
        }
        coordHandler();
        return true;
    }
    /// Right going func
    bool goRight() {
        if ((this.coord.x + 1) !> MAPSIZE - 1) this.coord.x++;
        else {  writeln(RED, "НИЗЯ, БАШКОЙ ДУМАЙ! ПРИДЕЛИ КАРТЫ! ЕТА ПЛОХА!", DEFAULT);
                return false;
        }
        coordHandler();
        return true;
    }
    /// Constructor
    this(char[11] name, uint health, uint mana,
            uint attackPower, uint spellPower,
            uint damageReduction, uint fortune,
            uint critStrikeRate) {

        this.name = name;

        this.health = health;
        this.mana = mana;
        this.healthNow = health;
        this.manaNow = mana;

        this.attackPower = attackPower;
        this.spellPower = spellPower;
        this.damageReduction = damageReduction;
        this.fortune = fortune;
        this.critStrikeRate = critStrikeRate;
    }
}

Hero hero; /// Make new hero


void printHeroInfo() {

    std.c.stdlib.system("clear"); /// Clen the screen

    printMapMini();
    write(PURPLE);
    write("\033[9A");
    write(" Name: ", hero.name, "\r\n");
    write(" Health: ", hero.healthNow,'\\', hero.health, "\r\n");
    write(" Mana: ", hero.manaNow,'\\', hero.mana, "\r\n");
    write(" Coords: [", hero.coord.x,';', hero.coord.y, "]\r\n");
    write(" Locality type: ", heroLocalityType(), "\r\n");
    write(" Rating: ", hero.rating(), "\r\n");
    write("\033[5B");
    write(DEFAULT);
}

string heroLocalityType() {
    return map.worldMap[hero.coord.y][hero.coord.x].localityType;
}


void heroGoTo(string to) {

    write("\r\t As long? >");
    uint times;
    std.stdio.readf("%d", &times);
    writeln();

    if (to == "up") moveUp(times);
    else if (to == "down") moveDown(times);
    else if (to == "right") moveRight(times);
    else if (to == "left") moveLeft(times);
}

void moveUp(uint times) {
    for (int t = 0; t < times; ++t) {
        if (hero.goUp() == false) break;
    }
}
void moveDown(uint times) {
    for (int t = 0; t < times; ++t) {
        if (hero.goDown() == false) break;
    }
}
void moveRight(uint times) {
    for (int t = 0; t < times; ++t) {
        if (hero.goRight() == false) break;
    }
}
void moveLeft(uint times) {
    for (int t = 0; t < times; ++t) {
        if (hero.goLeft() == false) break;
    }
}


/**
* Hero-generating func
*/
void heroGenerator(ref Hero genHero) {

    auto type = randomInt(2); /// 1 -- маг, 2 -- воин

    if (type == 1) genHero = Hero(PlayerNickName,
                                  STD_HEALTH - randomInt(6)+1,
                                  STD_MANA + randomInt(6)-1,
                                  STD_ATTACK_POWER - (randomInt(STD_ATTACK_POWER/2 + 1) - 1),
                                  STD_SPELL_POWER + (randomInt(STD_SPELL_POWER/2 + 1) - 1),
                                  STD_REDUCTION,
                                  STD_FORTUNE,
                                  STD_CRIT_STRIKE_RATE);

    if (type == 2) genHero = Hero(PlayerNickName,
                                  STD_HEALTH + randomInt(6)-1,
                                  STD_MANA - randomInt(6)+1,
                                  STD_ATTACK_POWER + (randomInt(STD_ATTACK_POWER/2 + 1) - 1),
                                  STD_SPELL_POWER - (randomInt(STD_SPELL_POWER/2 + 1) - 1),
                                  STD_REDUCTION,
                                  STD_FORTUNE,
                                  STD_CRIT_STRIKE_RATE);

    exploration();
}






