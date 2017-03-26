using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class FootRadiusShaderController : MonoBehaviour {

    [SerializeField]
    private Material _foodRadiusMat;

	// Use this for initialization
	void Start () {
		
	}
	
	// Update is called once per frame
	void Update () {
        _foodRadiusMat.SetVector("_Center", transform.position); 
	}
}
