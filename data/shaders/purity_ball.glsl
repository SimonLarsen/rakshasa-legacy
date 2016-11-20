const vec4 redcol = vec4(0.825, 0.314, 0.314, 1.0);
const vec4 onevec = vec4(1, 1, 1, 1);
const number MARGIN = 14;

extern number cx, cy;
extern number radius, power;
extern number time;
extern Image disp;

vec4 effect(vec4 color, Image texture, vec2 texture_coords, vec2 screen_coords) {
	float px = texture_coords.x * 640 - 160;
	float py = texture_coords.y * 480;
	float value = 0.0;

	float dist = sqrt(pow(px - cx, 2.0) + pow(py - cy, 2.0));
	if(dist <= radius) {
		value = 1.0;
	}
	else if(dist > radius && dist < radius+MARGIN) {
		value = 1.0 - (dist-radius) / MARGIN;
	}

	vec4 tdisp = Texel(disp, screen_coords/800 + vec2(time*0.5, 0));
	vec4 tcol = Texel(texture, texture_coords);
	vec4 tcol2 = Texel(texture, texture_coords + vec2(tdisp.r - 0.5, tdisp.g - 0.5)*0.01*power);
	vec4 tout = 3*tcol2*redcol;
	return mix(tcol, tout, value*power*step(0.5, 1-tcol.r));
}
