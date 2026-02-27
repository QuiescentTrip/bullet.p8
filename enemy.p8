pico-8 cartridge // http://www.pico-8.com
version 43
__lua__
player={x=64,y=64}
enemies={}
bullets={}

function init_enemy_system()
    spawn_enemy(64,16,1.2,pattern_radial,30)
    spawn_enemy(30,16,1.2,pattern_radial,30)
    spawn_enemy(10,16,1.2,pattern_radial,30)
end

function spawn_enemy(x,y,speed,fire_pattern,fire_rate)
    add(enemies,{x=x,y=y,speed=speed,fire_pattern=fire_pattern,fire_rate=fire_rate,timer=0})
end

function update_enemies()
    for e in all(enemies) do
        local dx=player.x-e.x
        local dy=player.y-e.y
        local dist=sqrt(dx*dx+dy*dy)
        if dist>0 then
            e.x+=dx/dist*e.speed
            e.y+=dy/dist*e.speed
        end

        e.timer+=1
        if e.timer>=e.fire_rate then
            e.timer=0
            e.fire_pattern(e)
        end
    end
end

function draw_enemies()
    for e in all(enemies) do
        spr(1, e.x, e.y)
    end
end

function pattern_radial(e)
    for i=0,7 do
        local a=i/8
        add(bullets,{x=e.x,y=e.y,dx=cos(a)*1.5,dy=sin(a)*1.5})
    end
end


function update_bullets()
    for b in all(bullets) do
        b.x+=b.dx
        b.y+=b.dy
        if b.x<0 or b.x>127 or b.y<0 or b.y>127 then
            del(bullets,b)
        end
    end
end

function _init()
    init_enemy_system()
end

function _update()
    update_enemies()
    update_bullets()
end

function _draw()
    cls()
    draw_enemies()
    for b in all(bullets) do pset(b.x, b.y, 7) end
end
    




__gfx__
00000000003333000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000033333300000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700330330330000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000330330330000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000333333330000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700333333330000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000033333300000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000003333000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
