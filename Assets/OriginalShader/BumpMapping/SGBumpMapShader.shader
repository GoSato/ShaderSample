Shader "Custom/SGBumpMapShader"
{
	Properties
	{
		_MainTex ("Texture", 2D) = "white" {}
		_NormalTex("Normal map", 2D) = "white"{}
	}
	SubShader
	{
		Tags
		{ 
			"RenderType"="Opaque"
			"LightMode"="ForwardBase"
		}
		LOD 200

		Pass
		{
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			
			#include "UnityCG.cginc"

			struct vertInput 
			{
				float4 vertex : POSITION;
				float4 normal : NORMAL;
				float2 uv : TEXCOORD0;
			};

			struct v2f
			{
				float4 position : SV_POSITION;
				float2 uv : TEXCOORD0;
				float4 light : COLOR1;
			};

			float4x4 InvTangentMatrix(float3 tangent, float3 binormal, float3 normal)
			{
				float4x4 mat = float4x4(float4(tangent.x, tangent.y, tangent.z, 0.0f),
					float4(binormal.x, binormal.y, binormal.z, 0.0f),
					float4(normal.x, normal.y, normal.z, 0.0f),
					float4(0, 0, 0, 1));
				return transpose(mat);
			}

			uniform sampler2D _MainTex;
			uniform sampler2D _NormalTex;
			
			v2f vert (vertInput v)
			{
				v2f o;
				
				o.position = mul(UNITY_MATRIX_MVP, v.vertex);
				o.uv = v.uv;

				float3 n = normalize(v.normal);
				float3 t = normalize(cross(n, float3(0, 1, 0)));
				float3 b = cross(n, t);

				o.light = mul(mul(unity_WorldToObject, _WorldSpaceLightPos0), InvTangentMatrix(t, b, n));

				return o;
			}
			
			fixed4 frag (v2f i) : COLOR
			{
				float4 diffuseColor = tex2D(_MainTex, i.uv);
				//float3 mNormal = (tex2D(_NormalTex, i.uv) * 2.0 - 1.0).rgb;
				float3 mNormal = float4(UnpackNormal(tex2D(_NormalTex, i.uv)), 1);
				float3 light = normalize(i.light);
				float bright = max(0, dot(mNormal, light));
				return bright * diffuseColor;
			}
			ENDCG
		}
	}
}
