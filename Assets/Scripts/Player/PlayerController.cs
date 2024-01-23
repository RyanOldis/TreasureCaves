using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.InputSystem;

public class PlayerController : MonoBehaviour
{

    [Header("Raycast options")]
    public Vector2 boxSize;
    public Vector2 castOffset;
    public float castDistance;
    public LayerMask mask;
    [Header("Ladder Raycast")]
    public Vector2 ladderBoxSize;
    public Vector2 ladderOffset;
    public float ladderDistance;
    public LayerMask ladderMask;
    [Header("Swim Raycast")]
    public Vector2 swimBoxSize;
    public Vector2 swimOffset;
    public float swimDistance;
    public LayerMask waterMask;

    private bool _grounded = true;
    public bool Grounded { get { return _grounded; } set { _grounded = value; } }

    // public variables
    [Header("Character Controller Variables")]
    public float speed = 3f;
    public float jumpPower = 3.5f;
    public float accelerationRate;
    public float deacellerationRate;
    public bool RequireNewJumpPress;
    private Rigidbody2D _rb;
    public Rigidbody2D RB { get { return _rb; } }

    [Header("Jump Variables")]
    public float gravity = -9.81f;
    public float terminalVelocity;
    public float coyoteTime = 0.2f;
    public float jumpBufferTime;
    public float gravityModifier = 1f; // for moon gravity
    public float fallGravity;
    public float jumpFallDuration;
    public float platformBoost = 1f;

    [Header("Ladder Variables")]
    public float climbSpeed;
    public float shimmySpeed;

    // input variables
    private bool _jumpPressed = false;
    public bool JumpPressed { get { return _jumpPressed; } set { _jumpPressed = value; } }
    private Vector2 _moveDir;
    public Vector2 MoveDir { get { return _moveDir; } set { _moveDir = value; } }
    private bool _movePerformed;
    public bool MovePerformed { get { return _movePerformed; } set { _movePerformed = value; } }


    // state machine references
    PlayerBaseState _currentState;
    public PlayerBaseState CurrentState { get { return _currentState; } set { _currentState = value; } }
    PlayerStateFactory _states;

    // motion variables
    [Header("Motion Variables")]
    [SerializeField]
    private Vector3 calculatedMotion;
    public float MotionX { get { return calculatedMotion.x; } set { calculatedMotion.x = value; } }
    public float MotionY
    {
        get
        {
            return calculatedMotion.y;
        }
        set
        {
            //if (calculatedMotion.y == 0f)
            //{
            //  Debug.Log("set to zero");
            //}
            calculatedMotion.y = value;
        }
    }
    public float MotionZ { get { return calculatedMotion.z; } set { calculatedMotion.z = value; } }
    public Vector3 addedForce;
    [SerializeField]
    private Vector3 _previousMotion;
    public Vector3 PreviousMotion { get { return _previousMotion; } set { _previousMotion = value; } }
    public float PreviousMotionX { get { return _previousMotion.x; } set { _previousMotion.x = value; } }
    public float PreviousMotionY { get { return _previousMotion.y; } set { _previousMotion.y = value; } }
    public float PreviousMotionZ { get { return _previousMotion.z; } set { _previousMotion.z = value; } }

    //[Header("Armin Attributes")]
    //public float speedArmin = 1.8f;
    //public float jumpPowerArmin = 1.5f;
    //private Rigidbody2D rbA;

    private void Awake()
    {
        _states = new PlayerStateFactory(this);
        _currentState = _states.Fall();
        _currentState.EnterState();

        calculatedMotion = Vector3.zero;
        addedForce = Vector3.zero;

        _rb = GetComponent<Rigidbody2D>();
    }

    public Transform GetTransform()
    {
        return this.transform;
    }

    public bool IsGrounded()
    {
        return (bool)Physics2D.BoxCast(transform.position + (Vector3)castOffset, boxSize, 0, -transform.up, castDistance, mask);
    }

