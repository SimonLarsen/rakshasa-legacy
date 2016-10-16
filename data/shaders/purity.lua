{
	pixelcode = [[
		const vec4 redcol = vec4(0.825, 0.314, 0.314, 1.0);
		const vec4 onevec = vec4(1, 1, 1, 1);

		extern number left, right;
		extern number time;
		extern Image disp;

		vec4 effect(vec4 color, Image texture, vec2 texture_coords, vec2 screen_coords) {
			float cx = texture_coords.x * 640 - 160;
			float power = 0.0;
			if(cx >= left && cx <= right) {
				power = 1.0;
			}
			vec4 tdisp = Texel(disp, screen_coords/800 + vec2(time*0.5, 0));
			vec4 tcol = Texel(texture, texture_coords + vec2(tdisp.r - 0.5, tdisp.g - 0.5)*0.01*power);
			vec4 tout = 4*tcol*redcol;
			return mix(tcol, tout, power*step(0.5, 1-tcol.r));
		}
	]]
}
