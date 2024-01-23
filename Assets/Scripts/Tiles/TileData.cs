using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Tilemaps;

//[CreateAssetMenu]
public abstract class TileData : Tile
{
    bool _isBoulder = false;
    public TileBase[] tile;
    [SerializeField]
    private tileType type;
    [SerializeField]
    private GameObject Object;
    [SerializeField]
    float fallingWaitTime;
    [SerializeField]
    private GameObject fragments;

    [SerializeField]
    protected int arrowRotation = 0;
    [SerializeField]
    private Vector3 offset = new Vector3(0.5f, 0.5f, 0f);

    public tileType GetTileType()
    {
        return type;
    }
    public GameObject GetGameObject()
    {
        return Object;
    }

    

    public virtual GameObject Activate(Tilemap map, Vector3Int position, bool activatedFromBoulder = false, float directionX = 0f, float directionY = 0f, bool wasPushed = false)
    {
        // Create 'active' gameobject, and set the tile to nothing
        //Vector3Int newPos = map.WorldToCell(position);
        map.SetTile(position, null);
        return Instantiate(Object, (Vector3)position + offset, Quaternion.identity);
        //Debug.Log("Object " + Object + " created at: " + ((Vector3)position + offset));
    }

    public void BreakThis(Tilemap map, Vector3Int position)
    {
        //Debug.Log("Break the tile");
        //Debug.Log("This tile is at: " + position);
        map.SetTile(map.WorldToCell(position), null);
        Instantiate(fragments, position, Quaternion.identity);

        TileData above = map.GetTile(position + Vector3Int.up) as TileData;
        above?.Activate(map, position + Vector3Int.up, _isBoulder, 0f, 1f);
        TileData left = map.GetTile(position + Vector3Int.left) as BoulderTile;
        left?.Activate(map, position + Vector3Int.left, _isBoulder, -1f, 0f);
        TileData right = map.GetTile(position + Vector3Int.right) as BoulderTile;
        right?.Activate(map, position + Vector3Int.right, _isBoulder, 1f, 0f);
        //Debug.Log("Tile " + this + " broken at: " + position);
    }

    public abstract void OnPlayerHit(Tilemap map, Vector3Int pos, Vector3 playerPos);
    public abstract void OnArrowHit(Tilemap map, Vector3Int pos);
    public abstract void OnDynamiteHit(Tilemap map, Vector3Int pos);
    public abstract void OnGravityHit(Tilemap map, Vector3Int pos);
}

public enum tileType
{
    air = -1,
    terrain = 0,
    boulder = 1,
    platform = 2,
    spike = 3,
    ladder = 4,
    box = 5,
    arrowUp = 6
};