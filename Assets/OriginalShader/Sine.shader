Shader "Unlit/Sine"
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
				float PI = atan2(0.,-1.);
				i.uv = (i.uv * _ScreenParams / _ScreenParams.y)*PI;
				i.uv /= i.uv.x - PI;
				float x = i.uv.x + sin(_Time.y), y = i.uv.y + _Time.y;
				float func = sin(x * 2.) + sin(y * 8.) + sin((x + y) *4.);
				return fixed4(fixed3(func + i.uv.y / 20.0, func + i.uv.y / 20.0, func + i.uv.y / 20.0), 1.);
			}
			ENDCG
		}
	}
}
