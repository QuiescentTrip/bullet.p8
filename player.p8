pico-8 cartridge // http://www.pico-8.com
version 43
__lua__

x = 64 y = 64
last_look_direction = 0
bullets = {}
bullet_speed = 4

dash_distance = 20

function _update()
    if btn(0) then x-=1 last_look_direction = 0 end
    if btn(1) then x+=1 last_look_direction = 1 end
    if btn(2) then y-=1 last_look_direction = 2 end
    if btn(3) then y+=1 last_look_direction = 3 end
    if btnp(4) then fire_bullet() end
    if btnp(5) then dash() end
end

function _draw()
    cls(7)
    circfill(x, y, 2, 1)
    if btn(4) then fire_bullet() end
end

function _draw()
    cls(7)
    circfill(x, y, 2, 1)
    bullet_update()
end

function bullet_update()
    for _, bullet in ipairs(bullets) do
        circfill(bullet.x, bullet.y, 2, 1)
        if bullet.direction == 0 then
            bullet.x -= bullet.speed
        elseif bullet.direction == 1 then
            bullet.x += bullet.speed
        elseif bullet.direction == 2 then
            bullet.y -= bullet.speed
        elseif bullet.direction == 3 then
            bullet.y += bullet.speed
        end
        if bullet.x < 0 or bullet.x > 128 or bullet.y < 0 or bullet.y > 128 then
            del(bullets, bullet)
        end
    end
end

function fire_bullet()
    add(bullets, {x = x, y = y, speed = bullet_speed, direction = last_look_direction})
end

function dash()
    if last_look_direction == 0 then
        x -= dash_distance
    elseif last_look_direction == 1 then
        x += dash_distance
    elseif last_look_direction == 2 then
        y -= dash_distance
    elseif last_look_direction == 3 then
        y += dash_distance
    end
end



__gfx__
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
