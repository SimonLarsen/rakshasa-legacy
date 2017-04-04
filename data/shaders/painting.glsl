extern Image pattern;
extern vec2 pattern_size;

vec4 effect(vec4 color, Image texture, vec2 texture_coords, vec2 screen_coords) {
	vec2 tc = screen_coords / pattern_size;
	vec4 pcol = Texel(pattern, tc);
	return vec4(pcol);
}
