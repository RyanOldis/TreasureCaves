using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Tilemaps;

public class ActiveBox : ActiveObject
{
    /*
    float timeCount = 0f;
    float speed = 0f;

    public float rotateSpeed;
    public float acceleration;
    public float terminalVelocity;

    public Tilemap map;
    public Tile tile;
    public GameObject fragments;

    private Transform box;
    */
    /*
    // Start is called before the first frame update
    void Start()
    {
        //box = GetComponentInChildren<Transform>();
    }

    // Update is called once per frame
    void Update()
    {
        
    }

    private void OnCollisionEnter2D(Collision2D collision)
    {
        if (collision.gameObject.CompareTag("Player"))
        {
            BreakThis();
            return;
        }

        Vector3Int gridPos = map.WorldToCell(transform.position);
        map.SetTile(gridPos, tile);
        //map.RefreshAllTiles();
        //Debug.Log(MapManager.instance.GetDataFromTile(new Vector2(transform.position.x, transform.position.y - 1)));

        Destroy(this.gameObject);
    }

    void BreakThis()
    {
        Instantiate(fragments);
        Destroy(this.gameObject);
    }
    */
    protected override void OnCollisionEnter2D(Collision2D collision)
    {
        if (collision.gameObject.CompareTag("Player"))
        {
            BreakThis();
            return;
        }
        base.OnCollisionEnter2D(collision);
    }
}
