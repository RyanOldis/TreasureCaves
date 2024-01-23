using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Tilemaps;

public interface EntityInteraction
{
    public abstract void OnPlayerHit(Tilemap map, Vector2 pos);
    public abstract void OnArrowHit(Tilemap map, Vector2 pos);
    public abstract void OnDynamiteHit(Tilemap map, Vector2 pos);
    public abstract void OnGravityHit(Tilemap map, Vector2 pos);
}
