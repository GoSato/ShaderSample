using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class RotateController : MonoBehaviour {

    [SerializeField]
    private bool _autoRotate;

    [SerializeField]
    private float _rotateSpeed = 10f;

    private Transform _cachedTrans;

    private Vector3 _rotateVec;

	// Use this for initialization
	void Start () {
        _cachedTrans = this.gameObject.transform;
        _rotateVec = _cachedTrans.transform.eulerAngles;       
	}
	
	// Update is called once per frame
	void Update () {
        if(_autoRotate)
        {
            _rotateVec += new Vector3(Time.deltaTime * _rotateSpeed, 0, 0);
            _cachedTrans.eulerAngles = _rotateVec;
        }

		if(Input.GetKeyDown(KeyCode.W))
        {
            _cachedTrans.eulerAngles += new Vector3(10, 0, 0);
        }
        else if(Input.GetKeyDown(KeyCode.S))
        {
            _cachedTrans.eulerAngles += new Vector3(-10, 0, 0);
        }
        else if(Input.GetKeyDown(KeyCode.A))
        {
            _cachedTrans.eulerAngles += new Vector3(0, -10, 0);
        }
        else if(Input.GetKeyDown(KeyCode.D))
        {
            _cachedTrans.eulerAngles += new Vector3(0, 10, 0);
        }
	}
}
