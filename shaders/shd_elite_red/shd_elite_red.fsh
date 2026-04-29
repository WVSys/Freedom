varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform float u_red_amount;

void main()
{
    vec4 base = texture2D(gm_BaseTexture, v_vTexcoord) * v_vColour;

    vec3 red_tint = vec3(1.0, 0.15, 0.10);
    base.rgb = mix(base.rgb, red_tint, u_red_amount);

    gl_FragColor = base;
}