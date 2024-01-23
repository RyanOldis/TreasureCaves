using System.Collections;
using System.Collections.Generic;
using UnityEngine;

[CreateAssetMenu]
public class SteelBoxTile : TileData
{
    public SteelBoxTile()
    {
    }

    public override void OnArrowHit(UnityEngine.Tilemaps.Tilemap map, Vector3Int pos)
    {
        BreakThis(map, pos);
    }

    public override void OnDynamiteHit(UnityEngine.Tilemaps.Tilemap map, Vector3Int pos)
    {
        BreakThis(map, pos);
    }

    public override void OnGravityHit(UnityEngine.Tilemaps.Tilemap map, Vector3Int pos)
    {
        
    }

    public override void OnPlayerHit(UnityEngine.Tilemaps.Tilemap map, Vector3Int pos, Vector3 playerPos)
    {
        
    }
}
