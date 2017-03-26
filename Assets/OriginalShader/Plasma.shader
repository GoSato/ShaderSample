Shader "Unlit/Plasma"
{
	Properties
	{
		_MainTex ("Texture", 2D) = "white" {}
	}
	SubShader
	{
		Tags { "RenderType"="Opaque" }
		LOD 100

		Pass
		{
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			// make fog work
			#pragma multi_compile_fog
			
			#include "UnityCG.cginc"

			struct appdata
			{
				float4 vertex : POSITION;
				float2 uv : TEXCOORD0;
			};

			struct v2f
			{
				float2 uv : TEXCOORD0;
				UNITY_FOG_COORDS(1)
				float4 vertex : SV_POSITION;
			};

			sampler2D _MainTex;
			float4 _MainTex_ST;

			float len(float3 p) {
				return max(abs(p.x)*0.5 + abs(p.z)*0.5, max(abs(p.y)*0.5 + abs(p.x)*0.5, abs(p.z)*0.5 + abs(p.y)*0.5));
			}
			
			v2f vert (appdata v)
			{
				v2f o;
				o.vertex = UnityObjectToClipPos(v.vertex);
				o.uv = TRANSFORM_TEX(v.uv, _MainTex);
				UNITY_TRANSFER_FOG(o,o.vertex);
				return o;
			}
			
			fixed4 frag (v2f i) : SV_Target
			{
				float2 R = _ScreenParams.xy,
				uv = (i.uv * _ScreenParams - .5*R) / _ScreenParams.y;

				float3 rp = float3(0.,1 / 50.,_Time.y + 1 / 50.);
				float3 rd = normalize(float3(uv,1.));

				float3 c = float3(0.0, 0.0, 0.0);
				float s = 0.;

				float viewVary = cos(_Time.y*0.05)*.15;

				for (int i = 0; i < 74; i++) {
					float3 hp = rp + rd*s;
					float d = len(cos(hp*.6 +
						cos(hp*.3 + _Time.y*.5))) - .75;
					float cc = min(1.,pow(max(0., 1. - abs(d)*10.25),1.)) / (float(i)*1. + 10.);//clamp(1.-(d*.5+(d*5.)/s),-1.,1.);

					c += (cos(float3(hp.xy,s))*.5 + .5 + cos(float3(s + _Time.y,hp.yx)*.1)*.5 + .5 + 1.) / 3.
						*cc;

					s += max(abs(d),0.35 + viewVary);
					rd = normalize(rd + float3(sin(s*0.5),cos(s*0.5),0.)*d*0.05*clamp(s - 1.,0.,1.));
				}

				return fixed4(pow(c,float3(1.7, 1.7, 1.7)),1.);
			}
			ENDCG
		}
	}
}
