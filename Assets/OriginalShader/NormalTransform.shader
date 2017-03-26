Shader "Unlit/NormalTransform"
{
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

			struct v2f
			{
				float4 pos : SV_POSITION;
				fixed3 color : COLOR0;
			};

			
			v2f vert (appdata_base v)
			{
				v2f o;
				v.vertex.x *= 1 + pow(sin(_Time.y * 10 * v.vertex.y), 2);
				//v.vertex.y *= 1 + pow(sin(_Time.y * 10 * v.vertex.y), 2);
				v.vertex.z *= 1 + pow(sin(_Time.y * 10 * v.vertex.y), 2);
				o.pos = UnityObjectToClipPos(v.vertex);
				o.color = v.normal * 0.5 + 0.5;
				return o;
			}
			
			fixed4 frag (v2f i) : SV_Target
			{
				return fixed4(i.color, 1);
			}
			ENDCG
		}
	}
}
