extern Image filter;
extern number edge;
extern number radius, cx, cy;

const vec4 redcol = vec4(0.825, 0.314, 0.314, 1.0);

vec4 effect(vec4 color, Image texture, vec2 texture_coords, vec2 screen_coords) {
	vec2 filter_coords = vec2(screen_coords.x-(cx-radius), screen_coords.y-(cy-radius)) / (2.0*radius);
	vec4 fcol = Texel(filter, filter_coords);
	number alpha = step(edge, fcol.r);
	return vec4(color.r, color.g, color.b, alpha);
}
