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
module mobs;

import random;
import map;
import hero;
import std.stdio;
static import skills;

struct Mob {
    string name;
    uint health;
    long healthNow;
    uint attackPower;
    uint spellPower;
    ulong id;
    string habitat; /// Can be bank jungle mountains plain desert water shoal forest
    //string weapon; /// Can be tusks fangs
    //bool dead = false; /// For killing)
    bool bellicosity;

    /// Check death mob or not
    bool death() {
        if (this.healthNow > 0) return false;
        else return true;
    }
    void takingDamage(int how) {
        this.healthNow -= how;
    }
    /// Returns current damage
    uint damage() {
        if (randomInt(10) == 1) {
            writeln(this.name," mised!");
            return 0;
        } else {
            write(' ',this.name," deals ",this.attackPower," damage!");
            return this.attackPower;
        }
    }

    /// Taking damage from mob 'fromMob'
    void takingDamage(long how) {
        this.healthNow -= how;
    }
    /// Returns the rating
    float rating() {
        float rating = (((health*2)*38)/75 + ((attackPower + spellPower)*67)/81);
        rating /= 13.2546798511277;
        return rating;
    }

    this(string name, uint health, uint attackPower,
                uint spellPower, string habitat, ulong id/*, string weapon*/, bool bellicosity) {
        this.name = name;
        this.health = health;
        this.attackPower = attackPower;
        this.spellPower = spellPower;
        this.id = id;
        this.habitat = habitat;
        this.healthNow = this.health;
        //this.weapon = weapon;
        this.bellicosity = bellicosity;
    }
}



ulong[] generateMobs() {

    ushort counter = 0;

    auto suitable = new ulong[0];

    for(ulong id = 0; id < NUMBER_OF_MOBS; ++id) {

        Mob bufferMob = get(id);

        if ( bufferMob.habitat == hero.hero.heroLocalityType() && ((bufferMob.rating() <= hero.hero.rating())) ) {
            suitable ~= id;
            counter++;
        }

    }

    auto ret = suitable;

    suitable.length = 0; /// Im
    suitable = null;     /// FUCKIN'
    delete suitable;     /// DESTROY YOU!!!!

    return ret;
}

Mob get(const ulong id) {
    switch (id) {
        case 0: return boar();
        break;
        case 1: return wolf();
        break;
        case 2: return bear();
        break;
        case 3: return crocodile();
        break;
        case 4: return rat();
        break;
        case 5: return tiger();
        break;
        case 6: return spider();
        break;
        case 7: return elephant();
        break;
        case 8: return wolverine();
        break;
        case 9: return crucian();
        break;
    }
}

/// Number of mobs:
immutable NUMBER_OF_MOBS = 10; /// last ID + 1


static Mob boar() {
    string name = "Boar";
    uint health = 7 + randomInt(3);
    uint attackPower = 3;
    uint spellPower = 0;
    ulong id = 0; /// ID
    string habitat = "forest"; /// Habitat, may be bank jungle mountains plain desert water shoal forest
    //string weapon = "tusks";
    bool bellicosity = true;

    auto mob = Mob(name, health, attackPower, spellPower, habitat, id, bellicosity);
    return mob;
}

static Mob wolf() {
    string name = "Wolf";
    uint health = 5 + randomInt(4);
    uint attackPower = 6;
    uint spellPower = 0;
    ulong id = 1;
    string habitat = "forest";
    //string weapon = "fangs";
    bool bellicosity = true;

    auto mob = Mob(name, health, attackPower, spellPower, habitat, id, bellicosity);
    return mob;
}

static Mob bear() {
    string name = "Bear";
    uint health = 8 + randomInt(4);
    uint attackPower = 9;
    uint spellPower = 0;
    ulong id = 2;
    string habitat = "forest";
    bool bellicosity = true;

    auto mob = Mob(name, health, attackPower, spellPower, habitat, id, bellicosity);
    return mob;
}

static Mob crocodile() {
    string name = "Crocodile";
    uint health = 7 + randomInt(4);
    uint attackPower = 7;
    uint spellPower = 0;
    ulong id = 3;
    string habitat = "shoal";
    bool bellicosity = true;

    auto mob = Mob(name, health, attackPower, spellPower, habitat, id, bellicosity);
    return mob;
}

static Mob rat() {
    string name = "Rat";
    uint health = 2 + randomInt(2);
    uint attackPower = 2;
    uint spellPower = 0;
    ulong id = 4;
    string habitat = "plain";
    bool bellicosity = false;

    auto mob = Mob(name, health, attackPower, spellPower, habitat, id, bellicosity);
    return mob;
}

static Mob tiger() {
    string name = "Tiger";
    uint health = 8 + randomInt(3);
    uint attackPower = 10;
    uint spellPower = 0;
    ulong id = 5;
    string habitat = "plain";
    bool bellicosity = true;

    auto mob = Mob(name, health, attackPower, spellPower, habitat, id, bellicosity);
    return mob;
}

static Mob spider() {
    string name = "Spider";
    uint health = 1 + randomInt(2);
    uint attackPower = 1;
    uint spellPower = 0;
    ulong id = 6;
    string habitat = "forest";
    bool bellicosity = false;

    auto mob = Mob(name, health, attackPower, spellPower, habitat, id, bellicosity);
    return mob;
}

static Mob elephant() {
    string name = "Elephant";
    uint health = 13 + randomInt(5);
    uint attackPower = 15;
    uint spellPower = 0;
    ulong id = 7;
    string habitat = "plain";
    bool bellicosity = false;

    auto mob = Mob(name, health, attackPower, spellPower, habitat, id, bellicosity);
    return mob;
}

static Mob wolverine() {
    string name = "Wolverine";
    uint health = 7 + randomInt(3);
    uint attackPower = 1;
    uint spellPower = 0;
    ulong id = 8;
    string habitat = "jungle";
    bool bellicosity = true;

    auto mob = Mob(name, health, attackPower, spellPower, habitat, id, bellicosity);
    return mob;
}

static Mob crucian() {
    string name = "Crucian";
    uint health = 0 + randomInt(2);
    uint attackPower = 11;
    uint spellPower = 0;
    ulong id = 9;
    string habitat = "shoal";
    bool bellicosity = false;

    auto mob = Mob(name, health, attackPower, spellPower, habitat, id, bellicosity);
    return mob;
}


