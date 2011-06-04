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
import std.process;

public import map;
import random;
import color;
import handlers;
import mobs;
static import skills;


static char[16] PlayerNickName = ' '; /// Player's nickname, 10 chars maximum long
immutable STD_HEALTH = 20; /// Standart health
immutable STD_MANA = 20; /// Standart mana
immutable STD_SPELL_POWER = 2; /// Have always done a multiple of two
immutable STD_ATTACK_POWER = 2; /// Have always done a multiple of two
immutable STD_FORTUNE = 0; /// It's fate, standart fate ;D
immutable STD_REDUCTION = 0; /// Standart damage reduction
immutable STD_CRIT_STRIKE_RATE = 0; /// Standart critical strike rating

static immutable START_COORD = Coord(45, 15); /// Hero start coordinates, х = 45 и у = 15

/// Coordinates structure
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
    char[16] name;               /// Name
    ulong health;               /// Health, maximum
    long healthNow;            /// Health, now
    ulong mana;               /// Mana, maximum
    long manaNow;            /// Mana, now
    uint attackPower;       /// Attack power
    uint spellPower;       /// Spell power
    uint damageReduction; /// Damage reduction
    uint fortune;        /// Fortune
    uint critStrikeRate;/// Critical strike rating

    uint armor = 0;   /// Armor

    uint[32] inventory; /// Inventory(

    Coord coord = START_COORD; /// Initialize hero coords by START_COORDS

    /// Using skills)
    int useSkills() {
        string command ="43235dsf235";
        while (command != "43235235") {
            writeln(FLASH, "\n Type \"skills\" to print avaliable skills\n",
                            "\tWhat skill use?", RED);
                            write("\r >", RED);
            stdin.readln(command);
            write(DEFAULT, "\r\n", command);
            for(int t = 0; t < skills.get.length; ++t) {
                if (command == "skills\n") {
                    this.printAvaliableSkills();
                    break;
                }
                else if ((skills.get[t].command) == command) {
                    return this.genDamage(t);
                    break;
                } else continue;
            }
        }
        return 0;
    }
    /// Prints avaliable skils for hero
    void printAvaliableSkills(){
        writeln(RED,"\tSkills that you can youse:
                     [command] -- [name]",DEFAULT);

        for(uint t; t < skills.get.length; ++t){
            if (skills.get[t].opened == false) continue;
            else write(LIGHTRED,'\t',skills.get[t].name," -- ",skills.get[t].command,DEFAULT);
        }
    }
    /// Generate and returns damage from skill
    int genDamage(uint skill_ID) {
        auto skll = skills.get[skill_ID];
        if (skll.forMage == true) return (skll.damage * spellPower);
        else {
            return (skll.damage * attackPower);
        }
    }

    /// Returns type of locality where hero is now
    string heroLocalityType() {
        return map.worldMap[hero.coord.y][hero.coord.x].localityType;
    }

    /// Printing current info about the hero
    void printInfo() {
        shell("clear"); /// Clean the screen

        printMapMini();
        write(PURPLE);
        write("\033[9A");
        write(" Name: ", this.name, "\r\n");
        write(" Health: ", this.healthNow,'\\', this.health, "\r\n");
        write(" Mana: ", this.manaNow,'\\', this.mana, "\r\n");
        write(" Coords: [", this.coord.x,';', this.coord.y, "]\r\n");
        write(" Locality type: ", heroLocalityType(), "\r\n");
        write(" Attack power: ", this.attackPower, "\r\n");
        write(" Spell power: ", this.spellPower, "\r\n");
        write("\033[2B");
        write(DEFAULT);
    }
    /// Cause death immidiatly
    void dieNow() {
        this.healthNow = 0;
        this.death();
    }
    /// Cheсk do hero die or not
    bool death() {
        if (this.healthNow > 0) return false;
        else {
            writeln("You die... Rest in ",heroLocalityType());
            return true;
        }
    }
    /// Taking damage from mob 'fromMob'
    void takingDamage(Mob fromMob) {
        this.healthNow -= fromMob.damage();
        this.death();
    }
    /// Returns rating. Doesn't it?
    float rating() {
        float rating = (((this.health + this.mana)*38)/75 + ((this.attackPower + this.spellPower)*67)/81);
        rating /= 13.2546798511277;
        return rating;
    }
    /// Prints the warning
    void printWarningEdjeOfMap() {
        writeln(RED, "Now you are in a such place where our developers' hand didn't reach.", DEFAULT);
    }
    /// Up going func
    bool goUp() {
        if ((this.coord.y - 1) !< 0) this.coord.y--;
        else {
            printWarningEdjeOfMap();
            return false;
        }
        coordHandler(this);
        return true;
    }
    /// Down  going func
    bool goDown() {
        if ((this.coord.y + 1) !> MAPSIZE - 1) this.coord.y++;
        else {
            printWarningEdjeOfMap();
            return false;
        }
        coordHandler(this);
        return true;
    }
    /// Left going func
    bool goLeft() {
        if ((this.coord.x - 1) !< 0) this.coord.x--;
        else {
            printWarningEdjeOfMap();
            return false;
        }
        coordHandler(this);
        return true;
    }
    /// Right going func
    bool goRight() {
        if ((this.coord.x + 1) !> MAPSIZE - 1) this.coord.x++;
        else {
            printWarningEdjeOfMap();
            return false;
        }
        coordHandler(this);
        return true;
    }
    /// Constructor
    this(char[16] name, ulong health, ulong mana,
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

Hero hero; /// Making new hero


/// Allows long-walks
void heroGoTo(string to) {

    write("\r\t How long? >");
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






