using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Tilemaps;

public abstract class ActiveObject : MonoBehaviour
{
    protected bool _isBoulder = false;
    float timeCount = 0f;
    float speed = 0f;
    public float waitTime = 0.1f;
    protected bool wait = true;
    public Vector3 LastPointCast;

    public float rotateSpeed;
    public float acceleration;
    public float terminalVelocity;

    protected Tilemap _map;
    public Tile tile;
    public GameObject fragments;

    private Transform box;
    public Rigidbody2D rb;
    public LayerMask mask;
    [SerializeField]
    protected Vector2 _calculatedMotion;
    protected Vector3 _startingPosition;
    public float MotionX { get { return _calculatedMotion.x; } set { _calculatedMotion.x = value; } }
    public float MotionY { get { return _calculatedMotion.y; } set { _calculatedMotion.y = value; } }
    protected int arrowRotation = 0;

    protected Collider2D thisCollider;
    public Collider2D ThisCollider {get {return thisCollider;}}
    public bool wasPushed = false;

    // Start is called before the first frame update
    protected virtual void Start()
    {
        box = GetComponentInChildren<Transform>();
        rb = GetComponent<Rigidbody2D>();
        thisCollider = GetComponent<Collider2D>();
        //Debug.Log(rb);
        _map = MapManager.instance.GetEntityMap();
        _startingPosition = transform.position;
        StartCoroutine(StartUpdating());
    }

    IEnumerator StartUpdating()
    {
        while (_startingPosition.y - transform.position.y < 2f)
        {
            yield return null;
        }
        Vector3Int tilePos = _map.WorldToCell(_startingPosition);
        Activate(_map, tilePos + Vector3Int.up, _isBoulder, 0f, 1f, wasPushed);
        ActivateBoulder(_map, tilePos + Vector3Int.left, _isBoulder, -1f, 0f);
        ActivateBoulder(_map, tilePos + Vector3Int.right, _isBoulder, 1f, 0f);
        //wait = false;
    }

    static void Activate(Tilemap map, Vector3Int pos, bool activatedFromBoulder = false, float directionX = 0f, float directionY = 0f, bool wasPushed = false)
    {
        TileData activatedTile = map.GetTile(pos) as TileData;
        if (!activatedTile)
            return;
        // check tile below to see if we should activate at all
        //if (MapManager.instance.CheckForTile(pos + Vector2.down))
        //    return;

        activatedTile.Activate(map, pos, activatedFromBoulder, directionX, directionY, wasPushed);
    }

    public virtual void ActivateBoulder(Tilemap map, Vector3Int pos, bool activatedFromBoulder = false, float directionX = 0f, float directionY = 0f, bool wasPushed = false)
    {
        BoulderTile activatedTile = map.GetTile(pos) as BoulderTile;
        if (!activatedTile)
            return;
        // check tile below to see if we should activate at all
        //if (MapManager.instance.CheckForTile(pos + Vector2.down))
        //    return;

        activatedTile.Activate(map, pos, activatedFromBoulder, directionX, directionY, wasPushed);
    }

    public void DeActivate()
    {
        Vector3Int gridPos = _map.WorldToCell(transform.position);
        _map.SetTile(gridPos, tile);

        Destroy(this.gameObject);
    }

    // Update is called once per frame
    protected virtual void Update()
    {
        //if (wait)
        //    return;

        box.rotation = Quaternion.Slerp(box.rotation, Quaternion.Euler(new Vector3(0, 0, 21.53f)), timeCount);
        timeCount += rotateSpeed * Time.deltaTime;

        //MotionY = Mathf.Min(MotionY + Physics2D.gravity.y * Time.deltaTime, terminalVelocity);
        //rb.velocity = _calculatedMotion;
        //Debug.Log(rb.velocity);
        
        box.position = new Vector3(box.position.x, box.position.y - (speed * Time.deltaTime), 0);
        speed += acceleration;
        if (speed > terminalVelocity)
        {
            speed = terminalVelocity;
        }
        
    }

    protected virtual void OnCollisionEnter2D(Collision2D collision)
    {
        //Debug.Log("hit");
        if (wait)
            return;
        if (!MapManager.instance.CheckForTile(_map.WorldToCell(transform.position) + Vector3Int.down))
        {
            return;
        }
        if (collision.gameObject.GetComponent<ActiveObject>())
        {
            speed = 0f;
            return;
        }

        DeActivate();
    }
    public RaycastHit2D PointCast(Vector3 position, int mask = 0)
    {
        LastPointCast = position;
        return Physics2D.Raycast(position, Vector2.up, 0.005f, mask);
    }
    protected void BreakThis()
    {
        //Debug.Log("Object " + this + " broken at: " + transform.position);
        Instantiate(fragments, transform.position, Quaternion.identity);
        Destroy(this.gameObject);
    }

    protected virtual void OnDrawGizmos()
    {
        Gizmos.DrawWireCube(transform.position, new Vector3(1f, 1f, 0f));
        Gizmos.color = Color.green;
        Gizmos.DrawWireCube(new Vector3(transform.position.x, transform.position.y + 1f), new Vector3(1f, 1f, 0f));
    }
}
