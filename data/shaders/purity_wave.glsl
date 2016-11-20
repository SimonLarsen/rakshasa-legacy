const vec4 redcol = vec4(0.825, 0.314, 0.314, 1.0);
const vec4 onevec = vec4(1, 1, 1, 1);
const number MARGIN = 14;

extern number left, right;
extern number time, power;
extern Image disp;

vec4 effect(vec4 color, Image texture, vec2 texture_coords, vec2 screen_coords) {
	float px = texture_coords.x * 640 - 160;
	float value = 0.0;
	if(px >= left && px <= right) {
		value = 1.0;
	}
	else if(px > left-MARGIN && px < left) {
		value = abs(left - px) / MARGIN;
	}
	else if(px < right+MARGIN && px > right) {
		value = (right+MARGIN-px) / MARGIN;
	}
	vec4 tdisp = Texel(disp, screen_coords/800 + vec2(time*0.5, 0));
	vec4 tcol = Texel(texture, texture_coords);
	vec4 tcol2 = Texel(texture, texture_coords + vec2(tdisp.r - 0.5, tdisp.g - 0.5)*0.01*power);
	vec4 tout = 3*tcol2*redcol;
	return mix(tcol, tout, power*value*step(0.5, 1-tcol.r));
}
