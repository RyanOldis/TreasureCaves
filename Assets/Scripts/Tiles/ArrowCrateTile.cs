using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Tilemaps;

[CreateAssetMenu]
public class ArrowCrateTile : TileData
{
    [SerializeField]
    private GameObject _arrow;

    private Vector2 offSet = new Vector2(0.5f, 0.5f);

    public override void OnArrowHit(Tilemap map, Vector3Int pos)
    {
        BreakThis(map, pos);
        ArrowBox.LaunchArrow(_arrow, arrowRotation, new Vector2(pos.x + offSet.x, pos.y + offSet.y));
    }

    public override void OnDynamiteHit(Tilemap map, Vector3Int pos)
    {
        BreakThis(map, pos);
        ArrowBox.LaunchArrow(_arrow, arrowRotation, new Vector2(pos.x + offSet.x, pos.y + offSet.y));
    }

    public override void OnGravityHit(Tilemap map, Vector3Int pos)
    {
        return;
    }

    public override void OnPlayerHit(Tilemap map, Vector3Int pos, Vector3 playerPos)
    {
        BreakThis(map, pos);
        ArrowBox.LaunchArrow(_arrow, arrowRotation, new Vector2(pos.x + offSet.x, pos.y + offSet.y));
    }
}
