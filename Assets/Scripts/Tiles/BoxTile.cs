using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Tilemaps;

[CreateAssetMenu]
public class BoxTile : TileData
{
    public override void OnArrowHit(Tilemap map, Vector3Int pos)
    {
        Debug.Log("hit by arrow");
        this.BreakThis(map, pos);
    }

    public override void OnDynamiteHit(Tilemap map, Vector3Int pos)
    {
        BreakThis(map, pos);
    }

    public override void OnGravityHit(Tilemap map, Vector3Int pos)
    {
        return;
    }

    public override void OnPlayerHit(Tilemap map, Vector3Int pos, Vector3 playerPos)
    {
        this.BreakThis(map, pos);
    }
}
