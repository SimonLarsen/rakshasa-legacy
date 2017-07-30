extern Image filter;
extern number edge;

const vec4 redcol = vec4(0.825, 0.314, 0.314, 1.0);

vec4 effect(vec4 color, Image texture, vec2 texture_coords, vec2 screen_coords) {
	vec2 filter_coords = vec2(screen_coords.x/320, screen_coords.y/320);
	vec4 fcol = Texel(filter, filter_coords*2);
	vec4 tcol = Texel(texture, texture_coords);
	vec4 mcol = (fcol.r - 0.1) > edge ? tcol : redcol;
	number alpha = step(edge, fcol.r) * tcol.a;
	return vec4(mcol.r, mcol.g, mcol.b, alpha);
}
