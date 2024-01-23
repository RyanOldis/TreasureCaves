using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class PlayerJumpState : PlayerBaseState
{
    private bool _jumpBuffer = false;
    private float _jumpBufferTimer;

    private float _localGravity = 1f;
    private bool _jumpReleased = false;

    public PlayerJumpState(PlayerController currentContext, PlayerStateFactory currentFactory) : base(currentContext, currentFactory)
    {
        _isRootState = true;
        InitializeSubstate();
    }

    public override void CheckSwitchState()
    {
        if (_context.Grounded && _context.MotionY <= 0f)
        {
            if (_jumpBuffer)
            {
                //HandleJump();
                SwitchState(_factory.Jump());
                return;
            }
            SwitchState(_factory.Ground());
        }
        if (_context.MotionY < 0f && LadderCheck())
        {
            SwitchState(_factory.Ladder());
        }
    }

    public override void EnterState()
    {
        HandleJump();
        //Debug.Log("jump");
    }

    public override void ExitState()
    {
        if (_context.JumpPressed)
        {
            _context.RequireNewJumpPress = true;
        }
    }

    public override void InitializeSubstate()
    {
        if (_context.MovePerformed)
        {
            SetSubState(_factory.Move());
        }
        else
        {
            SetSubState(_factory.Idle());
        }
    }

    public override void OnCollisionEnter(Collision2D collision)
    {
        //Debug.Log("hit from jump");
        if (collision.collider.CompareTag("Platforms"))
        {
            _context.MotionY = _context.MotionY * _context.platformBoost;
        }
    }

    public override void OnCollisionExit(Collision2D collision)
    {
        
    }

    public override void OnTriggerEnter(Collider2D collision)
    {
        _currentSubState.OnTriggerEnter(collision);
        if (collision.CompareTag("Ladders"))
        {
            SwitchState(_factory.Ladder());
        }
    }

    public override void OnTriggerExit(Collider2D collision)
    {
        
    }

    public override void UpdateState()
    {
        CheckSwitchState();

        SetJumpBuffer();
        UpdateBufferTimer();

        IncreaseGravity();

        _context.MotionY = Mathf.Min(_context.MotionY + Physics2D.gravity.y * _localGravity * Time.deltaTime, _context.terminalVelocity);
        //_context.PreviousMotionY = _context.MotionY;
        //_context.MotionY = _context.MotionY + (Physics2D.gravity.y * _localGravity * Time.deltaTime);
        //_context.MotionY = Mathf.Min((_context.PreviousMotionY + _context.MotionY) * 0.5f, _context.terminalVelocity);

        if (_context.MotionY > 0f)
        {
            _context.Grounded = false;
        }
    }

    void HandleJump()
    {
        //Debug.Log("Jumping from the jump state");
        _context.MotionY = Mathf.Sqrt(2 * _context.jumpPower * Mathf.Abs(Physics2D.gravity.y));
        //_context.MotionY = _context.jumpPower;
    }

    void SetJumpBuffer()
    {
        if (_context.JumpPressed && !_context.RequireNewJumpPress)
        {
            _jumpBuffer = true;
            _jumpBufferTimer = _context.jumpBufferTime;
            _context.RequireNewJumpPress = true;
        }
    }
    void UpdateBufferTimer()
    {
        _jumpBufferTimer -= Time.deltaTime;
        if (_jumpBufferTimer <= 0f)
        {
            _jumpBuffer = false;
            _context.RequireNewJumpPress = true;
        }
    }

    void IncreaseGravity()
    {
        if (_context.JumpPressed == false && _context.MotionY > 0f)
        {
            _jumpReleased = true;
            _context.RequireNewJumpPress = false;
        }
        if (_jumpReleased || _context.MotionY < 0f)
        {
            _localGravity = Mathf.Lerp(_localGravity, _context.fallGravity, _context.jumpFallDuration * Time.deltaTime);
            //Debug.Log("falling faster");
        }
    }

    private bool LadderCheck()
    {
        return (bool)Physics2D.BoxCast(_context.GetTransform().position + (Vector3)_context.ladderOffset, _context.ladderBoxSize, 0, -_context.GetTransform().up, _context.ladderDistance, _context.ladderMask);
    }
}
