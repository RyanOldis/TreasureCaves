using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Tilemaps;

public class ActiveBoulder : ActiveObject
{
    public float settleTime = 0.2f;
    public float pushSpeed;
    public int pushDirection = 0;
    public bool hasYielded = false;

    public float yieldDistance = 0f;

    //private Tilemap _map;
    public Tilemap Map { get { return base._map; } }

    BoulderBaseState _currentState;
    public BoulderBaseState CurrentState { get { return _currentState; } set { _currentState = value; } }
     BoulderStateFactory _states;
    public BoulderStateFactory States { get { return _states; } }
    public Color StateIndicator = Color.gray;
    Color _downRay = Color.red;
    public ActiveObject OtherBoulder;


    protected override void Start()
    {
        _isBoulder = true;
        _states = new BoulderStateFactory(this);
        base._map = MapManager.instance.GetEntityMap();
        if (pushDirection == 0)
        {
            _currentState = _states.Settle();
        }
        else
        {
            _currentState = _states.Push();
        }
        _currentState.EnterState();

        base.Start();
        
        //Debug.Log(CheckOtherObject(Vector3.down, 0.2f));
    }

    // Update is called once per frame
    protected override void Update()
    {
        /*
        if (CheckOtherObject(Vector3.down, 0.1f))
        {
            _downRay = Color.green;
        } else {
            _downRay = Color.red;
        }
        */
        //if (wait)
        //    return;

        _currentState.UpdateState();
        rb.velocity = _calculatedMotion;
    }

    protected override void OnCollisionEnter2D(Collision2D collision)
    {
        _currentState.OnCollisionEnter(collision);
        /*
        // check for collision with player
        if (collision.gameObject.tag == "Player")
        {
            //kill player

            return;
        }

        // check for collision with an enemy, but not an undead enemy
        if (collision.gameObject.tag == "EnemyLiving")
        {
            // kill enemy

            return;
        }
        */
        // fall through platforms
        /*
        if (MapManager.instance.GetDataFromPlatforms(new Vector2(transform.position.x, transform.position.y - 1)) == 2 && state == boulderState.falling)
        {
            // destroy the 3 platform tiles below
            platformMap.SetTile(new Vector3Int((int)transform.position.x, (int)transform.position.y - 1, 0), null);
        }
        */

        // if it lands on another boulder, check the adjacent tile and move the boulder into an empty space
    }

    public void ExternalSetPush()
    {
        //_currentState.ExitState();
        _currentState = _states.Push();
        _currentState.EnterState();
    }

    public void ExternalSetFall()
    {
        _currentState = _states.Fall();
        _currentState.EnterState();
    }

    public void ExternalSetYield()
    {
        _currentState.ExitState();
        _currentState = _states.Yield();
        _currentState.EnterState();
    }

    public override void ActivateBoulder(Tilemap map, Vector3Int pos, bool activatedFromBoulder = false, float directionX = 0f, float directionY = 0f, bool wasPushed = false)
    {
        BoulderTile activatedTile = map.GetTile(pos) as BoulderTile;
        if (!activatedTile)
            return;
        // check tile below to see if we should activate at all
        //if (MapManager.instance.CheckForTile(pos + Vector2.down))
        //    return;

        activatedTile.Activate(map, pos, true, directionX, directionY, false);
    }

    public bool checkNeighborTiles(Vector3Int tilePos)
    {
        return MapManager.instance.CheckForTile(tilePos + Vector3Int.left) && MapManager.instance.CheckForTile(tilePos + Vector3Int.right);
    }

    public void SetStateYield(float f)
    {
        _currentState.SetYieldDistance(f);
    }

    protected override void OnDrawGizmos()
    {
        //base.OnDrawGizmos();
        Gizmos.color = _downRay;
        Gizmos.DrawRay(new Ray(transform.position + Vector3.down * 0.45f, Vector3.down * 0.1f));
        Gizmos.color = StateIndicator;
        Gizmos.DrawWireSphere(transform.position, 0.5f);

        if (OtherBoulder)
        {
            Gizmos.color = Color.cyan;
            Gizmos.DrawLine(transform.position, OtherBoulder.transform.position);
        }
        if (LastPointCast != null)
        {
            Gizmos.color = Color.white;
            Gizmos.DrawCube(LastPointCast, new Vector3(0.15f, 0.15f, 0.15f));
        }
    }
}