    private void Update()
    {
        _grounded = IsGrounded();
        _currentState.UpdateStates();

        // move the player
        _rb.velocity = (Vector2)(calculatedMotion + addedForce);
    }

    private void OnCollisionEnter2D(Collision2D collision)
    {
        _currentState.OnCollisionEnter(collision);
    }
    private void OnCollisionExit2D(Collision2D collision)
    {
        _currentState.OnCollisionExit(collision);
    }
    private void OnTriggerEnter2D(Collider2D collision)
    {
        _currentState.OnTriggerEnter(collision);
    }
    private void OnTriggerExit2D(Collider2D collision)
    {
        _currentState.OnTriggerExit(collision);
    }

    private void OnDrawGizmos()
    {
        Gizmos.DrawWireSphere(transform.position + (Vector3)castOffset, 0.1f);
        Gizmos.DrawWireCube(transform.position + (Vector3)castOffset - transform.up * castDistance, boxSize);
        Gizmos.color = Color.yellow;
        Gizmos.DrawWireSphere(transform.position + (Vector3)ladderOffset, 0.1f);
        Gizmos.DrawWireCube(transform.position + (Vector3)ladderOffset - transform.up * ladderDistance, ladderBoxSize);
        Gizmos.color = Color.blue;
        Gizmos.DrawWireSphere(transform.position + (Vector3)swimOffset, 0.1f);
        Gizmos.DrawWireCube(transform.position + (Vector3)swimOffset - transform.up * swimDistance, swimBoxSize);
    }
    /*
    // Start is called before the first frame update
    void Start()
    {
        rbH = hannah.GetComponent<Rigidbody2D>();
        rbA = armin.GetComponent<Rigidbody2D>();

        arminCam.SetActive(false);

        grounded = true;
    }

    void UpdateHannah()
    {
        move = Input.GetAxisRaw("Horizontal");
        grounded = isGrounded(hannah.transform);

        rbH.velocity = new Vector2(move * speed, rbH.velocity.y);
        if (Input.GetButtonDown("Jump") && grounded)
        {
            rbH.AddForce(new Vector2(rbH.velocity.x, jumpPower * 110));
            grounded = false;
        }
    }
    void UpdateArmin()
    {
        move = Input.GetAxisRaw("Horizontal");
        grounded = isGrounded(armin.transform);

        rbA.velocity = new Vector2(move * speedArmin, rbA.velocity.y);
        if (Input.GetButtonDown("Jump") && grounded)
        {
            rbA.AddForce(new Vector2(rbA.velocity.x, jumpPowerArmin * 110));
            grounded = false;
        }
    }

    void SwitchCharacter()
    {
        switch (currentCharacter)
        {
            case 0:
                // switch to Armin
                currentCharacter = 1;
                hannahCam.SetActive(false);
                arminCam.SetActive(true);
                break;
            case 1:
                // switch to Hannah
                currentCharacter = 0;
                hannahCam.SetActive(true);
                arminCam.SetActive(false);
                break;
            default:
                break;
        }
    }

    bool isGrounded(Transform obj)
    {
        if (Physics2D.BoxCast(obj.position, boxSize, 0, -obj.up,castDistance, mask))
        {
            return true;
        }
        else
        {
            return false;
        }
    }

    private void OnDrawGizmos()
    {
        Gizmos.DrawWireCube(hannah.transform.position - hannah.transform.up * castDistance, boxSize);
    }

    // Update is called once per frame
    void Update()
    {
        switch (currentCharacter)
        {
            case 0:
                UpdateHannah();
                entityBox.transform.position = hannah.transform.position;
                break;
            case 1:
                UpdateArmin();
                entityBox.transform.position = armin.transform.position;
                break;
            default:
                break;
        }

        
    }
    
    private void OnMove(InputValue value)
    {
        // the speed the player wants to move at
        //float targetSpeed = value.x * 
    }

    private void OnSwitch()
    {
        SwitchCharacter();
    }

    private void OnJump()
    {
        if (grounded)
        {

        }
    }
    */
}
